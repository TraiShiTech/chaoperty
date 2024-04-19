// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_string_interpolations, prefer_collection_literals, sort_child_properties_last, avoid_unnecessary_containers, prefer_is_empty, prefer_final_fields, camel_case_types, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, deprecated_member_use
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class AdvanceSetting extends StatefulWidget {
  const AdvanceSetting({super.key});

  @override
  State<AdvanceSetting> createState() => _AdvanceSettingState();
}

class _AdvanceSettingState extends State<AdvanceSetting> {
  List<ZoneModel> zoneModels = [];
  @override
  void initState() {
    super.initState();

    read_GC_zone();
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
      // Map<String, dynamic> map = Map();
      // map['ser'] = '0';
      // map['rser'] = '0';
      // map['zn'] = 'ทั้งหมด';
      // map['qty'] = '0';
      // map['img'] = '0';
      // map['data_update'] = '0';

      // ZoneModel zoneModelx = ZoneModel.fromJson(map);

      // setState(() {
      //   zoneModels.add(zoneModelx);
      // });

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
      // zoneModels.sort((a, b) => a.number_zn!.compareTo(b.number_zn!));
      zoneModels.sort((a, b) {
        return int.parse(a.number_zn!).compareTo(int.parse(b.number_zn!));
      });
    } catch (e) {}
  }

  /////////---------------------------------------------------->
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

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Container(
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'ตั้งค่าแบบพิเศษ',
                maxLines: 1,
                style: TextStyle(
                  color: SettingScreen_Color.Colors_Text1_,
                  fontFamily: FontWeight_.Fonts_T,
                  fontWeight: FontWeight.bold,
                  //fontSize: 10.0
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ScrollConfiguration(
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
                      width: (!Responsive.isDesktop(context))
                          ? 1000
                          : MediaQuery.of(context).size.width * 0.82,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration:  BoxDecoration(
                              color: AppbackgroundColor.TiTile_Colors,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120,
                                  child: Text('ลำดับ',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          // fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('โซน',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          // fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('ประเภทโซน',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          //fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('บ.1',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          // fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('บ.2',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          //fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('บ.3',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          //fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('บ.4',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          //fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('ที่เหลือแบ่งเข้า',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          //fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder(
                              stream:
                                  Stream.periodic(const Duration(seconds: 0)),
                              builder: (context, snapshot) {
                                return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.54,
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
                                    child: ListView.builder(
                                        controller: _scrollController1,
                                        // itemExtent: 50,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: zoneModels.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String dropdownValue =
                                              zoneModels[index]
                                                  .number_zn
                                                  .toString();
                                          return Container(
                                            // height: 50,
                                            // decoration: const BoxDecoration(
                                            //   color: AppbackgroundColor
                                            //       .TiTile_Colors,
                                            //   borderRadius: BorderRadius.only(
                                            //       topLeft: Radius.circular(10),
                                            //       topRight: Radius.circular(10),
                                            //       bottomLeft:
                                            //           Radius.circular(0),
                                            //       bottomRight:
                                            //           Radius.circular(0)),
                                            // ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 120,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                    isExpanded: true,
                                                    hint: Text(
                                                      zoneModels[index]
                                                          .number_zn!,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black45,
                                                    ),
                                                    iconSize: 30,
                                                    buttonHeight: 60,
                                                    buttonPadding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    items: [
                                                      for (int i = 0;
                                                          i <
                                                              zoneModels
                                                                      .length +
                                                                  1;
                                                          i++)
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: '${i}',
                                                          child: Text(
                                                            i.toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: (zoneModels[index]
                                                                            .number_zn! ==
                                                                        '$i')
                                                                    ? Colors
                                                                        .green
                                                                    : PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        )
                                                    ],
                                                    onChanged: (value) async {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String? ren =
                                                          preferences.getString(
                                                              'renTalSer');
                                                      String? ser_user =
                                                          preferences
                                                              .getString('ser');

                                                      String url =
                                                          '${MyConstant().domain}/UP_Adv_Setting_numberzone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&numberzn=${value}';

                                                      try {
                                                        var response =
                                                            await http.get(
                                                                Uri.parse(url));

                                                        var result =
                                                            json.decode(
                                                                response.body);
                                                        print(result);
                                                        if (result.toString() ==
                                                            'true') {
                                                          Insert_log.Insert_logs(
                                                              'ตั้งค่า',
                                                              'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> ลำดับโซน >> $value');
                                                          setState(() {
                                                            read_GC_zone();
                                                          });
                                                        } else {}
                                                      } catch (e) {}
                                                    },
                                                    onSaved: (value) {
                                                      // selectedValue = value.toString();
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        '${zoneModels[index].zn.toString()}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: const TextStyle(
                                                            // fontSize: 15,
                                                            color: SettingScreen_Color
                                                                .Colors_Text2_,
                                                            fontFamily:
                                                                Font_.Fonts_T
                                                            // fontWeight: FontWeight.bold,
                                                            )),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                    isExpanded: true,
                                                    hint: Text(
                                                      (zoneModels[index].jon! ==
                                                              '1')
                                                          ? 'จรประจำ'
                                                          : 'ปกติ',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black45,
                                                    ),
                                                    iconSize: 30,
                                                    buttonHeight: 60,
                                                    buttonPadding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    items: [
                                                      DropdownMenuItem<String>(
                                                        value: '0',
                                                        child: Text(
                                                          'ปกติ',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: (zoneModels[
                                                                              index]
                                                                          .jon! ==
                                                                      '0')
                                                                  ? Colors.green
                                                                  : PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      DropdownMenuItem<String>(
                                                        value: '1',
                                                        child: Text(
                                                          'จรประจำ',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: (zoneModels[
                                                                              index]
                                                                          .jon! ==
                                                                      '1')
                                                                  ? Colors.green
                                                                  : PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                    onChanged: (value) async {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String? ren =
                                                          preferences.getString(
                                                              'renTalSer');
                                                      String? ser_user =
                                                          preferences
                                                              .getString('ser');

                                                      String url1 = (value! ==
                                                              '1')
                                                          ? '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${value}&valueB1=${zoneModels[index].b_1}&valueB2=${zoneModels[index].b_2}&valueB3=${0}&valueB4=${zoneModels[index].b_4}'
                                                          : '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${value}&valueB1=${zoneModels[index].b_1}&valueB2=${zoneModels[index].b_2}&valueB3=${zoneModels[index].b_3}&valueB4=${zoneModels[index].b_4}';

                                                      try {
                                                        var response =
                                                            await http.get(
                                                                Uri.parse(
                                                                    url1));

                                                        var result =
                                                            json.decode(
                                                                response.body);
                                                        print(result);
                                                        if (result.toString() ==
                                                            'true') {
                                                          // setState(() {
                                                          //   read_GC_zone();
                                                          // });
                                                        } else {}
                                                      } catch (e) {}
                                                      ///////////////////////////-------->
                                                      String url2 = (value ==
                                                              '0')
                                                          ? '${MyConstant().domain}/UP_Adv_Setting_jonbookZone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&jonbook=${0}'
                                                          : '${MyConstant().domain}/UP_Adv_Setting_jonbookZone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&jonbook=${3}';

                                                      try {
                                                        var response =
                                                            await http.get(
                                                                Uri.parse(
                                                                    url2));

                                                        var result =
                                                            json.decode(
                                                                response.body);
                                                        print(result);
                                                        if (result.toString() ==
                                                            'true') {
                                                          setState(() {
                                                            read_GC_zone();
                                                          });
                                                        } else {}
                                                      } catch (e) {}
                                                    },
                                                    onSaved: (value) {
                                                      // selectedValue = value.toString();
                                                    },
                                                  ),

                                                  // Row(
                                                  //   children: [
                                                  //     Text('ปกติ',
                                                  //         textAlign:
                                                  //             TextAlign.center,
                                                  //         maxLines: 2,
                                                  //         overflow: TextOverflow
                                                  //             .ellipsis,
                                                  //         softWrap: false,
                                                  //         style: TextStyle(
                                                  //             // fontSize: 15,
                                                  //             // fontSize: 15,
                                                  //             color: SettingScreen_Color
                                                  //                 .Colors_Text2_,
                                                  //             fontFamily:
                                                  //                 Font_.Fonts_T
                                                  //             // fontWeight: FontWeight.bold,
                                                  //             )),
                                                  //     InkWell(
                                                  // onTap: () async {
                                                  //   String? value_jon_;
                                                  //   setState(() {
                                                  //     if (zoneModels[index]
                                                  //             .jon! ==
                                                  //         '1') {
                                                  //       value_jon_ = '0';
                                                  //     } else {
                                                  //       value_jon_ = '1';
                                                  //     }
                                                  //   });
                                                  //   SharedPreferences
                                                  //       preferences =
                                                  //       await SharedPreferences
                                                  //           .getInstance();
                                                  //   String? ren = preferences
                                                  //       .getString(
                                                  //           'renTalSer');
                                                  //   String? ser_user =
                                                  //       preferences
                                                  //           .getString(
                                                  //               'ser');

                                                  //   String url =
                                                  //       '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=$value_jon_&valueB1=${zoneModels[index].b_1}&valueB2=${zoneModels[index].b_2}&valueB3=${zoneModels[index].b_3}&valueB4=${zoneModels[index].b_4}';

                                                  //   try {
                                                  //     var response =
                                                  //         await http.get(
                                                  //             Uri.parse(
                                                  //                 url));

                                                  //     var result = json
                                                  //         .decode(response
                                                  //             .body);
                                                  //     print(result);
                                                  //     if (result
                                                  //             .toString() ==
                                                  //         'true') {
                                                  //       if (value_jon_ ==
                                                  //           '1') {
                                                  //         Insert_log
                                                  //             .Insert_logs(
                                                  //                 'ตั้งค่า',
                                                  //                 'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> (จร)');
                                                  //       } else {
                                                  //         Insert_log
                                                  //             .Insert_logs(
                                                  //                 'ตั้งค่า',
                                                  //                 'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> (ปกติ)');
                                                  //       }

                                                  //       setState(() {
                                                  //         read_GC_zone();
                                                  //       });
                                                  //     } else {}
                                                  //   } catch (e) {}
                                                  // },
                                                  //         child: zoneModels[
                                                  //                         index]
                                                  //                     .jon! ==
                                                  //                 '1'
                                                  //             ? const Icon(
                                                  //                 Icons
                                                  //                     .toggle_on,
                                                  //                 color: Colors
                                                  //                     .green,
                                                  //                 size: 50.0,
                                                  //               )
                                                  //             : const Icon(
                                                  //                 Icons
                                                  //                     .toggle_off,
                                                  //                 size: 50.0,
                                                  //               )),
                                                  //     Text('จรประจำ',
                                                  //         textAlign:
                                                  //             TextAlign.center,
                                                  //         maxLines: 2,
                                                  //         overflow: TextOverflow
                                                  //             .ellipsis,
                                                  //         softWrap: false,
                                                  //         style: TextStyle(
                                                  //             // fontSize: 15,
                                                  //             color: (zoneModels[
                                                  //                             index]
                                                  //                         .jon! ==
                                                  //                     '1')
                                                  //                 ? Colors.green
                                                  //                 : SettingScreen_Color
                                                  //                     .Colors_Text2_,
                                                  //             fontFamily:
                                                  //                 Font_.Fonts_T
                                                  //             // fontWeight: FontWeight.bold,
                                                  //             )),
                                                  //   ],
                                                  // ),
                                                ),
                                                (zoneModels[index].jon! ==
                                                            '1' &&
                                                        zoneModels[index]
                                                                .jon_book! ==
                                                            '1')
                                                    ? Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
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
                                                          ),
                                                        ))
                                                    : Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            // width: 200,
                                                            child:
                                                                TextFormField(
                                                              textAlign:
                                                                  TextAlign.end,
                                                              // controller:
                                                              //     Add_Number_area_,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                }
                                                                // if (int.parse(value.toString()) < 13) {
                                                                //   return '< 13';
                                                                // }
                                                                return null;
                                                              },
                                                              initialValue:
                                                                  zoneModels[
                                                                          index]
                                                                      .b_1,
                                                              onFieldSubmitted:
                                                                  (value) async {
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

                                                                String url =
                                                                    '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${zoneModels[index].jon}&valueB1=$value&valueB2=${zoneModels[index].b_2}&valueB3=${zoneModels[index].b_3}&valueB4=${zoneModels[index].b_4}';

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
                                                                          .toString() ==
                                                                      'true') {
                                                                    Insert_log.Insert_logs(
                                                                        'ตั้งค่า',
                                                                        'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> Acc1 >> $value');
                                                                    setState(
                                                                        () {
                                                                      read_GC_zone();
                                                                    });
                                                                  } else {}
                                                                } catch (e) {}
                                                              },
                                                              // maxLength: 4,
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
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder:
                                                                          const OutlineInputBorder(
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
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
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
                                                                      // labelText:
                                                                      //     'เลขเรื่มต้น 1-xxx',
                                                                      labelStyle:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      )),
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .deny(RegExp(
                                                                        r'\s')),
                                                                // FilteringTextInputFormatter
                                                                //     .deny(RegExp(
                                                                //         r'^0')),
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'[0-9 .]')),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                (zoneModels[index].jon! ==
                                                            '1' &&
                                                        zoneModels[index]
                                                                .jon_book! ==
                                                            '2')
                                                    ? Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
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
                                                          ),
                                                        ))
                                                    : Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            // width: 200,
                                                            child:
                                                                TextFormField(
                                                              textAlign:
                                                                  TextAlign.end,
                                                              // controller:
                                                              //     Add_Number_area_,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                }
                                                                // if (int.parse(value.toString()) < 13) {
                                                                //   return '< 13';
                                                                // }
                                                                return null;
                                                              },
                                                              initialValue:
                                                                  zoneModels[
                                                                          index]
                                                                      .b_2,
                                                              onFieldSubmitted:
                                                                  (value) async {
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

                                                                String url =
                                                                    '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${zoneModels[index].jon}&valueB1=${zoneModels[index].b_1}&valueB2=$value&valueB3=${zoneModels[index].b_3}&valueB4=${zoneModels[index].b_4}';

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
                                                                          .toString() ==
                                                                      'true') {
                                                                    Insert_log.Insert_logs(
                                                                        'ตั้งค่า',
                                                                        'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> Acc2 >> $value ');
                                                                    setState(
                                                                        () {
                                                                      read_GC_zone();
                                                                    });
                                                                  } else {}
                                                                } catch (e) {}
                                                              },
                                                              // maxLength: 4,
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
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder:
                                                                          const OutlineInputBorder(
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
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
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
                                                                      // labelText:
                                                                      //     'เลขเรื่มต้น 1-xxx',
                                                                      labelStyle:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      )),
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .deny(RegExp(
                                                                        r'\s')),
                                                                // FilteringTextInputFormatter
                                                                //     .deny(RegExp(
                                                                //         r'^0')),
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'[0-9 .]')),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                (zoneModels[index].jon! ==
                                                            '1' &&
                                                        zoneModels[index]
                                                                .jon_book! ==
                                                            '3')
                                                    ? Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
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
                                                          ),
                                                        ))
                                                    : Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            // width: 200,
                                                            child:
                                                                TextFormField(
                                                              textAlign:
                                                                  TextAlign.end,
                                                              // controller:
                                                              //     Add_Number_area_,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                }
                                                                // if (int.parse(value.toString()) < 13) {
                                                                //   return '< 13';
                                                                // }
                                                                return null;
                                                              },
                                                              initialValue:
                                                                  zoneModels[
                                                                          index]
                                                                      .b_3,
                                                              onFieldSubmitted:
                                                                  (value) async {
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

                                                                String url =
                                                                    '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${zoneModels[index].jon}&valueB1=${zoneModels[index].b_1}&valueB2=${zoneModels[index].b_2}&valueB3=$value&valueB4=${zoneModels[index].b_4}';

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
                                                                          .toString() ==
                                                                      'true') {
                                                                    Insert_log.Insert_logs(
                                                                        'ตั้งค่า',
                                                                        'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> Acc3 >> $value');
                                                                    setState(
                                                                        () {
                                                                      read_GC_zone();
                                                                    });
                                                                  } else {}
                                                                } catch (e) {}
                                                              },
                                                              // maxLength: 4,
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
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder:
                                                                          const OutlineInputBorder(
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
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
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
                                                                      // labelText:
                                                                      //     'เลขเรื่มต้น 1-xxx',
                                                                      labelStyle:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      )),
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .deny(RegExp(
                                                                        r'\s')),
                                                                // FilteringTextInputFormatter
                                                                //     .deny(RegExp(
                                                                //         r'^0')),
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'[0-9 .]')),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                (zoneModels[index].jon! ==
                                                            '1' &&
                                                        zoneModels[index]
                                                                .jon_book! ==
                                                            '4')
                                                    ? Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
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
                                                          ),
                                                        ))
                                                    : Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            // width: 200,
                                                            child:
                                                                TextFormField(
                                                              textAlign:
                                                                  TextAlign.end,
                                                              // controller:
                                                              //     Add_Number_area_,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                }
                                                                // if (int.parse(value.toString()) < 13) {
                                                                //   return '< 13';
                                                                // }
                                                                return null;
                                                              },
                                                              initialValue:
                                                                  zoneModels[
                                                                          index]
                                                                      .b_4,
                                                              onFieldSubmitted:
                                                                  (value) async {
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

                                                                String url =
                                                                    '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${zoneModels[index].jon}&valueB1=${zoneModels[index].b_1}&valueB2=${zoneModels[index].b_2}&valueB3=${zoneModels[index].b_3}&valueB4=$value';

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
                                                                          .toString() ==
                                                                      'true') {
                                                                    Insert_log.Insert_logs(
                                                                        'ตั้งค่า',
                                                                        'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> Acc4 >> $value');
                                                                    setState(
                                                                        () {
                                                                      read_GC_zone();
                                                                    });
                                                                  } else {}
                                                                } catch (e) {}
                                                              },
                                                              // maxLength: 4,
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
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder:
                                                                          const OutlineInputBorder(
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
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
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
                                                                      // labelText:
                                                                      //     'เลขเรื่มต้น 1-xxx',
                                                                      labelStyle:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      )),
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .deny(RegExp(
                                                                        r'\s')),
                                                                // FilteringTextInputFormatter
                                                                //     .deny(RegExp(
                                                                //         r'^0')),
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'[0-9 .]')),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                (zoneModels[index].jon! != '1')
                                                    ? Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
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
                                                          ),
                                                        ))
                                                    : Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              DropdownButtonFormField2(
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                            ),
                                                            isExpanded: true,
                                                            hint: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                'บ.${zoneModels[index].jon_book!}',
                                                                style: const TextStyle(
                                                                    fontSize: 14,
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                            icon: const Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                            iconSize: 30,
                                                            buttonHeight: 60,
                                                            buttonPadding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10),
                                                            dropdownDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            items: [
                                                              for (int i = 1;
                                                                  i < 5;
                                                                  i++)
                                                                // if (i != 2)
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: '${i}',
                                                                  child: Text(
                                                                    'บ.${i}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: (zoneModels[index].jon_book! ==
                                                                                '$i')
                                                                            ? Colors
                                                                                .green
                                                                            : PeopleChaoScreen_Color
                                                                                .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                )
                                                            ],
                                                            onChanged:
                                                                (value) async {
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

                                                              //////////////////------------------------>
                                                              String url1 = (value! ==
                                                                      '1')
                                                                  ? '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${zoneModels[index].jon}&valueB1=0&valueB2=${zoneModels[index].b_2}&valueB3=${zoneModels[index].b_3}&valueB4=${zoneModels[index].b_4}'
                                                                  : (value ==
                                                                          '2')
                                                                      ? '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${zoneModels[index].jon}&valueB1=${zoneModels[index].b_1}&valueB2=0&valueB3=${zoneModels[index].b_3}&valueB4=${zoneModels[index].b_4}'
                                                                      : (value ==
                                                                              '3')
                                                                          ? '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${zoneModels[index].jon}&valueB1=${zoneModels[index].b_1}&valueB2=${zoneModels[index].b_2}&valueB3=0&valueB4=${zoneModels[index].b_4}'
                                                                          : '${MyConstant().domain}/UP_Adv_Setting_C_zone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&valuejon=${zoneModels[index].jon}&valueB1=${zoneModels[index].b_1}&valueB2=${zoneModels[index].b_2}&valueB3=${zoneModels[index].b_3}&valueB4=0';

                                                              try {
                                                                var response =
                                                                    await http.get(
                                                                        Uri.parse(
                                                                            url1));

                                                                var result =
                                                                    json.decode(
                                                                        response
                                                                            .body);
                                                                print(result);
                                                                if (result
                                                                        .toString() ==
                                                                    'true') {
                                                                  Insert_log.Insert_logs(
                                                                      'ตั้งค่า',
                                                                      'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> Acc$value >> 0.00');

                                                                  // setState(() {
                                                                  //   read_GC_zone();
                                                                  // });
                                                                } else {}
                                                              } catch (e) {}
                                                              ///////////////////////////-------->
                                                              String url2 =
                                                                  '${MyConstant().domain}/UP_Adv_Setting_jonbookZone_Cm.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&jonbook=${value}';

                                                              try {
                                                                var response =
                                                                    await http.get(
                                                                        Uri.parse(
                                                                            url2));

                                                                var result =
                                                                    json.decode(
                                                                        response
                                                                            .body);
                                                                print(result);
                                                                if (result
                                                                        .toString() ==
                                                                    'true') {
                                                                  Insert_log.Insert_logs(
                                                                      'ตั้งค่า',
                                                                      'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> ที่เหลื่อเข้า >> บ.$value');
                                                                  setState(() {
                                                                    read_GC_zone();
                                                                  });
                                                                } else {}
                                                              } catch (e) {}
                                                            },
                                                            onSaved: (value) {
                                                              // selectedValue = value.toString();
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          );
                                        }));
                              }),
                          Container(
                              width: (!Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width
                                  : MediaQuery.of(context).size.width * 0.84,
                              decoration: const BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                // border: Border(
                                //   bottom: BorderSide(color: Colors.black),
                                // ),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  _scrollController1.animateTo(
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
                                                                          8)),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: const Text(
                                                      'Top',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                  _scrollController1.animateTo(
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
                                                        fontFamily:
                                                            Font_.Fonts_T),
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
                                                  'Scroll',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10.0,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                )),
                                            InkWell(
                                              onTap: _moveDown1,
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
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
