// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member
import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/AdminScaffold/AdminScaffold.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:intl/intl.dart';
import 'package:popup_menu_plus/popup_menu_plus.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../Constant/Myconstant.dart';

import '../Home/home_reservespace_calendar.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetArea_quot.dart';
import '../Model/GetAreax_con_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetSubZone_Model.dart';
import '../Model/GetZone_Model.dart';

import '../PeopleChao/PeopleChao_Screen2.dart';
import '../Responsive/responsive.dart';

import '../Style/colors.dart';
import 'package:http/http.dart' as http;

import 'ChaoAreaBid_Screen.dart';
import 'ChaoAreaRenew_Screen.dart';
import 'package:xml/xml.dart';

import 'loadSvgImage.dart';
import '../Style/view_pagenow.dart';

class ChaoAreaScreen extends StatefulWidget {
  const ChaoAreaScreen({super.key});

  @override
  State<ChaoAreaScreen> createState() => _ChaoAreaScreenState();
}

class _ChaoAreaScreenState extends State<ChaoAreaScreen> {
  List<GlobalKey> _btnKeys = [];
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  int switcherIndex1 = 0;
  int Status_ = 1;
  int Ser_Body = 0;
  String Visit_ = 'grid'; //มุมมอง Visit_ = 'grid';
  String Ser_nowpage = '1';
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  ///////---------------------------------------------------->
  String? ser_Floor_plans;
  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];
  List<AreaQuotModel> areaQuotModels = [];
  List<AreaModel> areaFloorplanModels = [];
  List<AreaModel> _areaModels = <AreaModel>[];
  List<RenTalModel> renTalModels = [];
  List<SubZoneModel> subzoneModels = [];
  List<AreaxConModel> areaxConModels = [];
  List Area_ = [
    'คอมมูนิตี้มอลล์',
    'ออฟฟิศให้เช่า',
    'ตลาดนัด',
    'อื่นๆ',
  ];
  List buttonview_ = [
    'เรียกดู'
    // 'ข้อมูลการเช่า',
    // 'ตั้งหนี้/วางบิล',
    // 'รับชำระ',
    // 'ลดหนี้',
    // 'ประวัติบิล',
  ];
  List buttonview_2 = [
    '+เสนอราคา'
        '+ทำ/ต่อสัญญา',
  ];
  List Status = [
    'ทั้งหมด',
    'ใกล้หมดสัญญา',
    'เสนอราคา',
    'ว่าง',
    'เช่าอยู่',
    'หมดสัญญา',
  ];
  List Year_ = [
    'ทั้งหมด',
    for (int i = 0; i < 10; i++) '${2565 - i}',
  ];

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
      Value_stasus;
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
  String? a_ser, a_area, a_rent, a_ln, a_page, ser_cidtan;
  String? rtname, type, typex, renname, pkname, ser_Zonex;
  int? pkqty, pkuser, countarae;
  /////////////----------------------------------------->
  // List<Country> countries = [];
  AreaModel? areaFloorplanModelss;
  TransformationController _controller = TransformationController();
  Key _countriesKey = UniqueKey();
  void _zoomInSVG() {
    _controller.value *= Matrix4.identity()..scale(1.2);
  }

  void _zoomOutSVG() {
    _controller.value *= Matrix4.identity()..scale(0.8);
  }

  //////////////---------------------------------------------->
  String? Name_, Img_, Img_logo_, Province_, DBN_, Typex_, Img_rental_;
  int open_set_date = 30;
  int renTal_lavel = 0;
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_Sub_zone();
    read_GC_zone();
    read_GC_area();
    read_GC_rental();

    _areaModels = areaModels;
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

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
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
            DBN_ = renTalModel.dbn;
            pkname = pkx;
            img_ = img;
            img_logo = imglogo;
            ser_Floor_plans = renTalModel.Floor_plans!;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    // print('name>>>>>  $renname');
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
      //print(result);
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
      zone_ser = preferences.getString('zoneSer');
      zone_name = preferences.getString('zonesName');
      zone_Subser = preferences.getString('zoneSubSer');
      zone_Subname = preferences.getString('zonesSubName');
    });

    int selectedIndex = zoneModels.indexWhere(
        (element) => element.ser == zone_ser && element.zn == zone_name);

    // print('Selected index: $selectedIndex');
    if (selectedIndex == 0) {
    } else {
      Img_Zone =
          '${MyConstant().domain}/files/$DBN_/zone/${zoneModels[selectedIndex].img}';
      // Img_Zone =
      //     'https://dzentric.com/chao_perty/chao_api/files/${DBN_}/zone/${zoneModels[selectedIndex].img}';
      Imgfloorplan =
          '${MyConstant().domain}/files/$DBN_/zone/${zoneModels[selectedIndex].img_floorplan}';
    }

    setState(() {
      areaFloorplanModels.clear;
      areaModels.clear();
      _areaModels.clear();
      // read_GC_area();
    });
  }

  Future<Null> read_GC_area() async {
    if (areaModels.isNotEmpty) {
      setState(() {
        areaQuotModels.clear();
        areaModels.clear();
        _areaModels.clear();
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
      // print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);

          setState(() {
            areaModels.add(areaModel);
          });

          if (areaModel.quantity != '1' && areaModel.quantity != null) {
            var qin = areaModel.ln_q;
            var qinser = areaModel.ser;
            String url =
                '${MyConstant().domain}/GC_area_quot.php?isAdd=true&ren=$ren&qin=$qin&qinser=$qinser';

            try {
              var response = await http.get(Uri.parse(url));

              var result = json.decode(response.body);
              // print(result);
              if (result != null) {
                for (var map in result) {
                  AreaQuotModel areaQuotModel = AreaQuotModel.fromJson(map);
                  setState(() {
                    areaQuotModels.add(areaQuotModel);
                  });
                }
              }
            } catch (e) {}
          }
        }
        // print(
        //     'areaQuotModels.length>>>>>>>> ${areaQuotModels.length} ${areaQuotModels.map((e) => '152' == e.ser ? e.docno : '0').toString()}');
        if (zone == null || zone == '0') {
          setState(() {
            areaFloorplanModels.clear();
          });
        } else {
          setState(() {
            loadSvg();
          });
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
        _areaModels = areaModels;
        zone_ser = preferences.getString('zoneSer');
        zone_name = preferences.getString('zonesName');
      });
      _btnKeys = List.generate(areaModels.length, (_) => GlobalKey());

      // print(
      //     'zoneModels >>. ${zoneModels.length} ${areaModels.map((e) => e.zser).toString()}');
    } catch (e) {}
  }
////////////------------------------------------------>

  ////////////------------------------------------------>
  Future<Null> loadareaQuot(index) async {
    if (areaQuotModels.isNotEmpty) {
      setState(() {
        areaQuotModels.clear();
      });

      SharedPreferences preferences = await SharedPreferences.getInstance();

      var ren = preferences.getString('renTalSer');
      var zone = preferences.getString('zoneSer');

      var qin = areaModels[index].ln_q;
      var qinser = areaModels[index].ser;

      String url =
          '${MyConstant().domain}/GC_area_quot.php?isAdd=true&ren=$ren&qin=$qin&qinser=$qinser';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
        if (result != null) {
          for (var map in result) {
            AreaQuotModel areaQuotModel = AreaQuotModel.fromJson(map);
            setState(() {
              areaQuotModels.add(areaQuotModel);
            });
          }
        }
      } catch (e) {}
    }
  }

  void loadSvg() async {
    setState(() {
      areaFloorplanModels.clear();
      areaFloorplanModels.clear();
    });

    // Update the key of the KeyedSubtree widget
    _countriesKey = UniqueKey();

    List<AreaModel> loadedCountries =
        await loadSvgImage(svgImage: '$Imgfloorplan', areaModels: areaModels);

    setState(() {
      areaFloorplanModels = loadedCountries;
    });
  }

  void onCountrySelected(AreaModel areaFloorplanModel) {
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

  Future<Null> read_GC_areaSelect(int select) async {
    if (areaModels.length != 0) {
      areaModels.clear();
      _areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $select');

    if (select == 1) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
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
          _areaModels = areaModels;
          zone_ser = preferences.getString('zoneSer');
          zone_name = preferences.getString('zonesName');
        });
      } catch (e) {}
    } else if (select == 2) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
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
          _areaModels = areaModels;
          zone_ser = preferences.getString('zoneSer');
          zone_name = preferences.getString('zonesName');
        });
      } catch (e) {}
    } else if (select == 3) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
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
          _areaModels = areaModels;
          zone_ser = preferences.getString('zoneSer');
          zone_name = preferences.getString('zonesName');
        });
      } catch (e) {}
    } else if (select == 4) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
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
          _areaModels = areaModels;
          zone_ser = preferences.getString('zoneSer');
          zone_name = preferences.getString('zonesName');
        });
      } catch (e) {}
    } else if (select == 5) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
        if (result != null) {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);

            if (areaModel.quantity == '1') {
              setState(() {
                if (datex.isAfter(
                            DateTime.parse('${areaModel.ldate} 00:00:00.000')
                                .subtract(const Duration(days: 0))) !=
                        true ||
                    datex.isAfter(
                            DateTime.parse('${areaModel.ldate} 00:00:00.000')
                                .subtract(Duration(days: open_set_date))) !=
                        true) {
                  areaModels.add(areaModel);
                }
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
          _areaModels = areaModels;
          zone_ser = preferences.getString('zoneSer');
          zone_name = preferences.getString('zonesName');
        });
      } catch (e) {}
    } else if (select == 6) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
        if (result != null) {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);
            if (areaModel.quantity == '1') {
              setState(() {
                if (datex.isAfter(
                        DateTime.parse('${areaModel.ldate} 00:00:00.000')
                            .subtract(const Duration(days: 0))) ==
                    true) {
                  areaModels.add(areaModel);
                }
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
          _areaModels = areaModels;
          zone_ser = preferences.getString('zoneSer');
          zone_name = preferences.getString('zonesName');
        });
      } catch (e) {}
    } else if (select == 7) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
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
          _areaModels = areaModels;
          zone_ser = preferences.getString('zoneSer');
          zone_name = preferences.getString('zonesName');
        });
      } catch (e) {}
    }
  }

  _searchBar() {
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
          // fontSize: 20.0,
          color: TextHome_Color.TextHome_Colors,
        ),
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
        text = text;
        setState(() {
          areaModels = _areaModels.where((areaModel) {
            var notTitle0 = areaModel.zn.toString();
            var notTitle1 = areaModel.ln.toString();
            var notTitle = areaModel.lncode.toString();
            var notsname = areaModel.sname.toString();
            var notcname = areaModel.cname.toString();
            var notcid = areaModel.cid.toString();
            var notfid = areaModel.fid.toString();
            return notTitle.contains(text) ||
                notTitle0.contains(text) ||
                notTitle1.contains(text) ||
                notsname.contains(text) ||
                notcname.contains(text) ||
                notcid.contains(text) ||
                notfid.contains(text);
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

  ///////////////------------------------------------------------->
  double _scaleFactor = 1.0; // define the initial scale factor

  void _zoomIn() {
    setState(() {
      _scaleFactor *= 1.2; // increase the scale factor by 20%
    });
  }

  void _zoomOut() {
    setState(() {
      _scaleFactor /= 1.2; // decrease the scale factor by 20%
    });
  }

  ///----------------->
  @override
  Widget build(BuildContext context) {
    double hi_ = MediaQuery.of(context).size.height / 1.7;
    return SingleChildScrollView(
      child: Column(
        children: [
          if ((Ser_Body == 0))
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                'พื้นที่เช่า ',
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
                                ' > > ',
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
          //      if ((Ser_Body == 0))  Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Align(
          //       alignment: Alignment.topLeft,
          //       child: viewpage(context, '$Ser_nowpage'),
          //     ),
          //   ],
          // ),
          if ((Ser_Body != 0 && Ser_Body != 5))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 8,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 1,
                      Ser_Body == 1
                          ? 'เสนอราคา'
                          : Ser_Body == 2
                              ? 'ทำ/ต่อสัญญา'
                              : '',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 20,
                          color: PeopleChaoScreen_Color.Colors_Text2_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Ser_Body = 0;
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
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'ปิด',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
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
          if ((Ser_Body == 0))
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    subzoneModels.length == 1
                        ? SizedBox()
                        : MediaQuery.of(context).size.shortestSide <
                                MediaQuery.of(context).size.width * 1
                            ? const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'โซน:',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  ),
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
                        ? const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'โซนพื้นที่เช่า:',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ))
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
                              zone_name == null ? 'ทั้งหมด' : '$zone_name',
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: TextHome_Color.TextHome_Colors,
                            ),
                            style: const TextStyle(
                                color: Colors.green, fontFamily: Font_.Fonts_T),
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
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ))
                                .toList(),

                            onChanged: (value) async {
                              //   var zones = value!.indexOf(',');
                              // var zoneSer = value.substring(0, zones);
                              // var zonesName = value.substring(zones + 1);
                              // var zonesNames = zonesName.indexOf(',');
                              // var zonesNamenew =
                              //     zonesName.substring(0, zonesNames);
                              // var zonesNamesub =
                              //     zonesName.substring(zonesNames + 1);
                              // print(
                              //     'mmmmm>> zoneSer $zoneSer mmmm>>zonesName $zonesName mmmm>>zonesNames $zonesNames mmmm>>zonesNamenew $zonesNamenew mmmm>>zonesNamesub $zonesNamesub');

                              var zones = value!.indexOf(',');
                              var zoneSer = value.substring(0, zones);
                              var zonesName = value.substring(zones + 1);
                              // print('mmmmm ${zoneSer.toString()} $zonesName');

                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setString(
                                  'zoneSer', zoneSer.toString());
                              preferences.setString(
                                  'zonesName', zonesName.toString());

                              int selectedIndex = zoneModels.indexWhere(
                                  (element) =>
                                      element.ser == zoneSer &&
                                      element.zn == zonesName);

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
                                read_GC_area();
                              });
                              // print(selectedIndex);
                              // print(selectedIndex);
                              // print(selectedIndex);
                              // print(selectedIndex);
                            },
                            // onSaved: (value) {
                            //   // selectedValue = value.toString();
                            // },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: MediaQuery.of(context).size.shortestSide <
                              MediaQuery.of(context).size.width * 1
                          ? 1
                          : 2,
                      child: const Padding(
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
                    ),
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
                          // width: 120,
                          height: 40,
                          child: _searchBar(),
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
                    //                       color: PeopleChaoScreen_Color
                    //                           .Colors_Text1_,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontFamily: FontWeight_.Fonts_T),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Container(
                    //                   decoration: BoxDecoration(
                    //                     color:
                    //                         AppbackgroundColor.Sub_Abg_Colors,
                    //                     borderRadius: const BorderRadius.only(
                    //                         topLeft: Radius.circular(10),
                    //                         topRight: Radius.circular(10),
                    //                         bottomLeft: Radius.circular(10),
                    //                         bottomRight: Radius.circular(10)),
                    //                     border: Border.all(
                    //                         color: Colors.grey, width: 1),
                    //                   ),
                    //                   width: 150,
                    //                   child: DropdownButtonFormField2(
                    //                     decoration: InputDecoration(
                    //                       isDense: true,
                    //                       contentPadding: EdgeInsets.zero,
                    //                       border: OutlineInputBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
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
                    //                           color: PeopleChaoScreen_Color
                    //                               .Colors_Text2_,
                    //                           fontFamily: Font_.Fonts_T),
                    //                     ),
                    //                     icon: const Icon(
                    //                       Icons.arrow_drop_down,
                    //                       color: TextHome_Color.TextHome_Colors,
                    //                     ),
                    //                     style: const TextStyle(
                    //                         color: Colors.green,
                    //                         fontFamily: Font_.Fonts_T),
                    //                     iconSize: 30,
                    //                     buttonHeight: 40,
                    //                     // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    //                     dropdownDecoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(10),
                    //                     ),
                    //                     items: zoneModels
                    //                         .map((item) =>
                    //                             DropdownMenuItem<String>(
                    //                               value:
                    //                                   '${item.ser},${item.zn}',
                    //                               child: Text(
                    //                                 item.zn!,
                    //                                 style: const TextStyle(
                    //                                     fontSize: 14,
                    //                                     fontFamily:
                    //                                         Font_.Fonts_T),
                    //                               ),
                    //                             ))
                    //                         .toList(),

                    //                     onChanged: (value) async {
                    //                       var zones = value!.indexOf(',');
                    //                       var zoneSer =
                    //                           value.substring(0, zones);
                    //                       var zonesName =
                    //                           value.substring(zones + 1);
                    //                       print(
                    //                           'mmmmm ${zoneSer.toString()} $zonesName');

                    //                       SharedPreferences preferences =
                    //                           await SharedPreferences
                    //                               .getInstance();
                    //                       preferences.setString(
                    //                           'zoneSer', zoneSer.toString());
                    //                       preferences.setString('zonesName',
                    //                           zonesName.toString());

                    //                       setState(() {
                    //                         read_GC_area();
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
                    //                       color: PeopleChaoScreen_Color
                    //                           .Colors_Text1_,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontFamily: FontWeight_.Fonts_T),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Container(
                    //                   decoration: BoxDecoration(
                    //                     color:
                    //                         AppbackgroundColor.Sub_Abg_Colors,
                    //                     borderRadius: const BorderRadius.only(
                    //                         topLeft: Radius.circular(10),
                    //                         topRight: Radius.circular(10),
                    //                         bottomLeft: Radius.circular(10),
                    //                         bottomRight: Radius.circular(10)),
                    //                     border: Border.all(
                    //                         color: Colors.grey, width: 1),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          // width: 100,
                          // height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            // border: Border.all(color: Colors.grey, width: 1),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(
                            child: Text(
                              'ดูแผนผัง',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog<String>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              title: const Center(
                                  child: Text(
                                'แผนผัง',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              )),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    InteractiveViewer(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.brown[100],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: (img_ == null ||
                                                img_.toString() == '')
                                            ? const Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : Image.network(
                                                '${MyConstant().domain}/files/$foder/contract/$img_',
                                                fit: BoxFit.contain,
                                              ),
                                      ),
                                      scaleEnabled: true,
                                      minScale: 0.5,
                                      maxScale: 5.0,
                                      transformationController:
                                          TransformationController()
                                            ..value = Matrix4.diagonal3Values(
                                                _scaleFactor, _scaleFactor, 1),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text(
                                            'ปิด',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
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
                    InkWell(
                      child: Container(
                          // padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: PopupMenuButton(
                          child: const Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              child: InkWell(
                                  onTap: () async {
                                    if (renTal_lavel <= 2) {
                                      Navigator.pop(context);
                                      infomation();
                                    } else {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      var zone =
                                          preferences.getString('zoneSer');
                                      if (zone == '0' || zone == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                            'กรุณาเลือกโซนพื้นที่เช่า',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: Font_.Fonts_T),
                                          )),
                                        );
                                      } else {
                                        setState(() {
                                          Ser_Body = 1;
                                          a_ln = null;
                                          a_ser = null;
                                          a_area = null;
                                          a_rent = null;
                                          a_page = '0';
                                        });
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '+ เสนอราคา',
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          )
                                        ],
                                      ))),
                            ),
                            PopupMenuItem(
                              child: InkWell(
                                  onTap: () async {
                                    if (renTal_lavel <= 2) {
                                      Navigator.pop(context);
                                      infomation();
                                    } else {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      var zone =
                                          preferences.getString('zoneSer');
                                      if (zone == '0' || zone == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                            'กรุณาเลือกโซนพื้นที่เช่า',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: Font_.Fonts_T),
                                          )),
                                        );
                                      } else {
                                        setState(() {
                                          Ser_Body = 2;
                                          a_ln = null;
                                          a_ser = null;
                                          a_area = null;
                                          a_rent = null;
                                          a_page = '0';
                                        });
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '+ ทำ/ต่อสัญญา',
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          )
                                        ],
                                      ))),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          if ((Ser_Body == 0))
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
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
                  // padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (!Responsive.isDesktop(context))
                        Padding(
                          padding: const EdgeInsets.all(4.0),
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
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  ),
                                  for (int i = 0; i < Status.length; i++)
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              tappedIndex_ = '';
                                            });
                                            setState(() {
                                              Status_ = i + 1;
                                            });
                                            read_GC_areaSelect(i + 1);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: (i + 1 == 1)
                                                  ? (Status_ == i + 1)
                                                      ? Colors.grey[700]
                                                      : Colors.grey[300]
                                                  : (i + 1 == 2)
                                                      ? (Status_ == i + 1)
                                                          ? Colors.orange[700]
                                                          : Colors.orange[200]
                                                      : (i + 1 == 3)
                                                          ? (Status_ == i + 1)
                                                              ? Colors.blue[700]
                                                              : Colors.blue[200]
                                                          : (i + 1 == 4)
                                                              ? (Status_ ==
                                                                      i + 1)
                                                                  ? Colors.green[
                                                                      700]
                                                                  : Colors.green[
                                                                      200]
                                                              : (i + 1 == 4)
                                                                  ? (Status_ ==
                                                                          i + 1)
                                                                      ? Colors.red[
                                                                          700]
                                                                      : Colors.red[
                                                                          200]
                                                                  : (Status_ ==
                                                                          i + 1)
                                                                      ? Colors.grey[
                                                                          700]
                                                                      : Colors.grey[
                                                                          300],
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
                                              border: (Status_ == i + 1)
                                                  ? Border.all(
                                                      color: Colors.white,
                                                      width: 1)
                                                  : null,
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                Status[i],
                                                style: TextStyle(
                                                    color: (Status_ == i + 1)
                                                        ? Colors.white
                                                        : PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
                                              ),
                                            ),
                                          ),
                                        )),
                                ])),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Expanded(
                          //   flex: 3,
                          //   child: Row(
                          //     children: [
                          //       const Padding(
                          //         padding: EdgeInsets.all(8.0),
                          //         child: Text(
                          //           'ปี',
                          //           style: TextStyle(
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             color: AppbackgroundColor.Sub_Abg_Colors,
                          //             borderRadius: const BorderRadius.only(
                          //                 topLeft: Radius.circular(10),
                          //                 topRight: Radius.circular(10),
                          //                 bottomLeft: Radius.circular(10),
                          //                 bottomRight: Radius.circular(10)),
                          //             border: Border.all(
                          //                 color: Colors.grey, width: 1),
                          //           ),
                          //           width: 120,
                          //           child: DropdownButtonFormField2(
                          //             itemHighlightColor:
                          //                 TextHome_Color.TextHome_Colors,

                          //             decoration: InputDecoration(
                          //               isDense: true,
                          //               contentPadding: EdgeInsets.zero,
                          //               border: OutlineInputBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(10),
                          //               ),
                          //             ),
                          //             isExpanded: true,
                          //             style: TextStyle(
                          //               color: Colors.green,
                          //             ),
                          //             hint: const Text(
                          //               'ทั้งหมด',
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //                 color: TextHome_Color.TextHome_Colors,
                          //               ),
                          //             ),
                          //             icon: const Icon(
                          //               Icons.arrow_drop_down,
                          //               color: TextHome_Color.TextHome_Colors,
                          //             ),
                          //             iconSize: 30,
                          //             buttonHeight: 40,
                          //             // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                          //             dropdownDecoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             items: Year_.map(
                          //                 (item) => DropdownMenuItem<String>(
                          //                       value: item,
                          //                       child: Text(
                          //                         item,
                          //                         style: const TextStyle(
                          //                           fontSize: 14,
                          //                         ),
                          //                       ),
                          //                     )).toList(),
                          //             // validator: (value) {
                          //             //   if (value == null) {
                          //             //     return 'ค้นหายี่ห้อ.';
                          //             //   } else {}
                          //             // },
                          //             onChanged: (value) async {},
                          //             onSaved: (value) {
                          //               // selectedValue = value.toString();
                          //             },
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          if (Responsive.isDesktop(context))
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
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
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T),
                                        ),
                                        for (int i = 0; i < Status.length; i++)
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
                                                  read_GC_areaSelect(Status_);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: (i + 1 == 1)
                                                        ? (Status_ == i + 1)
                                                            ? Colors.grey[700]
                                                            : Colors.grey[300]
                                                        : (i + 1 == 2)
                                                            ? (Status_ == i + 1)
                                                                ? Colors
                                                                    .orange[700]
                                                                : Colors
                                                                    .orange[200]
                                                            : (i + 1 == 3)
                                                                ? (Status_ ==
                                                                        i + 1)
                                                                    ? Colors.blue[
                                                                        700]
                                                                    : Colors.blue[
                                                                        200]
                                                                : (i + 1 == 4)
                                                                    ? (Status_ ==
                                                                            i +
                                                                                1)
                                                                        ? Colors.green[
                                                                            700]
                                                                        : Colors.green[
                                                                            200]
                                                                    : (i + 1 ==
                                                                            5)
                                                                        ? (Status_ ==
                                                                                i + 1)
                                                                            ? Colors.red[700]
                                                                            : Colors.red[200]
                                                                        : (Status_ == i + 1)
                                                                            ? Colors.grey[700]
                                                                            : Colors.grey[300],
                                                    borderRadius:
                                                        const BorderRadius.only(
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
                                                                    10)),
                                                    border: (Status_ == i + 1)
                                                        ? Border.all(
                                                            color: Colors.white,
                                                            width: 1)
                                                        : null,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      Status[i],
                                                      style: TextStyle(
                                                          color: (Status_ ==
                                                                  i + 1)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                      ])),
                                ),
                              ),
                            ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'มุมมอง :',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: SlideSwitcher(
                                      containerBorderRadius: 10,
                                      onSelect: (index) async {
                                        setState(() {
                                          switcherIndex1 = index;
                                        });
                                        if (index + 1 == 1) {
                                          setState(() {
                                            Visit_ = 'grid';
                                          });
                                        } else if (index + 1 == 2) {
                                          setState(() {
                                            Ser_Body = 5;
                                            Visit_ = 'calendar';
                                          });
                                        } else if (index + 1 == 3) {
                                          setState(() {
                                            Visit_ = 'list';
                                          });
                                        } else if (index + 1 == 4) {
                                          setState(() {
                                            Visit_ = 'map';
                                          });
                                          read_GC_area();
                                        }
                                      },
                                      containerHeight: 40,
                                      containerWight: 130,
                                      containerColor: Colors.grey,
                                      children: [
                                        Icon(
                                          Icons.grid_view_rounded,
                                          color: (Visit_ == 'grid')
                                              ? Colors.blue[900]
                                              : Colors.black,
                                        ),
                                        Icon(
                                          Icons.calendar_month_rounded,
                                          color: (Visit_ == 'calendar')
                                              ? Colors.blue[900]
                                              : Colors.black,
                                        ),
                                        Icon(
                                          Icons.list,
                                          color: (Visit_ == 'list')
                                              ? Colors.blue[900]
                                              : Colors.black,
                                        ),
                                        Icon(
                                          Icons.map_outlined,
                                          color: (Visit_ == 'map')
                                              ? Colors.blue[900]
                                              : Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          (Ser_Body == 0)
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      BodyHome_Web(context),
                    ],
                  ))
              : (Ser_Body == 1)
                  ? Body_bid(context)
                  : (Ser_Body == 2)
                      ? Body_Renew(context)
                      : (Ser_Body == 3)
                          ? PeopleChaoScreen2(
                              Get_Value_cid: Value_cid,
                              Get_Value_NameShop_index: ser_cidtan,
                              Get_Value_status: Value_stasus,
                              Get_Value_indexpage: '0',
                              updateMessage: updateMessage,
                            )
                          : (Ser_Body == 4)
                              ? PeopleChaoScreen2(
                                  Get_Value_cid: Value_cid,
                                  Get_Value_NameShop_index: ser_cidtan,
                                  Get_Value_status: Value_stasus,
                                  Get_Value_indexpage: '4',
                                  updateMessage: updateMessage,
                                )
                              : Homereservespace_calendar()
        ],
      ),
    );
  }

  String? _message;
  void updateMessage(String newMessage) {
    setState(() {
      _message = newMessage;
      Ser_Body = 0;
    });
    checkPreferance();
    read_GC_zone();
    read_GC_rental();
    read_GC_area();
  }

  Widget BodyHome_Web(context) {
    return (Visit_ == 'list')
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        //   flex: 1,
                        //   child: Padding(
                        //     padding: EdgeInsets.all(8.0),
                        //     child: Text(
                        //       '',
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold,
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
                              'โซนพื้นที่',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
                                  //fontSize: 10.0
                                  ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  children: [
                    Container(
                        height: (!Responsive.isDesktop(context))
                            ? MediaQuery.of(context).size.height * 0.85
                            : MediaQuery.of(context).size.height * 0.6,
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
                        child: areaModels.isEmpty
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
                                                      fontFamily: Font_.Fonts_T
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
                                                      fontFamily: Font_.Fonts_T
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
                                    const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: areaModels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  int daysBetween(DateTime from, DateTime to) {
                                    from = DateTime(
                                        from.year, from.month, from.day);
                                    to = DateTime(to.year, to.month, to.day);
                                    return (to.difference(from).inHours / 24)
                                        .round();
                                  }

                                  var daterz = areaModels[index].ldate == null
                                      ? '0000-00-00'
                                      : areaModels[index].ldate;

                                  var birthday =
                                      DateTime.parse('$daterz 00:00:00.000')
                                          .add(const Duration(days: -30));
                                  var date2 = DateTime.now();
                                  var difference = daysBetween(birthday, date2);

                                  return Material(
                                    color: tappedIndex_ == index.toString()
                                        ? tappedIndex_Color.tappedIndex_Colors
                                        : AppbackgroundColor.Sub_Abg_Colors,
                                    child: Container(
                                      // color: tappedIndex_ == index.toString()
                                      //     ? Colors.grey.shade300
                                      //     : null,
                                      child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              tappedIndex_ = index.toString();
                                            });
                                          },
                                          title: Container(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Row(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.center,
                                                //     children: [
                                                //       Container(
                                                //         decoration: BoxDecoration(
                                                //           color:
                                                //               Colors.grey.shade300,
                                                //           borderRadius:
                                                //               BorderRadius.only(
                                                //                   topLeft: Radius
                                                //                       .circular(10),
                                                //                   topRight: Radius
                                                //                       .circular(10),
                                                //                   bottomLeft: Radius
                                                //                       .circular(10),
                                                //                   bottomRight:
                                                //                       Radius
                                                //                           .circular(
                                                //                               10)),
                                                //           // border: Border.all(color: Colors.grey, width: 1),
                                                //         ),
                                                //         padding:
                                                //             EdgeInsets.all(8.0),
                                                //         child: PopupMenuButton(
                                                //           child: Center(
                                                //               child: Row(
                                                //             children: const [
                                                //               Text(
                                                //                 'เรียกดู',
                                                //                 style: TextStyle(
                                                //                   color: TextHome_Color
                                                //                       .TextHome_Colors,

                                                //                   //fontSize: 10.0
                                                //                 ),
                                                //               ),
                                                //               Icon(
                                                //                 Icons.navigate_next,
                                                //                 color: TextHome_Color
                                                //                     .TextHome_Colors,
                                                //               )
                                                //             ],
                                                //           )),
                                                //           itemBuilder: (context) {
                                                //             return List.generate(
                                                //                 buttonview_.length,
                                                //                 (index) {
                                                //               return PopupMenuItem(
                                                //                 child: Text(
                                                //                   buttonview_[
                                                //                       index],
                                                //                   style:
                                                //                       const TextStyle(
                                                //                     color: Colors
                                                //                         .black,

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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '${areaModels[index].zn}',
                                                      textAlign:
                                                          TextAlign.start,
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
                                                    areaModels[index].ln_c ==
                                                            null
                                                        ? areaModels[index]
                                                                    .ln_q ==
                                                                null
                                                            ? '${areaModels[index].lncode}'
                                                            : '${areaModels[index].ln_q}'
                                                        : '${areaModels[index].ln_c}',
                                                    textAlign: TextAlign.start,
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
                                                  child: Text(
                                                    areaModels[index].cid ==
                                                            null
                                                        ? ''
                                                        : '${areaModels[index].cid}',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.end,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    areaModels[index].docno ==
                                                            null
                                                        ? ''
                                                        : '${areaModels[index].docno}',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.end,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: areaModels[index]
                                                                    .docno !=
                                                                null
                                                            ? Colors.blue
                                                            : PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
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
                                                            .format(DateTime.parse(
                                                                '${areaModels[index].ldate} 00:00:00'))
                                                            .toString(),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.end,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                                : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) ==
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
                                                        fontFamily: Font_.Fonts_T),
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
                                                                        Duration(
                                                                            days:
                                                                                open_set_date))) ==
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
                                                                : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) ==
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
                                              ],
                                            ),
                                          )),
                                    ),
                                  );
                                })),
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
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(8)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
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
              )
            ],
          )
        : (Visit_ == 'grid')
            ? Column(
                children: [
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
                      padding: const EdgeInsets.all(20),
                      // color: Colors.white,
                      child:
                          zone_ser == '0' || zone_ser == '' || zone_ser == null
                              ? ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: zoneModels.length,
                                  itemBuilder:
                                      (BuildContext context, int zindex) {
                                    return zoneModels[zindex].ser == '0'
                                        ? const SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                    .TiTile_Colors,
                                                                borderRadius:
                                                                    const BorderRadius
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
                                                                          10),
                                                                ),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  text:
                                                                      'โซน :  ${zoneModels[zindex].zn}  ',
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T

                                                                      //fontSize: 10.0
                                                                      ),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                      text:
                                                                          '[ ${areaModels.where((item) => item.zser == zoneModels[zindex].ser).toList().length} พื้นที่ ]',
                                                                      style: TextStyle(
                                                                          fontSize: 13,
                                                                          color: Colors.grey.shade800.withOpacity(0.45),
                                                                          // fontWeight: FontWeight
                                                                          //     .bold,
                                                                          fontFamily: Font_.Fonts_T

                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //     flex: 1, child: Text('')),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ScrollConfiguration(
                                                    behavior:
                                                        ScrollConfiguration.of(
                                                                context)
                                                            .copyWith(
                                                                dragDevices: {
                                                          PointerDeviceKind
                                                              .touch,
                                                          PointerDeviceKind
                                                              .mouse,
                                                        }),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: (areaModels
                                                                  .where((item) =>
                                                                      item.zser ==
                                                                      zoneModels[
                                                                              zindex]
                                                                          .ser)
                                                                  .toList()
                                                                  .isEmpty)
                                                              ? null
                                                              : ((areaModels.where((item) => item.zser == zoneModels[zindex].ser).toList().length /
                                                                          12) <
                                                                      1.5)
                                                                  ? 145
                                                                  : ((areaModels.where((item) => item.zser == zoneModels[zindex].ser).toList().length /
                                                                              12) <
                                                                          2.5)
                                                                      ? 245
                                                                      : 320,
                                                          // height: MediaQuery.of(
                                                          //                 context)
                                                          //             .size
                                                          //             .shortestSide <
                                                          //         MediaQuery.of(
                                                          //                     context)
                                                          //                 .size
                                                          //                 .height *
                                                          //             1
                                                          //     ? 420
                                                          //     : 320,
                                                          child: (areaModels
                                                                  .where((item) =>
                                                                      item.zser ==
                                                                      zoneModels[
                                                                              zindex]
                                                                          .ser)
                                                                  .toList()
                                                                  .isEmpty)
                                                              ? SizedBox(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      StreamBuilder(
                                                                        stream: Stream.periodic(
                                                                            const Duration(milliseconds: 15),
                                                                            (i) => i),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (!snapshot
                                                                              .hasData)
                                                                            return const Text('');
                                                                          double
                                                                              elapsed =
                                                                              double.parse(snapshot.data.toString()) * 0.05;
                                                                          return Column(
                                                                            children: [
                                                                              if (elapsed < 8.00)
                                                                                CircularProgressIndicator(),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: (elapsed > 8.00)
                                                                                    ? const Text(
                                                                                        'ไม่พบข้อมูล',
                                                                                        style: TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T, fontWeight: FontWeight.w500,
                                                                                          //fontSize: 10.0
                                                                                        ),
                                                                                      )
                                                                                    : Text(
                                                                                        'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                                        // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                                        style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T
                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : GridView.count(
                                                                  crossAxisCount: MediaQuery.of(context)
                                                                              .size
                                                                              .shortestSide <
                                                                          MediaQuery.of(context).size.width *
                                                                              1
                                                                      ? 12
                                                                      : (MediaQuery.of(context).size.width <
                                                                              400)
                                                                          ? 4
                                                                          : 6,
                                                                  children: [
                                                                    for (int i =
                                                                            0;
                                                                        i <
                                                                            areaModels
                                                                                .length;
                                                                        i++)
                                                                      if (zoneModels[zindex]
                                                                              .ser ==
                                                                          areaModels[i]
                                                                              .zser)
                                                                        createCard(
                                                                            i,
                                                                            context),
                                                                  ],
                                                                ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Divider(
                                                                color: Colors
                                                                    .grey[300],
                                                                height: 4.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),

                                                        // SizedBox(
                                                        //   width: 300,
                                                        // )

                                                        // ScrollConfiguration(
                                                        //   behavior: ScrollConfiguration
                                                        //           .of(context)
                                                        //       .copyWith(
                                                        //           dragDevices: {
                                                        //         PointerDeviceKind
                                                        //             .touch,
                                                        //         PointerDeviceKind
                                                        //             .mouse,
                                                        //       }),
                                                        //   child:
                                                        //       SingleChildScrollView(
                                                        //     scrollDirection:
                                                        //         Axis.vertical,
                                                        //     dragStartBehavior:
                                                        //         DragStartBehavior
                                                        //             .start,
                                                        //     child: Row(
                                                        //         mainAxisAlignment:
                                                        //             MainAxisAlignment
                                                        //                 .start,
                                                        //         children: [
                                                        //           for (int i =
                                                        //                   0;
                                                        //               i <
                                                        //                   areaModels
                                                        //                       .length;
                                                        //               i++)
                                                        //             zoneModels[zindex].ser ==
                                                        //                     areaModels[i].zser
                                                        //                 ? Column(
                                                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                                                        //                     children: [
                                                        //                       areaModels[i].quantity == null
                                                        //                           ? Row(
                                                        //                               mainAxisAlignment: MainAxisAlignment.start,
                                                        //                               children: [
                                                        //                                 createCard(i),
                                                        //                               ],
                                                        //                             )
                                                        //                           : SizedBox()
                                                        //                     ],
                                                        //                   )
                                                        //                 : SizedBox(),
                                                        //           SizedBox(
                                                        //             width:
                                                        //                 300,
                                                        //           )
                                                        //         ]),
                                                        //   ),
                                                        // ),
                                                        // ScrollConfiguration(
                                                        //   behavior: ScrollConfiguration
                                                        //           .of(context)
                                                        //       .copyWith(
                                                        //           dragDevices: {
                                                        //         PointerDeviceKind
                                                        //             .touch,
                                                        //         PointerDeviceKind
                                                        //             .mouse,
                                                        //       }),
                                                        //   child:
                                                        //       SingleChildScrollView(
                                                        //     scrollDirection:
                                                        //         Axis.horizontal,
                                                        //     dragStartBehavior:
                                                        //         DragStartBehavior
                                                        //             .start,
                                                        //     child: Row(
                                                        //         mainAxisAlignment:
                                                        //             MainAxisAlignment
                                                        //                 .start,
                                                        //         children: [
                                                        //           for (int i =
                                                        //                   0;
                                                        //               i <
                                                        //                   areaModels
                                                        //                       .length;
                                                        //               i++)
                                                        //             zoneModels[zindex].ser ==
                                                        //                     areaModels[i].zser
                                                        //                 ? Column(
                                                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                                                        //                     children: [
                                                        //                       areaModels[i].quantity == '2'
                                                        //                           ? Row(
                                                        //                               mainAxisAlignment: MainAxisAlignment.start,
                                                        //                               children: [
                                                        //                                 createCard(i),
                                                        //                               ],
                                                        //                             )
                                                        //                           : SizedBox(),
                                                        //                     ],
                                                        //                   )
                                                        //                 : SizedBox(),
                                                        //           SizedBox(
                                                        //             width:
                                                        //                 300,
                                                        //           )
                                                        //         ]),
                                                        //   ),
                                                        // ),
                                                        // ScrollConfiguration(
                                                        //   behavior: ScrollConfiguration
                                                        //           .of(context)
                                                        //       .copyWith(
                                                        //           dragDevices: {
                                                        //         PointerDeviceKind
                                                        //             .touch,
                                                        //         PointerDeviceKind
                                                        //             .mouse,
                                                        //       }),
                                                        //   child:
                                                        //       SingleChildScrollView(
                                                        //     scrollDirection:
                                                        //         Axis.horizontal,
                                                        //     dragStartBehavior:
                                                        //         DragStartBehavior
                                                        //             .start,
                                                        //     child: Row(
                                                        //         mainAxisAlignment:
                                                        //             MainAxisAlignment
                                                        //                 .start,
                                                        //         children: [
                                                        //           for (int i =
                                                        //                   0;
                                                        //               i <
                                                        //                   areaModels
                                                        //                       .length;
                                                        //               i++)
                                                        //             zoneModels[zindex].ser ==
                                                        //                     areaModels[i].zser
                                                        //                 ? Column(
                                                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                                                        //                     children: [
                                                        //                       areaModels[i].quantity == '1'
                                                        //                           ? Row(
                                                        //                               mainAxisAlignment: MainAxisAlignment.start,
                                                        //                               children: [
                                                        //                                 createCard(i),
                                                        //                               ],
                                                        //                             )
                                                        //                           : SizedBox(),
                                                        //                     ],
                                                        //                   )
                                                        //                 : SizedBox(),
                                                        //           SizedBox(
                                                        //             width:
                                                        //                 300,
                                                        //           )
                                                        //         ]),
                                                        //   ),
                                                        // ),
                                                        // ScrollConfiguration(
                                                        //   behavior: ScrollConfiguration
                                                        //           .of(context)
                                                        //       .copyWith(
                                                        //           dragDevices: {
                                                        //         PointerDeviceKind
                                                        //             .touch,
                                                        //         PointerDeviceKind
                                                        //             .mouse,
                                                        //       }),
                                                        //   child:
                                                        //       SingleChildScrollView(
                                                        //     scrollDirection:
                                                        //         Axis.horizontal,
                                                        //     dragStartBehavior:
                                                        //         DragStartBehavior
                                                        //             .start,
                                                        //     child: Row(
                                                        //         mainAxisAlignment:
                                                        //             MainAxisAlignment
                                                        //                 .start,
                                                        //         children: [
                                                        //           for (int i =
                                                        //                   0;
                                                        //               i <
                                                        //                   areaModels
                                                        //                       .length;
                                                        //               i++)
                                                        //             zoneModels[zindex].ser ==
                                                        //                     areaModels[i].zser
                                                        //                 ? Column(
                                                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                                                        //                     children: [
                                                        //                       areaModels[i].quantity == '3'
                                                        //                           ? Row(
                                                        //                               mainAxisAlignment: MainAxisAlignment.start,
                                                        //                               children: [
                                                        //                                 createCard(i),
                                                        //                               ],
                                                        //                             )
                                                        //                           : SizedBox(),
                                                        //                     ],
                                                        //                   )
                                                        //                 : SizedBox(),
                                                        //           SizedBox(
                                                        //             width:
                                                        //                 300,
                                                        //           )
                                                        //         ]),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ))
                                            ],
                                          );
                                  })
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .TiTile_Colors,
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
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: zone_ser == null
                                                            ? 'โซน ทั้งหมด  '
                                                            : 'โซน $zone_name  ',
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T

                                                            //fontSize: 10.0
                                                            ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '[ ${areaModels.where((item) => item.zser == zone_ser).toList().length} พื้นที่ ]',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .grey
                                                                    .shade800
                                                                    .withOpacity(
                                                                        0.45),
                                                                // fontWeight: FontWeight
                                                                //     .bold,
                                                                fontFamily:
                                                                    Font_
                                                                        .Fonts_T

                                                                //fontSize: 10.0
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                    // Text(
                                                    //   zone_ser == null
                                                    //       ? 'โซน ทั้งหมด'
                                                    //       : 'โซน ($zone_name)',
                                                    //   style: const TextStyle(
                                                    //       color:
                                                    //           PeopleChaoScreen_Color
                                                    //               .Colors_Text2_,
                                                    //       fontWeight: FontWeight.bold,
                                                    //       fontFamily:
                                                    //           FontWeight_.Fonts_T

                                                    //       //fontSize: 10.0
                                                    //       ),
                                                    // ),
                                                    ),
                                              ],
                                            ),
                                          ),
                                          // Expanded(flex: 1, child: Text('')),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ScrollConfiguration(
                                          behavior:
                                              ScrollConfiguration.of(context)
                                                  .copyWith(dragDevices: {
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.mouse,
                                          }),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: (areaModels.length == 0)
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.6
                                                    : 600,
                                                child: (areaModels.length == 0)
                                                    ? SizedBox(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            StreamBuilder(
                                                              stream: Stream.periodic(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          15),
                                                                  (i) => i),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (!snapshot
                                                                    .hasData)
                                                                  return const Text(
                                                                      '');
                                                                double elapsed =
                                                                    double.parse(snapshot
                                                                            .data
                                                                            .toString()) *
                                                                        0.05;
                                                                return Column(
                                                                  children: [
                                                                    if (elapsed <
                                                                        8.00)
                                                                      CircularProgressIndicator(),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: (elapsed >
                                                                              8.00)
                                                                          ? const Text(
                                                                              'ไม่พบข้อมูล',
                                                                              style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                fontFamily: Font_.Fonts_T,
                                                                                fontWeight: FontWeight.w500,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                              // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                              style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T
                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : GridView.count(
                                                        crossAxisCount: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .shortestSide <
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    1
                                                            ? 12
                                                            : (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width <
                                                                    400)
                                                                ? 4
                                                                : 6,
                                                        children: [
                                                          for (int i = 0;
                                                              i <
                                                                  areaModels
                                                                      .length;
                                                              i++)
                                                            createCard(
                                                                i, context),
                                                        ],
                                                      ),
                                              )
                                            ],
                                          ),
                                        )),
                                    // Container(
                                    //   width: MediaQuery.of(context).size.width,
                                    //   height: 500,
                                    //   child: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       ScrollConfiguration(
                                    //         behavior: ScrollConfiguration.of(context)
                                    //             .copyWith(dragDevices: {
                                    //           PointerDeviceKind.touch,
                                    //           PointerDeviceKind.mouse,
                                    //         }),
                                    //         child: SingleChildScrollView(
                                    //           scrollDirection: Axis.horizontal,
                                    //           dragStartBehavior: DragStartBehavior.start,
                                    //           child: Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.start,
                                    //               children: [
                                    //                 for (int i = 0;
                                    //                     i < areaModels.length;
                                    //                     i++)
                                    //                   Column(
                                    //                     crossAxisAlignment:
                                    //                         CrossAxisAlignment.start,
                                    //                     children: [
                                    //                       areaModels[i].quantity == null
                                    //                           ? Row(
                                    //                               mainAxisAlignment:
                                    //                                   MainAxisAlignment
                                    //                                       .start,
                                    //                               children: [
                                    //                                 createCard(i),
                                    //                               ],
                                    //                             )
                                    //                           : SizedBox()
                                    //                     ],
                                    //                   ),
                                    //                 SizedBox(
                                    //                   width: 300,
                                    //                 )
                                    //               ]),
                                    //         ),
                                    //       ),
                                    //       ScrollConfiguration(
                                    //         behavior: ScrollConfiguration.of(context)
                                    //             .copyWith(dragDevices: {
                                    //           PointerDeviceKind.touch,
                                    //           PointerDeviceKind.mouse,
                                    //         }),
                                    //         child: SingleChildScrollView(
                                    //           scrollDirection: Axis.horizontal,
                                    //           dragStartBehavior: DragStartBehavior.start,
                                    //           child: Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.start,
                                    //               children: [
                                    //                 for (int i = 0;
                                    //                     i < areaModels.length;
                                    //                     i++)
                                    //                   Column(
                                    //                     crossAxisAlignment:
                                    //                         CrossAxisAlignment.start,
                                    //                     children: [
                                    //                       areaModels[i].quantity == '2'
                                    //                           ? Row(
                                    //                               mainAxisAlignment:
                                    //                                   MainAxisAlignment
                                    //                                       .start,
                                    //                               children: [
                                    //                                 createCard(i),
                                    //                               ],
                                    //                             )
                                    //                           : SizedBox(),
                                    //                     ],
                                    //                   ),
                                    //                 SizedBox(
                                    //                   width: 300,
                                    //                 )
                                    //               ]),
                                    //         ),
                                    //       ),
                                    //       ScrollConfiguration(
                                    //         behavior: ScrollConfiguration.of(context)
                                    //             .copyWith(dragDevices: {
                                    //           PointerDeviceKind.touch,
                                    //           PointerDeviceKind.mouse,
                                    //         }),
                                    //         child: SingleChildScrollView(
                                    //           scrollDirection: Axis.horizontal,
                                    //           dragStartBehavior: DragStartBehavior.start,
                                    //           child: Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.start,
                                    //               children: [
                                    //                 for (int i = 0;
                                    //                     i < areaModels.length;
                                    //                     i++)
                                    //                   Column(
                                    //                     crossAxisAlignment:
                                    //                         CrossAxisAlignment.start,
                                    //                     children: [
                                    //                       areaModels[i].quantity == '1'
                                    //                           ? Row(
                                    //                               mainAxisAlignment:
                                    //                                   MainAxisAlignment
                                    //                                       .start,
                                    //                               children: [
                                    //                                 createCard(i),
                                    //                               ],
                                    //                             )
                                    //                           : SizedBox(),
                                    //                     ],
                                    //                   ),
                                    //                 const SizedBox(
                                    //                   width: 300,
                                    //                 )
                                    //               ]),
                                    //         ),
                                    //       ),
                                    //       ScrollConfiguration(
                                    //         behavior: ScrollConfiguration.of(context)
                                    //             .copyWith(dragDevices: {
                                    //           PointerDeviceKind.touch,
                                    //           PointerDeviceKind.mouse,
                                    //         }),
                                    //         child: SingleChildScrollView(
                                    //           scrollDirection: Axis.horizontal,
                                    //           dragStartBehavior: DragStartBehavior.start,
                                    //           child: Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.start,
                                    //               children: [
                                    //                 for (int i = 0;
                                    //                     i < areaModels.length;
                                    //                     i++)
                                    //                   Column(
                                    //                     crossAxisAlignment:
                                    //                         CrossAxisAlignment.start,
                                    //                     children: [
                                    //                       areaModels[i].quantity == '3'
                                    //                           ? Row(
                                    //                               mainAxisAlignment:
                                    //                                   MainAxisAlignment
                                    //                                       .start,
                                    //                               children: [
                                    //                                 createCard(i),
                                    //                               ],
                                    //                             )
                                    //                           : SizedBox(),
                                    //                     ],
                                    //                   ),
                                    //                 SizedBox(
                                    //                   width: 300,
                                    //                 )
                                    //               ]),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                    ),
                  )
                ],
              )
            : (ser_Floor_plans == '0')
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
                                              if (!Responsive.isDesktop(
                                                  context))
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
                                                            alignment: Alignment
                                                                .center,
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
                                                                constrained:
                                                                    true,
                                                                boundaryMargin:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        double
                                                                            .infinity),
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          300,
                                                                      height:
                                                                          300,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey[50],
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage("images/Floor-plan-try.png"),
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
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
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
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom:
                                                                          75,
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
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom:
                                                                          75,
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
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
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
                                                        decoration:
                                                            BoxDecoration(
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
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                              icon: const Icon(
                                                                Icons.zoom_in,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed:
                                                                  _zoomInSVG,
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                Icons.zoom_out,
                                                                color: Colors
                                                                    .white,
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
                                              Center(
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
                                                        color:
                                                            Colors.orange[600],
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
                                                        // border: Border.all(color: Colors.grey, width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: const Text(
                                                        'อัพเกรด ( Upgrade ) ',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                            image: DecorationImage(
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        width: 400,
                                                        height: 250,
                                                        child:
                                                            InteractiveViewer(
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
                                                                              style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                                        .red[
                                                                            200]!
                                                                        .withOpacity(
                                                                            0.5),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        'A',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
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
                                                                              style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                                      child:
                                                                          Text(
                                                                        'B',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
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
                                                                              style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                                      child:
                                                                          Text(
                                                                        'C',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
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
                                                                              style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                                        .red[
                                                                            200]!
                                                                        .withOpacity(
                                                                            0.5),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        'D',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
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
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
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
                                                        MainAxisAlignment
                                                            .center,
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
                                  color: Colors.white,
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
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 5),
                                            ),
                                            child: Center(
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
                                              Color.fromARGB(
                                                  255, 216, 231, 199),
                                              Color.fromARGB(
                                                  255, 199, 219, 175),
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
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
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
                                            height: 510,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: ScrollConfiguration(
                                                behavior:
                                                    ScrollConfiguration.of(
                                                            context)
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
                                                          alignment:
                                                              Alignment.center,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
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
                                                                              10)),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black,
                                                                      width: 5),
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
                                                                  minScale: 0.8,
                                                                  maxScale: 2.0,
                                                                  constrained:
                                                                      true,
                                                                  boundaryMargin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              150.0),
                                                                  // boundaryMargin:
                                                                  //     const EdgeInsets.all(
                                                                  //         double.infinity),
                                                                  child: Stack(
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
                                                                                        clipper: Clipper(
                                                                                          svgPath: areaModel.path!,
                                                                                          // height:
                                                                                          //     17.0,
                                                                                          // width:
                                                                                          //     26.2,
                                                                                        ),
                                                                                        child: InkWell(
                                                                                          onTap: () async {
                                                                                            int index = areaModels.indexWhere((area) => area.ser.toString().trim() == areaModel.ser);
                                                                                            onCountrySelected.call(areaModel);
                                                                                            // print('${areaModel.id}  ');
                                                                                            Future.delayed(const Duration(milliseconds: 200), () {
                                                                                              dialog_svg(index, context);
                                                                                            });
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(
                                                                                              color: (areaFloorplanModelss?.id == areaModel.id)
                                                                                                  ? areaModel.quantity == '1'
                                                                                                      ? datex.isAfter(DateTime.parse('${areaModel.ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) == true //datex
                                                                                                          ? datex.isAfter(DateTime.parse('${areaModel.ldate} 00:00:00.000').subtract(Duration(days: 0))) == false
                                                                                                              ? Colors.orange[900]!.withOpacity(0.5)
                                                                                                              : Colors.grey[900]!.withOpacity(0.5)
                                                                                                          : Colors.red[900]!.withOpacity(0.5)
                                                                                                      : areaModel.quantity == '2'
                                                                                                          ? Colors.blue[900]!.withOpacity(0.5)
                                                                                                          : areaModel.quantity == '3'
                                                                                                              ? Colors.purple[900]!.withOpacity(0.5)
                                                                                                              : Colors.green[900]!.withOpacity(0.5)
                                                                                                  : (areaFloorplanModelss != null)
                                                                                                      ? Colors.grey[200]!.withOpacity(0.4)
                                                                                                      : areaModel.quantity == '1'
                                                                                                          ? datex.isAfter(DateTime.parse('${areaModel.ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) == true //datex
                                                                                                              ? datex.isAfter(DateTime.parse('${areaModel.ldate} 00:00:00.000').subtract(Duration(days: 0))) == false
                                                                                                                  ? Colors.orange[900]!.withOpacity(0.4)
                                                                                                                  : Colors.grey[900]!.withOpacity(0.4)
                                                                                                              : Colors.red[200]!.withOpacity(0.4)
                                                                                                          : areaModel.quantity == '2'
                                                                                                              ? Colors.blue[200]!.withOpacity(0.4)
                                                                                                              : areaModel.quantity == '3'
                                                                                                                  ? Colors.purple[200]!.withOpacity(0.4)
                                                                                                                  : Colors.green[200]!.withOpacity(0.4),
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
                                              Color.fromARGB(
                                                  255, 216, 231, 199),
                                              Color.fromARGB(
                                                  255, 199, 219, 175),
                                              AppBarColors.ABar_Colors,
                                            ],
                                          )),
                                      height: 80,
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 10,
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
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      'Floorplans แผนผังพื้นที่',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ),
                              ),
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
                          ),
                  );

    // Column(children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Container(
    //         height: MediaQuery.of(context).size.height / 1.2,
    //         width: 1600,
    //         decoration: const BoxDecoration(
    //           color: Colors.red,
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(10),
    //               topRight: Radius.circular(10),
    //               bottomLeft: Radius.circular(10),
    //               bottomRight: Radius.circular(10)),
    //           // border: Border.all(color: Colors.grey, width: 1),
    //         ),
    //         padding: const EdgeInsets.all(20),
    //         // color: Colors.white,
    //         child:
    // Stack(
    //           children: [
    //             InteractiveViewer(
    //               alignment: Alignment.center,
    //               scaleEnabled: false,
    //               trackpadScrollCausesScale: false,
    //               transformationController: _controller,
    //               minScale: 0.8,
    //               maxScale: 2.0,
    //               constrained: true,
    //               boundaryMargin:
    //                   const EdgeInsets.all(double.infinity),
    //               child: Container(
    //                 height: 500,
    //                 width: 850,
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   image: DecorationImage(
    //                     image: NetworkImage("$Img_Zone"),
    //                     // fit: BoxFit.cover,
    //                   ),
    //                 ),
    //                 child: Align(
    //                   alignment: Alignment.center,
    //                   child: KeyedSubtree(
    //                       key: _countriesKey,
    //                       child: Container(
    //                         child: Stack(children: [
    //                           for (var areaModels
    //                               in areaFloorplanModels)
    //                             Center(
    //                               child: ClipPath(
    //                                 clipper: Clipper(
    //                                   svgPath: areaModels.path!,
    //                                   height: 15.0,
    //                                   width: 23.2,
    //                                 ),
    //                                 child: InkWell(
    //                                   onTap: () async {
    //                                     onCountrySelected
    //                                         .call(areaModels);
    //                                     print('${areaModels.id}  ');
    //                                     setState(() {
    //                                       Ln_name =
    //                                           '${areaModels.lncode} (${areaModels.ln})';
    //                                       // Ln_name = '${country.}//${areaModels.length}';
    //                                     });
    //                                     showDialog<String>(
    //                                       context: context,
    //                                       builder: (BuildContext
    //                                               context) =>
    //                                           AlertDialog(
    //                                         shape: const RoundedRectangleBorder(
    //                                             borderRadius:
    //                                                 BorderRadius.all(
    //                                                     Radius.circular(
    //                                                         20.0))),
    //                                         title: Center(
    //                                             child: Column(
    //                                           children: [
    //                                             Text(
    //                                               '$Ln_name',
    //                                               style: const TextStyle(
    //                                                   color: AdminScafScreen_Color
    //                                                       .Colors_Text1_,
    //                                                   fontWeight:
    //                                                       FontWeight
    //                                                           .bold,
    //                                                   fontFamily:
    //                                                       FontWeight_
    //                                                           .Fonts_T),
    //                                             ),
    //                                             const SizedBox(
    //                                               height: 5.0,
    //                                             ),
    //                                             Divider(
    //                                               color: Colors
    //                                                   .grey[100],
    //                                               height: 4.0,
    //                                             ),
    //                                             const SizedBox(
    //                                               height: 5.0,
    //                                             ),
    //                                           ],
    //                                         )),
    //                                         content:
    //                                             SingleChildScrollView(
    //                                           child: Column(
    //                                             crossAxisAlignment:
    //                                                 CrossAxisAlignment
    //                                                     .center,
    //                                             children: <Widget>[
    //                                               if (areaModels
    //                                                       .quantity !=
    //                                                   '1')
    //                                                 ListTile(
    //                                                     onTap:
    //                                                         () async {
    //                                                       SharedPreferences
    //                                                           preferences =
    //                                                           await SharedPreferences
    //                                                               .getInstance();
    //                                                       preferences.setString(
    //                                                           'zoneSer',
    //                                                           areaModels
    //                                                               .zser
    //                                                               .toString());
    //                                                       preferences.setString(
    //                                                           'zonesName',
    //                                                           areaModels
    //                                                               .zn
    //                                                               .toString());
    //                                                       setState(
    //                                                           () {
    //                                                         Ser_Body =
    //                                                             1;
    //                                                         a_ln = areaModels
    //                                                             .lncode;
    //                                                         a_ser =
    //                                                             areaModels.ser;
    //                                                         a_area =
    //                                                             areaModels.area;
    //                                                         a_rent =
    //                                                             areaModels.rent;
    //                                                         a_page =
    //                                                             '1';
    //                                                       });

    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     title: Container(
    //                                                         decoration: BoxDecoration(
    //                                                           color:
    //                                                               Colors.grey[100],
    //                                                           borderRadius: const BorderRadius.only(
    //                                                               topLeft: Radius.circular(10),
    //                                                               topRight: Radius.circular(10),
    //                                                               bottomLeft: Radius.circular(10),
    //                                                               bottomRight: Radius.circular(10)),
    //                                                         ),
    //                                                         padding: const EdgeInsets.all(10),
    //                                                         // width: MediaQuery.of(context).size.width,
    //                                                         child: Row(
    //                                                           children: [
    //                                                             Expanded(
    //                                                                 child: Text(
    //                                                               'เสนอราคา: ${areaModels.lncode} (${areaModels.ln})',
    //                                                               overflow: TextOverflow.ellipsis,
    //                                                               style: const TextStyle(
    //                                                                   color: PeopleChaoScreen_Color.Colors_Text2_,
    //                                                                   //fontWeight: FontWeight.bold,
    //                                                                   fontFamily: Font_.Fonts_T),
    //                                                             ))
    //                                                           ],
    //                                                         ))),
    //                                               if (areaModels
    //                                                       .quantity !=
    //                                                   '1')
    //                                                 ListTile(
    //                                                     onTap:
    //                                                         () async {
    //                                                       SharedPreferences
    //                                                           preferences =
    //                                                           await SharedPreferences
    //                                                               .getInstance();
    //                                                       preferences.setString(
    //                                                           'zoneSer',
    //                                                           areaModels
    //                                                               .zser
    //                                                               .toString());
    //                                                       preferences.setString(
    //                                                           'zonesName',
    //                                                           areaModels
    //                                                               .zn
    //                                                               .toString());

    //                                                       setState(
    //                                                           () {
    //                                                         Ser_Body =
    //                                                             2;
    //                                                         a_ln = areaModels
    //                                                             .lncode;
    //                                                         a_ser =
    //                                                             areaModels.ser;
    //                                                         a_area =
    //                                                             areaModels.area;
    //                                                         a_rent =
    //                                                             areaModels.rent;
    //                                                         a_page =
    //                                                             '1';
    //                                                       });
    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     title: Container(
    //                                                         decoration: BoxDecoration(
    //                                                           color:
    //                                                               Colors.grey[100],
    //                                                           borderRadius: const BorderRadius.only(
    //                                                               topLeft: Radius.circular(10),
    //                                                               topRight: Radius.circular(10),
    //                                                               bottomLeft: Radius.circular(10),
    //                                                               bottomRight: Radius.circular(10)),
    //                                                         ),
    //                                                         padding: const EdgeInsets.all(10),
    //                                                         // width: MediaQuery.of(context).size.width,
    //                                                         child: Row(
    //                                                           children: [
    //                                                             Expanded(
    //                                                                 child: Text(
    //                                                               'ทำสัญญา: ${areaModels.lncode} (${areaModels.ln})',
    //                                                               overflow: TextOverflow.ellipsis,
    //                                                               style: const TextStyle(
    //                                                                   color: PeopleChaoScreen_Color.Colors_Text2_,
    //                                                                   //fontWeight: FontWeight.bold,
    //                                                                   fontFamily: Font_.Fonts_T),
    //                                                             ))
    //                                                           ],
    //                                                         ))),
    //                                               if (areaModels
    //                                                       .quantity ==
    //                                                   '1')
    //                                                 ListTile(
    //                                                     onTap:
    //                                                         () async {
    //                                                       setState(
    //                                                           () {
    //                                                         Ser_Body =
    //                                                             3;
    //                                                         Value_cid =
    //                                                             areaModels.cid;
    //                                                         ser_cidtan =
    //                                                             '1';
    //                                                       });
    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     title: Container(
    //                                                         decoration: BoxDecoration(
    //                                                           color:
    //                                                               Colors.grey[100],
    //                                                           borderRadius: const BorderRadius.only(
    //                                                               topLeft: Radius.circular(10),
    //                                                               topRight: Radius.circular(10),
    //                                                               bottomLeft: Radius.circular(10),
    //                                                               bottomRight: Radius.circular(10)),
    //                                                         ),
    //                                                         padding: const EdgeInsets.all(10),
    //                                                         // width: MediaQuery.of(context).size.width,
    //                                                         child: Row(
    //                                                           children: [
    //                                                             Expanded(
    //                                                                 child: Text(
    //                                                               'เช่าอยู่: ${areaModels.cid}',
    //                                                               overflow: TextOverflow.ellipsis,
    //                                                               style: const TextStyle(
    //                                                                   color: PeopleChaoScreen_Color.Colors_Text2_,
    //                                                                   //fontWeight: FontWeight.bold,
    //                                                                   fontFamily: Font_.Fonts_T),
    //                                                             ))
    //                                                           ],
    //                                                         ))),
    //                                               if (areaModels
    //                                                       .quantity ==
    //                                                   '1')
    //                                                 ListTile(
    //                                                     onTap:
    //                                                         () async {
    //                                                       setState(
    //                                                           () {
    //                                                         Ser_Body =
    //                                                             4;
    //                                                         Value_cid =
    //                                                             areaModels.cid;
    //                                                         ser_cidtan =
    //                                                             '1';
    //                                                       });
    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     title: Container(
    //                                                         decoration: BoxDecoration(
    //                                                           color:
    //                                                               Colors.grey[100],
    //                                                           borderRadius: const BorderRadius.only(
    //                                                               topLeft: Radius.circular(10),
    //                                                               topRight: Radius.circular(10),
    //                                                               bottomLeft: Radius.circular(10),
    //                                                               bottomRight: Radius.circular(10)),
    //                                                         ),
    //                                                         padding: const EdgeInsets.all(10),
    //                                                         // width: MediaQuery.of(context).size.width,
    //                                                         child: Row(
    //                                                           children: [
    //                                                             Expanded(
    //                                                                 child: Text(
    //                                                               'รับชำระ: ${areaModels.cid}',
    //                                                               overflow: TextOverflow.ellipsis,
    //                                                               style: const TextStyle(
    //                                                                   color: PeopleChaoScreen_Color.Colors_Text2_,
    //                                                                   //fontWeight: FontWeight.bold,
    //                                                                   fontFamily: Font_.Fonts_T),
    //                                                             ))
    //                                                           ],
    //                                                         ))),
    //                                               if (areaModels
    //                                                       .quantity ==
    //                                                   '2')
    //                                                 ListTile(
    //                                                     onTap:
    //                                                         () async {
    //                                                       setState(
    //                                                           () {
    //                                                         Ser_Body =
    //                                                             3;
    //                                                         Value_cid =
    //                                                             areaModels.docno;
    //                                                         ser_cidtan =
    //                                                             '2';
    //                                                       });
    //                                                       Navigator.pop(
    //                                                           context);
    //                                                     },
    //                                                     title: Container(
    //                                                         decoration: BoxDecoration(
    //                                                           color:
    //                                                               Colors.grey[100],
    //                                                           borderRadius: const BorderRadius.only(
    //                                                               topLeft: Radius.circular(10),
    //                                                               topRight: Radius.circular(10),
    //                                                               bottomLeft: Radius.circular(10),
    //                                                               bottomRight: Radius.circular(10)),
    //                                                         ),
    //                                                         padding: const EdgeInsets.all(10),
    //                                                         // width: MediaQuery.of(context).size.width,
    //                                                         child: Row(
    //                                                           children: [
    //                                                             Expanded(
    //                                                                 child: Text(
    //                                                               'เสนอราคา: ${areaModels.docno}',
    //                                                               overflow: TextOverflow.ellipsis,
    //                                                               style: const TextStyle(
    //                                                                   color: PeopleChaoScreen_Color.Colors_Text2_,
    //                                                                   //fontWeight: FontWeight.bold,
    //                                                                   fontFamily: Font_.Fonts_T),
    //                                                             ))
    //                                                           ],
    //                                                         ))),
    //                                             ],
    //                                           ),
    //                                         ),
    //                                         actions: <Widget>[
    //                                           Column(
    //                                             children: [
    //                                               const SizedBox(
    //                                                 height: 2.0,
    //                                               ),
    //                                               const Divider(
    //                                                 color:
    //                                                     Colors.grey,
    //                                                 height: 4.0,
    //                                               ),
    //                                               const SizedBox(
    //                                                 height: 2.0,
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                     const EdgeInsets
    //                                                             .all(
    //                                                         8.0),
    //                                                 child: Row(
    //                                                   mainAxisAlignment:
    //                                                       MainAxisAlignment
    //                                                           .center,
    //                                                   children: [
    //                                                     Padding(
    //                                                       padding:
    //                                                           const EdgeInsets.all(
    //                                                               4.0),
    //                                                       child:
    //                                                           Row(
    //                                                         mainAxisAlignment:
    //                                                             MainAxisAlignment.center,
    //                                                         children: [
    //                                                           Container(
    //                                                             width:
    //                                                                 100,
    //                                                             decoration:
    //                                                                 const BoxDecoration(
    //                                                               color: Colors.redAccent,
    //                                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
    //                                                             ),
    //                                                             padding:
    //                                                                 const EdgeInsets.all(5.0),
    //                                                             child:
    //                                                                 TextButton(
    //                                                               onPressed: () => Navigator.pop(context, 'OK'),
    //                                                               child: const Text(
    //                                                                 'ปิด',
    //                                                                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
    //                                                               ),
    //                                                             ),
    //                                                           ),
    //                                                         ],
    //                                                       ),
    //                                                     ),
    //                                                   ],
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     );
    //                                   },
    //                                   child: Container(
    //                                     decoration: BoxDecoration(
    //                                       color: (areaFloorplanModelss
    //                                                   ?.id ==
    //                                               areaModels.id)
    //                                           ? areaModels.quantity ==
    //                                                   '1'
    //                                               ? Colors.red[800]!
    //                                                   .withOpacity(
    //                                                       0.5)
    //                                               : areaModels.quantity ==
    //                                                       '2'
    //                                                   ? Colors.blue[800]!
    //                                                       .withOpacity(
    //                                                           0.5)
    //                                                   : areaModels.quantity ==
    //                                                           '3'
    //                                                       ? Colors.purple[800]!.withOpacity(
    //                                                           0.5)
    //                                                       : Colors.green[800]!
    //                                                           .withOpacity(
    //                                                               0.5)
    //                                           : areaModels.quantity ==
    //                                                   '1'
    //                                               ? Colors.red[200]!
    //                                                   .withOpacity(
    //                                                       0.5)
    //                                               : areaModels.quantity ==
    //                                                       '2'
    //                                                   ? Colors
    //                                                       .blue[200]!
    //                                                       .withOpacity(0.5)
    //                                                   : areaModels.quantity == '3'
    //                                                       ? Colors.purple[200]!.withOpacity(0.5)
    //                                                       : Colors.green[200]!.withOpacity(0.5),
    //                                       //  color: (areaFloorplanModelss?.id == areaModels.id) ? Colors.deepPurple[400]!.withOpacity(0.5) : Colors.blue[600]!.withOpacity(0.5),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                         ]),
    //                       )),
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               top: 10,
    //               right: 10,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.blueGrey.withOpacity(0.5),
    //                   borderRadius: const BorderRadius.only(
    //                     topLeft: Radius.circular(5),
    //                     topRight: Radius.circular(5),
    //                     bottomLeft: Radius.circular(5),
    //                     bottomRight: Radius.circular(5),
    //                   ),
    //                 ),
    //                 padding: const EdgeInsets.all(2.0),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     IconButton(
    //                       icon: const Icon(
    //                         Icons.zoom_in,
    //                         color: Colors.white,
    //                       ),
    //                       onPressed: _zoomInSVG,
    //                     ),
    //                     IconButton(
    //                       icon: const Icon(
    //                         Icons.zoom_out,
    //                         color: Colors.white,
    //                       ),
    //                       onPressed: _zoomOutSVG,
    //                     ),
    //                     Container(
    //                       decoration: BoxDecoration(
    //                         color: Colors.grey,
    //                         borderRadius: const BorderRadius.only(
    //                           topLeft: Radius.circular(5),
    //                           topRight: Radius.circular(5),
    //                           bottomLeft: Radius.circular(5),
    //                           bottomRight: Radius.circular(5),
    //                         ),
    //                       ),
    //                       child: Text(
    //                         '${MediaQuery.of(context).size.width}',
    //                         overflow: TextOverflow.ellipsis,
    //                         // minFontSize: 1,
    //                         // maxFontSize: 12,
    //                         maxLines: 1,
    //                         textAlign: TextAlign.left,
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                           fontFamily: Font_.Fonts_T,

    //                           //fontSize: 10.0s
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     )
    //   ]);
  }

  Future<Null> read_GC_con_area(int index) async {
    if (areaxConModels.length != 0) {
      setState(() {
        areaxConModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var zoneSubSer = preferences.getString('zoneSubSer');
    var zonesSubName = preferences.getString('zonesSubName');
    var ren = preferences.getString('renTalSer');
    var aser = areaModels[index].ser.toString();

    String url =
        '${MyConstant().domain}/GC_areax_con.php?isAdd=true&ren=$ren&aser=$aser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      areaxConModels.clear();
      for (var map in result) {
        AreaxConModel areaxConModel = AreaxConModel.fromJson(map);
        var cid = areaModels[index].cid;
        var cser = areaxConModel.cser;
        setState(() {
          if (cid != cser) {
            areaxConModels.add(areaxConModel);
          }
        });
      }
    } catch (e) {}
  }

/////-------------------------------------------->
  Color getRandomColor(index) {
    final random = Random();
    return areaModels[index].quantity == '1'
        ? datex.isAfter(
                    DateTime.parse('${areaModels[index].ldate} 00:00:00.000')
                        .subtract(Duration(days: open_set_date))) ==
                true
            ? Colors.grey.shade700
            : Colors.red.shade700
        : areaModels[index].quantity == '2'
            ? Colors.blue.shade700
            : areaModels[index].quantity == '3'
                ? Colors.purple.shade700
                : Colors.green.shade700;
  }

  dialog_svg(int index, context) {
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
              ' ${areaModels[index].lncode} (${areaModels[index].ln})',
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
              if (areaModels[index].quantity != '1')
                ListTile(
                    onTap: () async {
                      if (renTal_lavel <= 2) {
                        infomation();
                      } else {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString(
                            'zoneSer', areaModels[index].zser.toString());
                        preferences.setString(
                            'zonesName', areaModels[index].zn.toString());
                        setState(() {
                          Ser_Body = 1;
                          a_ln = areaModels[index].lncode;
                          a_ser = areaModels[index].ser;
                          a_area = areaModels[index].area;
                          a_rent = areaModels[index].rent;
                          a_page = '1';
                        });
                        Navigator.pop(context, 'OK');
                      }
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
                              'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index)),
                        ],
                      ),
                    )),
////////////-------------------------->
              if (areaModels[index].quantity != '1')
                ListTile(
                    onTap: () async {
                      if (renTal_lavel <= 2) {
                        infomation();
                      } else {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString(
                            'zoneSer', areaModels[index].zser.toString());
                        preferences.setString(
                            'zonesName', areaModels[index].zn.toString());

                        setState(() {
                          Ser_Body = 2;
                          a_ln = areaModels[index].lncode;
                          a_ser = areaModels[index].ser;
                          a_area = areaModels[index].area;
                          a_rent = areaModels[index].rent;
                          a_page = '1';
                        });
                        Navigator.pop(context, 'OK');
                      }
                    },
                    title: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      )),
                      padding: const EdgeInsets.all(4.0),
                      width: 270,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index)),
                        ],
                      ),
                    )),
////////////-------------------------->
              if (areaModels[index].quantity == '1')
                for (int i = 0; i < areaxConModels.length; i++)
                  ListTile(
                      onTap: () async {
                        if (renTal_lavel <= 2) {
                          infomation();
                        } else {
                          setState(() {
                            Ser_Body = 3;
                            Value_stasus = '0';
                            Value_cid = areaxConModels[i].cser;
                            ser_cidtan = '1';
                          });
                          Navigator.pop(context, 'OK');
                        }
                      },
                      // title: '${areaxConModels[i].cser} (${areaxConModels[i].cname})',
                      // textStyle: const TextStyle(
                      //     color: PeopleChaoScreen_Color.Colors_Text2_,
                      //     //fontWeight: FontWeight.bold,
                      //     fontFamily: Font_.Fonts_T),
                      title: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            //                    <--- top side
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        )),
                        padding: const EdgeInsets.all(4.0),
                        width: 270,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${areaxConModels[i].cser} (${areaxConModels[i].cname})',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Icon(Iconsax.arrow_circle_right,
                                color: getRandomColor(index)),
                          ],
                        ),
                      )),
              if (areaModels[index].quantity == '1')
                if (areaModels[index].cid != areaModels[index].fid &&
                    areaModels[index].con_st_cid == 'สัญญาปัจจุบัน')
                  ListTile(
                      onTap: () async {
                        if (renTal_lavel <= 2) {
                          infomation();
                        } else {
                          setState(() {
                            Ser_Body = 3;
                            Value_stasus = areaModels[index].quantity == '1'
                                ? datex.isAfter(DateTime.parse(
                                                '${areaModels[index].ldate} 00:00:00.000')
                                            .subtract(
                                                const Duration(days: 0))) ==
                                        true
                                    ? 'หมดสัญญา'
                                    : datex.isAfter(DateTime.parse(
                                                    '${areaModels[index].ldate} 00:00:00.000')
                                                .subtract(Duration(
                                                    days: open_set_date))) ==
                                            true
                                        ? 'ใกล้หมดสัญญา'
                                        : 'เช่าอยู่'
                                : areaModels[index].quantity == '2'
                                    ? 'เสนอราคา'
                                    : areaModels[index].quantity == '3'
                                        ? 'เสนอราคา(มัดจำ)'
                                        : 'ว่าง';
                            Value_cid = areaModels[index].fid;
                            ser_cidtan = '1';
                          });
                          Navigator.pop(context, 'OK');
                        }
                      },
                      // title:
                      //     'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
                      // textStyle: const TextStyle(
                      //     color: PeopleChaoScreen_Color.Colors_Text2_,
                      //     //fontWeight: FontWeight.bold,
                      //     fontFamily: Font_.Fonts_T),
                      title: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            //                    <--- top side
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        )),
                        padding: const EdgeInsets.all(4.0),
                        width: 270,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'สัญญาเดิม: ${areaModels[index].fid} (${areaModels[index].cname})',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Icon(Iconsax.arrow_circle_right,
                                color: getRandomColor(index)),
                          ],
                        ),
                      )),

////////////-------------------------->
              if (areaModels[index].quantity == '1')
                ListTile(
                    onTap: () async {
                      if (renTal_lavel <= 2) {
                        infomation();
                      } else {
                        setState(() {
                          Ser_Body = 3;
                          Value_stasus = areaModels[index].quantity == '1'
                              ? datex.isAfter(DateTime.parse(
                                              '${areaModels[index].ldate} 00:00:00.000')
                                          .subtract(const Duration(days: 0))) ==
                                      true
                                  ? 'หมดสัญญา'
                                  : datex.isAfter(DateTime.parse(
                                                  '${areaModels[index].ldate} 00:00:00.000')
                                              .subtract(Duration(
                                                  days: open_set_date))) ==
                                          true
                                      ? 'ใกล้หมดสัญญา'
                                      : 'เช่าอยู่'
                              : areaModels[index].quantity == '2'
                                  ? 'เสนอราคา'
                                  : areaModels[index].quantity == '3'
                                      ? 'เสนอราคา(มัดจำ)'
                                      : 'ว่าง';
                          Value_cid = areaModels[index].cid;
                          ser_cidtan = '1';
                        });
                        Navigator.pop(context, 'OK');
                      }
                    },
                    // title:
                    //     'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
                    // textStyle: const TextStyle(
                    //     color: PeopleChaoScreen_Color.Colors_Text2_,
                    //     //fontWeight: FontWeight.bold,
                    //     fontFamily: Font_.Fonts_T),
                    title: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      )),
                      padding: const EdgeInsets.all(4.0),
                      width: 270,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index)),
                        ],
                      ),
                    )),

////////////-------------------------->
              if (areaModels[index].quantity == '1')
                ListTile(
                    onTap: () async {
                      if (renTal_lavel <= 2) {
                        infomation();
                      } else {
                        setState(() {
                          Value_stasus = areaModels[index].quantity == '1'
                              ? datex.isAfter(DateTime.parse(
                                              '${areaModels[index].ldate} 00:00:00.000')
                                          .subtract(const Duration(days: 0))) ==
                                      true
                                  ? 'หมดสัญญา'
                                  : datex.isAfter(DateTime.parse(
                                                  '${areaModels[index].ldate} 00:00:00.000')
                                              .subtract(Duration(
                                                  days: open_set_date))) ==
                                          true
                                      ? 'ใกล้หมดสัญญา'
                                      : 'เช่าอยู่'
                              : areaModels[index].quantity == '2'
                                  ? 'เสนอราคา'
                                  : areaModels[index].quantity == '3'
                                      ? 'เสนอราคา(มัดจำ)'
                                      : 'ว่าง';
                          Ser_Body = 4;
                          Value_cid = areaModels[index].cid;
                          ser_cidtan = '1';
                        });
                        Navigator.pop(context, 'OK');
                      }
                    },
                    // title:
                    //     'รับชำระ: ${areaModels[index].cid} (${areaModels[index].cname})',
                    // textStyle: const TextStyle(
                    //     color: PeopleChaoScreen_Color.Colors_Text2_,
                    //     //fontWeight: FontWeight.bold,
                    //     fontFamily: Font_.Fonts_T),
                    title: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      )),
                      padding: const EdgeInsets.all(4.0),
                      width: 270,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'รับชำระ: ${areaModels[index].cid} (${areaModels[index].cname})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index)),
                        ],
                      ),
                    )),
              ////////////-------------------------->
              if (areaModels[index].quantity == '2')
                for (int i = 0; i < areaQuotModels.length; i++)
                  if (areaQuotModels[i]
                          .ln_q!
                          .contains(areaModels[index].lncode.toString()) ==
                      true)
                    ListTile(
                        onTap: () async {
                          if (renTal_lavel <= 2) {
                            infomation();
                          } else {
                            setState(() {
                              Ser_Body = 3;
                              Value_stasus = '1';
                              Value_cid = areaQuotModels[i].docno;
                              ser_cidtan = '2';
                            });
                            Navigator.pop(context, 'OK');
                          }
                        },
                        // title: 'เสนอราคา: ${areaQuotModels[i].docno}',
                        // textStyle: const TextStyle(
                        //     color: PeopleChaoScreen_Color.Colors_Text2_,
                        //     //fontWeight: FontWeight.bold,
                        //     fontFamily: Font_.Fonts_T),
                        title: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              //                    <--- top side
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          )),
                          padding: const EdgeInsets.all(4.0),
                          width: 270,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'เสนอราคา: ${areaQuotModels[i].docno}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Icon(Iconsax.arrow_circle_right,
                                  color: getRandomColor(index)),
                            ],
                          ),
                        )),
              ////////////-------------------------->
              if (areaModels[index].quantity == '3')
                // for (int i = 0; i < areaQuotModels.length; i++)
                for (int i = 0; i < areaQuotModels.length; i++)
                  if (areaQuotModels[i]
                          .ln_q!
                          .contains(areaModels[index].lncode.toString()) ==
                      true)
                    ListTile(
                        onTap: () async {
                          if (renTal_lavel <= 2) {
                            infomation();
                          } else {
                            setState(() {
                              Ser_Body = 3;
                              Value_stasus = '1';
                              Value_cid = areaQuotModels[i].docno;
                              ser_cidtan = '2';
                            });
                            Navigator.pop(context, 'OK');
                          }
                        },
                        // title: 'เสนอราคา: (มัดจำ) ${areaQuotModels[i].docno}',
                        // textStyle: const TextStyle(
                        //     color: PeopleChaoScreen_Color.Colors_Text2_,
                        //     //fontWeight: FontWeight.bold,
                        //     fontFamily: Font_.Fonts_T),
                        title: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              //                    <--- top side
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          )),
                          padding: const EdgeInsets.all(4.0),
                          width: 270,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'เสนอราคา: (มัดจำ) ${areaQuotModels[i].docno}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Icon(Iconsax.arrow_circle_right,
                                  color: getRandomColor(index)),
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

  PopupMenu? menu;
  maxColumn(int index, context) {
    menu = PopupMenu(
      context: context,
      // config: const MenuConfig(
      //   type: MenuType.custom,
      //   itemHeight: 200,
      //   itemWidth: 200,
      //   backgroundColor: Colors.green,
      // ),
      config: MenuConfig(
          border: BorderConfig(
            color: Color.fromARGB(255, 56, 56, 56),
          ),
          itemWidth: 300,
          backgroundColor: Color.fromARGB(255, 252, 251, 251),
          type: MenuType.list,
          lineColor: Colors.greenAccent,
          maxColumn: 10),
      items: [
        if (areaModels[index].quantity == '1' &&
            areaModels[index].docno != null)
          PopUpMenuItem(
              // title:
              //     'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    if (renTal_lavel <= 2) {
                      menu!.dismiss();
                      infomation();
                    } else {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          'zoneSer', areaModels[index].zser.toString());
                      preferences.setString(
                          'zonesName', areaModels[index].zn.toString());
                      setState(() {
                        Ser_Body = 1;
                        a_ln = areaModels[index].lncode;
                        a_ser = areaModels[index].ser;
                        a_area = areaModels[index].area;
                        a_rent = areaModels[index].rent;
                        a_page = '1';
                      });
                      menu!.dismiss();
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
        if (areaModels[index].quantity != '1')
          PopUpMenuItem(
              // title:
              //     'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    if (renTal_lavel <= 2) {
                      menu!.dismiss();
                      infomation();
                    } else {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          'zoneSer', areaModels[index].zser.toString());
                      preferences.setString(
                          'zonesName', areaModels[index].zn.toString());
                      setState(() {
                        Ser_Body = 1;
                        a_ln = areaModels[index].lncode;
                        a_ser = areaModels[index].ser;
                        a_area = areaModels[index].area;
                        a_rent = areaModels[index].rent;
                        a_page = '1';
                      });
                      menu!.dismiss();
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
        if (areaModels[index].quantity == '1' &&
            areaModels[index].cc_date != null &&
            areaModels[index].cc_date.toString() != "0000-00-00")
          PopUpMenuItem(
              // title:
              //     'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    if (renTal_lavel <= 2) {
                      menu!.dismiss();
                      infomation();
                    } else {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          'zoneSer', areaModels[index].zser.toString());
                      preferences.setString(
                          'zonesName', areaModels[index].zn.toString());
                      setState(() {
                        Ser_Body = 1;
                        a_ln = areaModels[index].lncode;
                        a_ser = areaModels[index].ser;
                        a_area = areaModels[index].area;
                        a_rent = areaModels[index].rent;
                        a_page = '1';
                      });
                      menu!.dismiss();
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),

////////////-------------------------->
        ///
        if (areaModels[index].quantity != '1')
          PopUpMenuItem(
              // title:
              //     'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    if (renTal_lavel <= 2) {
                      menu!.dismiss();
                      infomation();
                    } else {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          'zoneSer', areaModels[index].zser.toString());
                      preferences.setString(
                          'zonesName', areaModels[index].zn.toString());

                      setState(() {
                        Ser_Body = 2;
                        a_ln = areaModels[index].lncode;
                        a_ser = areaModels[index].ser;
                        a_area = areaModels[index].area;
                        a_rent = areaModels[index].rent;
                        a_page = '1';
                      });
                      menu!.dismiss();
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    )),
                    padding: const EdgeInsets.all(4.0),
                    width: 270,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),

        if (areaModels[index].quantity == '1' &&
            areaModels[index].cc_date != null &&
            areaModels[index].cc_date.toString() != "0000-00-00")
          PopUpMenuItem(
              // title:
              //     'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    if (renTal_lavel <= 2) {
                      menu!.dismiss();
                      infomation();
                    } else {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          'zoneSer', areaModels[index].zser.toString());
                      preferences.setString(
                          'zonesName', areaModels[index].zn.toString());

                      setState(() {
                        Ser_Body = 2;
                        a_ln = areaModels[index].lncode;
                        a_ser = areaModels[index].ser;
                        a_area = areaModels[index].area;
                        a_rent = areaModels[index].rent;
                        a_page = '1';
                      });
                      menu!.dismiss();
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    )),
                    padding: const EdgeInsets.all(4.0),
                    width: 270,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
////////////-------------------------->
        if (areaModels[index].quantity == '1')
          for (int i = 0; i < areaxConModels.length; i++)
            PopUpMenuItem(
                // title: '${areaxConModels[i].cser} (${areaxConModels[i].cname})',
                // textStyle: const TextStyle(
                //     color: PeopleChaoScreen_Color.Colors_Text2_,
                //     //fontWeight: FontWeight.bold,
                //     fontFamily: Font_.Fonts_T),
                image: InkWell(
                    onTap: () async {
                      if (renTal_lavel <= 2) {
                        menu!.dismiss();
                        infomation();
                      } else {
                        setState(() {
                          Ser_Body = 3;
                          Value_stasus = '0';
                          Value_cid = areaxConModels[i].cser;
                          ser_cidtan = '1';
                        });
                        menu!.dismiss();
                      }
                      // Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      )),
                      padding: const EdgeInsets.all(4.0),
                      width: 270,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${areaxConModels[i].cser} (${areaxConModels[i].cname})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index)),
                        ],
                      ),
                    ))),
        if (areaModels[index].quantity == '1')
          if (areaModels[index].cid != areaModels[index].fid &&
              areaModels[index].con_st_cid == 'สัญญาปัจจุบัน')
            PopUpMenuItem(
                // title:
                //     'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
                // textStyle: const TextStyle(
                //     color: PeopleChaoScreen_Color.Colors_Text2_,
                //     //fontWeight: FontWeight.bold,
                //     fontFamily: Font_.Fonts_T),
                image: InkWell(
                    onTap: () async {
                      if (renTal_lavel <= 2) {
                        menu!.dismiss();
                        infomation();
                      } else {
                        setState(() {
                          Ser_Body = 3;
                          Value_stasus = areaModels[index].quantity == '1'
                              ? datex.isAfter(DateTime.parse(
                                              '${areaModels[index].ldate} 00:00:00.000')
                                          .subtract(const Duration(days: 0))) ==
                                      true
                                  ? 'หมดสัญญา'
                                  : datex.isAfter(DateTime.parse(
                                                  '${areaModels[index].ldate} 00:00:00.000')
                                              .subtract(Duration(
                                                  days: open_set_date))) ==
                                          true
                                      ? 'ใกล้หมดสัญญา'
                                      : 'เช่าอยู่'
                              : areaModels[index].quantity == '2'
                                  ? 'เสนอราคา'
                                  : areaModels[index].quantity == '3'
                                      ? 'เสนอราคา(มัดจำ)'
                                      : 'ว่าง';
                          Value_cid = areaModels[index].fid;
                          ser_cidtan = '1';
                        });
                        menu!.dismiss();
                      }
                      // Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      )),
                      padding: const EdgeInsets.all(4.0),
                      width: 270,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'สัญญาเดิม: ${areaModels[index].fid} (${areaModels[index].cname})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index)),
                        ],
                      ),
                    ))),
////////////-------------------------->
        if (areaModels[index].quantity == '1')
          PopUpMenuItem(
              // title:
              //     'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    if (renTal_lavel <= 2) {
                      menu!.dismiss();
                      infomation();
                    } else {
                      setState(() {
                        Ser_Body = 3;
                        Value_stasus = areaModels[index].quantity == '1'
                            ? datex.isAfter(DateTime.parse(
                                            '${areaModels[index].ldate} 00:00:00.000')
                                        .subtract(const Duration(days: 0))) ==
                                    true
                                ? 'หมดสัญญา'
                                : datex.isAfter(DateTime.parse(
                                                '${areaModels[index].ldate} 00:00:00.000')
                                            .subtract(Duration(
                                                days: open_set_date))) ==
                                        true
                                    ? 'ใกล้หมดสัญญา'
                                    : 'เช่าอยู่'
                            : areaModels[index].quantity == '2'
                                ? 'เสนอราคา'
                                : areaModels[index].quantity == '3'
                                    ? 'เสนอราคา(มัดจำ)'
                                    : 'ว่าง';
                        Value_cid = areaModels[index].cid;
                        ser_cidtan = '1';
                      });
                      menu!.dismiss();
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    )),
                    padding: const EdgeInsets.all(4.0),
                    width: 270,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            areaModels[index].scfid == 'N'
                                ? 'N: ${areaModels[index].cid} (${areaModels[index].cname})'
                                : 'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),

////////////-------------------------->
        if (areaModels[index].quantity == '1')
          PopUpMenuItem(
              // title:
              //     'รับชำระ: ${areaModels[index].cid} (${areaModels[index].cname})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    if (renTal_lavel <= 2) {
                      menu!.dismiss();
                      infomation();
                    } else {
                      setState(() {
                        Value_stasus = areaModels[index].quantity == '1'
                            ? datex.isAfter(DateTime.parse(
                                            '${areaModels[index].ldate} 00:00:00.000')
                                        .subtract(const Duration(days: 0))) ==
                                    true
                                ? 'หมดสัญญา'
                                : datex.isAfter(DateTime.parse(
                                                '${areaModels[index].ldate} 00:00:00.000')
                                            .subtract(Duration(
                                                days: open_set_date))) ==
                                        true
                                    ? 'ใกล้หมดสัญญา'
                                    : 'เช่าอยู่'
                            : areaModels[index].quantity == '2'
                                ? 'เสนอราคา'
                                : areaModels[index].quantity == '3'
                                    ? 'เสนอราคา(มัดจำ)'
                                    : 'ว่าง';
                        Ser_Body = 4;
                        Value_cid = areaModels[index].cid;
                        ser_cidtan = '1';
                      });
                      menu!.dismiss();
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    )),
                    padding: const EdgeInsets.all(4.0),
                    width: 270,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            areaModels[index].scfid == 'N'
                                ? 'N: ${areaModels[index].cid} (${areaModels[index].cname})'
                                : 'รับชำระ: ${areaModels[index].cid} (${areaModels[index].cname})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
        ////////////-------------------------->
        if (areaModels[index].quantity == '2')
          for (int i = 0; i < areaQuotModels.length; i++)
            if (areaQuotModels[i]
                    .ln_q!
                    .contains(areaModels[index].lncode.toString()) ==
                true)
              PopUpMenuItem(
                  // title: 'เสนอราคา: ${areaQuotModels[i].docno}',
                  // textStyle: const TextStyle(
                  //     color: PeopleChaoScreen_Color.Colors_Text2_,
                  //     //fontWeight: FontWeight.bold,
                  //     fontFamily: Font_.Fonts_T),
                  image: InkWell(
                      onTap: () async {
                        if (renTal_lavel <= 2) {
                          menu!.dismiss();
                          infomation();
                        } else {
                          setState(() {
                            Ser_Body = 3;
                            Value_stasus = '1';
                            Value_cid = areaQuotModels[i].docno;
                            ser_cidtan = '2';
                          });
                          menu!.dismiss();
                        }
                        // Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            //                    <--- top side
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        )),
                        padding: const EdgeInsets.all(4.0),
                        width: 270,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'เสนอราคา: ${areaQuotModels[i].docno}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Icon(Iconsax.arrow_circle_right,
                                color: getRandomColor(index)),
                          ],
                        ),
                      ))),
        ////////////-------------------------->
        if (areaModels[index].quantity == '3')
          // for (int i = 0; i < areaQuotModels.length; i++)
          for (int i = 0; i < areaQuotModels.length; i++)
            if (areaQuotModels[i]
                    .ln_q!
                    .contains(areaModels[index].lncode.toString()) ==
                true)
              PopUpMenuItem(
                  // title: 'เสนอราคา: (มัดจำ) ${areaQuotModels[i].docno}',
                  // textStyle: const TextStyle(
                  //     color: PeopleChaoScreen_Color.Colors_Text2_,
                  //     //fontWeight: FontWeight.bold,
                  //     fontFamily: Font_.Fonts_T),
                  image: InkWell(
                      onTap: () async {
                        if (renTal_lavel <= 2) {
                          menu!.dismiss();
                          infomation();
                        } else {
                          setState(() {
                            Ser_Body = 3;
                            Value_stasus = '1';
                            Value_cid = areaQuotModels[i].docno;
                            ser_cidtan = '2';
                          });
                          menu!.dismiss();
                        }
                        // Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            //                    <--- top side
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        )),
                        padding: const EdgeInsets.all(4.0),
                        width: 270,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'เสนอราคา: (มัดจำ) ${areaQuotModels[i].docno}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Icon(Iconsax.arrow_circle_right,
                                color: getRandomColor(index)),
                          ],
                        ),
                      ))),

        if (areaModels[index].quantity == '1' && areaModels[index].cfid != null)
          PopUpMenuItem(
              // title:
              //     'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    if (renTal_lavel <= 2) {
                      menu!.dismiss();
                      infomation();
                    } else {
                      setState(() {
                        Ser_Body = 3;
                        Value_stasus = areaModels[index].quantity == '1'
                            ? datex.isAfter(DateTime.parse(
                                            '${areaModels[index].ldate} 00:00:00.000')
                                        .subtract(const Duration(days: 0))) ==
                                    true
                                ? 'หมดสัญญา'
                                : datex.isAfter(DateTime.parse(
                                                '${areaModels[index].ldate} 00:00:00.000')
                                            .subtract(Duration(
                                                days: open_set_date))) ==
                                        true
                                    ? 'ใกล้หมดสัญญา'
                                    : 'เช่าอยู่'
                            : areaModels[index].quantity == '2'
                                ? 'เสนอราคา'
                                : areaModels[index].quantity == '3'
                                    ? 'เสนอราคา(มัดจำ)'
                                    : 'ว่าง';
                        Value_cid = areaModels[index].cfid;
                        ser_cidtan = '1';
                      });
                      menu!.dismiss();
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    )),
                    padding: const EdgeInsets.all(4.0),
                    width: 270,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เช่าอยู่: ${areaModels[index].cfid}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
      ],

      // onDismiss: onDismiss,
    );
    menu!.show(widgetKey: _btnKeys[index]);

    // Future.delayed(const Duration(seconds: 1), () {

    //   menu!.dismiss();
    // });
  }

  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    showDialog(
      barrierDismissible:
          false, // Set to true if you want to allow dismissing the dialog by tapping outside
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget createCard(int index, context) {
    return (_btnKeys.length == 0)
        ? SizedBox()
        : Stack(
            children: [
              Card(
                  color: areaModels[index].quantity == '1'
                      ? (areaModels[index].ldate == null)
                          ? Colors.red.shade200
                          : datex.isAfter(DateTime.parse(
                                          '${areaModels[index].ldate} 00:00:00.000')
                                      .subtract(
                                          Duration(days: open_set_date))) ==
                                  true //datex
                              ? datex.isAfter(DateTime.parse(
                                              '${areaModels[index].ldate} 00:00:00.000')
                                          .subtract(Duration(days: 0))) ==
                                      false
                                  ? Colors.orange.shade200
                                  : Colors.grey.shade200
                              : Colors.red.shade200
                      : areaModels[index].quantity == '2'
                          ? Colors.blue.shade200
                          : areaModels[index].quantity == '3'
                              ? Colors.purple.shade200
                              : Colors.green.shade200,
                  child: MaterialButton(
                    key: _btnKeys[index],
                    onPressed: () async {
                      setState(() {
                        read_GC_con_area(index);
                        // if (areaModels[index].quantity == '2' ||
                        //     areaModels[index].quantity == '3') {
                        //   loadareaQuot(index);
                        // }
                      });
                      if (areaModels[index].quantity != '1') {
                        for (int i = 0; i < areaQuotModels.length; i++) {
                          var oo = areaQuotModels[i]
                              .ln_q!
                              .contains(areaModels[index].ln.toString());
                          // print('$oo');
                          // print('${areaQuotModels[i].ln_q}');
                          // print('${areaModels[index].ln}');
                        }
                      }

                      // showLoaderDialog(context);
                      Future.delayed(const Duration(milliseconds: 400), () {
                        maxColumn(index, context);
                      });
                    },
                    child: Container(
                        color: areaModels[index].quantity == '1'
                            ? (areaModels[index].ldate == null)
                                ? Colors.red.shade200
                                : datex.isAfter(DateTime.parse(
                                                '${areaModels[index].ldate} 00:00:00.000')
                                            .subtract(Duration(
                                                days: open_set_date))) ==
                                        true //datex
                                    ? datex.isAfter(DateTime.parse(
                                                    '${areaModels[index].ldate} 00:00:00.000')
                                                .subtract(Duration(days: 0))) ==
                                            false
                                        ? Colors.orange.shade200
                                        : Colors.grey.shade200
                                    : Colors.red.shade200
                            : areaModels[index].quantity == '2'
                                ? Colors.blue.shade200
                                : areaModels[index].quantity == '3'
                                    ? Colors.purple.shade200
                                    : Colors.green.shade200,
                        width: MediaQuery.of(context).size.width * 0.1,
                        // height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: AutoSizeText(
                              '${areaModels[index].lncode} (${areaModels[index].ln})',
                              minFontSize: 8,
                              maxFontSize:
                                  (Responsive.isDesktop(context)) ? 18 : 12,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                // fontSize: 20,
                                fontFamily: Font_.Fonts_T,
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                              ),
                              maxLines: (Responsive.isDesktop(context)) ? 4 : 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                            AutoSizeText(
                              areaModels[index].quantity == '1'
                                  ? (areaModels[index].ldate == null)
                                      ? 'หมดสัญญา'
                                      : datex.isAfter(DateTime.parse(
                                                      '${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000')
                                                  .subtract(const Duration(
                                                      days: 0))) ==
                                              true
                                          ? 'หมดสัญญา ${areaModels[index].cc_date != null ? areaModels[index].cc_date == "0000-00-00" ? '' : DateFormat('dd-MM-yyyy').format(DateTime.parse('${areaModels[index].cc_date} 00:00:00.000')) : ''}'
                                          : datex.isAfter(DateTime.parse(
                                                          '${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000')
                                                      .subtract(Duration(
                                                          days:
                                                              open_set_date))) ==
                                                  true
                                              ? 'ใกล้หมดสัญญา ${areaModels[index].cc_date != null ? areaModels[index].cc_date == "0000-00-00" ? '' : DateFormat('dd-MM-yyyy').format(DateTime.parse('${areaModels[index].cc_date} 00:00:00.000')) : ''}'
                                              : 'เช่าอยู่ ${areaModels[index].cc_date != null ? areaModels[index].cc_date == "0000-00-00" ? '' : DateFormat('dd-MM-yyyy').format(DateTime.parse('${areaModels[index].cc_date} 00:00:00.000')) : ''}'
                                  : areaModels[index].quantity == '2'
                                      ? 'เสนอราคา'
                                      : areaModels[index].quantity == '3'
                                          ? 'เสนอราคา(มัดจำ)'
                                          : 'ว่าง',
                              minFontSize: 8,
                              maxFontSize: 12,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                // fontSize: 20,
                                fontFamily: Font_.Fonts_T,
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        )),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      areaModels[index].cc_date != null
                          ? areaModels[index].cc_date == "0000-00-00"
                              ? SizedBox()
                              : Icon(
                                  Icons.closed_caption,
                                )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            ],
          );

    // PopupMenuButton(
    //   onOpened: () {
    //     setState(() {
    //       read_GC_con_area(index);
    //     });
    //   },
    //   itemBuilder: (BuildContext context) => [
    //     if (areaModels[index].quantity != '1')
    //       PopupMenuItem(
    //         child: InkWell(
    //             onTap: () async {
    //               SharedPreferences preferences =
    //                   await SharedPreferences.getInstance();
    //               preferences.setString(
    //                   'zoneSer', areaModels[index].zser.toString());
    //               preferences.setString(
    //                   'zonesName', areaModels[index].zn.toString());
    //               setState(() {
    //                 Ser_Body = 1;
    //                 a_ln = areaModels[index].lncode;
    //                 a_ser = areaModels[index].ser;
    //                 a_area = areaModels[index].area;
    //                 a_rent = areaModels[index].rent;
    //                 a_page = '1';
    //               });

    //               Navigator.pop(context);
    //             },
    //             child: Container(
    //                 padding: const EdgeInsets.all(10),
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Row(
    //                   children: [
    //                     Expanded(
    //                         child:
    // Text(
    //                       'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
    //                       overflow: TextOverflow.ellipsis,
    //                       style: const TextStyle(
    //                           color: PeopleChaoScreen_Color.Colors_Text2_,
    //                           //fontWeight: FontWeight.bold,
    //                           fontFamily: Font_.Fonts_T),
    //                     )
    // )
    //                   ],
    //                 ))),
    //       ),
    //     if (areaModels[index].quantity != '1')
    //       PopupMenuItem(
    //         child: InkWell(
    //             onTap: () async {
    //               SharedPreferences preferences =
    //                   await SharedPreferences.getInstance();
    //               preferences.setString(
    //                   'zoneSer', areaModels[index].zser.toString());
    //               preferences.setString(
    //                   'zonesName', areaModels[index].zn.toString());

    //               setState(() {
    //                 Ser_Body = 2;
    //                 a_ln = areaModels[index].lncode;
    //                 a_ser = areaModels[index].ser;
    //                 a_area = areaModels[index].area;
    //                 a_rent = areaModels[index].rent;
    //                 a_page = '1';
    //               });
    //               Navigator.pop(context);
    //             },
    //             child: Container(
    //                 padding: const EdgeInsets.all(10),
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Row(
    //                   children: [
    //                     Expanded(
    //                         child: Text(
    //                       'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
    //                       overflow: TextOverflow.ellipsis,
    //                       style: const TextStyle(
    //                           color: PeopleChaoScreen_Color.Colors_Text2_,
    //                           //fontWeight: FontWeight.bold,
    //                           fontFamily: Font_.Fonts_T),
    //                     ))
    //                   ],
    //                 ))),
    //       ),
    //     if (areaModels[index].quantity == '1')
    //       for (int i = 0; i < areaxConModels.length; i++)
    //         PopupMenuItem(
    //           child: InkWell(
    //               onTap: () async {
    //                 setState(() {
    //                   Ser_Body = 3;
    //                   Value_stasus = '0';
    //                   Value_cid = areaxConModels[i].cser;
    //                   ser_cidtan = '1';
    //                 });
    //                 Navigator.pop(context);
    //               },
    //               child: Container(
    //                   padding: const EdgeInsets.all(10),
    //                   width: MediaQuery.of(context).size.width,
    //                   child: Row(
    //                     children: [
    //                       Expanded(
    //                           child: Text(
    //                         '${areaxConModels[i].cser} (${areaxConModels[i].cname})',
    //                         overflow: TextOverflow.ellipsis,
    //                         style: const TextStyle(
    //                             color: PeopleChaoScreen_Color.Colors_Text2_,
    //                             //fontWeight: FontWeight.bold,
    //                             fontFamily: Font_.Fonts_T),
    //                       ))
    //                     ],
    //                   ))),
    //         ),
    //     if (areaModels[index].quantity == '1')
    //       PopupMenuItem(
    //         child: InkWell(
    //             onTap: () async {
    //               setState(() {
    //                 Ser_Body = 3;
    //                 Value_stasus = areaModels[index].quantity == '1'
    //                     ? datex.isAfter(DateTime.parse(
    //                                     '${areaModels[index].ldate} 00:00:00.000')
    //                                 .subtract(const Duration(days: 0))) ==
    //                             true
    //                         ? 'หมดสัญญา'
    //                         : datex.isAfter(DateTime.parse(
    //                                         '${areaModels[index].ldate} 00:00:00.000')
    //                                     .subtract(const Duration(days: open_set_date))) ==
    //                                 true
    //                             ? 'ใกล้หมดสัญญา'
    //                             : 'เช่าอยู่'
    //                     : areaModels[index].quantity == '2'
    //                         ? 'เสนอราคา'
    //                         : areaModels[index].quantity == '3'
    //                             ? 'เสนอราคา(มัดจำ)'
    //                             : 'ว่าง';
    //                 Value_cid = areaModels[index].cid;
    //                 ser_cidtan = '1';
    //               });
    //               Navigator.pop(context);
    //             },
    //             child: Container(
    //                 padding: const EdgeInsets.all(10),
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Row(
    //                   children: [
    //                     Expanded(
    //                         child: Text(
    //                       'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
    //                       overflow: TextOverflow.ellipsis,
    //                       style: const TextStyle(
    //                           color: PeopleChaoScreen_Color.Colors_Text2_,
    //                           //fontWeight: FontWeight.bold,
    //                           fontFamily: Font_.Fonts_T),
    //                     ))
    //                   ],
    //                 ))),
    //       ),
    //     if (areaModels[index].quantity == '1')
    //       PopupMenuItem(
    //         child: InkWell(
    //             onTap: () async {
    //               setState(() {
    //                 Value_stasus = areaModels[index].quantity == '1'
    //                     ? datex.isAfter(DateTime.parse(
    //                                     '${areaModels[index].ldate} 00:00:00.000')
    //                                 .subtract(const Duration(days: 0))) ==
    //                             true
    //                         ? 'หมดสัญญา'
    //                         : datex.isAfter(DateTime.parse(
    //                                         '${areaModels[index].ldate} 00:00:00.000')
    //                                     .subtract(const Duration(days: open_set_date))) ==
    //                                 true
    //                             ? 'ใกล้หมดสัญญา'
    //                             : 'เช่าอยู่'
    //                     : areaModels[index].quantity == '2'
    //                         ? 'เสนอราคา'
    //                         : areaModels[index].quantity == '3'
    //                             ? 'เสนอราคา(มัดจำ)'
    //                             : 'ว่าง';
    //                 Ser_Body = 4;
    //                 Value_cid = areaModels[index].cid;
    //                 ser_cidtan = '1';
    //               });
    //               Navigator.pop(context);
    //             },
    //             child: Container(
    //                 padding: const EdgeInsets.all(10),
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Row(
    //                   children: [
    //                     Expanded(
    //                         child: Text(
    //                       'รับชำระ: ${areaModels[index].cid} (${areaModels[index].cname})',
    //                       overflow: TextOverflow.ellipsis,
    //                       style: const TextStyle(
    //                           color: PeopleChaoScreen_Color.Colors_Text2_,
    //                           //fontWeight: FontWeight.bold,
    //                           fontFamily: Font_.Fonts_T),
    //                     ))
    //                   ],
    //                 ))),
    //       ),
    //     if (areaModels[index].quantity == '2')
    //       for (int i = 0; i < areaQuotModels.length; i++)
    //         if (areaModels[index].ser == areaQuotModels[i].ser)
    //           PopupMenuItem(
    //             child: InkWell(
    //                 onTap: () async {
    //                   setState(() {
    //                     Ser_Body = 3;
    //                     Value_stasus = '1';
    //                     Value_cid = areaQuotModels[i].docno;
    //                     ser_cidtan = '2';
    //                   });
    //                   Navigator.pop(context);
    //                 },
    //                 child: Container(
    //                     padding: const EdgeInsets.all(10),
    //                     width: MediaQuery.of(context).size.width,
    //                     child: Row(
    //                       children: [
    //                         Expanded(
    //                             child: Text(
    //                           'เสนอราคา: ${areaQuotModels[i].docno}',
    //                           overflow: TextOverflow.ellipsis,
    //                           style: const TextStyle(
    //                               color: PeopleChaoScreen_Color.Colors_Text2_,
    //                               //fontWeight: FontWeight.bold,
    //                               fontFamily: Font_.Fonts_T),
    //                         ))
    //                       ],
    //                     ))),
    //           ),
    //     if (areaModels[index].quantity == '3')
    //       for (int i = 0; i < areaQuotModels.length; i++)
    //         if (areaModels[index].ser == areaQuotModels[i].ser)
    //           PopupMenuItem(
    //             child: InkWell(
    //                 onTap: () async {
    //                   setState(() {
    //                     Ser_Body = 3;
    //                     Value_stasus = '1';
    //                     Value_cid = areaQuotModels[i].docno;
    //                     ser_cidtan = '2';
    //                   });
    //                   Navigator.pop(context);
    //                 },
    //                 child: Container(
    //                     padding: const EdgeInsets.all(10),
    //                     width: MediaQuery.of(context).size.width,
    //                     child: Row(
    //                       children: [
    //                         Expanded(
    //                             child: Text(
    //                           'เสนอราคา: (มัดจำ) ${areaQuotModels[i].docno}',
    //                           overflow: TextOverflow.ellipsis,
    //                           style: const TextStyle(
    //                               color: PeopleChaoScreen_Color.Colors_Text2_,
    //                               //fontWeight: FontWeight.bold,
    //                               fontFamily: Font_.Fonts_T),
    //                         ))
    //                       ],
    //                     ))),
    //           ),
    //   ],
    //   child: Card(
    //       child: InkWell(
    //     // onTap: () async {},
    //     child: Container(
    //         color: areaModels[index].quantity == '1'
    //             ? Colors.red.shade200
    //             : areaModels[index].quantity == '2'
    //                 ? Colors.blue.shade200
    //                 : areaModels[index].quantity == '3'
    //                     ? Colors.purple.shade200
    //                     : Colors.green.shade200,
    //         width: MediaQuery.of(context).size.width * 0.1,
    //         height: 50,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Center(
    //                 child: AutoSizeText(
    //               '${areaModels[index].lncode} (${areaModels[index].ln})',
    //               minFontSize: 10,
    //               maxFontSize: 18,
    //               textAlign: TextAlign.center,
    //               style: const TextStyle(
    //                 // fontSize: 20,
    //                 fontFamily: Font_.Fonts_T,
    //                 color: PeopleChaoScreen_Color.Colors_Text2_,
    //               ),
    //               maxLines: 4,
    //               overflow: TextOverflow.ellipsis,
    //             )),
    //             AutoSizeText(
    //               areaModels[index].quantity == '1'
    //                   ? datex.isAfter(DateTime.parse(
    //                                   '${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000')
    //                               .subtract(const Duration(days: 0))) ==
    //                           true
    //                       ? 'หมดสัญญา'
    //                       : datex.isAfter(DateTime.parse(
    //                                       '${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000')
    //                                   .subtract(const Duration(days: open_set_date))) ==
    //                               true
    //                           ? 'ใกล้หมดสัญญา'
    //                           : 'เช่าอยู่'
    //                   : areaModels[index].quantity == '2'
    //                       ? 'เสนอราคา'
    //                       : areaModels[index].quantity == '3'
    //                           ? 'เสนอราคา(มัดจำ)'
    //                           : 'ว่าง',
    //               minFontSize: 8,
    //               maxFontSize: 12,
    //               textAlign: TextAlign.center,
    //               style: const TextStyle(
    //                 // fontSize: 20,
    //                 fontFamily: Font_.Fonts_T,
    //                 color: PeopleChaoScreen_Color.Colors_Text2_,
    //               ),
    //               maxLines: 1,
    //               overflow: TextOverflow.ellipsis,
    //             )
    //           ],
    //         )),
    //   )),
    // );
  }

  Widget createCardNull(value) {
    return Card(
        child: InkWell(
      onTap: () async {},
      child: Container(
          color: Colors.grey.shade200,
          width: MediaQuery.of(context).size.width * 0.1,
          height: 100,
          child: Center(
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: PeopleChaoScreen_Color.Colors_Text2_,
                  // fontWeight: FontWeight.bold,
                  fontFamily: Font_.Fonts_T
                  //fontSize: 10.0
                  ),
            ),
          )),
    ));
  }

  // Widget BodyHome_mobile() {
  //   return (Visit_ == 'list')
  //       ? Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             width: MediaQuery.of(context).size.width,
  //             decoration: const BoxDecoration(
  //               color: AppbackgroundColor.Sub_Abg_Colors,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(10),
  //                   topRight: Radius.circular(10),
  //                   bottomLeft: Radius.circular(10),
  //                   bottomRight: Radius.circular(10)),
  //               // border: Border.all(color: Colors.grey, width: 1),
  //             ),
  //             child: Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
  //                   child: ScrollConfiguration(
  //                     behavior: ScrollConfiguration.of(context)
  //                         .copyWith(dragDevices: {
  //                       PointerDeviceKind.touch,
  //                       PointerDeviceKind.mouse,
  //                     }),
  //                     child: SingleChildScrollView(
  //                       scrollDirection: Axis.horizontal,
  //                       dragStartBehavior: DragStartBehavior.start,
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                               width: 1000,
  //                               child: Column(
  //                                 children: [
  //                                   Container(
  //                                       width: 1000,
  //                                       decoration: const BoxDecoration(
  //                                         color:
  //                                             AppbackgroundColor.TiTile_Colors,
  //                                         borderRadius: BorderRadius.only(
  //                                             topLeft: Radius.circular(10),
  //                                             topRight: Radius.circular(10),
  //                                             bottomLeft: Radius.circular(0),
  //                                             bottomRight: Radius.circular(0)),
  //                                       ),
  //                                       padding: const EdgeInsets.all(8.0),
  //                                       child: Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.center,
  //                                         children: const [
  //                                           // Expanded(
  //                                           //   flex: 1,
  //                                           //   child: Padding(
  //                                           //     padding: EdgeInsets.all(8.0),
  //                                           //     child: Text(
  //                                           //       '',
  //                                           //       style: TextStyle(
  //                                           //         color: Colors.black,
  //                                           //         fontWeight: FontWeight.bold,
  //                                           //         //fontSize: 10.0
  //                                           //       ),
  //                                           //     ),
  //                                           //   ),
  //                                           // ),
  //                                           Expanded(
  //                                             flex: 1,
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(8.0),
  //                                               child: Text(
  //                                                 'โซนพื้นที่',
  //                                                 textAlign: TextAlign.center,
  //                                                 style: TextStyle(
  //                                                     color:
  //                                                         PeopleChaoScreen_Color
  //                                                             .Colors_Text1_,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontFamily:
  //                                                         FontWeight_.Fonts_T
  //                                                     //fontSize: 10.0
  //                                                     ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             flex: 1,
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(8.0),
  //                                               child: Text(
  //                                                 'รหัสพื้นที่',
  //                                                 textAlign: TextAlign.center,
  //                                                 style: TextStyle(
  //                                                     color:
  //                                                         PeopleChaoScreen_Color
  //                                                             .Colors_Text1_,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontFamily:
  //                                                         FontWeight_.Fonts_T
  //                                                     //fontSize: 10.0
  //                                                     ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             flex: 1,
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(8.0),
  //                                               child: Text(
  //                                                 'ขนาดพื้นที่(ต.ร.ม.)',
  //                                                 textAlign: TextAlign.end,
  //                                                 style: TextStyle(
  //                                                     color:
  //                                                         PeopleChaoScreen_Color
  //                                                             .Colors_Text1_,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontFamily:
  //                                                         FontWeight_.Fonts_T
  //                                                     //fontSize: 10.0
  //                                                     ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             flex: 1,
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(8.0),
  //                                               child: Text(
  //                                                 'ค่าเช่าต่องวด',
  //                                                 textAlign: TextAlign.end,
  //                                                 style: TextStyle(
  //                                                     color:
  //                                                         PeopleChaoScreen_Color
  //                                                             .Colors_Text1_,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontFamily:
  //                                                         FontWeight_.Fonts_T
  //                                                     //fontSize: 10.0
  //                                                     ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             flex: 1,
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(8.0),
  //                                               child: Text(
  //                                                 'เลขที่ใบสัญญา',
  //                                                 textAlign: TextAlign.end,
  //                                                 style: TextStyle(
  //                                                     color:
  //                                                         PeopleChaoScreen_Color
  //                                                             .Colors_Text1_,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontFamily:
  //                                                         FontWeight_.Fonts_T
  //                                                     //fontSize: 10.0
  //                                                     ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             flex: 1,
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(8.0),
  //                                               child: Text(
  //                                                 'เลขที่ใบเสนอราคา',
  //                                                 textAlign: TextAlign.end,
  //                                                 style: TextStyle(
  //                                                     color:
  //                                                         PeopleChaoScreen_Color
  //                                                             .Colors_Text1_,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontFamily:
  //                                                         FontWeight_.Fonts_T
  //                                                     //fontSize: 10.0
  //                                                     ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             flex: 1,
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(8.0),
  //                                               child: Text(
  //                                                 'วันสิ้นสุดสัญญา',
  //                                                 textAlign: TextAlign.end,
  //                                                 style: TextStyle(
  //                                                     color:
  //                                                         PeopleChaoScreen_Color
  //                                                             .Colors_Text1_,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontFamily:
  //                                                         FontWeight_.Fonts_T
  //                                                     //fontSize: 10.0
  //                                                     ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             flex: 1,
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(8.0),
  //                                               child: Text(
  //                                                 'สถานะ',
  //                                                 textAlign: TextAlign.end,
  //                                                 style: TextStyle(
  //                                                     color:
  //                                                         PeopleChaoScreen_Color
  //                                                             .Colors_Text1_,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontFamily:
  //                                                         FontWeight_.Fonts_T
  //                                                     //fontSize: 10.0
  //                                                     ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       )),
  //                                   Container(
  //                                       height:
  //                                           MediaQuery.of(context).size.height /
  //                                               1.7,
  //                                       width: 1000,
  //                                       decoration: const BoxDecoration(
  //                                         color:
  //                                             AppbackgroundColor.Sub_Abg_Colors,
  //                                         borderRadius: BorderRadius.only(
  //                                             topLeft: Radius.circular(0),
  //                                             topRight: Radius.circular(0),
  //                                             bottomLeft: Radius.circular(0),
  //                                             bottomRight: Radius.circular(0)),
  //                                         // border: Border.all(color: Colors.grey, width: 1),
  //                                       ),
  //                                       child: ListView.builder(
  //                                           controller: _scrollController1,
  //                                           // itemExtent: 50,
  //                                           physics:
  //                                               const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
  //                                           shrinkWrap: true,
  //                                           itemCount: areaModels.length,
  //                                           itemBuilder: (BuildContext context,
  //                                               int index) {
  //                                             int daysBetween(
  //                                                 DateTime from, DateTime to) {
  //                                               from = DateTime(from.year,
  //                                                   from.month, from.day);
  //                                               to = DateTime(
  //                                                   to.year, to.month, to.day);
  //                                               return (to
  //                                                           .difference(from)
  //                                                           .inHours /
  //                                                       24)
  //                                                   .round();
  //                                             }

  //                                             var daterz =
  //                                                 areaModels[index].ldate ==
  //                                                         null
  //                                                     ? '0000-00-00'
  //                                                     : areaModels[index].ldate;

  //                                             var birthday = DateTime.parse(
  //                                                     '$daterz 00:00:00.000')
  //                                                 .add(const Duration(
  //                                                     days: -30));
  //                                             var date2 = DateTime.now();
  //                                             var difference =
  //                                                 daysBetween(birthday, date2);

  //                                             return Container(
  //                                               color: tappedIndex_ ==
  //                                                       index.toString()
  //                                                   ? tappedIndex_Color
  //                                                       .tappedIndex_Colors
  //                                                   : null,
  //                                               child: ListTile(
  //                                                   onTap: () {
  //                                                     setState(() {
  //                                                       tappedIndex_ =
  //                                                           index.toString();
  //                                                     });
  //                                                   },
  //                                                   title: Row(
  //                                                     mainAxisAlignment:
  //                                                         MainAxisAlignment
  //                                                             .center,
  //                                                     children: [
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Padding(
  //                                                           padding:
  //                                                               const EdgeInsets
  //                                                                   .all(8.0),
  //                                                           child: Text(
  //                                                             'โซน ${areaModels[index].zser} (${areaModels[index].zn})',
  //                                                             textAlign:
  //                                                                 TextAlign
  //                                                                     .center,
  //                                                             style: const TextStyle(
  //                                                                 color: PeopleChaoScreen_Color
  //                                                                     .Colors_Text2_,
  //                                                                 fontFamily:
  //                                                                     Font_
  //                                                                         .Fonts_T
  //                                                                 //fontSize: 10.0
  //                                                                 ),
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Padding(
  //                                                           padding:
  //                                                               const EdgeInsets
  //                                                                   .all(8.0),
  //                                                           child: Text(
  //                                                             areaModels[index]
  //                                                                         .ln_c ==
  //                                                                     null
  //                                                                 ? areaModels[index]
  //                                                                             .ln_q ==
  //                                                                         null
  //                                                                     ? '${areaModels[index].lncode}'
  //                                                                     : '${areaModels[index].ln_q}'
  //                                                                 : '${areaModels[index].ln_c}',
  //                                                             textAlign:
  //                                                                 TextAlign
  //                                                                     .center,
  //                                                             style: const TextStyle(
  //                                                                 color: PeopleChaoScreen_Color
  //                                                                     .Colors_Text2_,
  //                                                                 fontFamily:
  //                                                                     Font_
  //                                                                         .Fonts_T
  //                                                                 //fontSize: 10.0
  //                                                                 ),
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Text(
  //                                                           areaModels[index]
  //                                                                       .area_c ==
  //                                                                   null
  //                                                               ? areaModels[index]
  //                                                                           .ln_q ==
  //                                                                       null
  //                                                                   ? nFormat.format(double.parse(
  //                                                                       areaModels[index]
  //                                                                           .area!))
  //                                                                   : nFormat.format(
  //                                                                       double.parse(areaModels[index]
  //                                                                           .area_q!))
  //                                                               : nFormat.format(
  //                                                                   double.parse(
  //                                                                       areaModels[index]
  //                                                                           .area_c!)),
  //                                                           textAlign:
  //                                                               TextAlign.end,
  //                                                           style: const TextStyle(
  //                                                               color: PeopleChaoScreen_Color
  //                                                                   .Colors_Text2_,
  //                                                               fontFamily:
  //                                                                   Font_
  //                                                                       .Fonts_T
  //                                                               //fontSize: 10.0
  //                                                               ),
  //                                                         ),
  //                                                       ),
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Text(
  //                                                           areaModels[index]
  //                                                                       .total ==
  //                                                                   null
  //                                                               ? areaModels[index]
  //                                                                           .total_q ==
  //                                                                       null
  //                                                                   ? nFormat.format(double.parse(
  //                                                                       areaModels[index]
  //                                                                           .rent!))
  //                                                                   : nFormat.format(
  //                                                                       double.parse(areaModels[index]
  //                                                                           .total_q!))
  //                                                               : nFormat.format(
  //                                                                   double.parse(
  //                                                                       areaModels[index]
  //                                                                           .total!)),
  //                                                           textAlign:
  //                                                               TextAlign.end,
  //                                                           style: const TextStyle(
  //                                                               color: PeopleChaoScreen_Color
  //                                                                   .Colors_Text2_,
  //                                                               fontFamily:
  //                                                                   Font_
  //                                                                       .Fonts_T
  //                                                               //fontSize: 10.0
  //                                                               ),
  //                                                         ),
  //                                                       ),
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Padding(
  //                                                             padding:
  //                                                                 const EdgeInsets
  //                                                                     .all(8.0),
  //                                                             child: Text(
  //                                                               areaModels[index]
  //                                                                           .cid ==
  //                                                                       null
  //                                                                   ? ''
  //                                                                   : '${areaModels[index].cid}',
  //                                                               maxLines: 2,
  //                                                               textAlign:
  //                                                                   TextAlign
  //                                                                       .end,
  //                                                               overflow:
  //                                                                   TextOverflow
  //                                                                       .ellipsis,
  //                                                               style: const TextStyle(
  //                                                                   color: PeopleChaoScreen_Color
  //                                                                       .Colors_Text2_,
  //                                                                   fontFamily:
  //                                                                       Font_
  //                                                                           .Fonts_T),
  //                                                             )),
  //                                                       ),
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Padding(
  //                                                             padding:
  //                                                                 const EdgeInsets
  //                                                                     .all(8.0),
  //                                                             child: Text(
  //                                                               areaModels[index]
  //                                                                           .docno ==
  //                                                                       null
  //                                                                   ? ''
  //                                                                   : '${areaModels[index].docno}',
  //                                                               maxLines: 2,
  //                                                               textAlign:
  //                                                                   TextAlign
  //                                                                       .end,
  //                                                               overflow:
  //                                                                   TextOverflow
  //                                                                       .ellipsis,
  //                                                               style: TextStyle(
  //                                                                   color: areaModels[index].docno !=
  //                                                                           null
  //                                                                       ? Colors
  //                                                                           .blue
  //                                                                       : PeopleChaoScreen_Color
  //                                                                           .Colors_Text2_,
  //                                                                   fontFamily:
  //                                                                       Font_
  //                                                                           .Fonts_T),
  //                                                             )),
  //                                                       ),
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Padding(
  //                                                           padding:
  //                                                               const EdgeInsets
  //                                                                   .all(8.0),
  //                                                           child: Text(
  //                                                             areaModels[index]
  //                                                                         .ldate ==
  //                                                                     null
  //                                                                 ? areaModels[index]
  //                                                                             .ldate_q ==
  //                                                                         null
  //                                                                     ? ''
  //                                                                     : DateFormat(
  //                                                                             'dd-MM-yyyy')
  //                                                                         .format(DateTime.parse(
  //                                                                             '${areaModels[index].ldate_q} 00:00:00'))
  //                                                                         .toString()
  //                                                                 : DateFormat(
  //                                                                         'dd-MM-yyyy')
  //                                                                     .format(DateTime
  //                                                                         .parse(
  //                                                                             '${areaModels[index].ldate} 00:00:00'))
  //                                                                     .toString(),
  //                                                             maxLines: 1,
  //                                                             textAlign:
  //                                                                 TextAlign.end,
  //                                                             overflow:
  //                                                                 TextOverflow
  //                                                                     .ellipsis,
  //                                                             style: TextStyle(
  //                                                                 color: areaModels[index]
  //                                                                             .quantity ==
  //                                                                         '1'
  //                                                                     ? datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
  //                                                                             true
  //                                                                         ? Colors
  //                                                                             .red
  //                                                                         : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: open_set_date))) ==
  //                                                                                 true
  //                                                                             ? Colors
  //                                                                                 .orange.shade900
  //                                                                             : PeopleChaoScreen_Color
  //                                                                                 .Colors_Text2_
  //                                                                     : areaModels[index].quantity ==
  //                                                                             '2'
  //                                                                         ? Colors
  //                                                                             .blue
  //                                                                         : areaModels[index].quantity ==
  //                                                                                 '3'
  //                                                                             ? Colors
  //                                                                                 .blue
  //                                                                             : Colors
  //                                                                                 .green,
  //                                                                 fontFamily: Font_
  //                                                                     .Fonts_T),
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Text(
  //                                                           areaModels[index]
  //                                                                       .quantity ==
  //                                                                   '1'
  //                                                               ? datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(
  //                                                                           days:
  //                                                                               0))) ==
  //                                                                       true
  //                                                                   ? 'หมดสัญญา'
  //                                                                   : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: open_set_date))) ==
  //                                                                           true
  //                                                                       ? 'ใกล้หมดสัญญา'
  //                                                                       : 'เช่าอยู่'
  //                                                               : areaModels[index]
  //                                                                           .quantity ==
  //                                                                       '2'
  //                                                                   ? 'เสนอราคา'
  //                                                                   : areaModels[index].quantity ==
  //                                                                           '3'
  //                                                                       ? 'เสนอราคา(มัดจำ)'
  //                                                                       : 'ว่าง',
  //                                                           textAlign:
  //                                                               TextAlign.end,
  //                                                           style: TextStyle(
  //                                                               color: areaModels[index]
  //                                                                           .quantity ==
  //                                                                       '1'
  //                                                                   ? datex.isAfter(DateTime.parse('${areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
  //                                                                           true
  //                                                                       ? Colors
  //                                                                           .red
  //                                                                       : datex.isAfter(DateTime.parse('${areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: open_set_date))) ==
  //                                                                               true
  //                                                                           ? Colors
  //                                                                               .orange.shade900
  //                                                                           : PeopleChaoScreen_Color
  //                                                                               .Colors_Text2_
  //                                                                   : areaModels[index].quantity ==
  //                                                                           '2'
  //                                                                       ? Colors
  //                                                                           .blue
  //                                                                       : areaModels[index].quantity ==
  //                                                                               '3'
  //                                                                           ? Colors
  //                                                                               .blue
  //                                                                           : Colors
  //                                                                               .green,
  //                                                               fontFamily:
  //                                                                   Font_
  //                                                                       .Fonts_T

  //                                                               //fontSize: 10.0
  //                                                               ),
  //                                                         ),
  //                                                       ),
  //                                                     ],
  //                                                   )),
  //                                             );
  //                                           })),
  //                                 ],
  //                               )),
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
  //                                             color: Colors.grey,
  //                                             fontSize: 10.0),
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
  //                                           color: Colors.grey, fontSize: 10.0),
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
  //                                         color: Colors.grey, fontSize: 10.0),
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
  //                 const SizedBox(
  //                   height: 20,
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       : Column(
  //           children: [
  //             Container(
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(10),
  //                     topRight: Radius.circular(10),
  //                     bottomLeft: Radius.circular(10),
  //                     bottomRight: Radius.circular(10)),
  //                 // border: Border.all(color: Colors.grey, width: 1),
  //               ),
  //               padding: const EdgeInsets.all(20),
  //               // color: Colors.white,
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           flex: 1,
  //                           child: Container(
  //                             child: Text(
  //                               zone_ser == null
  //                                   ? 'โซน ทั้งหมด'
  //                                   : zone_ser == '0'
  //                                       ? 'โซน ($zone_name)'
  //                                       : 'โซน $zone_ser ($zone_name)',
  //                               style: const TextStyle(
  //                                   color: PeopleChaoScreen_Color.Colors_Text1_,
  //                                   fontWeight: FontWeight.bold,
  //                                   fontFamily: FontWeight_.Fonts_T
  //                                   //fontSize: 10.0
  //                                   ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     height: 500,
  //                     child: ScrollConfiguration(
  //                       behavior: ScrollConfiguration.of(context)
  //                           .copyWith(dragDevices: {
  //                         PointerDeviceKind.touch,
  //                         PointerDeviceKind.mouse,
  //                       }),
  //                       child: ResponsiveGridList(
  //                         horizontalGridSpacing:
  //                             16, // Horizontal space between grid items

  //                         horizontalGridMargin:
  //                             50, // Horizontal space around the grid
  //                         verticalGridMargin:
  //                             50, // Vertical space around the grid
  //                         minItemWidth:
  //                             300, // The minimum item width (can be smaller, if the layout constraints are smaller)
  //                         minItemsPerRow:
  //                             2, // The minimum items to show in a single row. Takes precedence over minItemWidth
  //                         maxItemsPerRow:
  //                             12, // The maximum items to show in a single row. Can be useful on large screens
  //                         listViewBuilderOptions:
  //                             ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
  //                         children: List.generate(
  //                           areaModels.length,
  //                           (index) => Padding(
  //                             padding: const EdgeInsets.all(2.0),
  //                             child: Container(
  //                               width: MediaQuery.of(context).size.width * 0.07,
  //                               height: 50,
  //                               decoration: BoxDecoration(
  //                                 color: areaModels[index].quantity == '1'
  //                                     ? Colors.red.shade200
  //                                     : areaModels[index].quantity == '2'
  //                                         ? Colors.blue.shade200
  //                                         : areaModels[index].quantity == '3'
  //                                             ? Colors.blue.shade200
  //                                             : Colors.green.shade200,
  //                                 borderRadius: const BorderRadius.only(
  //                                     topLeft: Radius.circular(10),
  //                                     topRight: Radius.circular(10),
  //                                     bottomLeft: Radius.circular(10),
  //                                     bottomRight: Radius.circular(10)),
  //                                 // border: Border.all(color: Colors.grey, width: 1),
  //                               ),
  //                               // padding: const EdgeInsets.all(8.0),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   Text(
  //                                     '${areaModels[index].lncode} (${areaModels[index].zn})',
  //                                     textAlign: TextAlign.center,
  //                                     style: const TextStyle(
  //                                         color: PeopleChaoScreen_Color
  //                                             .Colors_Text2_,
  //                                         // fontWeight: FontWeight.bold,
  //                                         fontFamily: Font_.Fonts_T
  //                                         //fontSize: 10.0
  //                                         ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             )
  //           ],
  //         );
  // }

  Widget Body_Renew(context) {
    return ChaoAreaRenewScreen(
      Get_Value_area_index: a_ser,
      Get_Value_area_ln: a_ln,
      Get_Value_area_sum: a_area,
      Get_Value_rent_sum: a_rent,
      Get_Value_page: a_page,
    );
  }

  Widget Body_bid(context) {
    return ChaoAreaBidScreen(
      Get_Value_area_index: a_ser,
      Get_Value_area_ln: a_ln,
      Get_Value_area_sum: a_area,
      Get_Value_rent_sum: a_rent,
      Get_Value_page: a_page,
    );
  }
}
