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
import '../Model/GetC_Quot_Select_Model.dart';
import '../Model/GetContract_Photo_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/electricity_model.dart';
import '../Report/Excel_PeopleCho_Report.dart';
import '../Responsive/responsive.dart';
import 'package:http/http.dart' as http;

import '../Style/colors.dart';
import '../Style/downloadImage.dart';
import 'Cancellation_notice.dart';
import 'PeopleChao_Screen2.dart';
import 'package:pdf/widgets.dart' as pw;
import 'PeopleChao_Screen3.dart';
import 'PeopleChao_Screen4.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:image/image.dart' as IMG;

import 'People_Gen_QR.dart';
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
  var nFormat = NumberFormat("#,##0.00", "en_US");
  TextEditingController Text_searchBar_Sub_TeNant = TextEditingController();
  int Date_ser = 0;

  ///------------------------------------------------->
  DateTime datex = DateTime.now();
  // String rotation = 'vertical';
  String Ser_nowpage = '2';
  int Ser_QRpage = 0;
  int? ser_indexShow;

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
  List<QuotxSelectModel> quotxSelectModels_Select = [];
  List<ElectricityModel> electricityModels = [];
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
  List Status = [
    'ปัจจุบัน',
    'หมดสัญญา',
    'ใกล้หมดสัญญา',
    'ผู้สนใจ',
    'บัญชีผู้เช่า',
    'แจ้งยกเลิก ล่วงหน้า',
    'ประวัติยกเลิกสัญญาผู้เช่า',
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
  int limit = 50; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;

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
  int renTal_lavel = 0;
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
    // read_GC_tenant();
    read_GC_rental();
    read_GC_areaSelect();
    teNantModels_Save = [];
  }

  Future<dynamic> showcountmiter(int index) async {
    var ser = quotxSelectModels_Select[index].ele_ty;
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
  }

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
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
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

  /////////------------------------------------------------------>
  Future<Null> red_quotx_Select(index) async {
    setState(() {
      quotxSelectModels_Select.clear();
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
        '${MyConstant().domain}/GC_quot_conx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
          setState(() {
            quotxSelectModels_Select.add(quotxSelectModel);
          });
        }
      } else {}
      // quotxSelectModels[index].sort((a, b) => a.expser!.compareTo(b.expser!));
    } catch (e) {}
  }

////////////----------------------------------------------------->(รายงาน ข้อมูลผู้เช่า(ยกเลิกสัญญา))
  Future<Null> read_GC_tenant_Cancel() async {
    if (limitedList_teNantModels.isNotEmpty) {
      limitedList_teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');
    var zone_Sub = preferences.getString('zoneSubSer');

    print('zone>>>>>>zone>>>>>$zone');

    String url = zone == null || zone == '0'
        ? '${MyConstant().domain}/GC_tenant_Cancel_All.php?isAdd=true&ren=$ren&zone=0'
        : '${MyConstant().domain}/GC_tenant_Cancel_All.php?isAdd=true&ren=$ren&zone=$zone';

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
  Future<Null> read_GC_areaSelect() async {
    int select = Status_;
    setState(() {
      limitedList_teNantModels.clear();
    });
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
                    limitedList_teNantModels.add(teNantModel);
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
            if (limitedList_teNantModels.isEmpty) {
              preferences.remove('zonePSer');
              preferences.remove('zonesPName');
              zone_ser = null;
              zone_name = null;
            }
          });
        }

        setState(() {
          _teNantModels = limitedList_teNantModels;

          zone_ser = preferences.getString('zonePSer');
          zone_name = preferences.getString('zonesPName');
        });
        read_tenant_limit();
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
                    limitedList_teNantModels.add(teNantModel);
                  }
                });
              }
            }
          }
        } else {
          setState(() {
            if (limitedList_teNantModels.isEmpty) {
              preferences.remove('zonePSer');
              preferences.remove('zonesPName');
              zone_ser = null;
              zone_name = null;
            }
          });
        }
        setState(() {
          _teNantModels = limitedList_teNantModels;

          zone_ser = preferences.getString('zonePSer');
          zone_name = preferences.getString('zonesPName');
        });
        read_tenant_limit();
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
                      limitedList_teNantModels.add(teNantModel);
                    });
                  }
                }
              }
            }
          }
        } else {
          setState(() {
            if (limitedList_teNantModels.isEmpty) {
              preferences.remove('zonePSer');
              preferences.remove('zonesPName');
              zone_ser = null;
              zone_name = null;
            }
          });
        }
        setState(() {
          _teNantModels = limitedList_teNantModels;

          zone_ser = preferences.getString('zonePSer');
          zone_name = preferences.getString('zonesPName');
        });
        read_tenant_limit();
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
                limitedList_teNantModels.add(teNantModel);
              });
            }
          }
        } else {
          setState(() {
            if (limitedList_teNantModels.isEmpty) {
              preferences.remove('zonePSer');
              preferences.remove('zonesPName');
              zone_ser = null;
              zone_name = null;
            }
          });
        }
        setState(() {
          _teNantModels = limitedList_teNantModels;

          zone_ser = preferences.getString('zonePSer');
          zone_name = preferences.getString('zonesPName');
        });
        read_tenant_limit();
      } catch (e) {}
    }
  }
// /////////////////////----------------------------------------->
//   Future<Null> read_GC_areaSelect() async {
//         int select = Status_;
//      setState(() {
//       limitedList_teNantModels.clear();
//     });
//     SharedPreferences preferences = await SharedPreferences.getInstance();

//     var ren = preferences.getString('renTalSer');
//     var zone = preferences.getString('zonePSer');

//     print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $select');

//     if (select == 1) {
//       String url = zone == null
//           ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
//           : zone == '0'
//               ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
//               : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

//       try {
//         var response = await http.get(Uri.parse(url));

//         var result = json.decode(response.body);
//         // print(result);
//         if (result != null) {
//           for (var map in result) {
//             TeNantModel teNantModel = TeNantModel.fromJson(map);
//             if (teNantModel.quantity == '1') {
//               var daterx = teNantModel.ldate == null
//                   ? teNantModel.ldate_q
//                   : teNantModel.ldate;

//               if (daterx != null) {
//                 int daysBetween(DateTime from, DateTime to) {
//                   from = DateTime(from.year, from.month, from.day);
//                   to = DateTime(to.year, to.month, to.day);
//                   return (to.difference(from).inHours / 24).round();
//                 }

//                 var birthday = DateTime.parse('$daterx 00:00:00.000')
//                     .add(const Duration(days: -30));
//                 var date2 = DateTime.now();
//                 var difference = daysBetween(birthday, date2);

//                 print('difference == $difference');

//                 var daterx_now = DateTime.now();

//                 var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

//                 final now = DateTime.now();
//                 final earlier = daterx_ldate.subtract(const Duration(days: 0));
//                 var daterx_A = now.isAfter(earlier);
//                 print(now.isAfter(earlier)); // true
//                 print(now.isBefore(earlier)); // true

//                 if (daterx_A != true) {
//                   setState(() {
//                     teNantModels.add(teNantModel);
//                   });
//                 }
//               }
//               // setState(() {
//               //   teNantModels.add(teNantModel);
//               // });
//             }
//             // setState(() {
//             //   teNantModels.add(teNantModel);
//             // });
//           }
//         } else {
//           setState(() {
//             if (teNantModels.isEmpty) {
//               preferences.remove('zonePSer');
//               preferences.remove('zonesPName');
//               zone_ser = null;
//               zone_name = null;
//             }
//           });
//         }

//         setState(() {
//           _teNantModels = teNantModels;

//           zone_ser = preferences.getString('zonePSer');
//           zone_name = preferences.getString('zonesPName');
//         });
//       } catch (e) {}
//     } else if (select == 2) {
//       String url = zone == null
//           ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
//           : zone == '0'
//               ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
//               : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

//       try {
//         var response = await http.get(Uri.parse(url));

//         var result = json.decode(response.body);
//         // print(result);
//         if (result != null) {
//           for (var map in result) {
//             TeNantModel teNantModel = TeNantModel.fromJson(map);
//             var daterx = teNantModel.ldate == null
//                 ? teNantModel.ldate_q
//                 : teNantModel.ldate;

//             if (daterx != null) {
//               int daysBetween(DateTime from, DateTime to) {
//                 from = DateTime(from.year, from.month, from.day);
//                 to = DateTime(to.year, to.month, to.day);
//                 return (to.difference(from).inHours / 24).round();
//               }

//               var birthday = DateTime.parse('$daterx 00:00:00.000')
//                   .add(const Duration(days: -30));
//               var date2 = DateTime.now();
//               var difference = daysBetween(birthday, date2);

//               print('difference == $difference');

//               var daterx_now = DateTime.now();

//               var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

//               final now = DateTime.now();
//               final earlier = daterx_ldate.subtract(const Duration(days: 0));
//               var daterx_A = now.isAfter(earlier);
//               print(now.isAfter(earlier)); // true
//               print(now.isBefore(earlier)); // true

//               if (daterx_A == true) {
//                 setState(() {
//                   if (teNantModel.quantity == '1') {
//                     teNantModels.add(teNantModel);
//                   }
//                 });
//               }
//             }
//           }
//         } else {
//           setState(() {
//             if (teNantModels.isEmpty) {
//               preferences.remove('zonePSer');
//               preferences.remove('zonesPName');
//               zone_ser = null;
//               zone_name = null;
//             }
//           });
//         }
//         setState(() {
//           _teNantModels = teNantModels;

//           zone_ser = preferences.getString('zonePSer');
//           zone_name = preferences.getString('zonesPName');
//         });
//       } catch (e) {}
//     } else if (select == 3) {
//       String url = zone == null
//           ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
//           : zone == '0'
//               ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
//               : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

//       try {
//         var response = await http.get(Uri.parse(url));

//         var result = json.decode(response.body);
//         print(result);
//         if (result != null) {
//           for (var map in result) {
//             TeNantModel teNantModel = TeNantModel.fromJson(map);
//             if (teNantModel.quantity == '1') {
//               if (datex.isAfter(
//                       DateTime.parse('${teNantModel.ldate} 00:00:00.000')
//                           .subtract(Duration(days: open_set_date))) ==
//                   true) {
//                 var daterx = teNantModel.ldate == null
//                     ? teNantModel.ldate_q
//                     : teNantModel.ldate;

//                 if (daterx != null) {
//                   int daysBetween(DateTime from, DateTime to) {
//                     from = DateTime(from.year, from.month, from.day);
//                     to = DateTime(to.year, to.month, to.day);
//                     return (to.difference(from).inHours / 24).round();
//                   }

//                   var birthday = DateTime.parse('$daterx 00:00:00.000')
//                       .add(const Duration(days: -30));
//                   var date2 = DateTime.now();
//                   var difference = daysBetween(birthday, date2);

//                   print('difference == $difference');

//                   var daterx_now = DateTime.now();

//                   var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

//                   final now = DateTime.now();
//                   final earlier =
//                       daterx_ldate.subtract(const Duration(days: 0));
//                   var daterx_A = now.isAfter(earlier);
//                   print(now.isAfter(earlier)); // true
//                   print(now.isBefore(earlier)); // true

//                   if (daterx_A != true) {
//                     setState(() {
//                       teNantModels.add(teNantModel);
//                     });
//                   }
//                 }
//               }
//             }
//           }
//         } else {
//           setState(() {
//             if (teNantModels.isEmpty) {
//               preferences.remove('zonePSer');
//               preferences.remove('zonesPName');
//               zone_ser = null;
//               zone_name = null;
//             }
//           });
//         }
//         setState(() {
//           _teNantModels = teNantModels;

//           zone_ser = preferences.getString('zonePSer');
//           zone_name = preferences.getString('zonesPName');
//         });
//       } catch (e) {}
//     } else if (select == 4) {
//       String url = zone == null
//           ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
//           : zone == '0'
//               ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
//               : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

//       try {
//         var response = await http.get(Uri.parse(url));

//         var result = json.decode(response.body);
//         print(result);
//         if (result != null) {
//           for (var map in result) {
//             TeNantModel teNantModel = TeNantModel.fromJson(map);
//             if (teNantModel.quantity == '2' || teNantModel.quantity == '3') {
//               setState(() {
//                 teNantModels.add(teNantModel);
//               });
//             }
//           }
//         } else {
//           setState(() {
//             if (teNantModels.isEmpty) {
//               preferences.remove('zonePSer');
//               preferences.remove('zonesPName');
//               zone_ser = null;
//               zone_name = null;
//             }
//           });
//         }
//         setState(() {
//           _teNantModels = teNantModels;

//           zone_ser = preferences.getString('zonePSer');
//           zone_name = preferences.getString('zonesPName');
//         });
//       } catch (e) {}
//     }
//   }

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
        // text = text.toLowerCase();
        setState(() {
          quotxSelectModels_Select.clear();
          ser_indexShow = null;
        });
        setState(() {
          teNantModels = _teNantModels.where((teNantModels) {
            var notTitle = teNantModels.lncode.toString();
            var notTitle2 = teNantModels.cid.toString();
            var notTitle3 = teNantModels.docno.toString();
            var notTitle4 = teNantModels.sname.toString();
            var notTitle5 = teNantModels.cname.toString();
            var notTitle6 = teNantModels.zn.toString();
            var notTitle7 = teNantModels.zser.toString();
            var notTitle8 = teNantModels.sdate.toString();
            var notTitle9 = teNantModels.fid.toString();
            var notTitle10 = teNantModels.sdate_q.toString();
            var notTitle11 = teNantModels.ldate_q.toString();
            var notTitle12 = teNantModels.wnote.toString();
            // var notTitle = teNantModels.lncode.toString().toLowerCase();
            // var notTitle2 = teNantModels.cid.toString().toLowerCase();
            // var notTitle3 = teNantModels.docno.toString().toLowerCase();
            // var notTitle4 = teNantModels.sname.toString().toLowerCase();
            // var notTitle5 = teNantModels.cname.toString().toLowerCase();
            // var notTitle6 = teNantModels.zn.toString().toLowerCase();
            // var notTitle7 = teNantModels.zser.toString().toLowerCase();
            // var notTitle8 = teNantModels.sdate.toString().toLowerCase();
            // var notTitle9 = teNantModels.fid.toString().toLowerCase();
            // var notTitle10 = teNantModels.sdate_q.toString().toLowerCase();
            // var notTitle11 = teNantModels.ldate_q.toString().toLowerCase();
            // var notTitle12 = teNantModels.wnote.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text) ||
                notTitle6.contains(text) ||
                notTitle7.contains(text) ||
                notTitle8.contains(text) ||
                notTitle9.contains(text) ||
                notTitle12.contains(text);
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
        // text = text.toLowerCase();
        setState(() {
          teNantModels = teNantModels.where((teNantModel) {
            var notTitle = teNantModel.lncode.toString();
            var notTitle2 = teNantModel.cid.toString();
            var notTitle3 = teNantModel.docno.toString();
            var notTitle4 = teNantModel.sname.toString();
            var notTitle5 = teNantModel.cname.toString();
            var notTitle6 = teNantModel.zn.toString();
            var notTitle7 = teNantModel.zser.toString();
            var notTitle8 = teNantModel.sdate.toString();
            var notTitle9 = teNantModel.fid.toString();
            var notTitle10 = teNantModel.sdate_q.toString();
            var notTitle11 = teNantModel.ldate_q.toString();
            // var notTitle = teNantModel.lncode.toString().toLowerCase();
            // var notTitle2 = teNantModel.cid.toString().toLowerCase();
            // var notTitle3 = teNantModel.docno.toString().toLowerCase();
            // var notTitle4 = teNantModel.sname.toString().toLowerCase();
            // var notTitle5 = teNantModel.cname.toString().toLowerCase();
            // var notTitle6 = teNantModel.zn.toString().toLowerCase();
            // var notTitle7 = teNantModel.zser.toString().toLowerCase();
            // var notTitle8 = teNantModel.sdate.toString().toLowerCase();
            // var notTitle9 = teNantModel.fid.toString().toLowerCase();
            // var notTitle10 = teNantModel.sdate_q.toString().toLowerCase();
            // var notTitle11 = teNantModel.ldate_q.toString().toLowerCase();
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
        // text = text.toLowerCase();
        setState(() {
          teNantModels = teNantModels.where((teNantModel) {
            var notTitle = teNantModel.lncode.toString();
            var notTitle2 = teNantModel.cid.toString();
            var notTitle3 = teNantModel.docno.toString();
            var notTitle4 = teNantModel.sname.toString();
            var notTitle5 = teNantModel.cname.toString();
            var notTitle6 = teNantModel.zn.toString();
            var notTitle7 = teNantModel.zser.toString();
            var notTitle8 = teNantModel.sdate.toString();
            var notTitle9 = teNantModel.fid.toString();
            var notTitle10 = teNantModel.sdate_q.toString();
            var notTitle11 = teNantModel.ldate_q.toString();
            // var notTitle = teNantModel.lncode.toString().toLowerCase();
            // var notTitle2 = teNantModel.cid.toString().toLowerCase();
            // var notTitle3 = teNantModel.docno.toString().toLowerCase();
            // var notTitle4 = teNantModel.sname.toString().toLowerCase();
            // var notTitle5 = teNantModel.cname.toString().toLowerCase();
            // var notTitle6 = teNantModel.zn.toString().toLowerCase();
            // var notTitle7 = teNantModel.zser.toString().toLowerCase();
            // var notTitle8 = teNantModel.sdate.toString().toLowerCase();
            // var notTitle9 = teNantModel.fid.toString().toLowerCase();
            // var notTitle10 = teNantModel.sdate_q.toString().toLowerCase();
            // var notTitle11 = teNantModel.ldate_q.toString().toLowerCase();
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

  ///----------------->
  _searchBar_Sub_TeNant() {
    return TextField(
      textAlign: TextAlign.center,
      controller: Text_searchBar_Sub_TeNant,
      autofocus: false,
      cursorHeight: 14,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: PeopleChaoScreen_Color.Colors_Text2_,
          fontFamily: Font_.Fonts_T),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.grey[100]!.withOpacity(0.5),
        hintText: ' Search...',
        hintStyle: const TextStyle(
            // fontSize: 12,
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
        var Text_searchBar2_ = Text_searchBar_Sub_TeNant.text.toLowerCase();

        setState(() {
          quotxSelectModels_Select.clear();
          ser_indexShow = null;
        });
        if (Date_ser == 0) {
          setState(() {
            teNantModels = _teNantModels.where((teNantModel) {
              var sdate_ = (teNantModel.sdate_q == null)
                  ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModel.sdate} 00:00:00'))}'
                  : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModel.sdate_q} 00:00:00'))}';
              var ldate_ = (teNantModel.ldate_q == null)
                  ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModel.ldate} 00:00:00'))}'
                  : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModel.ldate_q} 00:00:00'))}';

              var notTitle1 = sdate_.toString().toLowerCase();
              var notTitle2 = ldate_.toString().toLowerCase();

              return notTitle1.contains(text) || notTitle2.contains(text);
            }).toList();
          });
        } else if (Date_ser == 1) {
          setState(() {
            teNantModels = _teNantModels.where((teNantModel) {
              var sdate_ = (teNantModel.sdate_q == null)
                  ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModel.sdate} 00:00:00'))}'
                  : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModel.sdate_q} 00:00:00'))}';

              var notTitle1 = sdate_.toString().toLowerCase();

              return notTitle1.contains(text);
            }).toList();
          });
        } else if (Date_ser == 2) {
          setState(() {
            teNantModels = _teNantModels.where((teNantModel) {
              var ldate_ = (teNantModel.ldate_q == null)
                  ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModel.ldate} 00:00:00'))}'
                  : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModel.ldate_q} 00:00:00'))}';
              var notTitle2 = ldate_.toString().toLowerCase();

              return notTitle2.contains(text);
            }).toList();
          });
        }
        if (text.isEmpty) {
          read_tenant_limit();
        } else {}
      },
    );
  }

  ///----------------->
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
                        (Ser_QRpage == 1)
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Ser_QRpage = 0;
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        // border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '<< ย้อนกลับ ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
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
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1
                                          ? const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'โซนพื้นที่เช่า : ',
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
                                              ),
                                            )
                                          : const SizedBox(),
                                      Expanded(
                                        flex: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1
                                            ? 2
                                            : 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10)),
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
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
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
                                                    'zonePSer',
                                                    zoneSer.toString());
                                                preferences.setString(
                                                    'zonesPName',
                                                    zonesName.toString());

                                                setState(() {
                                                  // read_GC_tenant();
                                                  read_GC_areaSelect();
                                                });

                                                String? _route = preferences
                                                    .getString('route');
                                                MaterialPageRoute
                                                    materialPageRoute =
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            AdminScafScreen(
                                                                route: _route));
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    materialPageRoute,
                                                    (route) => false);
                                              },
                                              // onSaved: (value) {
                                              //   // selectedValue = value.toString();
                                              // },
                                            ),
                                          ),
                                        ),
                                      ),
                                      // (Status_ == 5 || Status_ == 6)
                                      //     ? Expanded(flex: 1, child: SizedBox())
                                      //     : Expanded(
                                      //         flex: 1,
                                      //         child: Padding(
                                      //           padding: EdgeInsets.all(8.0),
                                      //           child: Text(
                                      //             'ค้นหา:',
                                      //             textAlign: TextAlign.end,
                                      //             style: TextStyle(
                                      //                 color: PeopleChaoScreen_Color
                                      //                     .Colors_Text1_,
                                      //                 fontWeight: FontWeight.bold,
                                      //                 fontFamily:
                                      //                     FontWeight_.Fonts_T),
                                      //           ),
                                      //         ),
                                      //       ),
                                      // (Status_ == 5 || Status_ == 6)
                                      //     ? Expanded(flex: 4, child: SizedBox())
                                      //     : Expanded(
                                      //         // flex: MediaQuery.of(context)
                                      //         //             .size
                                      //         //             .shortestSide <
                                      //         //         MediaQuery.of(context).size.width * 1
                                      //         //     ? 8
                                      //         //     : 6,
                                      //         flex: 4,
                                      //         child: Padding(
                                      //           padding: const EdgeInsets.all(8.0),
                                      //           child: Container(
                                      //             decoration: BoxDecoration(
                                      //               color: AppbackgroundColor
                                      //                   .Sub_Abg_Colors,
                                      //               borderRadius:
                                      //                   const BorderRadius.only(
                                      //                       topLeft:
                                      //                           Radius.circular(10),
                                      //                       topRight:
                                      //                           Radius.circular(10),
                                      //                       bottomLeft:
                                      //                           Radius.circular(10),
                                      //                       bottomRight:
                                      //                           Radius.circular(10)),
                                      //               border: Border.all(
                                      //                   color: Colors.grey, width: 1),
                                      //             ),
                                      //             // width: 120,
                                      //             height: 40,
                                      //             child: _searchBar(),
                                      //           ),
                                      //         ),
                                      //       ),
                                      Expanded(
                                          flex: 5,
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
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                quotxSelectModels_Select
                                                                    .clear();
                                                                ser_indexShow =
                                                                    null;
                                                                Ser_QRpage = 1;
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                        .yellow[
                                                                    800],
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
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1),
                                                              ),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            4.0),
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(2.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .contact_emergency,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(2.0),
                                                                        child:
                                                                            Text(
                                                                          'Card',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text1_,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))
                                      // Expanded(
                                      //   // flex: MediaQuery.of(context)
                                      //   //             .size
                                      //   //             .shortestSide <
                                      //   //         MediaQuery.of(context).size.width * 1
                                      //   //     ? 8
                                      //   //     : 6,
                                      //   flex: 4,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Container(
                                      //       decoration: BoxDecoration(
                                      //         color:
                                      //             AppbackgroundColor.Sub_Abg_Colors,
                                      //         borderRadius: const BorderRadius.only(
                                      //             topLeft: Radius.circular(10),
                                      //             topRight: Radius.circular(10),
                                      //             bottomLeft: Radius.circular(10),
                                      //             bottomRight: Radius.circular(10)),
                                      //         border: Border.all(
                                      //             color: Colors.grey, width: 1),
                                      //       ),
                                      //       // width: 120,
                                      //       height: 40,
                                      //       child: _searchBar2(),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   // flex: MediaQuery.of(context)
                                      //   //             .size
                                      //   //             .shortestSide <
                                      //   //         MediaQuery.of(context).size.width * 1
                                      //   //     ? 8
                                      //   //     : 6,
                                      //   flex: 4,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Container(
                                      //       decoration: BoxDecoration(
                                      //         color:
                                      //             AppbackgroundColor.Sub_Abg_Colors,
                                      //         borderRadius: const BorderRadius.only(
                                      //             topLeft: Radius.circular(10),
                                      //             topRight: Radius.circular(10),
                                      //             bottomLeft: Radius.circular(10),
                                      //             bottomRight: Radius.circular(10)),
                                      //         border: Border.all(
                                      //             color: Colors.grey, width: 1),
                                      //       ),
                                      //       // width: 120,
                                      //       height: 40,
                                      //       child: _searchBar3(),
                                      //     ),
                                      //   ),
                                      // ),
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
                        (Ser_QRpage == 1)
                            ? SizedBox()
                            : Padding(
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
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1
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
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'ผู้เช่า :',
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T),
                                                      ),
                                                    ),
                                                    for (int i = 0;
                                                        i < Status.length;
                                                        i++)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              tappedIndex_ = '';
                                                            });
                                                            setState(() {
                                                              Status_ = i + 1;
                                                            });
                                                            setState(() {
                                                              Status_pe =
                                                                  Status[i]!;
                                                            });
                                                            if (Status_ == 6) {
                                                            } else if (Status_ ==
                                                                7) {
                                                              print(
                                                                  'ยกเลิกสัญญา');
                                                              read_GC_tenant_Cancel();
                                                            } else {
                                                              read_GC_areaSelect();
                                                            }
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: (i + 1 ==
                                                                      1)
                                                                  ? (Status_ ==
                                                                          i + 1)
                                                                      ? Colors.grey[
                                                                          700]
                                                                      : Colors.grey[
                                                                          300]
                                                                  : (i + 1 == 2)
                                                                      ? (Status_ ==
                                                                              i +
                                                                                  1)
                                                                          ? Colors.orange[
                                                                              700]
                                                                          : Colors.orange[
                                                                              200]
                                                                      : (i + 1 ==
                                                                              3)
                                                                          ? (Status_ == i + 1)
                                                                              ? Colors.blue[700]
                                                                              : Colors.blue[200]
                                                                          : (i + 1 == 4)
                                                                              ? (Status_ == i + 1)
                                                                                  ? Colors.deepPurple[700]
                                                                                  : Colors.deepPurple[200]
                                                                              : (i + 1 == 5)
                                                                                  ? (Status_ == i + 1)
                                                                                      ? Colors.indigo[700]
                                                                                      : Colors.indigo[200]
                                                                                  : (i + 1 == 6)
                                                                                      ? (Status_ == i + 1)
                                                                                          ? Colors.pink[700]
                                                                                          : Colors.pink[200]
                                                                                      : (Status_ == i + 1)
                                                                                          ? Colors.red[700]
                                                                                          : Colors.red[200],
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
                                                              border: (Status_ ==
                                                                      i + 1)
                                                                  ? Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 1)
                                                                  : null,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child: Text(
                                                                Status[i],
                                                                style: TextStyle(
                                                                    color: (Status_ ==
                                                                            i +
                                                                                1)
                                                                        ? Colors
                                                                            .white
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
                                    ],
                                  ),
                                ),
                              ),
                        BodyHome_Web()
                        // (!Responsive.isDesktop(context))
                        //     ? BodyHome_mobile()
                        //     : BodyHome_Web()
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
                                    quotxSelectModels_Select.clear();
                                    ser_indexShow = null;
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
                                  quotxSelectModels_Select.clear();
                                  ser_indexShow = null;
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
    return (Ser_QRpage == 1)
        ? People_GenQR()
        : (Status_ == 5)
            ? Rental_customers(updateMessage: updateMessage)
            : (Status_ == 6)
                ? Cancellation_notice()
                : (Status_ == 7)
                    ? BodyHome_TenantCancel()
                    : ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          dragStartBehavior: DragStartBehavior.start,
                          child: SizedBox(
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width * 0.85
                                : 1200,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Container(
                                      width: (Responsive.isDesktop(context))
                                          ? MediaQuery.of(context).size.width *
                                              0.85
                                          : 1200,
                                      decoration: BoxDecoration(
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
                                            // mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Text(
                                                  'ค้นหา :',
                                                  style: TextStyle(
                                                    color: ReportScreen_Color
                                                        .Colors_Text2_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                // flex: 1,
                                                child: Container(
                                                  height: 35, //Date_ser
                                                  // width: 150,
                                                  decoration: BoxDecoration(
                                                    color: AppbackgroundColor
                                                        .Sub_Abg_Colors,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                  child: _searchBar(),
                                                ),
                                              ),
                                              Container(
                                                  width: 150,
                                                  child: Next_page_Web())
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppbackgroundColor
                                                          .Sub_Abg_Colors
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.only(
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
                                                  // border: Border.all(color: Colors.white, width: 1),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: Text(
                                                        'ประเภทวันที่ :',
                                                        style: TextStyle(
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                          borderRadius: BorderRadius.only(
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
                                                        width: 150,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child:
                                                            DropdownButtonFormField2(
                                                          alignment:
                                                              Alignment.center,
                                                          focusColor:
                                                              Colors.white,
                                                          autofocus: false,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelAlignment:
                                                                FloatingLabelAlignment
                                                                    .center,
                                                            enabled: true,
                                                            hoverColor:
                                                                Colors.brown,
                                                            prefixIconColor:
                                                                Colors.blue,
                                                            fillColor: Colors
                                                                .white
                                                                .withOpacity(
                                                                    0.05),
                                                            filled: false,
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .red),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            focusedBorder:
                                                                const OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                              ),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        231,
                                                                        227,
                                                                        227),
                                                              ),
                                                            ),
                                                          ),
                                                          isExpanded: false,
                                                          // value: YEAR_Now,
                                                          hint: Text(
                                                            'ทั้งหมด',
                                                            maxLines: 2,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Colors.black,
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                          iconSize: 20,
                                                          buttonHeight: 30,
                                                          buttonWidth: 150,
                                                          // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                          dropdownDecoration:
                                                              BoxDecoration(
                                                            // color: Colors
                                                            //     .amber,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 1),
                                                          ),
                                                          items: const [
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: '0',
                                                              child: Text(
                                                                'ทั้งหมด',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: '1',
                                                              child: Text(
                                                                'วันที่เริ่มสัญญา',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: '2',
                                                              child: Text(
                                                                'วันที่สิ้นสุดสัญญา',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ],

                                                          onChanged:
                                                              (value) async {
                                                            setState(() {
                                                              Text_searchBar_Sub_TeNant
                                                                  .clear();
                                                              // _TransReBillModels =
                                                              //     TransReBillModels_;
                                                              Date_ser =
                                                                  int.parse(
                                                                      value!);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: Text(
                                                        'ค้นหาวันที่ :',
                                                        style: TextStyle(
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   height: 30, //Date_ser
                                                    //   width: 120,
                                                    //   child: _searchBar2(),
                                                    // )
                                                    Container(
                                                      height: 25, //Date_ser
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
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
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      child:
                                                          _searchBar_Sub_TeNant(),
                                                      //  _searchBar_Sub_TeNant(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 60,
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                  'เลขอ้างอิง',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
                                                      //fontSize: 10.0
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 40,
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.65,
                                        width: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85
                                            : 1200,
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
                                                              milliseconds: 25),
                                                          (i) => i),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData)
                                                          return const Text('');
                                                        double elapsed = double
                                                                .parse(snapshot
                                                                    .data
                                                                    .toString()) *
                                                            0.05;
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              (elapsed > 8.00)
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
                                                controller: _scrollController1,
                                                // itemExtent: 50,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: teNantModels.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      Material(
                                                        color: tappedIndex_ ==
                                                                index.toString()
                                                            ? tappedIndex_Color
                                                                .tappedIndex_Colors
                                                                .withOpacity(
                                                                    0.5)
                                                            : AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        child: Container(
                                                          // color: Colors.white,
                                                          // color: tappedIndex_ == index.toString()
                                                          //     ? tappedIndex_Color.tappedIndex_Colors
                                                          //         .withOpacity(0.5)
                                                          //     : null,
                                                          child: ListTile(
                                                            // onTap: () {
                                                            //   setState(() {
                                                            //     tappedIndex_ =
                                                            //         index.toString();
                                                            //   });
                                                            // },
                                                            title: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                // color: Colors.green[100]!
                                                                //     .withOpacity(0.5),
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 1,
                                                                  ),
                                                                ),
                                                              ),
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
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight: Radius.circular(
                                                                              10),
                                                                          bottomLeft: Radius.circular(
                                                                              10),
                                                                          bottomRight:
                                                                              Radius.circular(10)),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        PopupMenuButton(
                                                                      onOpened:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          quotxSelectModels_Select
                                                                              .clear();
                                                                          ser_indexShow =
                                                                              null;
                                                                          tappedIndex_ =
                                                                              index.toString();
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            InkWell(
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
                                                                            maxLines:
                                                                                1,
                                                                            'เรียกดู >',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      itemBuilder:
                                                                          (BuildContext context) =>
                                                                              [
                                                                        PopupMenuItem(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    if (renTal_lavel <= 2) {
                                                                                      Navigator.pop(context);
                                                                                      infomation();
                                                                                    } else {
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
                                                                                        ReturnBodyPeople = 'PeopleChaoScreen2';
                                                                                      });
                                                                                      Navigator.pop(context);
                                                                                    }
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
                                                                              teNantModels[index].cid == teNantModels[index].fid
                                                                                  ? SizedBox()
                                                                                  : InkWell(
                                                                                      onTap: () {
                                                                                        if (renTal_lavel <= 2) {
                                                                                          Navigator.pop(context);
                                                                                          infomation();
                                                                                        } else {
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
                                                                                        }
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
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          Tooltip(
                                                                        richMessage:
                                                                            TextSpan(
                                                                          text: teNantModels[index].docno == null
                                                                              ? teNantModels[index].cid == null
                                                                                  ? ''
                                                                                  : teNantModels[index].cid == teNantModels[index].fid
                                                                                      ? '${teNantModels[index].cid}'
                                                                                      : 'สัญญาเดิม ${teNantModels[index].fid}'
                                                                              : '${teNantModels[index].docno}',
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                HomeScreen_Color.Colors_Text1_,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                            //fontSize: 10.0
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          color:
                                                                              Colors.grey[200],
                                                                        ),
                                                                        child:
                                                                            AutoSizeText(
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              25,
                                                                          maxLines:
                                                                              1,
                                                                          teNantModels[index].docno == null
                                                                              ? teNantModels[index].cid == null
                                                                                  ? ''
                                                                                  : '${teNantModels[index].cid}'
                                                                              : '${teNantModels[index].docno}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
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
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        teNantModels[index].cname ==
                                                                                null
                                                                            ? teNantModels[index].cname_q == null
                                                                                ? ''
                                                                                : '${teNantModels[index].cname_q}'
                                                                            : '${teNantModels[index].cname}',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          Tooltip(
                                                                        richMessage:
                                                                            TextSpan(
                                                                          text: teNantModels[index].sname == null
                                                                              ? teNantModels[index].sname_q == null
                                                                                  ? ''
                                                                                  : '${teNantModels[index].sname_q}'
                                                                              : '${teNantModels[index].sname}',
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                HomeScreen_Color.Colors_Text1_,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                            //fontSize: 10.0
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          color:
                                                                              Colors.grey[200],
                                                                        ),
                                                                        child:
                                                                            AutoSizeText(
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              25,
                                                                          maxLines:
                                                                              1,
                                                                          teNantModels[index].sname == null
                                                                              ? teNantModels[index].sname_q == null
                                                                                  ? ''
                                                                                  : '${teNantModels[index].sname_q}'
                                                                              : '${teNantModels[index].sname}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
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
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        '${teNantModels[index].zn}',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text: teNantModels[index].ln_c ==
                                                                                null
                                                                            ? teNantModels[index].ln_q == null
                                                                                ? ''
                                                                                : '${teNantModels[index].ln_q}'
                                                                            : '${teNantModels[index].ln_c}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .grey[200],
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(2.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              25,
                                                                          maxLines:
                                                                              1,
                                                                          teNantModels[index].ln_c == null
                                                                              ? teNantModels[index].ln_q == null
                                                                                  ? ''
                                                                                  : '${teNantModels[index].ln_q}'
                                                                              : '${teNantModels[index].ln_c}',
                                                                          textAlign:
                                                                              TextAlign.left,
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
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        teNantModels[index].area_c ==
                                                                                null
                                                                            ? teNantModels[index].area_q == null
                                                                                ? ''
                                                                                : '${teNantModels[index].area_q}'
                                                                            : '${teNantModels[index].area_c}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        teNantModels[index].period ==
                                                                                null
                                                                            ? teNantModels[index].period_q == null
                                                                                ? ''
                                                                                : '${teNantModels[index].period_q}  ${teNantModels[index].rtname_q!.substring(3)}'
                                                                            : '${teNantModels[index].period}  ${teNantModels[index].rtname!.substring(3)}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        teNantModels[index].sdate_q ==
                                                                                null
                                                                            ? teNantModels[index].sdate == null
                                                                                ? ''
                                                                                : DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].sdate} 00:00:00')).toString()
                                                                            : DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].sdate_q} 00:00:00')).toString(),
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        teNantModels[index].ldate_q ==
                                                                                null
                                                                            ? teNantModels[index].ldate == null
                                                                                ? ''
                                                                                : DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].ldate} 00:00:00')).toString()
                                                                            : DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].ldate_q} 00:00:00')).toString(),
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        teNantModels[index].quantity ==
                                                                                '1'
                                                                            ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) == true
                                                                                ? 'หมดสัญญา'
                                                                                : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) == true
                                                                                    ? 'ใกล้หมดสัญญา'
                                                                                    : 'เช่าอยู่'
                                                                            : teNantModels[index].quantity == '2'
                                                                                ? 'เสนอราคา'
                                                                                : teNantModels[index].quantity == '3'
                                                                                    ? 'เสนอราคา(มัดจำ)'
                                                                                    : 'ว่าง',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: teNantModels[index].quantity == '1'
                                                                                ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) == true
                                                                                    ? Colors.red
                                                                                    : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) == true
                                                                                        ? Colors.orange.shade900
                                                                                        : Colors.black
                                                                                : teNantModels[index].quantity == '2'
                                                                                    ? Colors.blue
                                                                                    : teNantModels[index].quantity == '3'
                                                                                        ? Colors.blue
                                                                                        : Colors.green,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        teNantModels[index].wnote ==
                                                                                null
                                                                            ? ''
                                                                            : '${teNantModels[index].wnote}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            2.0),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 40,
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (renTal_lavel <=
                                                                                2) {
                                                                              infomation();
                                                                            } else {
                                                                              setState(() {
                                                                                tappedIndex_ = index.toString();
                                                                                if (ser_indexShow == index) {
                                                                                  quotxSelectModels_Select.clear();
                                                                                  ser_indexShow = null;
                                                                                } else {
                                                                                  red_quotx_Select(index);
                                                                                  ser_indexShow = index;
                                                                                }
                                                                              });
                                                                            }
                                                                          },
                                                                          child: CircleAvatar(
                                                                              backgroundColor: (ser_indexShow == index) ? Colors.red[700]!.withOpacity(0.5) : Colors.grey[600]!.withOpacity(0.5),
                                                                              child: Icon(
                                                                                (ser_indexShow == index) ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down_outlined,
                                                                                color: Colors.white,
                                                                                size: 20,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (ser_indexShow ==
                                                          index)
                                                        SizedBox(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .green[
                                                                        100],
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                8),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                8),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                0),
                                                                        bottomRight:
                                                                            Radius.circular(0)),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child:
                                                                      const Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0),
                                                                          child:
                                                                              Text(
                                                                            'งวด',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0),
                                                                          child:
                                                                              Text(
                                                                            'วันที่',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0),
                                                                          child:
                                                                              Text(
                                                                            'รายการ',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0),
                                                                          child:
                                                                              Text(
                                                                            'ยอด/งวด',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0),
                                                                          child:
                                                                              Text(
                                                                            'ยอด',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (quotxSelectModels_Select
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
                                                                            color:
                                                                                Colors.black12,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child: ListTile(
                                                                          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            'ไม่พบข้อมูล',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ]))),
                                                                for (int index2 =
                                                                        0;
                                                                    index2 <
                                                                        quotxSelectModels_Select
                                                                            .length;
                                                                    index2++)
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .green[50],
                                                                      border:
                                                                          const Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.black12,
                                                                          width:
                                                                              1,
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
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                8,
                                                                            // maxFontSize: 15,
                                                                            '${quotxSelectModels_Select[index2].unit} / ${quotxSelectModels_Select[index2].term} (งวด)',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                8,
                                                                            // maxFontSize: 15,
                                                                            '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels_Select[index2].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels_Select[index2].ldate!} 00:00:00'))}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${quotxSelectModels_Select[index2].expname}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[200],
                                                                            ),
                                                                            child:
                                                                                AutoSizeText(
                                                                              maxLines: 2,
                                                                              minFontSize: 8,
                                                                              // maxFontSize: 15,
                                                                              '${quotxSelectModels_Select[index2].expname}',
                                                                              textAlign: TextAlign.start,
                                                                              style: const TextStyle(
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  //fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        quotxSelectModels_Select[index2].ele_ty ==
                                                                                '0'
                                                                            ? Expanded(
                                                                                flex: 1,
                                                                                child: AutoSizeText(
                                                                                  maxLines: 2,
                                                                                  minFontSize: 8,
                                                                                  // maxFontSize: 15,
                                                                                  quotxSelectModels_Select[index2].qty == '0.00' ? '${nFormat.format(double.parse(quotxSelectModels_Select[index2].total!))} / งวด' : '${nFormat.format(double.parse(quotxSelectModels_Select[index2].qty!))} / หน่วย',
                                                                                  // '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                                  textAlign: TextAlign.end,
                                                                                  style: const TextStyle(
                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                      //fontWeight: FontWeight.bold,
                                                                                      fontFamily: Font_.Fonts_T),
                                                                                ),
                                                                              )
                                                                            : Expanded(
                                                                                flex: 1,
                                                                                child: AutoSizeText(
                                                                                  maxLines: 2,
                                                                                  minFontSize: 8,
                                                                                  // maxFontSize: 15,
                                                                                  'อัตราพิเศษ',
                                                                                  // '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                                  textAlign: TextAlign.end,
                                                                                  style: const TextStyle(
                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                      //fontWeight: FontWeight.bold,
                                                                                      fontFamily: Font_.Fonts_T),
                                                                                ),
                                                                              ),
                                                                        quotxSelectModels_Select[index2].ele_ty ==
                                                                                '0'
                                                                            ? Expanded(
                                                                                flex: 1,
                                                                                child: AutoSizeText(
                                                                                  maxLines: 2,
                                                                                  minFontSize: 8,
                                                                                  // maxFontSize: 15,
                                                                                  '${nFormat.format(int.parse(quotxSelectModels_Select[index2].term!) * double.parse(quotxSelectModels_Select[index2].total!))}',
                                                                                  textAlign: TextAlign.end,
                                                                                  style: const TextStyle(
                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                      //fontWeight: FontWeight.bold,
                                                                                      fontFamily: Font_.Fonts_T),
                                                                                ),
                                                                              )
                                                                            : Expanded(
                                                                                flex: 1,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    showcountmiter(index2).then((value) => showDialog(
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
                                                                                                              style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontWeight: FontWeight.bold, fontSize: 25, fontFamily: Font_.Fonts_T),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Divider(),
                                                                                                    (double.parse(electricityModels[0].eleMitOne!) + double.parse(electricityModels[0].eleGobOne!)) == 0.00
                                                                                                        ? SizedBox()
                                                                                                        : Row(
                                                                                                            children: [
                                                                                                              Expanded(flex: 1, child: Text('')),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  'หน่วยที่ 0 - ${electricityModels[0].eleOne}',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitOne!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitOne!) == 0.00 ? '${electricityModels[0].eleGobOne}' : '${electricityModels[0].eleMitOne}',
                                                                                                                  textAlign: TextAlign.end,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Text(
                                                                                                                  'บาท',
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                    SizedBox(
                                                                                                      height: 10,
                                                                                                    ),
                                                                                                    (double.parse(electricityModels[0].eleMitTwo!) + double.parse(electricityModels[0].eleGobTwo!)) == 0.00
                                                                                                        ? SizedBox()
                                                                                                        : Row(
                                                                                                            children: [
                                                                                                              Expanded(flex: 1, child: Text('')),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  'หน่วยที่ ${int.parse(electricityModels[0].eleOne!) + 1} - ${electricityModels[0].eleTwo}',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitTwo!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitTwo!) == 0.00 ? '${electricityModels[0].eleGobTwo}' : '${electricityModels[0].eleMitTwo}',
                                                                                                                  textAlign: TextAlign.end,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Text(
                                                                                                                  'บาท',
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                    SizedBox(
                                                                                                      height: 10,
                                                                                                    ),
                                                                                                    (double.parse(electricityModels[0].eleMitThree!) + double.parse(electricityModels[0].eleGobThree!)) == 0.00
                                                                                                        ? SizedBox()
                                                                                                        : Row(
                                                                                                            children: [
                                                                                                              Expanded(flex: 1, child: Text('')),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  'หน่วยที่ ${int.parse(electricityModels[0].eleTwo!) + 1} - ${electricityModels[0].eleThree}',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitThree!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitThree!) == 0.00 ? '${electricityModels[0].eleGobThree}' : '${electricityModels[0].eleMitThree}',
                                                                                                                  textAlign: TextAlign.end,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Text(
                                                                                                                  'บาท',
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                    SizedBox(
                                                                                                      height: 10,
                                                                                                    ),
                                                                                                    (double.parse(electricityModels[0].eleMitTour!) + double.parse(electricityModels[0].eleGobTour!)) == 0.00
                                                                                                        ? SizedBox()
                                                                                                        : Row(
                                                                                                            children: [
                                                                                                              Expanded(flex: 1, child: Text('')),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  'หน่วยที่ ${int.parse(electricityModels[0].eleThree!) + 1} - ${electricityModels[0].eleTour}',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitTour!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitTour!) == 0.00 ? '${electricityModels[0].eleGobTour}' : '${electricityModels[0].eleMitTour}',
                                                                                                                  textAlign: TextAlign.end,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Text(
                                                                                                                  'บาท',
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                    SizedBox(
                                                                                                      height: 10,
                                                                                                    ),
                                                                                                    (double.parse(electricityModels[0].eleMitFive!) + double.parse(electricityModels[0].eleGobFive!)) == 0.00
                                                                                                        ? SizedBox()
                                                                                                        : Row(
                                                                                                            children: [
                                                                                                              Expanded(flex: 1, child: Text('')),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  'หน่วยที่ ${int.parse(electricityModels[0].eleTour!) + 1} - ${electricityModels[0].eleFive}',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitFive!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitFive!) == 0.00 ? '${electricityModels[0].eleGobFive}' : '${electricityModels[0].eleMitFive}',
                                                                                                                  textAlign: TextAlign.end,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Text(
                                                                                                                  'บาท',
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                    SizedBox(
                                                                                                      height: 10,
                                                                                                    ),
                                                                                                    (double.parse(electricityModels[0].eleMitSix!) + double.parse(electricityModels[0].eleGobSix!)) == 0.00
                                                                                                        ? SizedBox()
                                                                                                        : Row(
                                                                                                            children: [
                                                                                                              Expanded(flex: 1, child: Text('')),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  'หน่วยที่ ${electricityModels[0].eleSix} ขึ้นไป',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitSix!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                                  textAlign: TextAlign.start,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 2,
                                                                                                                child: Text(
                                                                                                                  double.parse(electricityModels[0].eleMitSix!) == 0.00 ? '${electricityModels[0].eleGobSix}' : '${electricityModels[0].eleMitSix}',
                                                                                                                  textAlign: TextAlign.end,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Text(
                                                                                                                  'บาท',
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
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
                                                                                                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: Font_.Fonts_T),
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
                                                                                        }));
                                                                                  },
                                                                                  child: AutoSizeText(
                                                                                    maxLines: 2,
                                                                                    minFontSize: 8,
                                                                                    // maxFontSize: 15,
                                                                                    'ดูอัตราคำนวณ',
                                                                                    // '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                                    textAlign: TextAlign.end,
                                                                                    style: const TextStyle(
                                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                        //fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        // Expanded(
                                                                        //   flex: 1,
                                                                        //   child:
                                                                        //       AutoSizeText(
                                                                        //     maxLines:
                                                                        //         2,
                                                                        //     minFontSize:
                                                                        //         8,
                                                                        //     // maxFontSize: 15,
                                                                        //     '${quotxSelectModels_Select[index2].unit} / ${quotxSelectModels_Select[index2].term} (งวด)',
                                                                        //     textAlign:
                                                                        //         TextAlign.start,
                                                                        //     style: const TextStyle(
                                                                        //         color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //         //fontWeight: FontWeight.bold,
                                                                        //         fontFamily: Font_.Fonts_T),
                                                                        //   ),
                                                                        // ),
                                                                        // Expanded(
                                                                        //   flex: 1,
                                                                        //   child:
                                                                        //       AutoSizeText(
                                                                        //     maxLines:
                                                                        //         2,
                                                                        //     minFontSize:
                                                                        //         8,
                                                                        //     // maxFontSize: 15,
                                                                        //     '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels_Select[index2].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels_Select[index2].ldate!} 00:00:00'))}',
                                                                        //     textAlign:
                                                                        //         TextAlign.start,
                                                                        //     style: const TextStyle(
                                                                        //         color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //         //fontWeight: FontWeight.bold,
                                                                        //         fontFamily: Font_.Fonts_T),
                                                                        //   ),
                                                                        // ),
                                                                        // Expanded(
                                                                        //   flex: 1,
                                                                        //   child:
                                                                        //       Tooltip(
                                                                        //     richMessage:
                                                                        //         TextSpan(
                                                                        //       text:
                                                                        //           '${quotxSelectModels_Select[index2].expname}',
                                                                        //       style:
                                                                        //           const TextStyle(
                                                                        //         color:
                                                                        //             HomeScreen_Color.Colors_Text1_,
                                                                        //         fontWeight:
                                                                        //             FontWeight.bold,
                                                                        //         fontFamily:
                                                                        //             FontWeight_.Fonts_T,
                                                                        //         //fontSize: 10.0
                                                                        //       ),
                                                                        //     ),
                                                                        //     decoration:
                                                                        //         BoxDecoration(
                                                                        //       borderRadius:
                                                                        //           BorderRadius.circular(5),
                                                                        //       color:
                                                                        //           Colors.grey[200],
                                                                        //     ),
                                                                        //     child:
                                                                        //         AutoSizeText(
                                                                        //       maxLines:
                                                                        //           2,
                                                                        //       minFontSize:
                                                                        //           8,
                                                                        //       // maxFontSize: 15,
                                                                        //       '${quotxSelectModels_Select[index2].expname}',
                                                                        //       textAlign:
                                                                        //           TextAlign.start,
                                                                        //       style: const TextStyle(
                                                                        //           color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //           //fontWeight: FontWeight.bold,
                                                                        //           fontFamily: Font_.Fonts_T),
                                                                        //     ),
                                                                        //   ),
                                                                        // ),
                                                                        // Expanded(
                                                                        //   flex: 1,
                                                                        //   child:
                                                                        //       AutoSizeText(
                                                                        //     maxLines:
                                                                        //         2,
                                                                        //     minFontSize:
                                                                        //         8,
                                                                        //     // maxFontSize: 15,
                                                                        //     '${nFormat.format(double.parse(quotxSelectModels_Select[index2].total!))}',
                                                                        //     textAlign:
                                                                        //         TextAlign.end,
                                                                        //     style: const TextStyle(
                                                                        //         color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //         //fontWeight: FontWeight.bold,
                                                                        //         fontFamily: Font_.Fonts_T),
                                                                        //   ),
                                                                        // ),
                                                                        // Expanded(
                                                                        //   flex: 1,
                                                                        //   child:
                                                                        //       AutoSizeText(
                                                                        //     maxLines:
                                                                        //         2,
                                                                        //     minFontSize:
                                                                        //         8,
                                                                        //     // maxFontSize: 15,
                                                                        //     '${nFormat.format(int.parse(quotxSelectModels_Select[index2].term!) * double.parse(quotxSelectModels_Select[index2].total!))}',
                                                                        //     textAlign:
                                                                        //         TextAlign.end,
                                                                        //     style: const TextStyle(
                                                                        //         color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //         //fontWeight: FontWeight.bold,
                                                                        //         fontFamily: Font_.Fonts_T),
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    )),
                                                                  ),
                                                                SizedBox(
                                                                  height: 30,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                },
                                              ),
                                      ),
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          _scrollController1
                                                              .animateTo(
                                                            0,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 1),
                                                            curve:
                                                                Curves.easeOut,
                                                          );
                                                        },
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: AppbackgroundColor
                                                              //     .TiTile_Colors,
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          6),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          6),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          6),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          8)),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child: const Text(
                                                              'Top',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      10.0,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            )),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (_scrollController1
                                                            .hasClients) {
                                                          final position =
                                                              _scrollController1
                                                                  .position
                                                                  .maxScrollExtent;
                                                          _scrollController1
                                                              .animateTo(
                                                            position,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 1),
                                                            curve:
                                                                Curves.easeOut,
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: AppbackgroundColor
                                                            //     .TiTile_Colors,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                topRight: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            6)),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: const Text(
                                                            'Down',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10.0,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: _moveUp1,
                                                      child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_upward,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: AppbackgroundColor
                                                          //     .TiTile_Colors,
                                                          borderRadius: const BorderRadius
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
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: const Text(
                                                          'Scroll',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10.0,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        )),
                                                    InkWell(
                                                      onTap: _moveDown1,
                                                      child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_downward,
                                                              color:
                                                                  Colors.grey,
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
                        decoration: BoxDecoration(
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
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    'ค้นหา :',
                                    style: TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // flex: 1,
                                  child: Container(
                                    height: 35, //Date_ser
                                    // width: 150,
                                    decoration: BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    child: _searchBar(),
                                  ),
                                ),
                                Container(width: 150, child: Next_page_Web())
                              ],
                            ),
                            const Divider(),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Expanded(child: Next_page_Web()),
                            //   ],
                            // ),
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
                                                      (teNantModels[index]
                                                                  .cc_date ==
                                                              null)
                                                          ? '${teNantModels[index].cc_date}'
                                                          : '${DateFormat('dd-MM').format(DateTime.parse('${teNantModels[index].cc_date} 00:00:00'))}-${DateTime.parse('${teNantModels[index].cc_date} 00:00:00').year + 543}',
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
                                                              if (renTal_lavel <=
                                                                  2) {
                                                                // Navigator.pop(
                                                                //     context);
                                                                infomation();
                                                              } else {
                                                                setState(() {
                                                                  tappedIndex_ =
                                                                      index
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
                                                                var Cid = teNantModels[index]
                                                                            .docno ==
                                                                        null
                                                                    ? '${teNantModels[index].cid}'
                                                                    : '${teNantModels[index].docno}';
                                                                _showMyDialog_SAVE(
                                                                    Cid,
                                                                    newValuePDFimg);
                                                              }
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
          backgroundColor: AppBarColors.hexColor,
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
