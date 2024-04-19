import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/GetVat_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class EditZoneAmt extends StatefulWidget {
  const EditZoneAmt({super.key});

  @override
  State<EditZoneAmt> createState() => _EditZoneAmtState();
}

class _EditZoneAmtState extends State<EditZoneAmt> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  final price_text = TextEditingController();
  List<ZoneModel> zoneModels = [];
  List<ExpModel> expModels = [];
  List<TransModel> _TransModels = [];
  List<VatModel> vatModels = [];
  String? ser_Zonex, ser_exp, vat_Ser;
  int renTal_lavel = 0;
  String tappedIndex_ = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_GC_zone();
    read_GC_vat();
  }

  Future<Null> read_GC_vat() async {
    if (vatModels.isNotEmpty) {
      vatModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_vat.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          VatModel vatModel = VatModel.fromJson(map);
          setState(() {
            vatModels.add(vatModel);
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

    String url = '${MyConstant().domain}/GC_exp.php?isAdd=true&ren=$ren&serx=1';

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

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
    } catch (e) {}

    setState(() {
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
    });
  }

  Future<Null> read_GC_Exp_trans() async {
    if (_TransModels.isNotEmpty) {
      _TransModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/read_GC_Exp_trans.php?isAdd=true&ren=$ren&serexp=$ser_exp&serzn=$ser_Zonex';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TransModel transModel = TransModel.fromJson(map);

          setState(() {
            _TransModels.add(transModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
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
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ScrollConfiguration(
                    behavior:
                        ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'โซน :',
                                  style: const TextStyle(
                                    color: SettingScreen_Color.Colors_Text2_,
                                    fontFamily: FontWeight_.Fonts_T,
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 10.0
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  width: 260,
                                  padding: const EdgeInsets.all(2.0),
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
                                        borderSide:
                                            const BorderSide(color: Colors.red),
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
                                          color: Color.fromARGB(
                                              255, 231, 227, 227),
                                        ),
                                      ),
                                    ),
                                    isExpanded: false,

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
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    items: zoneModels
                                        .map((item) => DropdownMenuItem<String>(
                                              value: '${item.zn}',
                                              child: Text(
                                                '${item.zn}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ))
                                        .toList(),

                                    onChanged: (value) async {
                                      int selectedIndex = zoneModels.indexWhere(
                                          (item) => item.zn == value);

                                      setState(() {
                                        ser_Zonex = zoneModels[selectedIndex]
                                            .ser
                                            .toString();
                                        ser_exp = null;
                                        read_GC_Exp();
                                      });
                                    },
                                  ),
                                ),
                              ),
                              expModels.length == 0
                                  ? SizedBox()
                                  : Container(
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'ค่าบริการ :',
                                              style: const TextStyle(
                                                color: SettingScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: FontWeight_.Fonts_T,
                                                fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                                // border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              width: 260,
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: DropdownButtonFormField2(
                                                alignment: Alignment.center,
                                                focusColor: Colors.white,
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                  enabled: true,
                                                  hoverColor: Colors.brown,
                                                  prefixIconColor: Colors.blue,
                                                  fillColor: Colors.white
                                                      .withOpacity(0.05),
                                                  filled: false,
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 231, 227, 227),
                                                    ),
                                                  ),
                                                ),
                                                isExpanded: false,

                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                                iconSize: 20,
                                                buttonHeight: 40,
                                                buttonWidth: 280,
                                                // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  // color: Colors
                                                  //     .amber,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                ),
                                                items: expModels
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value:
                                                              '${item.expname}',
                                                          child: Text(
                                                            '${item.expname}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),

                                                onChanged: (value) async {
                                                  int selectedIndex = expModels
                                                      .indexWhere((item) =>
                                                          item.expname ==
                                                          value);

                                                  setState(() {
                                                    ser_exp =
                                                        expModels[selectedIndex]
                                                            .ser
                                                            .toString();
                                                    price_text.clear();
                                                    read_GC_Exp_trans();
                                                  });
                                                  print(ser_exp);
                                                },
                                              ),
                                            ),
                                          ),
                                          // for (int index = 0;
                                          //     index < expModels.length;
                                          //     index++)
                                          //   Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(4.0),
                                          //       child: InkWell(
                                          //         onTap: () async {
                                          //           setState(() {
                                          //             ser_exp = expModels[index]
                                          //                 .ser
                                          //                 .toString();
                                          //             price_text.clear();
                                          //             read_GC_Exp_trans();
                                          //           });
                                          //           print(ser_exp);
                                          //         },
                                          //         child: Container(
                                          //           // width:
                                          //           //     MediaQuery.of(context).size.width,
                                          //           decoration: BoxDecoration(
                                          //               color: ser_exp ==
                                          //                       expModels[index]
                                          //                           .ser
                                          //                           .toString()
                                          //                   ? Colors
                                          //                       .blue.shade800
                                          //                   : Colors
                                          //                       .blue.shade200,
                                          //               borderRadius: const BorderRadius.only(
                                          //                   topLeft: Radius.circular(
                                          //                       10),
                                          //                   topRight: Radius.circular(
                                          //                       10),
                                          //                   bottomLeft: Radius.circular(
                                          //                       10),
                                          //                   bottomRight:
                                          //                       Radius.circular(
                                          //                           10)),
                                          //               border: Border.all(
                                          //                   color: Colors.white,
                                          //                   width: 1)),
                                          //           padding:
                                          //               const EdgeInsets.all(
                                          //                   8.0),
                                          //           child: Center(
                                          //             child: Text(
                                          //               expModels[index]
                                          //                   .expname
                                          //                   .toString(),
                                          //               style: TextStyle(
                                          //                   color: ser_exp ==
                                          //                           expModels[
                                          //                                   index]
                                          //                               .ser
                                          //                               .toString()
                                          //                       ? Colors.white
                                          //                       : Colors.black,
                                          //                   fontFamily:
                                          //                       FontWeight_
                                          //                           .Fonts_T),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       )),
                                        ],
                                      ),
                                    ),

                              // for (int index = 0;
                              //     index < zoneModels.length;
                              //     index++)
                              //   Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: InkWell(
                              //         onTap: () async {
                              //           setState(() {
                              //             ser_Zonex =
                              //                 zoneModels[index].ser.toString();
                              //             read_GC_Exp();
                              //           });
                              //         },
                              //         child: Container(
                              //           // width: 100,
                              //           decoration: BoxDecoration(
                              //             color: (ser_Zonex ==
                              //                     zoneModels[index]
                              //                         .ser
                              //                         .toString())
                              //                 ? Colors.black54
                              //                 : Colors.black26,
                              //             borderRadius: const BorderRadius.only(
                              //               topLeft: Radius.circular(10),
                              //               topRight: Radius.circular(10),
                              //               bottomLeft: Radius.circular(10),
                              //               bottomRight: Radius.circular(10),
                              //             ),
                              //             border: Border.all(
                              //                 color: Colors.white, width: 2),
                              //           ),
                              //           padding: const EdgeInsets.all(5.0),
                              //           child: Center(
                              //             child: AutoSizeText(
                              //               minFontSize: 10,
                              //               maxFontSize: 20,
                              //               '${zoneModels[index].zn.toString()}',
                              //               style: TextStyle(
                              //                 color: (ser_Zonex ==
                              //                         zoneModels[index]
                              //                             .ser
                              //                             .toString())
                              //                     ? Colors.white
                              //                     : Colors.grey[100],
                              //                 // fontWeight: FontWeight.bold,
                              //                 fontFamily: FontWeight_.Fonts_T,
                              //                 fontWeight: FontWeight.bold,
                              //               ),
                              //             ),
                              //           ),
                              //         ),

                              //       )),
                            ])),
                  ),
                ),
              ),
            ),

            Padding(
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
                        width: (!Responsive.isDesktop(context))
                            ? 800
                            : MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.78,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          // border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: expModels.length == 0
                            ? SizedBox(
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppbackgroundColor.TiTile_Colors
                                          .withOpacity(0.5),
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
                                    child: Text(
                                      'กรุณาเลือก โซนพื้นที่ !!!',
                                      style: const TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: FontWeight_.Fonts_T,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : (ser_exp == null)
                                ? SizedBox(
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppbackgroundColor
                                              .TiTile_Colors.withOpacity(0.5),
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
                                        child: Text(
                                          'กรุณาเลือก ค่าบริการ !!!',
                                          style: const TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontWeight: FontWeight.bold,
                                            //fontSize: 10.0
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        decoration:  BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'แก้ไขค่าบริการทั้งหมด',
                                                style: const TextStyle(
                                                  color: SettingScreen_Color
                                                      .Colors_Text2_,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontWeight: FontWeight.bold,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'แก้ไขค่าบริการ',
                                                  style: const TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 50,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: TextFormField(
                                                        // keyboardType: TextInputType.number,
                                                        controller: price_text,

                                                        // maxLength: 13,
                                                        cursorColor:
                                                            Colors.green,
                                                        decoration:
                                                            InputDecoration(
                                                                fillColor: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.5),
                                                                filled: true,
                                                                // prefixIcon:
                                                                //     const Icon(Icons.person_pin, color: Colors.black),
                                                                // suffixIcon: Icon(Icons.clear, color: Colors.black),
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
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
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
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                labelStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T,
                                                                )),
                                                        inputFormatters: <TextInputFormatter>[
                                                          // for below version 2 use this
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'[0-9]')),
                                                          // for version 2 and greater youcan also use this
                                                          // FilteringTextInputFormatter.digitsOnly
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius.only(
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
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child:
                                                          DropdownButtonFormField2(
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        hint: const Text(
                                                          'เลือก',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                        icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                          color: TextHome_Color
                                                              .TextHome_Colors,
                                                        ),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .green.shade900,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                        iconSize: 20,
                                                        buttonHeight: 50,
                                                        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                        dropdownDecoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        items: vatModels
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value:
                                                                      '${item.ser}:${item.vat}',
                                                                  child: Text(
                                                                    item.vat!,
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
                                                          var zones = value!
                                                              .indexOf(':');
                                                          var vatSer =
                                                              value.substring(
                                                                  0, zones);
                                                          var vatName =
                                                              value.substring(
                                                                  zones + 1);
                                                          print(
                                                              'mmmmm ${vatSer.toString()} $vatName');

                                                          setState(() {
                                                            vat_Ser = vatSer;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    var ppri = price_text.text;
                                                    var ser_v = vat_Ser == null
                                                        ? '1'
                                                        : vat_Ser;
                                                    //  print('$ppri $ser_v ');
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
                                                          'ยืนยันการแก้ไข ??',
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
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            100,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Colors.green,
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                        ),
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (renTal_lavel >
                                                                                2) {
                                                                              if (ppri != 'null') {
                                                                                var ser_v = vat_Ser == null ? '1' : vat_Ser;
                                                                                for (int index = 0; index < _TransModels.length; index++) {
                                                                                  var ser_trans = _TransModels[index].ser;
                                                                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                  String? ren = preferences.getString('renTalSer');
                                                                                  String? ser_user = preferences.getString('ser');
                                                                                  String url = '${MyConstant().domain}/UpC_transx_amt.php?isAdd=true&ren=$ren&ser_trans=$ser_trans&ser_v=$ser_v&conx_amt=$ppri';

                                                                                  try {
                                                                                    var response = await http.get(Uri.parse(url));

                                                                                    var result = json.decode(response.body);
                                                                                    print(result);
                                                                                    if (result.toString() == 'true') {
                                                                                      // setState(() {
                                                                                      //   read_GC_rownum();
                                                                                      // });
                                                                                    } else {}
                                                                                  } catch (e) {}
                                                                                  if (index + 1 == _TransModels.length) {
                                                                                    Navigator.pop(context, 'OK');
                                                                                  } else {}
                                                                                }
                                                                                setState(() {
                                                                                  price_text.clear();
                                                                                  read_GC_Exp_trans();
                                                                                });
                                                                              }
                                                                            } else {
                                                                              Navigator.pop(context, 'OK');
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(content: Text('User ของท่านไม่สามารถทำการแก้ไขได้ ')),
                                                                              );
                                                                            }
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'ยืนยัน',
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.redAccent,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () => Navigator.pop(context, 'OK'),
                                                                              child: const Text(
                                                                                'ยกเลิก',
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
                                                  child: Container(
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .green.shade800,
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
                                                            color: Colors.white,
                                                            width: 1)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: Text(
                                                        'บันทึก',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:  BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'เลขที่สัญญา',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ค่าบริการ',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'VAT %',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'VAT ฿',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ก่อน VAT',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'รวม',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView(
                                            padding: const EdgeInsets.all(8),
                                            children: <Widget>[
                                              _TransModels.isEmpty
                                                  ? Container(
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
                                                              if (!snapshot
                                                                  .hasData)
                                                                return const Text(
                                                                    '');
                                                              double elapsed =
                                                                  double.parse(snapshot
                                                                          .data
                                                                          .toString()) *
                                                                      0.05;
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: (elapsed >
                                                                        8.00)
                                                                    ? const Text(
                                                                        'ไม่พบข้อมูล',
                                                                        style: TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text2_,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      )
                                                                    : Text(
                                                                        'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                        // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text2_,
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
                                                  : SizedBox(),
                                              for (int index = 0;
                                                  index < _TransModels.length;
                                                  index++)
                                                Material(
                                                    color: tappedIndex_ ==
                                                            index.toString()
                                                        ? tappedIndex_Color
                                                            .tappedIndex_Colors
                                                        : AppbackgroundColor
                                                            .Sub_Abg_Colors,
                                                    child: Container(
                                                        // color:
                                                        //     tappedIndex_ == index.toString()
                                                        //         ? tappedIndex_Color
                                                        //             .tappedIndex_Colors
                                                        //         : null,
                                                        child: ListTile(
                                                            onTap: () {
                                                              setState(() {
                                                                tappedIndex_ = index
                                                                    .toString();
                                                              });
                                                            },
                                                            title: Container(
                                                              decoration:
                                                                  BoxDecoration(
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
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${_TransModels[index].refno}',
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: const TextStyle(
                                                                          color: SettingScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T
                                                                          //fontWeight: FontWeight.bold,
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${_TransModels[index].expname}',
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: const TextStyle(
                                                                          color: SettingScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T
                                                                          //fontWeight: FontWeight.bold,
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse(_TransModels[index].nvat!))}',
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style: const TextStyle(
                                                                          color: SettingScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T
                                                                          //fontWeight: FontWeight.bold,
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse(_TransModels[index].vat!))}',
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style: const TextStyle(
                                                                          color: SettingScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T
                                                                          //fontWeight: FontWeight.bold,
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style: const TextStyle(
                                                                          color: SettingScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T
                                                                          //fontWeight: FontWeight.bold,
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse(_TransModels[index].total!))}',
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style: const TextStyle(
                                                                          color: SettingScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T
                                                                          //fontWeight: FontWeight.bold,
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ))))
                                              // Container(
                                              //   decoration: BoxDecoration(
                                              //     // color: Colors.green[100]!
                                              //     //     .withOpacity(0.5),
                                              //     border: Border(
                                              //       bottom: BorderSide(
                                              //         color: Colors.black12,
                                              //         width: 1,
                                              //       ),
                                              //     ),
                                              //   ),
                                              //   child: Padding(
                                              //     padding: const EdgeInsets.all(8.0),
                                              //     child: Row(
                                              //       children: [
                                              //         Expanded(
                                              //           child: Text(
                                              //               '${_TransModels[index].refno}'),
                                              //         ),
                                              //         Expanded(
                                              //           child: Text(
                                              //               '${_TransModels[index].expname}'),
                                              //         ),
                                              //         Expanded(
                                              //           child: Text(
                                              //               '${nFormat.format(double.parse(_TransModels[index].nvat!))}'),
                                              //         ),
                                              //         Expanded(
                                              //           child: Text(
                                              //               '${nFormat.format(double.parse(_TransModels[index].vat!))}'),
                                              //         ),
                                              //         Expanded(
                                              //           child: Text(
                                              //               '${nFormat.format(double.parse(_TransModels[index].pvat!))}'),
                                              //         ),
                                              //         Expanded(
                                              //           child: Text(
                                              //               '${nFormat.format(double.parse(_TransModels[index].total!))}'),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // )
                                            ]),
                                      ),
                                    ],
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // expModels.length == 0
            //     ? SizedBox()
            //     : Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           width: MediaQuery.of(context).size.width,
            //           child: Row(
            //             children: [
            //               Expanded(
            //                 flex: 2,
            //                 child: Container(
            //                   height: MediaQuery.of(context).size.width * 0.35,
            //                   child: SingleChildScrollView(
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       children: [
            //                         for (int index = 0;
            //                             index < expModels.length;
            //                             index++)
            //                           Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: InkWell(
            //                                 onTap: () async {
            //                                   setState(() {
            //                                     ser_exp = expModels[index]
            //                                         .ser
            //                                         .toString();
            //                                     price_text.clear();
            //                                     read_GC_Exp_trans();
            //                                   });
            //                                   print(ser_exp);
            //                                 },
            //                                 child: Container(
            //                                   width: MediaQuery.of(context)
            //                                       .size
            //                                       .width,
            //                                   decoration: BoxDecoration(
            //                                       color: ser_exp ==
            //                                               expModels[index]
            //                                                   .ser
            //                                                   .toString()
            //                                           ? Colors.blue.shade800
            //                                           : Colors.blue.shade200,
            //                                       borderRadius:
            //                                           const BorderRadius.only(
            //                                               topLeft:
            //                                                   Radius.circular(
            //                                                       10),
            //                                               topRight:
            //                                                   Radius.circular(
            //                                                       10),
            //                                               bottomLeft:
            //                                                   Radius.circular(
            //                                                       10),
            //                                               bottomRight:
            //                                                   Radius.circular(
            //                                                       10)),
            //                                       border: Border.all(
            //                                           color: Colors.white,
            //                                           width: 1)),
            //                                   padding:
            //                                       const EdgeInsets.all(8.0),
            //                                   child: Center(
            //                                     child: Text(
            //                                       expModels[index]
            //                                           .expname
            //                                           .toString(),
            //                                       style: TextStyle(
            //                                           color: ser_exp ==
            //                                                   expModels[index]
            //                                                       .ser
            //                                                       .toString()
            //                                               ? Colors.white
            //                                               : Colors.black,
            //                                           fontFamily:
            //                                               FontWeight_.Fonts_T),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               )),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Expanded(
            //                 flex: 6,
            //                 child: Container(
            //                   height: MediaQuery.of(context).size.width * 0.35,
            //                   child: SingleChildScrollView(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           color: Colors.grey.shade200,
            //                           child: Padding(
            //                             padding: const EdgeInsets.all(8.0),
            //                             child: Row(
            //                               children: [
            //                                 Expanded(
            //                                   flex: 2,
            //                                   child:
            //                                       Text('แก้ไขค่าบริการทั้งหมด'),
            //                                 ),
            //                                 Expanded(
            //                                   flex: 4,
            //                                   child: TextFormField(
            //                                     // keyboardType: TextInputType.number,
            //                                     controller: price_text,

            //                                     // maxLength: 13,
            //                                     cursorColor: Colors.green,
            //                                     decoration: InputDecoration(
            //                                         fillColor: Colors.white
            //                                             .withOpacity(0.3),
            //                                         filled: true,
            //                                         // prefixIcon:
            //                                         //     const Icon(Icons.person_pin, color: Colors.black),
            //                                         // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //                                         focusedBorder:
            //                                             const OutlineInputBorder(
            //                                           borderRadius:
            //                                               BorderRadius.only(
            //                                             topRight:
            //                                                 Radius.circular(15),
            //                                             topLeft:
            //                                                 Radius.circular(15),
            //                                             bottomRight:
            //                                                 Radius.circular(15),
            //                                             bottomLeft:
            //                                                 Radius.circular(15),
            //                                           ),
            //                                           borderSide: BorderSide(
            //                                             width: 1,
            //                                             color: Colors.black,
            //                                           ),
            //                                         ),
            //                                         enabledBorder:
            //                                             const OutlineInputBorder(
            //                                           borderRadius:
            //                                               BorderRadius.only(
            //                                             topRight:
            //                                                 Radius.circular(15),
            //                                             topLeft:
            //                                                 Radius.circular(15),
            //                                             bottomRight:
            //                                                 Radius.circular(15),
            //                                             bottomLeft:
            //                                                 Radius.circular(15),
            //                                           ),
            //                                           borderSide: BorderSide(
            //                                             width: 1,
            //                                             color: Colors.grey,
            //                                           ),
            //                                         ),
            //                                         labelStyle: const TextStyle(
            //                                           color: Colors.black54,
            //                                           fontFamily:
            //                                               FontWeight_.Fonts_T,
            //                                         )),
            //                                     inputFormatters: <TextInputFormatter>[
            //                                       // for below version 2 use this
            //                                       FilteringTextInputFormatter
            //                                           .allow(RegExp(r'[0-9]')),
            //                                       // for version 2 and greater youcan also use this
            //                                       // FilteringTextInputFormatter.digitsOnly
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Expanded(
            //                                   flex: 2,
            //                                   child: DropdownButtonFormField2(
            //                                     decoration: InputDecoration(
            //                                       isDense: true,
            //                                       contentPadding:
            //                                           EdgeInsets.zero,
            //                                       border: OutlineInputBorder(
            //                                         borderRadius:
            //                                             BorderRadius.circular(
            //                                                 10),
            //                                       ),
            //                                     ),
            //                                     isExpanded: true,
            //                                     hint: const Text(
            //                                       'เลือก',
            //                                       maxLines: 1,
            //                                       style: TextStyle(
            //                                           fontSize: 14,
            //                                           color:
            //                                               PeopleChaoScreen_Color
            //                                                   .Colors_Text2_,
            //                                           // fontWeight: FontWeight.bold,
            //                                           fontFamily:
            //                                               Font_.Fonts_T),
            //                                     ),
            //                                     icon: const Icon(
            //                                       Icons.arrow_drop_down,
            //                                       color: TextHome_Color
            //                                           .TextHome_Colors,
            //                                     ),
            //                                     style: TextStyle(
            //                                         color:
            //                                             Colors.green.shade900,
            //                                         fontFamily: Font_.Fonts_T),
            //                                     iconSize: 20,
            //                                     buttonHeight: 50,
            //                                     // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            //                                     dropdownDecoration:
            //                                         BoxDecoration(
            //                                       borderRadius:
            //                                           BorderRadius.circular(10),
            //                                     ),
            //                                     items: vatModels
            //                                         .map(
            //                                             (item) =>
            //                                                 DropdownMenuItem<
            //                                                     String>(
            //                                                   value:
            //                                                       '${item.ser}:${item.vat}',
            //                                                   child: Text(
            //                                                     item.vat!,
            //                                                     style: const TextStyle(
            //                                                         fontSize: 14,
            //                                                         color: PeopleChaoScreen_Color.Colors_Text2_,
            //                                                         // fontWeight: FontWeight.bold,
            //                                                         fontFamily: Font_.Fonts_T),
            //                                                   ),
            //                                                 ))
            //                                         .toList(),

            //                                     onChanged: (value) async {
            //                                       var zones =
            //                                           value!.indexOf(':');
            //                                       var vatSer =
            //                                           value.substring(0, zones);
            //                                       var vatName = value
            //                                           .substring(zones + 1);
            //                                       print(
            //                                           'mmmmm ${vatSer.toString()} $vatName');

            //                                       setState(() {
            //                                         vat_Ser = vatSer;
            //                                       });
            //                                     },
            //                                   ),
            //                                 ),
            //                                 Expanded(
            //                                   flex: 2,
            //                                   child: InkWell(
            //                                     onTap: () async {
            //                                       var ppri = price_text.text;
            //                                       var ser_v = vat_Ser == null
            //                                           ? '1'
            //                                           : vat_Ser;
            //                                       print('$ppri $ser_v ');
            //                                       if (renTal_lavel > 2) {
            //                                         if (ppri != 'null') {
            //                                           for (int index = 0;
            //                                               index <
            //                                                   _TransModels
            //                                                       .length;
            //                                               index++) {
            //                                             var ser_trans =
            //                                                 _TransModels[index]
            //                                                     .ser;
            //                                             SharedPreferences
            //                                                 preferences =
            //                                                 await SharedPreferences
            //                                                     .getInstance();
            //                                             String? ren = preferences
            //                                                 .getString(
            //                                                     'renTalSer');
            //                                             String? ser_user =
            //                                                 preferences
            //                                                     .getString(
            //                                                         'ser');
            //                                             String url =
            //                                                 '${MyConstant().domain}/UpC_transx_amt.php?isAdd=true&ren=$ren&ser_trans=$ser_trans&ser_v=$ser_v&conx_amt=$ppri';

            //                                             try {
            //                                               var response =
            //                                                   await http.get(
            //                                                       Uri.parse(
            //                                                           url));

            //                                               var result = json
            //                                                   .decode(response
            //                                                       .body);
            //                                               print(result);
            //                                               if (result
            //                                                       .toString() ==
            //                                                   'true') {
            //                                                 // setState(() {
            //                                                 //   read_GC_rownum();
            //                                                 // });
            //                                               } else {}
            //                                             } catch (e) {}
            //                                           }
            //                                           setState(() {
            //                                             price_text.clear();
            //                                             read_GC_Exp_trans();
            //                                           });
            //                                         }
            //                                       } else {
            //                                         ScaffoldMessenger.of(
            //                                                 context)
            //                                             .showSnackBar(
            //                                           SnackBar(
            //                                               content: Text(
            //                                                   'User ของท่านไม่สามารถทำการแก้ไขได้ ')),
            //                                         );
            //                                       }
            //                                     },
            //                                     child: Container(
            //                                       width: MediaQuery.of(context)
            //                                           .size
            //                                           .width,
            //                                       decoration: BoxDecoration(
            //                                           color:
            //                                               Colors.blue.shade800,
            //                                           borderRadius:
            //                                               const BorderRadius.only(
            //                                                   topLeft: Radius
            //                                                       .circular(10),
            //                                                   topRight: Radius
            //                                                       .circular(10),
            //                                                   bottomLeft: Radius
            //                                                       .circular(10),
            //                                                   bottomRight:
            //                                                       Radius
            //                                                           .circular(
            //                                                               10)),
            //                                           border: Border.all(
            //                                               color: Colors.white,
            //                                               width: 1)),
            //                                       padding:
            //                                           const EdgeInsets.all(8.0),
            //                                       child: Center(
            //                                         child: Text(
            //                                           'SAVE',
            //                                           style: TextStyle(
            //                                               color: Colors.white,
            //                                               fontFamily:
            //                                                   FontWeight_
            //                                                       .Fonts_T),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         Container(
            //                           color: Colors.grey.shade200,
            //                           child: Padding(
            //                             padding: const EdgeInsets.all(8.0),
            //                             child: Row(
            //                               children: [
            //                                 Expanded(
            //                                   child: Text('เลขที่สัญญา'),
            //                                 ),
            //                                 Expanded(
            //                                   child: Text('ค่าบริการ'),
            //                                 ),
            //                                 Expanded(
            //                                   child: Text('VAT %'),
            //                                 ),
            //                                 Expanded(
            //                                   child: Text('VAT ฿'),
            //                                 ),
            //                                 Expanded(
            //                                   child: Text('ก่อน VAT'),
            //                                 ),
            //                                 Expanded(
            //                                   child: Text('รวม'),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         _TransModels.isEmpty
            //                             ? Container(
            //                                 child: Column(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.center,
            //                                   children: [
            //                                     const CircularProgressIndicator(),
            //                                     StreamBuilder(
            //                                       stream: Stream.periodic(
            //                                           const Duration(
            //                                               milliseconds: 25),
            //                                           (i) => i),
            //                                       builder: (context, snapshot) {
            //                                         if (!snapshot.hasData)
            //                                           return const Text('');
            //                                         double elapsed =
            //                                             double.parse(snapshot
            //                                                     .data
            //                                                     .toString()) *
            //                                                 0.05;
            //                                         return Padding(
            //                                           padding:
            //                                               const EdgeInsets.all(
            //                                                   8.0),
            //                                           child: (elapsed > 8.00)
            //                                               ? const Text(
            //                                                   'ไม่พบข้อมูล',
            //                                                   style: TextStyle(
            //                                                       color: PeopleChaoScreen_Color
            //                                                           .Colors_Text2_,
            //                                                       fontFamily:
            //                                                           Font_
            //                                                               .Fonts_T
            //                                                       //fontSize: 10.0
            //                                                       ),
            //                                                 )
            //                                               : Text(
            //                                                   'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
            //                                                   // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
            //                                                   style: const TextStyle(
            //                                                       color: PeopleChaoScreen_Color
            //                                                           .Colors_Text2_,
            //                                                       fontFamily:
            //                                                           Font_
            //                                                               .Fonts_T
            //                                                       //fontSize: 10.0
            //                                                       ),
            //                                                 ),
            //                                         );
            //                                       },
            //                                     ),
            //                                   ],
            //                                 ),
            //                               )
            //                             : SizedBox(),
            //                         for (int index = 0;
            //                             index < _TransModels.length;
            //                             index++)
            //                           Container(
            //                             color: Colors.white,
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: Row(
            //                                 children: [
            //                                   Expanded(
            //                                     child: Text(
            //                                         '${_TransModels[index].refno}'),
            //                                   ),
            //                                   Expanded(
            //                                     child: Text(
            //                                         '${_TransModels[index].expname}'),
            //                                   ),
            //                                   Expanded(
            //                                     child: Text(
            //                                         '${nFormat.format(double.parse(_TransModels[index].nvat!))}'),
            //                                   ),
            //                                   Expanded(
            //                                     child: Text(
            //                                         '${nFormat.format(double.parse(_TransModels[index].vat!))}'),
            //                                   ),
            //                                   Expanded(
            //                                     child: Text(
            //                                         '${nFormat.format(double.parse(_TransModels[index].pvat!))}'),
            //                                   ),
            //                                   Expanded(
            //                                     child: Text(
            //                                         '${nFormat.format(double.parse(_TransModels[index].total!))}'),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           )
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
          ],
        ),
      ),
    );
  }
}
