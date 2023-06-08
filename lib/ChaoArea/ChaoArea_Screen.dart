import 'dart:convert';
import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../Constant/Myconstant.dart';

import '../Model/GetArea_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetZone_Model.dart';

import '../PeopleChao/PeopleChao_Screen2.dart';
import '../Responsive/responsive.dart';

import '../Style/colors.dart';
import 'package:http/http.dart' as http;

import 'ChaoAreaBid_Screen.dart';
import 'ChaoAreaRenew_Screen.dart';

class ChaoAreaScreen extends StatefulWidget {
  const ChaoAreaScreen({super.key});

  @override
  State<ChaoAreaScreen> createState() => _ChaoAreaScreenState();
}

class _ChaoAreaScreenState extends State<ChaoAreaScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  int switcherIndex1 = 0;
  int Status_ = 1;
  int Ser_Body = 0;
  String Visit_ = 'grid'; //มุมมอง Visit_ = 'grid';
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  ///////---------------------------------------------------->

  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];
  List<AreaModel> _areaModels = <AreaModel>[];
  List<RenTalModel> renTalModels = [];

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
  ];
  List Year_ = [
    'ทั้งหมด',
    for (int i = 0; i < 10; i++) '${2565 - i}',
  ];

  String? renTal_user, renTal_name, zone_ser, zone_name, Value_cid;
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
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_zone();
    read_GC_area();
    read_GC_rental();
    _areaModels = areaModels;
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
      print(result);
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
          setState(() {
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
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
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

      print(
          'zoneModels >>. ${zoneModels.length} ${areaModels.map((e) => e.zser).toString()}');
    } catch (e) {}
  }

  Future<Null> read_GC_area() async {
    if (areaModels.length != 0) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('zone >>>>>> $zone');

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

      print(
          'zoneModels >>. ${zoneModels.length} ${areaModels.map((e) => e.zser).toString()}');
    } catch (e) {}
  }

  Future<Null> read_GC_areaSelect(int select) async {
    if (areaModels.length != 0) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $select');

    if (select == 1) {
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
        text = text.toLowerCase();
        setState(() {
          areaModels = _areaModels.where((areaModel) {
            var notTitle = areaModel.lncode.toString().toLowerCase();
            var notsname = areaModel.sname.toString().toLowerCase();
            var notcname = areaModel.cname.toString().toLowerCase();
            return notTitle.contains(text) ||
                notsname.contains(text) ||
                notcname.contains(text);
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
          if ((Ser_Body != 0))
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                            const Padding(
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
                  color: AppbackgroundColor.TiTile_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  // border: Border.all(color: Colors.white, width: 1),
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    MediaQuery.of(context).size.shortestSide <
                            MediaQuery.of(context).size.width * 1
                        ? Expanded(
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
                        : SizedBox(),
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
                              var zones = value!.indexOf(',');
                              var zoneSer = value.substring(0, zones);
                              var zonesName = value.substring(zones + 1);
                              print('mmmmm ${zoneSer.toString()} $zonesName');

                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setString(
                                  'zoneSer', zoneSer.toString());
                              preferences.setString(
                                  'zonesName', zonesName.toString());

                              setState(() {
                                read_GC_area();
                              });
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
                      child: Padding(
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
                          // height: 35,
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
                            color: TextHome_Color.TextHome_Colors,
                          )),
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    var zone = preferences.getString('zoneSer');
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
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: [
                                          const Expanded(
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
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    var zone = preferences.getString('zoneSer');
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
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: [
                                          const Expanded(
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
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    // border: Border.all(color: Colors.white, width: 1),
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
                                                  ? Colors.grey.shade400
                                                  : (i + 1 == 2)
                                                      ? Colors.orange.shade400
                                                      : (i + 1 == 3)
                                                          ? Colors.blue.shade400
                                                          : (i + 1 == 4)
                                                              ? Colors.green
                                                                  .shade300
                                                              : Colors
                                                                  .red.shade300,
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
                                                        ? Colors.grey.shade400
                                                        : (i + 1 == 2)
                                                            ? Colors
                                                                .orange.shade400
                                                            : (i + 1 == 3)
                                                                ? Colors.blue
                                                                    .shade400
                                                                : (i + 1 == 4)
                                                                    ? Colors
                                                                        .green
                                                                        .shade300
                                                                    : Colors.red
                                                                        .shade300,
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
                                          if (index + 1 == 1) {
                                            setState(() {
                                              Visit_ = 'list';
                                            });
                                          } else {
                                            setState(() {
                                              Visit_ = 'grid';
                                            });
                                          }
                                        });
                                      },
                                      containerHeight: 40,
                                      containerWight: 70,
                                      containerColor: Colors.grey,
                                      children: [
                                        const Icon(Icons.list),
                                        const Icon(Icons.grid_view_rounded)
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
              ? SizedBox(child: BodyHome_Web(context))
              : (Ser_Body == 1)
                  ? Body_bid(context)
                  : (Ser_Body == 2)
                      ? Body_Renew(context)
                      : (Ser_Body == 3)
                          ? PeopleChaoScreen2(
                              Get_Value_cid: Value_cid,
                              Get_Value_NameShop_index: ser_cidtan,
                              Get_Value_status: 1,
                              Get_Value_indexpage: '0',
                              updateMessage: updateMessage,
                            )
                          : PeopleChaoScreen2(
                              Get_Value_cid: Value_cid,
                              Get_Value_NameShop_index: ser_cidtan,
                              Get_Value_status: 1,
                              Get_Value_indexpage: '3',
                              updateMessage: updateMessage,
                            )
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
                            ? MediaQuery.of(context).size.width * 0.85
                            : MediaQuery.of(context).size.width * 0.3,
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
                                    CircularProgressIndicator(),
                                    StreamBuilder(
                                      stream: Stream.periodic(
                                          Duration(milliseconds: 25), (i) => i),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) return Text('');
                                        double elapsed = double.parse(
                                                snapshot.data.toString()) *
                                            0.05;
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: (elapsed > 8.00)
                                              ? Text(
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
                                                  style: TextStyle(
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
                                          title: Row(
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
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${areaModels[index].zn}',
                                                    textAlign: TextAlign.center,
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
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    areaModels[index].ln_c ==
                                                            null
                                                        ? areaModels[index]
                                                                    .ln_q ==
                                                                null
                                                            ? '${areaModels[index].lncode}'
                                                            : '${areaModels[index].ln_q}'
                                                        : '${areaModels[index].ln_c}',
                                                    textAlign: TextAlign.center,
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
                                                      ? areaModels[index].ln_q ==
                                                              null
                                                          ? nFormat.format(
                                                              double.parse(
                                                                  areaModels[index]
                                                                      .area!))
                                                          : nFormat.format(
                                                              double.parse(
                                                                  areaModels[
                                                                          index]
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
                                                      fontFamily: Font_.Fonts_T
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
                                                      fontFamily: Font_.Fonts_T
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
                                                      textAlign: TextAlign.end,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
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
                                                      areaModels[index].docno ==
                                                              null
                                                          ? ''
                                                          : '${areaModels[index].docno}',
                                                      maxLines: 1,
                                                      textAlign: TextAlign.end,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                      const EdgeInsets.all(8.0),
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
                                                        fontFamily: Font_.Fonts_T),
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
                                                      : areaModels[index].quantity ==
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
                                                                  : Colors.black
                                                          : areaModels[index]
                                                                      .quantity ==
                                                                  '2'
                                                              ? Colors.blue
                                                              : areaModels[index]
                                                                          .quantity ==
                                                                      '3'
                                                                  ? Colors.blue
                                                                  : Colors
                                                                      .green,
                                                      fontFamily: Font_.Fonts_T
                                                      //fontSize: 10.0
                                                      ),
                                                ),
                                              ),
                                            ],
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
        : Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                padding: const EdgeInsets.all(20),
                // color: Colors.white,
                child: zone_ser == '0' || zone_ser == '' || zone_ser == null
                    ? ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: zoneModels.length,
                        itemBuilder: (BuildContext context, int zindex) {
                          return zoneModels[zindex].ser == '0'
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(
                                                'โซน ${zoneModels[zindex].ser} (${zoneModels[zindex].zn})',
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
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
                                                height: MediaQuery.of(context)
                                                            .size
                                                            .shortestSide <
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1
                                                    ? 500
                                                    : 350,
                                                child: GridView.count(
                                                  crossAxisCount: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide <
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              1
                                                      ? 12
                                                      : 6,
                                                  children: [
                                                    for (int i = 0;
                                                        i < areaModels.length;
                                                        i++)
                                                      if (zoneModels[zindex]
                                                              .ser ==
                                                          areaModels[i].zser)
                                                        createCard(i),
                                                  ],
                                                ),
                                              )

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
                                  child: Container(
                                    child: Text(
                                      zone_ser == null
                                          ? 'โซน ทั้งหมด'
                                          : 'โซน $zone_ser ($zone_name)',
                                      style: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T

                                          //fontSize: 10.0
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                }),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 600,
                                      child: GridView.count(
                                        crossAxisCount: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1
                                            ? 12
                                            : 6,
                                        children: [
                                          for (int i = 0;
                                              i < areaModels.length;
                                              i++)
                                            createCard(i),
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
              )
            ],
          );
  }

  Widget createCard(int index) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        if (areaModels[index].quantity != '1')
          PopupMenuItem(
            child: InkWell(
                onTap: () async {
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

                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
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
                        ))
                      ],
                    ))),
          ),
        if (areaModels[index].quantity != '1')
          PopupMenuItem(
            child: InkWell(
                onTap: () async {
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
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
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
                        ))
                      ],
                    ))),
          ),
        if (areaModels[index].quantity == '1')
          PopupMenuItem(
            child: InkWell(
                onTap: () async {
                  setState(() {
                    Ser_Body = 3;
                    Value_cid = areaModels[index].cid;
                    ser_cidtan = '1';
                  });
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'เช่าอยู่: ${areaModels[index].cid}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              //fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T),
                        ))
                      ],
                    ))),
          ),
        if (areaModels[index].quantity == '1')
          PopupMenuItem(
            child: InkWell(
                onTap: () async {
                  setState(() {
                    Ser_Body = 4;
                    Value_cid = areaModels[index].cid;
                    ser_cidtan = '1';
                  });
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'รับชำระ: ${areaModels[index].cid}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              //fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T),
                        ))
                      ],
                    ))),
          ),
        if (areaModels[index].quantity == '2')
          PopupMenuItem(
            child: InkWell(
                onTap: () async {
                  setState(() {
                    Ser_Body = 3;
                    Value_cid = areaModels[index].docno;
                    ser_cidtan = '2';
                  });
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'เสนอราคา: ${areaModels[index].docno}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              //fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T),
                        ))
                      ],
                    ))),
          ),
      ],
      child: Card(
          child: InkWell(
        // onTap: () async {},
        child: Container(
            color: areaModels[index].quantity == '1'
                ? Colors.red.shade200
                : areaModels[index].quantity == '2'
                    ? Colors.blue.shade200
                    : areaModels[index].quantity == '3'
                        ? Colors.purple.shade200
                        : Colors.green.shade200,
            width: MediaQuery.of(context).size.width * 0.1,
            height: 50,
            child: Center(
                child: AutoSizeText(
              '${areaModels[index].lncode} (${areaModels[index].ln})',
              minFontSize: 10,
              maxFontSize: 18,
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontSize: 20,
                fontFamily: Font_.Fonts_T,
                color: PeopleChaoScreen_Color.Colors_Text2_,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ))),
      )),
    );
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

  Widget BodyHome_mobile() {
    return (Visit_ == 'list')
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                          children: [
                            Container(
                                width: 1000,
                                child: Column(
                                  children: [
                                    Container(
                                        width: 1000,
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
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'รหัสพื้นที่',
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
                                                      //fontSize: 10.0
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.7,
                                        width: 1000,
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
                                        child: ListView.builder(
                                            controller: _scrollController1,
                                            // itemExtent: 50,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: areaModels.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              int daysBetween(
                                                  DateTime from, DateTime to) {
                                                from = DateTime(from.year,
                                                    from.month, from.day);
                                                to = DateTime(
                                                    to.year, to.month, to.day);
                                                return (to
                                                            .difference(from)
                                                            .inHours /
                                                        24)
                                                    .round();
                                              }

                                              var daterz =
                                                  areaModels[index].ldate ==
                                                          null
                                                      ? '0000-00-00'
                                                      : areaModels[index].ldate;

                                              var birthday = DateTime.parse(
                                                      '$daterz 00:00:00.000')
                                                  .add(const Duration(
                                                      days: -30));
                                              var date2 = DateTime.now();
                                              var difference =
                                                  daysBetween(birthday, date2);

                                              return Container(
                                                color: tappedIndex_ ==
                                                        index.toString()
                                                    ? tappedIndex_Color
                                                        .tappedIndex_Colors
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
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'โซน ${areaModels[index].zser} (${areaModels[index].zn})',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
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
                                                              areaModels[index]
                                                                          .ln_c ==
                                                                      null
                                                                  ? areaModels[index]
                                                                              .ln_q ==
                                                                          null
                                                                      ? '${areaModels[index].lncode}'
                                                                      : '${areaModels[index].ln_q}'
                                                                  : '${areaModels[index].ln_c}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            areaModels[index]
                                                                        .area_c ==
                                                                    null
                                                                ? areaModels[index]
                                                                            .ln_q ==
                                                                        null
                                                                    ? nFormat.format(double.parse(
                                                                        areaModels[index]
                                                                            .area!))
                                                                    : nFormat.format(
                                                                        double.parse(areaModels[index]
                                                                            .area_q!))
                                                                : nFormat.format(
                                                                    double.parse(
                                                                        areaModels[index]
                                                                            .area_c!)),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: const TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                fontFamily:
                                                                    Font_
                                                                        .Fonts_T
                                                                //fontSize: 10.0
                                                                ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            areaModels[index]
                                                                        .total ==
                                                                    null
                                                                ? areaModels[index]
                                                                            .total_q ==
                                                                        null
                                                                    ? nFormat.format(double.parse(
                                                                        areaModels[index]
                                                                            .rent!))
                                                                    : nFormat.format(
                                                                        double.parse(areaModels[index]
                                                                            .total_q!))
                                                                : nFormat.format(
                                                                    double.parse(
                                                                        areaModels[index]
                                                                            .total!)),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: const TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
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
                                                              child: Text(
                                                                areaModels[index]
                                                                            .cid ==
                                                                        null
                                                                    ? ''
                                                                    : '${areaModels[index].cid}',
                                                                maxLines: 2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                              )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                areaModels[index]
                                                                            .docno ==
                                                                        null
                                                                    ? ''
                                                                    : '${areaModels[index].docno}',
                                                                maxLines: 2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: areaModels[index].docno !=
                                                                            null
                                                                        ? Colors
                                                                            .blue
                                                                        : PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                              )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              areaModels[index]
                                                                          .ldate ==
                                                                      null
                                                                  ? areaModels[index]
                                                                              .ldate_q ==
                                                                          null
                                                                      ? ''
                                                                      : DateFormat(
                                                                              'dd-MM-yyyy')
                                                                          .format(DateTime.parse(
                                                                              '${areaModels[index].ldate_q} 00:00:00'))
                                                                          .toString()
                                                                  : DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(DateTime
                                                                          .parse(
                                                                              '${areaModels[index].ldate} 00:00:00'))
                                                                      .toString(),
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: areaModels[index]
                                                                              .quantity ==
                                                                          '1'
                                                                      ? datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
                                                                              true
                                                                          ? Colors
                                                                              .red
                                                                          : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                                  true
                                                                              ? Colors
                                                                                  .orange.shade900
                                                                              : PeopleChaoScreen_Color
                                                                                  .Colors_Text2_
                                                                      : areaModels[index].quantity ==
                                                                              '2'
                                                                          ? Colors
                                                                              .blue
                                                                          : areaModels[index].quantity ==
                                                                                  '3'
                                                                              ? Colors
                                                                                  .blue
                                                                              : Colors
                                                                                  .green,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            areaModels[index]
                                                                        .quantity ==
                                                                    '1'
                                                                ? datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(
                                                                            days:
                                                                                0))) ==
                                                                        true
                                                                    ? 'หมดสัญญา'
                                                                    : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                            true
                                                                        ? 'ใกล้หมดสัญญา'
                                                                        : 'เช่าอยู่'
                                                                : areaModels[index]
                                                                            .quantity ==
                                                                        '2'
                                                                    ? 'เสนอราคา'
                                                                    : areaModels[index].quantity ==
                                                                            '3'
                                                                        ? 'เสนอราคา(มัดจำ)'
                                                                        : 'ว่าง',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                                color: areaModels[index]
                                                                            .quantity ==
                                                                        '1'
                                                                    ? datex.isAfter(DateTime.parse('${areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
                                                                            true
                                                                        ? Colors
                                                                            .red
                                                                        : datex.isAfter(DateTime.parse('${areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                                true
                                                                            ? Colors
                                                                                .orange.shade900
                                                                            : PeopleChaoScreen_Color
                                                                                .Colors_Text2_
                                                                    : areaModels[index].quantity ==
                                                                            '2'
                                                                        ? Colors
                                                                            .blue
                                                                        : areaModels[index].quantity ==
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
                                            })),
                                  ],
                                )),
                          ],
                        ),
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
                                              fontSize: 10.0),
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
                                            color: Colors.grey, fontSize: 10.0),
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
                                          color: Colors.grey, fontSize: 10.0),
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
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        : Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                padding: const EdgeInsets.all(20),
                // color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                zone_ser == null
                                    ? 'โซน ทั้งหมด'
                                    : zone_ser == '0'
                                        ? 'โซน ($zone_name)'
                                        : 'โซน $zone_ser ($zone_name)',
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: ResponsiveGridList(
                          horizontalGridSpacing:
                              16, // Horizontal space between grid items

                          horizontalGridMargin:
                              50, // Horizontal space around the grid
                          verticalGridMargin:
                              50, // Vertical space around the grid
                          minItemWidth:
                              300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                          minItemsPerRow:
                              2, // The minimum items to show in a single row. Takes precedence over minItemWidth
                          maxItemsPerRow:
                              12, // The maximum items to show in a single row. Can be useful on large screens
                          listViewBuilderOptions:
                              ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                          children: List.generate(
                            areaModels.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.07,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: areaModels[index].quantity == '1'
                                      ? Colors.red.shade200
                                      : areaModels[index].quantity == '2'
                                          ? Colors.blue.shade200
                                          : areaModels[index].quantity == '3'
                                              ? Colors.blue.shade200
                                              : Colors.green.shade200,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                // padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${areaModels[index].lncode} (${areaModels[index].zn})',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T
                                          //fontSize: 10.0
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }

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
