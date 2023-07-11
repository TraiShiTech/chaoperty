// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetExpType_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetUnit_Model.dart';
import '../Model/GetUnitx_Model.dart';
import '../Model/GetVat_Model.dart';
import '../Model/GetWht_Model.dart';
import '../Model/vat_SC_model.dart';
import '../Model/vat_s_model.dart';
import '../Model/wht_SC_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class Rental extends StatefulWidget {
  const Rental({super.key});

  @override
  State<Rental> createState() => _RentalState();
}

class _RentalState extends State<Rental> {
  //////////////-------------------------------->

  List<String> tappedIndex_ = List.generate(5, (index) => '');
  late List<ScrollController> _scrollControllers;
  List<ExpTypeModel> expTypeModels = [];
  List<ExpModel> expModels = [];
  List<VatModel> vatModels = [];
  List<VatSeModel> vatSeModels = [];
  List<WhtModel> whtModels = [];
  List<WhtSeModel> whtSeModels = [];
  List<VatSModel> selectVat = [];
  List<UnitModel> unitModels = [];
  List<UnitxModel> unitxModels = [];
  String tappedIndex_VAT = '';
  String tappedIndex_WHT = '';
  int Show_VAT_WHT = 0;
  //////////////-------------------------------->
  List<String> dates =
      ('01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,18,17,19,20,21,22,23,24,25,26,27,28,29,30,31'
          .split(','));
  List<String> dateselect = [];
  @override
  void initState() {
    super.initState();
    read_GC_ExpType();
    read_GC_Exp();
    read_GC_vat();
    read_GC_wht();
    read_selectVat_map();
    read_GC_unit();
    _scrollControllers = List.generate(5, (_) => ScrollController());

    for (int i = 0; i < dates.length; i++) {
      dateselect.add(dates[i]);
    }
  }

  Future<Null> read_GC_unit() async {
    if (unitModels.isNotEmpty) {
      unitModels.clear();
      unitxModels.clear();
    }

    String url = '${MyConstant().domain}/GC_unit.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        Map<String, dynamic> map = Map();
        map['ser'] = '0';
        map['unit'] = 'ไม่ระบุ';
        map['st'] = '1';
        map['day'] = '0';
        map['data_update'] = '0';

        UnitModel unitModel = UnitModel.fromJson(map);
        UnitxModel unitxModel = UnitxModel.fromJson(map);

        setState(() {
          unitModels.add(unitModel);
          unitxModels.add(unitxModel);
        });

        for (var map in result) {
          UnitModel unitModel = UnitModel.fromJson(map);
          UnitxModel unitxModel = UnitxModel.fromJson(map);

          setState(() {
            if (unitModel.ser == '1' ||
                unitModel.ser == '2' ||
                unitModel.ser == '3' ||
                unitModel.ser == '4' ||
                unitModel.ser == '5') {
              unitModels.add(unitModel);
            }
            // unitModels.add(unitModel);
            if (unitxModel.ser == '5' ||
                unitxModel.ser == '6' ||
                unitxModel.ser == '7') {
              unitxModels.add(unitxModel);
            }
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_selectVat_map() async {
    if (selectVat.length != 0) {
      setState(() {
        selectVat.clear();
      });
    }
    Map<String, dynamic> value1 = {
      'ser': '0',
      'name': 'ไม่มี',
    };
    Map<String, dynamic> value2 = {
      'ser': '1',
      'name': 'รวมภาษี',
    };
    Map<String, dynamic> value3 = {
      'ser': '2',
      'name': 'ไม่รวมภาษี',
    };

    VatSModel vatModel = VatSModel.fromJson(value1);
    VatSModel vatModel1 = VatSModel.fromJson(value2);
    VatSModel vatModel2 = VatSModel.fromJson(value3);
    setState(() {
      selectVat.add(vatModel);
      selectVat.add(vatModel1);
      selectVat.add(vatModel2);
    });
  }

  Future<Null> read_GC_vat() async {
    if (vatModels.isNotEmpty) {
      vatModels.clear();
      vatSeModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_vat_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          VatModel vatModel = VatModel.fromJson(map);
          VatSeModel vatSeModel = VatSeModel.fromJson(map);
          setState(() {
            vatModels.add(vatModel);
            if (vatModel.st != '0') {
              vatSeModels.add(vatSeModel);
            }
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_wht() async {
    if (whtModels.isNotEmpty) {
      whtModels.clear();
      whtSeModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_wht_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          WhtModel whtModel = WhtModel.fromJson(map);
          WhtSeModel whtSeModel = WhtSeModel.fromJson(map);
          setState(() {
            whtModels.add(whtModel);
            if (whtModel.st != '0') {
              whtSeModels.add(whtSeModel);
            }
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      expModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_exp_setring.php?isAdd=true&ren=$ren';

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

  Future<Null> read_GC_ExpType() async {
    if (expTypeModels.isNotEmpty) {
      expTypeModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_exptype.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ExpTypeModel expTypeModel = ExpTypeModel.fromJson(map);
          setState(() {
            expTypeModels.add(expTypeModel);
          });
        }
        setState(() {
          _scrollControllers =
              List.generate(expTypeModels.length, (_) => ScrollController());
        });
      } else {}
    } catch (e) {}
  }

  //////////////-------------------------------->

  ScrollController _scrollController01 = ScrollController();
  ScrollController _scrollController02 = ScrollController();

  ///----------------->
  _moveUp01() {
    _scrollController01.animateTo(_scrollController01.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown01() {
    _scrollController01.animateTo(_scrollController01.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveUp02() {
    _scrollController02.animateTo(_scrollController02.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown02() {
    _scrollController02.animateTo(_scrollController02.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

//////////---------------------------------------------------->
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.white, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (Show_VAT_WHT == 1)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  Show_VAT_WHT = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                padding: const EdgeInsets.all(4.0),
                                width: 170,
                                // height: 30,
                                child: Center(
                                  child: Text(
                                    'X ปิดการตั้งค่า VAT, WHT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (Show_VAT_WHT == 0)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 4, 10, 4),
                            child: InkWell(
                              child: Container(
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
                                            setState(() {
                                              Show_VAT_WHT = 1;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                      '+ ตั้งค่า VAT, WHT',
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    ),
                                                  )
                                                ],
                                              ))),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ),
                      ],
                    ),
                  ],
                )),
          ),
          if (Show_VAT_WHT != 0)
            SizedBox(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'ตั้งค่าประเภทค่าบริการ หรือ ค่า Defauilt  และ VAT, WHT',
                          style: TextStyle(
                            color: SettingScreen_Color.Colors_Text1_,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                            //fontSize: 10.0
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ตั้งค่า VAT',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: SettingScreen_Color.Colors_Text1_,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      String? ren =
                                          preferences.getString('renTalSer');
                                      String? ser_user =
                                          preferences.getString('ser');

                                      String url =
                                          '${MyConstant().domain}/InC_vat.php?isAdd=true&ren=$ren&ser_user=$ser_user';

                                      try {
                                        var response =
                                            await http.get(Uri.parse(url));

                                        var result = json.decode(response.body);
                                        print(result);
                                        if (result.toString() == 'true') {
                                          Insert_log.Insert_logs(
                                              'ตั้งค่า', 'การเช่า>>เพิ่มVAT');
                                          setState(() {
                                            read_GC_vat();
                                          });
                                        } else {}
                                      } catch (e) {}
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text(
                                        '+ เพิ่ม',
                                        style: TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text3_,
                                          fontFamily: FontWeight_.Fonts_T,
                                          fontWeight: FontWeight.bold,
                                          //fontSize: 10.0
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // for (int index = 0; index < whtModels.length; index++)
                            Container(
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
                                      dragStartBehavior:
                                          DragStartBehavior.start,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width:
                                                (!Responsive.isDesktop(context))
                                                    ? 700
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.84,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        height: 50,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            'รายการเลือก',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            '%',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            'ประเภท',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            'เปิด-ปิด',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            'ลบ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 200,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppbackgroundColor
                                                        .Sub_Abg_Colors,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0),
                                                      topRight:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                    ),
                                                    // border: Border.all(
                                                    //     color: Colors.grey, width: 1),
                                                  ),
                                                  child: ListView.builder(
                                                    controller:
                                                        _scrollController01,
                                                    // controller:
                                                    //     _scrollControllers[Ser_Sub],
                                                    // itemExtent: 50,
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: vatModels.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Material(
                                                        color: tappedIndex_VAT ==
                                                                index.toString()
                                                            ? tappedIndex_Color
                                                                .tappedIndex_Colors
                                                            : AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        child: Container(
                                                          // color: Colors.white,
                                                          child: ListTile(
                                                            onTap: () {
                                                              setState(() {
                                                                tappedIndex_VAT =
                                                                    index
                                                                        .toString();
                                                              });
                                                            },
                                                            title: Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      initialValue:
                                                                          vatModels[index]
                                                                              .vat,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();
                                                                        String?
                                                                            ren =
                                                                            preferences.getString('renTalSer');
                                                                        String?
                                                                            ser_user =
                                                                            preferences.getString('ser');
                                                                        var vser =
                                                                            vatModels[index].ser;
                                                                        String
                                                                            url =
                                                                            '${MyConstant().domain}/UpC_vat_name.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                        try {
                                                                          var response =
                                                                              await http.get(Uri.parse(url));

                                                                          var result =
                                                                              json.decode(response.body);
                                                                          print(
                                                                              result);
                                                                          if (result.toString() ==
                                                                              'true') {
                                                                            setState(() {
                                                                              read_GC_vat();
                                                                            });
                                                                          } else {}
                                                                        } catch (e) {}
                                                                      },
                                                                      // maxLength: 13,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      decoration: InputDecoration(
                                                                          fillColor: Colors.white.withOpacity(0.05),
                                                                          filled: true,
                                                                          // prefixIcon:
                                                                          //     const Icon(Icons.key, color: Colors.black),
                                                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                          focusedBorder: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          enabledBorder: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          // labelText: 'PASSWOED',
                                                                          labelStyle: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      initialValue:
                                                                          vatModels[index]
                                                                              .pct,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();
                                                                        String?
                                                                            ren =
                                                                            preferences.getString('renTalSer');
                                                                        String?
                                                                            ser_user =
                                                                            preferences.getString('ser');
                                                                        var vser =
                                                                            vatModels[index].ser;
                                                                        String
                                                                            url =
                                                                            '${MyConstant().domain}/UpC_vat_pct.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                        try {
                                                                          var response =
                                                                              await http.get(Uri.parse(url));

                                                                          var result =
                                                                              json.decode(response.body);
                                                                          print(
                                                                              result);
                                                                          if (result.toString() ==
                                                                              'true') {
                                                                            setState(() {
                                                                              read_GC_vat();
                                                                            });
                                                                          } else {}
                                                                        } catch (e) {}
                                                                      },
                                                                      // maxLength: 13,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      decoration: InputDecoration(
                                                                          fillColor: Colors.white.withOpacity(0.05),
                                                                          filled: true,
                                                                          // prefixIcon:
                                                                          //     const Icon(Icons.key, color: Colors.black),
                                                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                          focusedBorder: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          enabledBorder: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          // labelText: 'PASSWOED',
                                                                          labelStyle: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      DropdownButtonFormField2(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //Add isDense true and zero Padding.
                                                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                      isDense:
                                                                          true,
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      //Add more decoration as you want here
                                                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                    ),
                                                                    isExpanded:
                                                                        true,
                                                                    // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                    hint: Text(
                                                                      vatModels[index].vtypex ==
                                                                              '0'
                                                                          ? 'ไม่มี'
                                                                          : vatModels[index].vtypex == '1'
                                                                              ? 'รวมภาษี'
                                                                              : 'ไม่รวมภาษี',
                                                                      style: const TextStyle(
                                                                          fontSize: 14,
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color: Colors
                                                                          .black45,
                                                                    ),
                                                                    iconSize:
                                                                        30,
                                                                    buttonHeight:
                                                                        60,
                                                                    buttonPadding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    dropdownDecoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    items: selectVat
                                                                        .map((item) => DropdownMenuItem<String>(
                                                                              value: '${item.ser}:${item.name}',
                                                                              child: Text(
                                                                                item.name!,
                                                                                style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                    onChanged:
                                                                        (value) async {
                                                                      var zones =
                                                                          value!
                                                                              .indexOf(':');
                                                                      var vat_ser =
                                                                          value.substring(
                                                                              0,
                                                                              zones);
                                                                      var vat_name =
                                                                          value.substring(zones +
                                                                              1);
                                                                      print(
                                                                          'mmmmm ${vat_ser.toString()} $vat_name');

                                                                      SharedPreferences
                                                                          preferences =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String?
                                                                          ren =
                                                                          preferences
                                                                              .getString('renTalSer');
                                                                      String?
                                                                          ser_user =
                                                                          preferences
                                                                              .getString('ser');
                                                                      var vser =
                                                                          vatModels[index]
                                                                              .ser;
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/UpC_vat_type.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user&vat_ser=$vat_ser&vat_name=$vat_name';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          setState(
                                                                              () {
                                                                            read_GC_vat();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    onSaved:
                                                                        (value) {
                                                                      // selectedValue = value.toString();
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: GestureDetector(
                                                                      onTap: () async {
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();
                                                                        String?
                                                                            ren =
                                                                            preferences.getString('renTalSer');
                                                                        String?
                                                                            ser_user =
                                                                            preferences.getString('ser');
                                                                        var open = vatModels[index].st ==
                                                                                '1'
                                                                            ? '0'
                                                                            : '1';
                                                                        var vser =
                                                                            vatModels[index].ser;
                                                                        String
                                                                            url =
                                                                            '${MyConstant().domain}/UpC_vat_open.php?isAdd=true&ren=$ren&vser=$vser&value=$open&ser_user=$ser_user';

                                                                        try {
                                                                          var response =
                                                                              await http.get(Uri.parse(url));

                                                                          var result =
                                                                              json.decode(response.body);
                                                                          print(
                                                                              result);
                                                                          if (result.toString() ==
                                                                              'true') {
                                                                            setState(() {
                                                                              read_GC_vat();
                                                                            });
                                                                          } else {}
                                                                        } catch (e) {}
                                                                      },
                                                                      child: vatModels[index].st == '1'
                                                                          ? const Icon(
                                                                              Icons.toggle_on,
                                                                              color: Colors.green,
                                                                              size: 50.0,
                                                                            )
                                                                          : const Icon(
                                                                              Icons.toggle_off,
                                                                              size: 50.0,
                                                                            )

                                                                      // Row(
                                                                      //   mainAxisAlignment:
                                                                      //       MainAxisAlignment
                                                                      //           .center,
                                                                      //   children: [
                                                                      //     Padding(
                                                                      //       padding:
                                                                      //           const EdgeInsets
                                                                      //                   .all(
                                                                      //               8.0),
                                                                      //       child:
                                                                      //           Container(
                                                                      //         width: 150,
                                                                      //         // height: 50,
                                                                      //         decoration:
                                                                      //             BoxDecoration(
                                                                      //           color: vatModels[index]
                                                                      //                       .st ==
                                                                      //                   '1'
                                                                      //               ? Colors
                                                                      //                   .green
                                                                      //               : Colors
                                                                      //                   .red,
                                                                      //           borderRadius: const BorderRadius
                                                                      //                   .only(
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
                                                                      //                   Radius.circular(10)),
                                                                      //         ),
                                                                      //         padding:
                                                                      //             const EdgeInsets
                                                                      //                     .all(
                                                                      //                 8.0),
                                                                      //         child: Center(
                                                                      //           child: Text(
                                                                      //             vatModels[index].st ==
                                                                      //                     '1'
                                                                      //                 ? 'เปิด'
                                                                      //                 : 'ปิด',
                                                                      //             textAlign:
                                                                      //                 TextAlign
                                                                      //                     .center,
                                                                      //             style: TextStyle(
                                                                      //                 color: vatModels[index].st == '1'
                                                                      //                     ? Colors.white
                                                                      //                     : Colors.white,
                                                                      //                 fontFamily: Font_.Fonts_T),
                                                                      //           ),
                                                                      //         ),
                                                                      //       ),
                                                                      //     ),
                                                                      //   ],
                                                                      // ),
                                                                      ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      SharedPreferences
                                                                          preferences =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String?
                                                                          ren =
                                                                          preferences
                                                                              .getString('renTalSer');
                                                                      String?
                                                                          ser_user =
                                                                          preferences
                                                                              .getString('ser');

                                                                      var vser =
                                                                          vatModels[index]
                                                                              .ser;
                                                                      print(
                                                                          '>>>>>>>>>vat $vser');
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/DeC_vat.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          setState(
                                                                              () {
                                                                            read_GC_vat();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            // height: 50,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.red,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                const Center(
                                                                              child: Icon(Icons.close),
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
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                    // width: MediaQuery.of(context)
                                                    //     .size
                                                    //     .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(0),
                                                              topRight: Radius
                                                                  .circular(0),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        const Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Text(
                                                            '** กรุณากด Enterทุกครั้งที่มีการเปลี่ยนแปลงข้อมูล **',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12.0,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _scrollController01
                                                                            .animateTo(
                                                                          0,
                                                                          duration:
                                                                              const Duration(seconds: 1),
                                                                          curve:
                                                                              Curves.easeOut,
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
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (_scrollController01
                                                                          .hasClients) {
                                                                        final position = _scrollController01
                                                                            .position
                                                                            .maxScrollExtent;
                                                                        _scrollController01
                                                                            .animateTo(
                                                                          position,
                                                                          duration:
                                                                              const Duration(seconds: 1),
                                                                          curve:
                                                                              Curves.easeOut,
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
                                                                              color: Colors.grey,
                                                                              width: 1),
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
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        _moveUp01,
                                                                    child: const Padding(
                                                                        padding: EdgeInsets.all(8.0),
                                                                        child: Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Icon(
                                                                            Icons.arrow_upward,
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
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(6),
                                                                            topRight: Radius.circular(6),
                                                                            bottomLeft: Radius.circular(6),
                                                                            bottomRight: Radius.circular(6)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3.0),
                                                                      child:
                                                                          const Text(
                                                                        'Scroll',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                                10.0,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T),
                                                                      )),
                                                                  InkWell(
                                                                    onTap:
                                                                        _moveDown01,
                                                                    child: const Padding(
                                                                        padding: EdgeInsets.all(8.0),
                                                                        child: Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Icon(
                                                                            Icons.arrow_downward,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // if (!Responsive.isDesktop(context))
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ตั้งค่า WHT',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: SettingScreen_Color.Colors_Text1_,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      String? ren =
                                          preferences.getString('renTalSer');
                                      String? ser_user =
                                          preferences.getString('ser');

                                      String url =
                                          '${MyConstant().domain}/InC_wht.php?isAdd=true&ren=$ren&ser_user=$ser_user';

                                      try {
                                        var response =
                                            await http.get(Uri.parse(url));

                                        var result = json.decode(response.body);
                                        print(result);
                                        if (result.toString() == 'true') {
                                          Insert_log.Insert_logs(
                                              'ตั้งค่า', 'การเช่า>>เพิ่มWHT');
                                          setState(() {
                                            read_GC_wht();
                                          });
                                        } else {}
                                      } catch (e) {}
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text(
                                        '+ เพิ่ม',
                                        style: TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text3_,
                                          fontFamily: FontWeight_.Fonts_T,
                                          fontWeight: FontWeight.bold,
                                          //fontSize: 10.0
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // for (int index = 0; index < whtModels.length; index++)
                            Container(
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
                                      dragStartBehavior:
                                          DragStartBehavior.start,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width:
                                                (!Responsive.isDesktop(context))
                                                    ? 700
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.84,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        height: 50,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            'รายการเลือก',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            '%',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                    //     decoration: const BoxDecoration(
                                                    //       color: AppbackgroundColor
                                                    //           .TiTile_Colors,
                                                    //       borderRadius:
                                                    //           BorderRadius.only(
                                                    //         topLeft: Radius.circular(0),
                                                    //         topRight:
                                                    //             Radius.circular(0),
                                                    //         bottomLeft:
                                                    //             Radius.circular(0),
                                                    //         bottomRight:
                                                    //             Radius.circular(0),
                                                    //       ),
                                                    //       // border: Border.all(
                                                    //       //     color: Colors.grey, width: 1),
                                                    //     ),
                                                    //     padding:
                                                    //         const EdgeInsets.all(8.0),
                                                    //     child: const Center(
                                                    //       child: Text(
                                                    //         '',
                                                    //         textAlign: TextAlign.center,
                                                    //         style: TextStyle(
                                                    //           color: SettingScreen_Color
                                                    //               .Colors_Text1_,
                                                    //           fontFamily:
                                                    //               FontWeight_.Fonts_T,
                                                    //           fontWeight:
                                                    //               FontWeight.bold,
                                                    //           //fontSize: 10.0
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 50,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            'เปิด-ปิด',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Center(
                                                          child: Text(
                                                            'ลบ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 200,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppbackgroundColor
                                                        .Sub_Abg_Colors,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0),
                                                      topRight:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                    ),
                                                    // border: Border.all(
                                                    //     color: Colors.grey, width: 1),
                                                  ),
                                                  child: ListView.builder(
                                                    controller:
                                                        _scrollController02,
                                                    // controller:
                                                    //     _scrollControllers[Ser_Sub],
                                                    // itemExtent: 50,
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: whtModels.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Material(
                                                        color: tappedIndex_WHT ==
                                                                index.toString()
                                                            ? tappedIndex_Color
                                                                .tappedIndex_Colors
                                                            : AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        child: Container(
                                                          // color: Colors.white,
                                                          child: ListTile(
                                                            onTap: () {
                                                              setState(() {
                                                                tappedIndex_WHT =
                                                                    index
                                                                        .toString();
                                                              });
                                                            },
                                                            title: Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      TextFormField(
                                                                    initialValue:
                                                                        whtModels[index]
                                                                            .wht,
                                                                    onFieldSubmitted:
                                                                        (value) async {
                                                                      SharedPreferences
                                                                          preferences =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String?
                                                                          ren =
                                                                          preferences
                                                                              .getString('renTalSer');
                                                                      String?
                                                                          ser_user =
                                                                          preferences
                                                                              .getString('ser');
                                                                      var vser =
                                                                          whtModels[index]
                                                                              .ser;
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/UpC_wht_name.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          setState(
                                                                              () {
                                                                            read_GC_wht();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    // maxLength: 13,
                                                                    cursorColor:
                                                                        Colors
                                                                            .green,
                                                                    decoration: InputDecoration(
                                                                        fillColor: Colors.white.withOpacity(0.05),
                                                                        filled: true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.key, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder: const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(15),
                                                                            topLeft:
                                                                                Radius.circular(15),
                                                                            bottomRight:
                                                                                Radius.circular(15),
                                                                            bottomLeft:
                                                                                Radius.circular(15),
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        enabledBorder: const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(15),
                                                                            topLeft:
                                                                                Radius.circular(15),
                                                                            bottomRight:
                                                                                Radius.circular(15),
                                                                            bottomLeft:
                                                                                Radius.circular(15),
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        // labelText: 'PASSWOED',
                                                                        labelStyle: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      initialValue:
                                                                          whtModels[index]
                                                                              .pct,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();
                                                                        String?
                                                                            ren =
                                                                            preferences.getString('renTalSer');
                                                                        String?
                                                                            ser_user =
                                                                            preferences.getString('ser');
                                                                        var wser =
                                                                            whtModels[index].ser;
                                                                        String
                                                                            url =
                                                                            '${MyConstant().domain}/UpC_wht_ptc.php?isAdd=true&ren=$ren&wser=$wser&value=$value&ser_user=$ser_user';

                                                                        try {
                                                                          var response =
                                                                              await http.get(Uri.parse(url));

                                                                          var result =
                                                                              json.decode(response.body);
                                                                          print(
                                                                              result);
                                                                          if (result.toString() ==
                                                                              'true') {
                                                                            setState(() {
                                                                              read_GC_wht();
                                                                            });
                                                                          } else {}
                                                                        } catch (e) {}
                                                                      },
                                                                      // maxLength: 13,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      decoration: InputDecoration(
                                                                          fillColor: Colors.white.withOpacity(0.05),
                                                                          filled: true,
                                                                          // prefixIcon:
                                                                          //     const Icon(Icons.key, color: Colors.black),
                                                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                          focusedBorder: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          enabledBorder: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          // labelText: 'PASSWOED',
                                                                          labelStyle: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: GestureDetector(
                                                                      onTap: () async {
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();
                                                                        String?
                                                                            ren =
                                                                            preferences.getString('renTalSer');
                                                                        String?
                                                                            ser_user =
                                                                            preferences.getString('ser');
                                                                        var open = whtModels[index].st ==
                                                                                '1'
                                                                            ? '0'
                                                                            : '1';
                                                                        var vser =
                                                                            whtModels[index].ser;
                                                                        String
                                                                            url =
                                                                            '${MyConstant().domain}/UpC_wht_open.php?isAdd=true&ren=$ren&vser=$vser&value=$open&ser_user=$ser_user';

                                                                        try {
                                                                          var response =
                                                                              await http.get(Uri.parse(url));

                                                                          var result =
                                                                              json.decode(response.body);
                                                                          print(
                                                                              result);
                                                                          if (result.toString() ==
                                                                              'true') {
                                                                            setState(() {
                                                                              read_GC_wht();
                                                                            });
                                                                          } else {}
                                                                        } catch (e) {}
                                                                      },
                                                                      child: whtModels[index].st == '1'
                                                                          ? const Icon(
                                                                              Icons.toggle_on,
                                                                              color: Colors.green,
                                                                              size: 50.0,
                                                                            )
                                                                          : const Icon(
                                                                              Icons.toggle_off,
                                                                              size: 50.0,
                                                                            )

                                                                      //  Row(
                                                                      //   mainAxisAlignment:
                                                                      //       MainAxisAlignment
                                                                      //           .center,
                                                                      //   children: [
                                                                      //     Padding(
                                                                      //       padding:
                                                                      //           const EdgeInsets
                                                                      //                   .all(
                                                                      //               8.0),
                                                                      //       child:
                                                                      //           Container(
                                                                      //         width: 150,
                                                                      //         decoration:
                                                                      //             BoxDecoration(
                                                                      //           color: whtModels[index]
                                                                      //                       .st ==
                                                                      //                   '1'
                                                                      //               ? Colors
                                                                      //                   .green
                                                                      //               : Colors
                                                                      //                   .red,
                                                                      //           borderRadius: const BorderRadius
                                                                      //                   .only(
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
                                                                      //                   Radius.circular(10)),
                                                                      //         ),
                                                                      //         padding:
                                                                      //             const EdgeInsets
                                                                      //                     .all(
                                                                      //                 8.0),
                                                                      //         child: Center(
                                                                      //           child: Text(
                                                                      //             whtModels[index].st ==
                                                                      //                     '1'
                                                                      //                 ? 'เปิด'
                                                                      //                 : 'ปิด',
                                                                      //             textAlign:
                                                                      //                 TextAlign
                                                                      //                     .center,
                                                                      //             style: TextStyle(
                                                                      //                 color: whtModels[index].st == '1'
                                                                      //                     ? Colors.white
                                                                      //                     : Colors.white,
                                                                      //                 fontFamily: Font_.Fonts_T),
                                                                      //           ),
                                                                      //         ),
                                                                      //       ),
                                                                      //     ),
                                                                      //   ],
                                                                      // ),
                                                                      ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      SharedPreferences
                                                                          preferences =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String?
                                                                          ren =
                                                                          preferences
                                                                              .getString('renTalSer');
                                                                      String?
                                                                          ser_user =
                                                                          preferences
                                                                              .getString('ser');

                                                                      var vser =
                                                                          whtModels[index]
                                                                              .ser;
                                                                      print(
                                                                          '>>>>>>>>>vat $vser');
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/DeC_wht.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          setState(
                                                                              () {
                                                                            read_GC_wht();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            // height: 50,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.red,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                const Center(
                                                                              child: Icon(Icons.close),
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
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                    // width: MediaQuery.of(context)
                                                    //     .size
                                                    //     .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(0),
                                                              topRight: Radius
                                                                  .circular(0),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        const Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Text(
                                                            '** กรุณากด Enterทุกครั้งที่มีการเปลี่ยนแปลงข้อมูล **',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12.0,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _scrollController02
                                                                            .animateTo(
                                                                          0,
                                                                          duration:
                                                                              const Duration(seconds: 1),
                                                                          curve:
                                                                              Curves.easeOut,
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
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (_scrollController02
                                                                          .hasClients) {
                                                                        final position = _scrollController02
                                                                            .position
                                                                            .maxScrollExtent;
                                                                        _scrollController02
                                                                            .animateTo(
                                                                          position,
                                                                          duration:
                                                                              const Duration(seconds: 1),
                                                                          curve:
                                                                              Curves.easeOut,
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
                                                                              color: Colors.grey,
                                                                              width: 1),
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
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        _moveUp02,
                                                                    child: const Padding(
                                                                        padding: EdgeInsets.all(8.0),
                                                                        child: Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Icon(
                                                                            Icons.arrow_upward,
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
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(6),
                                                                            topRight: Radius.circular(6),
                                                                            bottomLeft: Radius.circular(6),
                                                                            bottomRight: Radius.circular(6)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3.0),
                                                                      child:
                                                                          const Text(
                                                                        'Scroll',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                                10.0,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T),
                                                                      )),
                                                                  InkWell(
                                                                    onTap:
                                                                        _moveDown02,
                                                                    child: const Padding(
                                                                        padding: EdgeInsets.all(8.0),
                                                                        child: Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Icon(
                                                                            Icons.arrow_downward,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          for (int Ser_Sub = 0; Ser_Sub < expTypeModels.length; Ser_Sub++)
            (expTypeModels[Ser_Sub].etype != 'F')
                ? Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${Ser_Sub + 1}.${expTypeModels[Ser_Sub].bills}',
                                maxLines: 1,
                                style: const TextStyle(
                                  color: SettingScreen_Color.Colors_Text1_,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String? ren =
                                      preferences.getString('renTalSer');
                                  String? ser_user =
                                      preferences.getString('ser');
                                  var vser = expTypeModels[Ser_Sub].ser;
                                  String url =
                                      '${MyConstant().domain}/InC_exp.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user';

                                  try {
                                    var response =
                                        await http.get(Uri.parse(url));

                                    var result = json.decode(response.body);
                                    print(result);
                                    if (result.toString() == 'true') {
                                      Insert_log.Insert_logs('ตั้งค่า',
                                          'การเช่า>>เพิ่ม${expTypeModels[Ser_Sub].bills}');
                                      setState(() {
                                        read_GC_Exp();
                                      });
                                    } else {}
                                  } catch (e) {}
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    '+ เพิ่ม',
                                    style: TextStyle(
                                      color: SettingScreen_Color.Colors_Text3_,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                  width: (!Responsive.isDesktop(context))
                                      ? 1300
                                      : MediaQuery.of(context).size.width *
                                          0.85,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(0),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  '',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(0),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ค่า DEFEAULT',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
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
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  '',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
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
                                            flex: 3,
                                            child: Container(
                                              height: 60,
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ประเภทค่าบริการ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 60,
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ความถี่',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child:
                                                expTypeModels[Ser_Sub].ser ==
                                                        '3'
                                                    ? Container(
                                                        height: 60,
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    'กำหนดราคา',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: const [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'เปิด/ปิด',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: SettingScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ราคา',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: SettingScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'มิเตอร์/หน่วย',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: SettingScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 60,
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    'กำหนดราคา',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: const [
                                                                  Expanded(
                                                                    child: Text(
                                                                      'เปิด/ปิด',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: SettingScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      'ราคา',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: SettingScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        //fontSize: 10.0
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
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 60,
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'วันที่เริ่มงวด',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 60,
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'VAT',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 60,
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'WHT',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 60,
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'Auto',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 60,
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ลบ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 200,
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
                                          // controller: _scrollController1,
                                          controller:
                                              _scrollControllers[Ser_Sub],
                                          // itemExtent: 50,
                                          // physics:
                                          //     const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: expModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return expTypeModels[Ser_Sub].ser !=
                                                    expModels[index].exptser
                                                ? const SizedBox()
                                                : Material(
                                                    color: tappedIndex_[
                                                                Ser_Sub] ==
                                                            index.toString()
                                                        ? tappedIndex_Color
                                                            .tappedIndex_Colors
                                                        : AppbackgroundColor
                                                            .Sub_Abg_Colors,
                                                    child: Container(
                                                      // color: tappedIndex_[
                                                      //             Ser_Sub] ==
                                                      //         index.toString()
                                                      //     ? Colors.grey.shade300
                                                      //     : null,
                                                      child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            tappedIndex_[
                                                                    Ser_Sub] =
                                                                index
                                                                    .toString();
                                                          });
                                                        },
                                                        title: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 3,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextFormField(
                                                                  initialValue:
                                                                      expModels[
                                                                              index]
                                                                          .expname,
                                                                  onFieldSubmitted:
                                                                      (value) async {
                                                                    SharedPreferences
                                                                        preferences =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String?
                                                                        ren =
                                                                        preferences
                                                                            .getString('renTalSer');
                                                                    String?
                                                                        ser_user =
                                                                        preferences
                                                                            .getString('ser');
                                                                    var vser =
                                                                        expModels[index]
                                                                            .ser;
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_exp_name.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        setState(
                                                                            () {
                                                                          read_GC_Exp();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                  },
                                                                  // maxLength: 13,
                                                                  cursorColor:
                                                                      Colors
                                                                          .green,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.05),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.key, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText: 'PASSWOED',
                                                                    labelStyle: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ),
                                                              // Text(
                                                              //   '${expModels[index].expname}',
                                                              //   textAlign:
                                                              //       TextAlign
                                                              //           .center,
                                                              //   style: const TextStyle(
                                                              //       color: SettingScreen_Color
                                                              //           .Colors_Text2_,
                                                              //       fontFamily: Font_
                                                              //           .Fonts_T),
                                                              // ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: expModels[index]
                                                                            .exptser ==
                                                                        '3'
                                                                    ? DropdownButtonFormField2(
                                                                        decoration:
                                                                            InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          contentPadding:
                                                                              EdgeInsets.zero,
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                        ),
                                                                        isExpanded:
                                                                            true,
                                                                        hint:
                                                                            Text(
                                                                          expModels[index].unitser == '0'
                                                                              ? 'ไม่ระบุ'
                                                                              : '${expModels[index].unit}',
                                                                          maxLines:
                                                                              1,
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color:
                                                                              TextHome_Color.TextHome_Colors,
                                                                        ),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green.shade900,
                                                                            fontFamily: Font_.Fonts_T),
                                                                        iconSize:
                                                                            20,
                                                                        buttonHeight:
                                                                            50,
                                                                        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                        dropdownDecoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        items: unitxModels
                                                                            .map((item) {
                                                                          // if
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                '${item.ser}:${item.unit}',
                                                                            child:
                                                                                Text(
                                                                              item.unit!,
                                                                              style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          );
                                                                        }).toList(),

                                                                        onChanged:
                                                                            (value) async {
                                                                          var zones =
                                                                              value!.indexOf(':');
                                                                          var unitSer = value.substring(
                                                                              0,
                                                                              zones);
                                                                          var unitName =
                                                                              value.substring(zones + 1);
                                                                          print(
                                                                              'mmmmm ${unitSer.toString()} $unitName');

                                                                          SharedPreferences
                                                                              preferences =
                                                                              await SharedPreferences.getInstance();
                                                                          String?
                                                                              ren =
                                                                              preferences.getString('renTalSer');
                                                                          String?
                                                                              ser_user =
                                                                              preferences.getString('ser');
                                                                          var vser =
                                                                              expModels[index].ser;

                                                                          String
                                                                              url =
                                                                              '${MyConstant().domain}/UpC_exp_unit.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user&unitSer=$unitSer&unitName=$unitName';

                                                                          try {
                                                                            var response =
                                                                                await http.get(Uri.parse(url));

                                                                            var result =
                                                                                json.decode(response.body);
                                                                            print(result);
                                                                            if (result.toString() ==
                                                                                'true') {
                                                                              Insert_log.Insert_logs('ตั้งค่า', 'การเช่า>>${expTypeModels[Ser_Sub].bills}(ความถี่$unitName ${expModels[index].expname})');
                                                                              setState(() {
                                                                                read_GC_Exp();
                                                                              });
                                                                            } else {}
                                                                          } catch (e) {}
                                                                        },
                                                                      )
                                                                    : DropdownButtonFormField2(
                                                                        decoration:
                                                                            InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          contentPadding:
                                                                              EdgeInsets.zero,
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                        ),
                                                                        isExpanded:
                                                                            true,
                                                                        hint:
                                                                            Text(
                                                                          expModels[index].unitser == '0'
                                                                              ? 'ไม่ระบุ'
                                                                              : '${expModels[index].unit}',
                                                                          maxLines:
                                                                              1,
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color:
                                                                              TextHome_Color.TextHome_Colors,
                                                                        ),
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .green
                                                                              .shade900,
                                                                        ),
                                                                        iconSize:
                                                                            20,
                                                                        buttonHeight:
                                                                            50,
                                                                        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                        dropdownDecoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        items: unitModels
                                                                            .map((item) {
                                                                          // if (int.parse(Value_rental_type_3) ==
                                                                          //     1)
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                '${item.ser}:${item.unit}',
                                                                            child:
                                                                                Text(
                                                                              item.unit!,
                                                                              style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          );
                                                                          // } else {}
                                                                          // return dob;
                                                                        }).toList(),

                                                                        onChanged:
                                                                            (value) async {
                                                                          var zones =
                                                                              value!.indexOf(':');
                                                                          var unitSer = value.substring(
                                                                              0,
                                                                              zones);
                                                                          var unitName =
                                                                              value.substring(zones + 1);
                                                                          print(
                                                                              'mmmmm ${unitSer.toString()} $unitName');
                                                                          SharedPreferences
                                                                              preferences =
                                                                              await SharedPreferences.getInstance();
                                                                          String?
                                                                              ren =
                                                                              preferences.getString('renTalSer');
                                                                          String?
                                                                              ser_user =
                                                                              preferences.getString('ser');
                                                                          var vser =
                                                                              expModels[index].ser;

                                                                          String
                                                                              url =
                                                                              '${MyConstant().domain}/UpC_exp_unit.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user&unitSer=$unitSer&unitName=$unitName';

                                                                          try {
                                                                            var response =
                                                                                await http.get(Uri.parse(url));

                                                                            var result =
                                                                                json.decode(response.body);
                                                                            print(result);
                                                                            if (result.toString() ==
                                                                                'true') {
                                                                              Insert_log.Insert_logs('ตั้งค่า', 'การเช่า>>${expTypeModels[Ser_Sub].bills}(ความถี่$unitName ${expModels[index].expname})');
                                                                              setState(() {
                                                                                read_GC_Exp();
                                                                              });
                                                                            } else {}
                                                                          } catch (e) {}
                                                                        },
                                                                      ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: expModels[
                                                                              index]
                                                                          .exptser !=
                                                                      '3'
                                                                  ? Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            150,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          // color: Colors
                                                                          //     .red,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight:
                                                                                Radius.circular(10),
                                                                            bottomLeft:
                                                                                Radius.circular(10),
                                                                            bottomRight:
                                                                                Radius.circular(10),
                                                                          ),
                                                                          // border: Border.all(
                                                                          //     color: Colors.grey, width: 1),
                                                                        ),
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: GestureDetector(
                                                                                  onTap: () async {
                                                                                    SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                    String? ren = preferences.getString('renTalSer');
                                                                                    String? ser_user = preferences.getString('ser');
                                                                                    var vser = expModels[index].ser;

                                                                                    var autox = expModels[index].cal_auto == '1' ? '0' : '1';
                                                                                    String url = '${MyConstant().domain}/UpC_exp_Auto_cal.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user&autox=$autox';

                                                                                    try {
                                                                                      var response = await http.get(Uri.parse(url));

                                                                                      var result = json.decode(response.body);
                                                                                      print(result);
                                                                                      if (result.toString() == 'true') {
                                                                                        Insert_log.Insert_logs('ตั้งค่า', (autox == '0') ? 'การเช่า>>${expTypeModels[Ser_Sub].bills}(ปิดดึงราคา ${expModels[index].expname})' : 'การเช่า>>${expTypeModels[Ser_Sub].bills}(เปิดดึงราคา ${expModels[index].expname})');
                                                                                        setState(() {
                                                                                          read_GC_Exp();
                                                                                        });
                                                                                      } else {}
                                                                                    } catch (e) {}
                                                                                  },
                                                                                  child: expModels[index].cal_auto == '1'
                                                                                      ? const Icon(
                                                                                          Icons.toggle_on,
                                                                                          color: Colors.green,
                                                                                          size: 50.0,
                                                                                        )
                                                                                      : const Icon(
                                                                                          Icons.toggle_off,
                                                                                          size: 50.0,
                                                                                        )),
                                                                            ),
                                                                            Expanded(
                                                                                child: expModels[index].cal_auto == '1'
                                                                                    ? TextFormField(
                                                                                        textAlign: TextAlign.right,
                                                                                        initialValue: expModels[index].pri_auto,
                                                                                        onFieldSubmitted: (value) async {
                                                                                          SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                          String? ren = preferences.getString('renTalSer');
                                                                                          String? ser_user = preferences.getString('ser');
                                                                                          var vser = expModels[index].ser;
                                                                                          String url = '${MyConstant().domain}/UpC_pri_auto.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                                          try {
                                                                                            var response = await http.get(Uri.parse(url));

                                                                                            var result = json.decode(response.body);
                                                                                            print(result);
                                                                                            Insert_log.Insert_logs('ตั้งค่า', 'การเช่า>>${expTypeModels[Ser_Sub].bills}(แก้ไขราคา ${expModels[index].expname})${expModels[index].pri_auto}-->$value');
                                                                                            if (result.toString() == 'true') {
                                                                                              setState(() {
                                                                                                read_GC_Exp();
                                                                                              });
                                                                                            } else {}
                                                                                          } catch (e) {}
                                                                                        },
                                                                                        // maxLength: 13,
                                                                                        cursorColor: Colors.green,
                                                                                        decoration: InputDecoration(
                                                                                          fillColor: Colors.white.withOpacity(0.05),
                                                                                          filled: true,
                                                                                          // prefixIcon:
                                                                                          //     const Icon(Icons.key, color: Colors.black),
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
                                                                                              color: Colors.grey,
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
                                                                                          // labelText: 'PASSWOED',
                                                                                          labelStyle: const TextStyle(
                                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                              // fontWeight: FontWeight.bold,
                                                                                              fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                        inputFormatters: <TextInputFormatter>[
                                                                                          // for below version 2 use this
                                                                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                          // for version 2 and greater youcan also use this
                                                                                          // FilteringTextInputFormatter
                                                                                          //     .digitsOnly
                                                                                        ],
                                                                                      )
                                                                                    : const SizedBox())
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: GestureDetector(
                                                                                onTap: () async {
                                                                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                  String? ren = preferences.getString('renTalSer');
                                                                                  String? ser_user = preferences.getString('ser');
                                                                                  var vser = expModels[index].ser;

                                                                                  var autox = expModels[index].cal_auto == '1' ? '0' : '1';
                                                                                  String url = '${MyConstant().domain}/UpC_exp_Auto_cal.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user&autox=$autox';

                                                                                  try {
                                                                                    var response = await http.get(Uri.parse(url));

                                                                                    var result = json.decode(response.body);
                                                                                    print(result);
                                                                                    if (result.toString() == 'true') {
                                                                                      Insert_log.Insert_logs('ตั้งค่า', (autox == '0') ? 'การเช่า>>${expTypeModels[Ser_Sub].bills}(ปิดดึงราคา ${expModels[index].expname})' : 'การเช่า>>${Ser_Sub + 1}.${expTypeModels[Ser_Sub].bills}(เปิดดึงราคา ${expModels[index].expname})');
                                                                                      setState(() {
                                                                                        read_GC_Exp();
                                                                                      });
                                                                                    } else {}
                                                                                  } catch (e) {}
                                                                                },
                                                                                child: expModels[index].cal_auto == '1'
                                                                                    ? const Icon(
                                                                                        Icons.toggle_on,
                                                                                        color: Colors.green,
                                                                                        size: 50.0,
                                                                                      )
                                                                                    : const Icon(
                                                                                        Icons.toggle_off,
                                                                                        size: 50.0,
                                                                                      )),
                                                                          ),
                                                                          Expanded(
                                                                              child: expModels[index].cal_auto == '1'
                                                                                  ? TextFormField(
                                                                                      textAlign: TextAlign.right,
                                                                                      initialValue: expModels[index].pri_auto,
                                                                                      onFieldSubmitted: (value) async {
                                                                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                        String? ren = preferences.getString('renTalSer');
                                                                                        String? ser_user = preferences.getString('ser');
                                                                                        var vser = expModels[index].ser;
                                                                                        String url = '${MyConstant().domain}/UpC_pri_auto.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                                        try {
                                                                                          var response = await http.get(Uri.parse(url));

                                                                                          var result = json.decode(response.body);
                                                                                          print(result);
                                                                                          if (result.toString() == 'true') {
                                                                                            setState(() {
                                                                                              read_GC_Exp();
                                                                                            });
                                                                                          } else {}
                                                                                        } catch (e) {}
                                                                                      },
                                                                                      // maxLength: 13,
                                                                                      cursorColor: Colors.green,
                                                                                      decoration: InputDecoration(
                                                                                        fillColor: Colors.white.withOpacity(0.05),
                                                                                        filled: true,
                                                                                        // prefixIcon:
                                                                                        //     const Icon(Icons.key, color: Colors.black),
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
                                                                                            color: Colors.grey,
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
                                                                                        // labelText: 'PASSWOED',
                                                                                        labelStyle: const TextStyle(
                                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      inputFormatters: <TextInputFormatter>[
                                                                                        // for below version 2 use this
                                                                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                        // for version 2 and greater youcan also use this
                                                                                        // FilteringTextInputFormatter
                                                                                        //     .digitsOnly
                                                                                      ],
                                                                                    )
                                                                                  : const SizedBox()),
                                                                          Expanded(
                                                                            child:
                                                                                TextFormField(
                                                                              textAlign: TextAlign.right,
                                                                              initialValue: expModels[index].pri,
                                                                              onFieldSubmitted: (value) async {
                                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                String? ren = preferences.getString('renTalSer');
                                                                                String? ser_user = preferences.getString('ser');
                                                                                var vser = expModels[index].ser;
                                                                                String url = '${MyConstant().domain}/UpC_vat_meter.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                                try {
                                                                                  var response = await http.get(Uri.parse(url));

                                                                                  var result = json.decode(response.body);
                                                                                  print(result);
                                                                                  if (result.toString() == 'true') {
                                                                                    setState(() {
                                                                                      read_GC_Exp();
                                                                                    });
                                                                                  } else {}
                                                                                } catch (e) {}
                                                                              },
                                                                              // maxLength: 13,
                                                                              cursorColor: Colors.green,
                                                                              decoration: InputDecoration(
                                                                                fillColor: Colors.white.withOpacity(0.05),
                                                                                filled: true,
                                                                                // prefixIcon:
                                                                                //     const Icon(Icons.key, color: Colors.black),
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
                                                                                    color: Colors.grey,
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
                                                                                // labelText: 'PASSWOED',
                                                                                labelStyle: const TextStyle(
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                              inputFormatters: <TextInputFormatter>[
                                                                                // for below version 2 use this
                                                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                // for version 2 and greater youcan also use this
                                                                                // FilteringTextInputFormatter
                                                                                //     .digitsOnly
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  DropdownButtonFormField2(
                                                                decoration:
                                                                    InputDecoration(
                                                                  //Add isDense true and zero Padding.
                                                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                  isDense: true,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  ),
                                                                  //Add more decoration as you want here
                                                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                ),
                                                                isExpanded:
                                                                    true,
                                                                // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                hint: Row(
                                                                  children: [
                                                                    Text(
                                                                      expModels[
                                                                              index]
                                                                          .sday
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize: 14,
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ],
                                                                ),
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  color: Colors
                                                                      .black45,
                                                                ),
                                                                iconSize: 30,
                                                                buttonHeight:
                                                                    60,
                                                                buttonPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                dropdownDecoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                                items: dateselect
                                                                    .map((item) => DropdownMenuItem<String>(
                                                                          value:
                                                                              item,
                                                                          child:
                                                                              Text(
                                                                            item,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ))
                                                                    .toList(),
                                                                onChanged:
                                                                    (value) async {
                                                                  // var zones = value!
                                                                  //     .indexOf(
                                                                  //         ':');
                                                                  // var vat_ser = value
                                                                  //     .substring(
                                                                  //         0,
                                                                  //         zones);
                                                                  // var vat_name =
                                                                  //     value.substring(
                                                                  //         zones +
                                                                  //             1);
                                                                  print(
                                                                      'mmmmm ${value.toString()}');

                                                                  String?
                                                                      ldatex =
                                                                      DateFormat(
                                                                              'yyyy-MM')
                                                                          .format(
                                                                              DateTime.now());

                                                                  // String start =
                                                                  //     DateFormat(
                                                                  //             'dd')
                                                                  //         .format(
                                                                  //             newDate);

                                                                  String EtDay =
                                                                      '$value';

                                                                  SharedPreferences
                                                                      preferences =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  String? ren =
                                                                      preferences
                                                                          .getString(
                                                                              'renTalSer');
                                                                  String?
                                                                      ser_user =
                                                                      preferences
                                                                          .getString(
                                                                              'ser');
                                                                  var eser =
                                                                      expModels[
                                                                              index]
                                                                          .ser;
                                                                  String url =
                                                                      '${MyConstant().domain}/UpC_exp_date.php?isAdd=true&ren=$ren&eser=$eser&end=$EtDay&ser_user=$ser_user';

                                                                  try {
                                                                    var response =
                                                                        await http
                                                                            .get(Uri.parse(url));

                                                                    var result =
                                                                        json.decode(
                                                                            response.body);
                                                                    print(
                                                                        result);
                                                                    if (result
                                                                            .toString() ==
                                                                        'true') {
                                                                      Insert_log.Insert_logs(
                                                                          'ตั้งค่า',
                                                                          'การเช่า>>${expTypeModels[Ser_Sub].bills}(แก้ไขวันเริ่มงวด ${expModels[index].expname}เป็นวันที่$EtDay)');
                                                                      setState(
                                                                          () {
                                                                        read_GC_Exp();
                                                                      });
                                                                    } else {}
                                                                  } catch (e) {}
                                                                },
                                                                onSaved:
                                                                    (value) {
                                                                  // selectedValue = value.toString();
                                                                },
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    DropdownButtonFormField2(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //Add isDense true and zero Padding.
                                                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                    isDense:
                                                                        true,
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    //Add more decoration as you want here
                                                                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                  ),
                                                                  isExpanded:
                                                                      true,
                                                                  // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                  hint: Row(
                                                                    children: [
                                                                      for (int i =
                                                                              0;
                                                                          i < vatModels.length;
                                                                          i++)
                                                                        expModels[index].vat != vatModels[i].ser
                                                                            ? const SizedBox()
                                                                            : SizedBox(
                                                                                child: Text(
                                                                                  vatModels[i].vat.toString(),
                                                                                  style: const TextStyle(
                                                                                      fontSize: 14,
                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                      // fontWeight: FontWeight.bold,
                                                                                      fontFamily: Font_.Fonts_T),
                                                                                ),
                                                                              ),
                                                                    ],
                                                                  ),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .black45,
                                                                  ),
                                                                  iconSize: 30,
                                                                  buttonHeight:
                                                                      60,
                                                                  buttonPadding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  dropdownDecoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  ),
                                                                  items: vatSeModels
                                                                      .map((item) => DropdownMenuItem<String>(
                                                                            value:
                                                                                '${item.ser}:${item.vat}',
                                                                            child:
                                                                                SizedBox(
                                                                              child: Text(
                                                                                item.vat!,
                                                                                style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                  onChanged:
                                                                      (value) async {
                                                                    var zones = value!
                                                                        .indexOf(
                                                                            ':');
                                                                    var vat_ser =
                                                                        value.substring(
                                                                            0,
                                                                            zones);
                                                                    var vat_name =
                                                                        value.substring(
                                                                            zones +
                                                                                1);
                                                                    print(
                                                                        'mmmmm ${vat_ser.toString()} $vat_name');

                                                                    SharedPreferences
                                                                        preferences =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String?
                                                                        ren =
                                                                        preferences
                                                                            .getString('renTalSer');
                                                                    String?
                                                                        ser_user =
                                                                        preferences
                                                                            .getString('ser');
                                                                    var vser =
                                                                        expModels[index]
                                                                            .ser;
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_vat_exp.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user&vat_ser=$vat_ser&vat_name=$vat_name';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        Insert_log.Insert_logs(
                                                                            'ตั้งค่า',
                                                                            'การเช่า>>${expTypeModels[Ser_Sub].bills}(แก้ไขVat ${expModels[index].expname} เป็น$vat_name)');
                                                                        setState(
                                                                            () {
                                                                          read_GC_Exp();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                  },
                                                                  onSaved:
                                                                      (value) {
                                                                    // selectedValue = value.toString();
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    DropdownButtonFormField2(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //Add isDense true and zero Padding.
                                                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                    isDense:
                                                                        true,
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    //Add more decoration as you want here
                                                                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                  ),
                                                                  isExpanded:
                                                                      true,
                                                                  // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                  hint: Row(
                                                                    children: [
                                                                      for (int i =
                                                                              0;
                                                                          i < whtModels.length;
                                                                          i++)
                                                                        expModels[index].wht != whtModels[i].ser
                                                                            ? const SizedBox()
                                                                            : SizedBox(
                                                                                child: Text(
                                                                                  whtModels[i].wht.toString(),
                                                                                  style: const TextStyle(
                                                                                      fontSize: 14,
                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                      // fontWeight: FontWeight.bold,
                                                                                      fontFamily: Font_.Fonts_T),
                                                                                ),
                                                                              ),
                                                                    ],
                                                                  ),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .black45,
                                                                  ),
                                                                  iconSize: 30,
                                                                  buttonHeight:
                                                                      60,
                                                                  buttonPadding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  dropdownDecoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  ),
                                                                  items: whtSeModels
                                                                      .map((item) => DropdownMenuItem<String>(
                                                                            value:
                                                                                '${item.ser}:${item.wht}',
                                                                            child:
                                                                                SizedBox(
                                                                              child: Text(
                                                                                item.wht!,
                                                                                style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                  onChanged:
                                                                      (value) async {
                                                                    var zones = value!
                                                                        .indexOf(
                                                                            ':');
                                                                    var vat_ser =
                                                                        value.substring(
                                                                            0,
                                                                            zones);
                                                                    var vat_name =
                                                                        value.substring(
                                                                            zones +
                                                                                1);
                                                                    print(
                                                                        'mmmmm ${vat_ser.toString()} $vat_name');

                                                                    SharedPreferences
                                                                        preferences =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String?
                                                                        ren =
                                                                        preferences
                                                                            .getString('renTalSer');
                                                                    String?
                                                                        ser_user =
                                                                        preferences
                                                                            .getString('ser');
                                                                    var vser =
                                                                        expModels[index]
                                                                            .ser;
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_wht_exp.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user&vat_ser=$vat_ser&vat_name=$vat_name';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        Insert_log.Insert_logs(
                                                                            'ตั้งค่า',
                                                                            'การเช่า>>${expTypeModels[Ser_Sub].bills}(แก้ไขWHT ${expModels[index].expname} เป็น$vat_name)');
                                                                        setState(
                                                                            () {
                                                                          read_GC_Exp();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                  },
                                                                  onSaved:
                                                                      (value) {
                                                                    // selectedValue = value.toString();
                                                                  },
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
                                                                    Container(
                                                                  width: 100,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    // color: Colors
                                                                    //     .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
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
                                                                              .all(
                                                                          8.0),
                                                                  child: GestureDetector(
                                                                      onTap: () async {
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();
                                                                        String?
                                                                            ren =
                                                                            preferences.getString('renTalSer');
                                                                        String?
                                                                            ser_user =
                                                                            preferences.getString('ser');
                                                                        var vser =
                                                                            expModels[index].ser;

                                                                        var autox = expModels[index].auto ==
                                                                                '1'
                                                                            ? '0'
                                                                            : '1';
                                                                        String
                                                                            url =
                                                                            '${MyConstant().domain}/UpC_exp_Auto.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user&autox=$autox';

                                                                        try {
                                                                          var response =
                                                                              await http.get(Uri.parse(url));

                                                                          var result =
                                                                              json.decode(response.body);
                                                                          print(
                                                                              result);
                                                                          if (result.toString() ==
                                                                              'true') {
                                                                            Insert_log.Insert_logs('ตั้งค่า',
                                                                                (autox == '0') ? 'การเช่า>>${expTypeModels[Ser_Sub].bills}(ปิดAuto ${expModels[index].expname})' : 'การเช่า>>${Ser_Sub + 1}.${expTypeModels[Ser_Sub].bills}(เปิดAuto ${expModels[index].expname})');
                                                                            setState(() {
                                                                              read_GC_Exp();
                                                                            });
                                                                          } else {}
                                                                        } catch (e) {}
                                                                      },
                                                                      child: expModels[index].auto == '1'
                                                                          ? const Icon(
                                                                              Icons.toggle_on,
                                                                              color: Colors.green,
                                                                              size: 50.0,
                                                                            )
                                                                          : const Icon(
                                                                              Icons.toggle_off,
                                                                              size: 50.0,
                                                                            )
                                                                      //     const Text(
                                                                      //   'X',
                                                                      //   textAlign:
                                                                      //       TextAlign
                                                                      //           .center,
                                                                      //   style: TextStyle(
                                                                      //       color: SettingScreen_Color
                                                                      //           .Colors_Text2_,
                                                                      //       fontFamily:
                                                                      //           Font_.Fonts_T),
                                                                      // ),
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
                                                                child:
                                                                    Container(
                                                                  width: 100,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
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
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      SharedPreferences
                                                                          preferences =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String?
                                                                          ren =
                                                                          preferences
                                                                              .getString('renTalSer');
                                                                      String?
                                                                          ser_user =
                                                                          preferences
                                                                              .getString('ser');
                                                                      var vser =
                                                                          expModels[index]
                                                                              .ser;
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/DeC_exp.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          Insert_log.Insert_logs(
                                                                              'ตั้งค่า',
                                                                              'การเช่า>>${expTypeModels[Ser_Sub].bills}(ลบ ${expModels[index].expname})');
                                                                          setState(
                                                                              () {
                                                                            read_GC_Exp();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'X',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          color: SettingScreen_Color
                                                                              .Colors_Text2_,
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
                            width: (!Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width
                                : MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    // width: MediaQuery.of(context)
                                    //     .size
                                    //     .width,
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            '** กรุณากด Enterทุกครั้งที่มีการเปลี่ยนแปลงข้อมูล **',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.0,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                        Row(
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
                                                        _scrollControllers[
                                                                Ser_Sub]
                                                            .animateTo(
                                                          0,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve: Curves.easeOut,
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
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8)),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: const Text(
                                                            'Top',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10.0,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (_scrollControllers[
                                                              Ser_Sub]
                                                          .hasClients) {
                                                        final position =
                                                            _scrollControllers[
                                                                    Ser_Sub]
                                                                .position
                                                                .maxScrollExtent;

                                                        _scrollControllers[
                                                                Ser_Sub]
                                                            .animateTo(
                                                          position,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve: Curves.easeOut,
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
                                                          'Down',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.0,
                                                            fontFamily:
                                                                Font_.Fonts_T,
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
                                                    onTap: () {
                                                      _scrollControllers[
                                                              Ser_Sub]
                                                          .animateTo(
                                                              _scrollControllers[
                                                                          Ser_Sub]
                                                                      .offset -
                                                                  220,
                                                              curve:
                                                                  Curves.linear,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500));
                                                    },
                                                    child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
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
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(6),
                                                            topRight:
                                                                Radius.circular(
                                                                    6),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    6),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    6)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: const Text(
                                                        'Scroll',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      )),
                                                  InkWell(
                                                    onTap: () {
                                                      _scrollControllers[
                                                              Ser_Sub]
                                                          .animateTo(
                                                              _scrollControllers[
                                                                          Ser_Sub]
                                                                      .offset +
                                                                  220,
                                                              curve:
                                                                  Curves.linear,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500));
                                                    },
                                                    child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_downward,
                                                            color: Colors.grey,
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ],
                    ),
                  )

///////////----------------------------------------------------->( 5.ค่าบริการอื่นๆ )
                : Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${Ser_Sub + 1}.${expTypeModels[Ser_Sub].bills}',
                                maxLines: 1,
                                style: const TextStyle(
                                  color: SettingScreen_Color.Colors_Text1_,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String? ren =
                                      preferences.getString('renTalSer');
                                  String? ser_user =
                                      preferences.getString('ser');
                                  var vser = expTypeModels[Ser_Sub].ser;
                                  String url =
                                      '${MyConstant().domain}/InC_exp.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user';

                                  try {
                                    var response =
                                        await http.get(Uri.parse(url));

                                    var result = json.decode(response.body);
                                    print(result);
                                    if (result.toString() == 'true') {
                                      Insert_log.Insert_logs('ตั้งค่า',
                                          'การเช่า>>เพิ่ม${expTypeModels[Ser_Sub].bills}');
                                      setState(() {
                                        read_GC_Exp();
                                      });
                                    } else {}
                                  } catch (e) {}
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    '+ เพิ่ม',
                                    style: TextStyle(
                                      color: SettingScreen_Color.Colors_Text3_,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                  width: (!Responsive.isDesktop(context))
                                      ? 800
                                      : MediaQuery.of(context).size.width *
                                          0.85,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(0),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  '',
                                                  // 'ค่าใช้จ่ายที่ต้องการปรับ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(0),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ค่า DEFEAULT',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
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
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  '',
                                                  // 'ลบ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
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
                                            flex: 4,
                                            child: Container(
                                              height: 50,
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ค่าใช้จ่ายที่ต้องการปรับ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
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
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'จำนวนวันช้ากว่ากำหนด',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
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
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'วิธีการคำนวน %',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
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
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'วิธีการคำนวน บาท',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
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
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ลบ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 200,
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
                                          controller:
                                              _scrollControllers[Ser_Sub],
                                          // controller: _scrollController5,
                                          // itemExtent: 50,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: expModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return expTypeModels[Ser_Sub].ser !=
                                                    expModels[index].exptser
                                                ? const SizedBox()
                                                : Material(
                                                    color: tappedIndex_[
                                                                Ser_Sub] ==
                                                            index.toString()
                                                        ? tappedIndex_Color
                                                            .tappedIndex_Colors
                                                        : AppbackgroundColor
                                                            .Sub_Abg_Colors,
                                                    child: Container(
                                                      // color:
                                                      //     tappedIndex_[Ser_Sub] ==
                                                      //             index.toString()
                                                      //         ? Colors
                                                      //             .grey.shade300
                                                      //         : null,
                                                      child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            tappedIndex_[
                                                                    Ser_Sub] =
                                                                index
                                                                    .toString();
                                                          });
                                                        },
                                                        title: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 4,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextFormField(
                                                                  initialValue:
                                                                      expModels[
                                                                              index]
                                                                          .expname,
                                                                  onFieldSubmitted:
                                                                      (value) async {
                                                                    SharedPreferences
                                                                        preferences =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String?
                                                                        ren =
                                                                        preferences
                                                                            .getString('renTalSer');
                                                                    String?
                                                                        ser_user =
                                                                        preferences
                                                                            .getString('ser');
                                                                    var vser =
                                                                        expModels[index]
                                                                            .ser;
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_exp_name.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        setState(
                                                                            () {
                                                                          read_GC_Exp();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                  },
                                                                  // maxLength: 13,
                                                                  cursorColor:
                                                                      Colors
                                                                          .green,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.05),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.key, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText: 'PASSWOED',
                                                                    labelStyle: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
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
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextFormField(
                                                                  initialValue:
                                                                      expModels[
                                                                              index]
                                                                          .sday,
                                                                  onFieldSubmitted:
                                                                      (value) async {
                                                                    SharedPreferences
                                                                        preferences =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String?
                                                                        ren =
                                                                        preferences
                                                                            .getString('renTalSer');
                                                                    String?
                                                                        ser_user =
                                                                        preferences
                                                                            .getString('ser');
                                                                    var vser =
                                                                        expModels[index]
                                                                            .ser;
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_exp_date_p.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        setState(
                                                                            () {
                                                                          read_GC_Exp();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                  },
                                                                  // maxLength: 13,
                                                                  cursorColor:
                                                                      Colors
                                                                          .green,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.05),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.key, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText: 'PASSWOED',
                                                                    labelStyle: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            r'[0-9]')),
                                                                    // FilteringTextInputFormatter.digitsOnly
                                                                  ],
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
                                                                    TextFormField(
                                                                  initialValue:
                                                                      expModels[
                                                                              index]
                                                                          .fine_cal,
                                                                  onFieldSubmitted:
                                                                      (value) async {
                                                                    SharedPreferences
                                                                        preferences =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String?
                                                                        ren =
                                                                        preferences
                                                                            .getString('renTalSer');
                                                                    String?
                                                                        ser_user =
                                                                        preferences
                                                                            .getString('ser');
                                                                    var vser =
                                                                        expModels[index]
                                                                            .ser;
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_exp_fine_late.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        setState(
                                                                            () {
                                                                          read_GC_Exp();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                  },
                                                                  // maxLength: 13,
                                                                  cursorColor:
                                                                      Colors
                                                                          .green,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.05),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.key, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText: 'PASSWOED',
                                                                    labelStyle: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            r'[0-9 .]')),
                                                                    // FilteringTextInputFormatter.digitsOnly
                                                                  ],
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
                                                                    TextFormField(
                                                                  initialValue:
                                                                      expModels[
                                                                              index]
                                                                          .fine_pri,
                                                                  onFieldSubmitted:
                                                                      (value) async {
                                                                    SharedPreferences
                                                                        preferences =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String?
                                                                        ren =
                                                                        preferences
                                                                            .getString('renTalSer');
                                                                    String?
                                                                        ser_user =
                                                                        preferences
                                                                            .getString('ser');
                                                                    var vser =
                                                                        expModels[index]
                                                                            .ser;
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_exp_fine_pri.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        setState(
                                                                            () {
                                                                          read_GC_Exp();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                  },
                                                                  // maxLength: 13,
                                                                  cursorColor:
                                                                      Colors
                                                                          .green,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.05),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.key, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText: 'PASSWOED',
                                                                    labelStyle: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            r'[0-9 .]')),
                                                                    // FilteringTextInputFormatter.digitsOnly
                                                                  ],
                                                                ),
                                                              ),
                                                              //  Text(
                                                              //   '5%',
                                                              //   maxLines: 2,
                                                              //   textAlign:
                                                              //       TextAlign
                                                              //           .center,
                                                              //   style: TextStyle(
                                                              //     color: SettingScreen_Color
                                                              //         .Colors_Text2_,
                                                              //     fontFamily: Font_
                                                              //         .Fonts_T,
                                                              //     //fontWeight: FontWeight.bold,
                                                              //     //fontSize: 10.0
                                                              //   ),
                                                              // ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    // color: Colors
                                                                    //     .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
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
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      SharedPreferences
                                                                          preferences =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String?
                                                                          ren =
                                                                          preferences
                                                                              .getString('renTalSer');
                                                                      String?
                                                                          ser_user =
                                                                          preferences
                                                                              .getString('ser');
                                                                      var vser =
                                                                          expModels[index]
                                                                              .ser;
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/DeC_exp.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          Insert_log.Insert_logs(
                                                                              'ตั้งค่า',
                                                                              'การเช่า>>${expTypeModels[Ser_Sub].bills}(ลบ ${expModels[index].expname})');
                                                                          setState(
                                                                              () {
                                                                            read_GC_Exp();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'X',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: SettingScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,
                                                                        //fontWeight: FontWeight.bold,
                                                                        //fontSize: 10.0
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
                            width: (!Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width
                                : MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '** กรุณากด Enterทุกครั้งที่มีการเปลี่ยนแปลงข้อมูล **',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.0,
                                        fontFamily: FontWeight_.Fonts_T),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                _scrollControllers[Ser_Sub]
                                                    .animateTo(
                                                  0,
                                                  duration: const Duration(
                                                      seconds: 1),
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
                                                                Radius.circular(
                                                                    6),
                                                            topRight:
                                                                Radius.circular(
                                                                    6),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    6),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
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
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (_scrollControllers[Ser_Sub]
                                                  .hasClients) {
                                                final position =
                                                    _scrollControllers[Ser_Sub]
                                                        .position
                                                        .maxScrollExtent;

                                                _scrollControllers[Ser_Sub]
                                                    .animateTo(
                                                  position,
                                                  duration: const Duration(
                                                      seconds: 1),
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
                                                              Radius.circular(
                                                                  6),
                                                          topRight:
                                                              Radius.circular(
                                                                  6),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  6),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  6)),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: const Text(
                                                  'Down',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10.0,
                                                    fontFamily: Font_.Fonts_T,
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
                                            onTap: () {
                                              _scrollControllers[Ser_Sub]
                                                  .animateTo(
                                                      _scrollControllers[
                                                                  Ser_Sub]
                                                              .offset -
                                                          220,
                                                      curve: Curves.linear,
                                                      duration: const Duration(
                                                          milliseconds: 500));
                                            },
                                            child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Text(
                                                'Scroll',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0,
                                                  fontFamily: Font_.Fonts_T,
                                                ),
                                              )),
                                          InkWell(
                                            onTap: () {
                                              _scrollControllers[Ser_Sub]
                                                  .animateTo(
                                                      _scrollControllers[
                                                                  Ser_Sub]
                                                              .offset +
                                                          220,
                                                      curve: Curves.linear,
                                                      duration: const Duration(
                                                          milliseconds: 500));
                                            },
                                            child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
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
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

/////////////------------------------------------------->(ระยะเวลาการเช่ามาตราฐาน)
          // const SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   children: const [
          //     Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Text(
          //         'ระยะเวลาการเช่ามาตราฐาน',
          //         style: TextStyle(
          //           color: SettingScreen_Color.Colors_Text1_,
          //           fontFamily: FontWeight_.Fonts_T,
          //           fontWeight: FontWeight.bold,
          //           //fontSize: 10.0
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          // Row(
          //   children: const [
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Text(
          //         '12 งวด',
          //         style: TextStyle(
          //           color: SettingScreen_Color.Colors_Text1_,
          //           fontFamily: FontWeight_.Fonts_T,
          //           fontWeight: FontWeight.bold,
          //           //fontSize: 10.0
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          const SizedBox(
            height: 100,
          ),
        ]));
  }
}
