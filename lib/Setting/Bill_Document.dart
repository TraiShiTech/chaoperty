// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetDoctype_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_bill_one.dart';
import '../Model/Get_bill_two.dart';
import '../Responsive/responsive.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import 'package:http/http.dart' as http;

import 'Bill_Document_Template.dart';

class BillDocument extends StatefulWidget {
  const BillDocument({super.key});

  @override
  State<BillDocument> createState() => _BillDocumentState();
}

class _BillDocumentState extends State<BillDocument> {
  List<DoctypeOneModel> doctypeOneModels = [];
  List<DoctypeTwoModel> doctypeTwoModels = [];
  List<RenTalModel> renTalModels = [];
  int ser_pang = 0;
  List Default_ = [
    'บิลธรรมดา',
  ];
  List Default2_ = [
    'บิลธรรมดา',
    'ใบกำกับภาษี',
  ];
  List Default_Receipt = [
    'ออกใบเสร็จ',
    'ไม่ออกใบเสร็จ',
  ];
  List Tap_ = [
    'ข้อมูลการออกบิล',
    'Template',
  ];
  List TitleType_Default_Receipt_ = [
    'ไม่ระบุ',
    'ต้นฉบับ',
    'สำเนา',
  ];
  String tappedIndex_1 = '';
  String tappedIndex_2 = '';
  String? renTal_user, renTal_name, zone_ser, zone_name;
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
      Receipt_default,
      Language;
  int Receipt_defaultTitle = 0;
  String? rtname_Check,
      type_Check,
      typex_Check,
      renname_Check,
      bill_name_Check,
      bill_addr_Check,
      bill_tax_Check,
      bill_tel_Check,
      bill_email_Check,
      expbill_Check,
      expbill_name_Check;

  ///////---------------------------------------------------->
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_doctype();
    read_GC_doctype2();
    read_GC_rental();
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
          setState(() {
            Language = preferences.getString('renTal_Language');
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
            Receipt_default = renTalModel.printbill_default!;
            Receipt_defaultTitle = int.parse(renTalModel.receipt_title!);
            bill_tser = bill_tserx;
            renTalModels.add(renTalModel);
            rtname_Check = rtnamex;
            type_Check = typexs;
            typex_Check = typexx;
            renname_Check = name;
            bill_name_Check = bill_namex;
            bill_addr_Check = bill_addrx;
            bill_tax_Check = bill_taxx;
            bill_tel_Check = bill_telx;
            bill_email_Check = bill_emailx;
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  ///////---------------------------------------------------->
  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
  }

  Future<Null> read_GC_doctype() async {
    if (doctypeOneModels.length != 0) {
      doctypeOneModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('zone >>>>>> $zone');

    String url =
        '${MyConstant().domain}/GC_doctypeSetting1.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          DoctypeOneModel doctypeOneModel = DoctypeOneModel.fromJson(map);
          var expbillx = doctypeOneModel.doccode;
          var expbill_namex = doctypeOneModel.bills;
          setState(() {
            if (doctypeOneModel.dtype == 'BL') {
              expbill = expbillx;
              expbill_name = expbill_namex;
            }
            doctypeOneModels.add(doctypeOneModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_doctype2() async {
    if (doctypeTwoModels.length != 0) {
      doctypeTwoModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('zone >>>>>> $zone');

    String url =
        '${MyConstant().domain}/GC_doctypeSetting2.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          DoctypeTwoModel doctypeTwoModel = DoctypeTwoModel.fromJson(map);

          setState(() {
            doctypeTwoModels.add(doctypeTwoModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  String? set_dd;
  Future<Null> DialogEdit(
      int index,
      String typeDocu,
      String titleDocu,
      String numDocu,
      String serDocu,
      String dtype,
      String yy,
      String mm) async {
    final _formKey = GlobalKey<FormState>();
    final Formtitledoc_text = TextEditingController();
    final FormtitleDocu_text = TextEditingController();
    final FormnumDocu_text = TextEditingController();

    Formtitledoc_text.text = typeDocu;

    FormtitleDocu_text.text = titleDocu;
    FormnumDocu_text.text = numDocu;
    set_dd = null;
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Form(
        key: _formKey,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
              child: Text(
            '$typeDocu',
            style: const TextStyle(
              color: SettingScreen_Color.Colors_Text1_,
              fontFamily: FontWeight_.Fonts_T,
              fontWeight: FontWeight.bold,
            ),
          )),
          content: Container(
            // height: MediaQuery.of(context).size.height / 1.5,
            width: (!Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * 0.5,
            decoration: const BoxDecoration(
              // color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.white, width: 1),
            ),
            child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 0)),
                  builder: (context, snapshot) {
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Translate.TranslateAndSetText(
                                  'ประเภทเอกสาร',
                                  SettingScreen_Color.Colors_Text1_,
                                  TextAlign.center,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  14,
                                  1),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '( $typeDocu )',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: SettingScreen_Color.Colors_Text1_,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            // width: 200,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: Formtitledoc_text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'ใส่ข้อมูลให้ครบถ้วน ';
                                }
                                // if (int.parse(value.toString()) < 13) {
                                //   return '< 13';
                                // }
                                return null;
                              },
                              // maxLength: 13,
                              cursorColor: Colors.green,
                              decoration: InputDecoration(
                                  fillColor: Colors.white.withOpacity(0.3),
                                  filled: true,
                                  // prefixIcon:
                                  //     const Icon(Icons.person_pin, color: Colors.black),
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
                                  labelText: 'ประเภทเอกสาร',
                                  labelStyle: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: FontWeight_.Fonts_T,
                                  )),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.deny(
                                    RegExp("[' ']")),
                                // for below version 2 use this
                                // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                // for version 2 and greater youcan also use this
                                // FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Translate.TranslateAndSetText(
                                    'หัวบิล ( $titleDocu )',
                                    SettingScreen_Color.Colors_Text1_,
                                    TextAlign.left,
                                    FontWeight.bold,
                                    FontWeight_.Fonts_T,
                                    14,
                                    1),
                                // Text(
                                //   'หัวบิล ( $titleDocu )',
                                //   textAlign: TextAlign.left,
                                //   style: const TextStyle(
                                //     color: SettingScreen_Color.Colors_Text1_,
                                //     fontFamily: FontWeight_.Fonts_T,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ),
                            ),
                            dtype == 'WT' || dtype == 'Q'
                                ? Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              set_dd = yy == 'Y' ? '' : 'Y';
                                            });
                                          },
                                          icon: (set_dd == '' || set_dd == null)
                                              ? yy == 'Y'
                                                  ? Icon(
                                                      Icons.toggle_on,
                                                      color: Colors.green,
                                                      size: 25,
                                                    )
                                                  : Icon(
                                                      Icons.toggle_off,
                                                      color: Colors.grey,
                                                      size: 25,
                                                    )
                                              : set_dd == 'Y'
                                                  ? Icon(
                                                      Icons.toggle_on,
                                                      color: Colors.green,
                                                      size: 25,
                                                    )
                                                  : Icon(
                                                      Icons.toggle_off,
                                                      color: Colors.grey,
                                                      size: 25,
                                                    ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Translate.TranslateAndSetText(
                                              'เริ่ม 1 ทุกปี',
                                              SettingScreen_Color.Colors_Text1_,
                                              TextAlign.left,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              1),
                                          // Text(
                                          //   'เริ่ม 1 ทุกปี',
                                          //   textAlign: TextAlign.left,
                                          //   style: const TextStyle(
                                          //     color: SettingScreen_Color
                                          //         .Colors_Text1_,
                                          //     fontFamily: FontWeight_.Fonts_T,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              set_dd = yy == 'M' ? '' : 'M';
                                            });
                                          },
                                          icon: (set_dd == '' || set_dd == null)
                                              ? mm == 'M'
                                                  ? Icon(
                                                      Icons.toggle_on,
                                                      color: Colors.green,
                                                      size: 25,
                                                    )
                                                  : Icon(
                                                      Icons.toggle_off,
                                                      color: Colors.grey,
                                                      size: 25,
                                                    )
                                              : set_dd == 'M'
                                                  ? Icon(
                                                      Icons.toggle_on,
                                                      color: Colors.green,
                                                      size: 25,
                                                    )
                                                  : Icon(
                                                      Icons.toggle_off,
                                                      color: Colors.grey,
                                                      size: 25,
                                                    ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Translate.TranslateAndSetText(
                                              'เริ่ม 1 ทุกปี',
                                              SettingScreen_Color.Colors_Text1_,
                                              TextAlign.left,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              1),
                                          //  Text(
                                          //   'เริ่ม 1 ทุกเดือน',
                                          //   textAlign: TextAlign.left,
                                          //   style: const TextStyle(
                                          //     color: SettingScreen_Color
                                          //         .Colors_Text1_,
                                          //     fontFamily: FontWeight_.Fonts_T,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              set_dd = 'N';
                                            });
                                          },
                                          icon: set_dd == 'N' ||
                                                  set_dd == '' ||
                                                  set_dd == null &&
                                                      mm != 'M' &&
                                                      yy != 'Y'
                                              ? Icon(
                                                  Icons.toggle_on,
                                                  color: Colors.green,
                                                  size: 25,
                                                )
                                              : Icon(
                                                  Icons.toggle_off,
                                                  color: Colors.grey,
                                                  size: 25,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Translate.TranslateAndSetText(
                                              'ปิด $mm $yy',
                                              SettingScreen_Color.Colors_Text1_,
                                              TextAlign.left,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              1),
                                          // Text(
                                          //   'ปิด $mm $yy',
                                          //   textAlign: TextAlign.left,
                                          //   style: const TextStyle(
                                          //     color: SettingScreen_Color
                                          //         .Colors_Text1_,
                                          //     fontFamily: FontWeight_.Fonts_T,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                            dtype == 'WT' || dtype == 'Q'
                                ? Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Translate.TranslateAndSetText(
                                          'ตัวอย่าง ( ${FormtitleDocu_text.text.toString()}${(int.parse(DateFormat('yyyy').format(DateTime.now())) + 543).toString().substring(2)}-${DateFormat('MM').format(DateTime.now())}-${FormnumDocu_text.text.toString().padLeft(5, '0')} )',
                                          SettingScreen_Color.Colors_Text1_,
                                          TextAlign.left,
                                          FontWeight.bold,
                                          FontWeight_.Fonts_T,
                                          14,
                                          1),
                                      // Text(
                                      //   // (set_dd == '' || set_dd == null)
                                      //   //     ? (yy == 'Y' || mm == 'M')
                                      //   //         ? set_dd == 'N'
                                      //   //             ? 'ตัวอย่าง ( ${FormtitleDocu_text.text.toString()}${FormnumDocu_text.text.toString().padLeft(6, '0')})'
                                      //   //             : 'ตัวอย่าง ( ${FormtitleDocu_text.text.toString()}${FormnumDocu_text.text.toString().padLeft(4, '0')}-${DateFormat('MM').format(DateTime.now())}-${DateFormat('yyyy').format(DateTime.now())} )'
                                      //   //         : 'ตัวอย่าง (${FormtitleDocu_text.text.toString()}${FormnumDocu_text.text.toString().padLeft(6, '0')})'
                                      //   //     : set_dd == 'N'
                                      //   //         ? 'ตัวอย่าง ( ${FormtitleDocu_text.text.toString()}${FormnumDocu_text.text.toString().padLeft(6, '0')})'
                                      //   //         :
                                      //   'ตัวอย่าง ( ${FormtitleDocu_text.text.toString()}${(int.parse(DateFormat('yyyy').format(DateTime.now())) + 543).toString().substring(2)}-${DateFormat('MM').format(DateTime.now())}-${FormnumDocu_text.text.toString().padLeft(5, '0')} )',
                                      //   textAlign: TextAlign.left,
                                      //   style: const TextStyle(
                                      //     color:
                                      //         SettingScreen_Color.Colors_Text1_,
                                      //     fontFamily: FontWeight_.Fonts_T,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                    ),
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            // width: 200,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: FormtitleDocu_text,
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'ใส่ข้อมูลให้ครบถ้วน ';
                              //   }
                              //   // if (int.parse(value.toString()) < 13) {
                              //   //   return '< 13';
                              //   // }
                              //   return null;
                              // },
                              // maxLength: 13,
                              cursorColor: Colors.green,
                              decoration: InputDecoration(
                                  fillColor: Colors.white.withOpacity(0.3),
                                  filled: true,
                                  // prefixIcon:
                                  //     const Icon(Icons.person_pin, color: Colors.black),
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
                                  labelText: 'แก้ไขหัวบิล',
                                  labelStyle: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: FontWeight_.Fonts_T,
                                  )),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.deny(
                                    RegExp("[' ']")),
                                // for below version 2 use this
                                // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                // for version 2 and greater youcan also use this
                                // FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ),
                        if (numDocu != '')
                          SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Translate.TranslateAndSetText(
                                          'เลขเอกสาร ( $numDocu )',
                                          SettingScreen_Color.Colors_Text1_,
                                          TextAlign.left,
                                          FontWeight.bold,
                                          FontWeight_.Fonts_T,
                                          14,
                                          1),
                                      // Text(
                                      //   'เลขเอกสาร ( $numDocu )',
                                      //   textAlign: TextAlign.left,
                                      //   style: const TextStyle(
                                      //     color:
                                      //         SettingScreen_Color.Colors_Text1_,
                                      //     fontFamily: FontWeight_.Fonts_T,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    // width: 200,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: FormnumDocu_text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'ใส่ข้อมูลให้ครบถ้วน ';
                                        }
                                        // if (int.parse(value.toString()) < 13) {
                                        //   return '< 13';
                                        // }
                                        return null;
                                      },
                                      // maxLength: 13,
                                      cursorColor: Colors.green,
                                      decoration: InputDecoration(
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
                                          // prefixIcon:
                                          //     const Icon(Icons.person_pin, color: Colors.black),
                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                          labelText: 'แก้ไขเลขเอกสาร',
                                          labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontFamily: FontWeight_.Fonts_T,
                                          )),
                                      inputFormatters: <TextInputFormatter>[
                                        // for below version 2 use this
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                        // for version 2 and greater youcan also use this
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
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
                              if (_formKey.currentState!.validate()) {
                                print('Ser เอกสาร : ${serDocu.toString()}');
                                print(
                                    'แก้ไขหัวบิล : ${FormtitleDocu_text.text.toString()}');
                                print(
                                    'แก้ไขเลขเอกสาร : ${FormnumDocu_text.text.toString()}');
                                var name_bull =
                                    Formtitledoc_text.text.toString();
                                var name_abc =
                                    FormtitleDocu_text.text.toString();
                                var name_num = FormnumDocu_text.text.toString();
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String? ren =
                                    preferences.getString('renTalSer');
                                String? ser_user = preferences.getString('ser');
                                var vser = serDocu;
                                String url =
                                    '${MyConstant().domain}/UpC_Bill.php?isAdd=true&ren=$ren&ser_user=$ser_user&vser=$vser&name_bull=$name_bull&name_abc=$name_abc&name_num=$name_num&set_dd=$set_dd';

                                try {
                                  var response = await http.get(Uri.parse(url));

                                  var result = json.decode(response.body);
                                  print(result);
                                  if (result.toString() == 'true') {
                                    Insert_log.Insert_logs(
                                        'ตั้งค่า', 'เอกสาร>>$typeDocu');
                                    setState(() {
                                      FormtitleDocu_text.clear();
                                      FormnumDocu_text.clear();
                                      Formtitledoc_text.clear();
                                      read_GC_doctype();
                                      read_GC_doctype2();
                                    });
                                    Navigator.pop(context);
                                  } else {}
                                } catch (e) {}
                              }
                            },
                            child: Translate.TranslateAndSetText(
                                'บันทึก',
                                Colors.white,
                                TextAlign.left,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                14,
                                1),
                            // const Text(
                            //   'บันทึก',
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontFamily: FontWeight_.Fonts_T,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          child: TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: Translate.TranslateAndSetText(
                                'ยกเลิก',
                                Colors.white,
                                TextAlign.left,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                14,
                                1),
                            // const Text(
                            //   'ยกเลิก',
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontFamily: FontWeight_.Fonts_T,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
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
      ),
    );
  }

  ///////---------------------------------------------------->
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int index = 0; index < Tap_.length; index++)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              ser_pang = index;
                            });
                          },
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: (ser_pang == index)
                                  ? Colors.black54
                                  : Colors.black26,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Translate.TranslateAndSetText(
                                  '${Tap_[index]}',
                                  Colors.white,
                                  TextAlign.left,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  14,
                                  1),
                              // AutoSizeText(
                              //   minFontSize: 10,
                              //   maxFontSize: 20,
                              //   '${Tap_[index]}',
                              //   style: const TextStyle(
                              //     color: Colors.white,
                              //     // fontWeight: FontWeight.bold,
                              //     fontFamily: FontWeight_.Fonts_T,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        (ser_pang == 1)
            ? const Bill_DocumentTemplate()
            : Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                        // border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.TiTile_Colors,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              // border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Translate.TranslateAndSetText(
                                      'ข้อมูลการออกบิล',
                                      SettingScreen_Color.Colors_Text1_,
                                      TextAlign.left,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      14,
                                      1),

                                  //  Text(
                                  //   'ข้อมูลการออกบิล',
                                  //   style: TextStyle(
                                  //     color: SettingScreen_Color.Colors_Text1_,
                                  //     fontFamily: FontWeight_.Fonts_T,
                                  //     fontWeight: FontWeight.bold,
                                  //     //fontSize: 10.0
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Translate.TranslateAndSetText(
                                      'ชื่อผู้เช่า/บริบัท',
                                      SettingScreen_Color.Colors_Text2_,
                                      TextAlign.left,
                                      null,
                                      Font_.Fonts_T,
                                      14,
                                      1),
                                  // Text(
                                  //   'ชื่อผู้เช่า/บริบัท',
                                  //   textAlign: TextAlign.start,
                                  //   style: TextStyle(
                                  //       color:
                                  //           SettingScreen_Color.Colors_Text2_,
                                  //       fontFamily: Font_.Fonts_T
                                  //       //fontWeight: FontWeight.bold,
                                  //       //fontSize: 10.0
                                  //       ),
                                  // ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      // decoration: BoxDecoration(
                                      //   // color: Colors.green,
                                      //   borderRadius: const BorderRadius.only(
                                      //     topLeft: Radius.circular(6),
                                      //     topRight: Radius.circular(6),
                                      //     bottomLeft: Radius.circular(6),
                                      //     bottomRight: Radius.circular(6),
                                      //   ),
                                      //   border: Border.all(color: Colors.grey, width: 1),
                                      // ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        initialValue: bill_name!.trim(),
                                        onFieldSubmitted: (value) async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? ren = preferences
                                              .getString('renTalSer');
                                          String? ser_user =
                                              preferences.getString('ser');

                                          String url =
                                              '${MyConstant().domain}/UpC_rentel_bill_name.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            print(result);
                                            if (result.toString() == 'true') {
                                              Insert_log.Insert_logs('ตั้งค่า',
                                                  'เอกสาร>>แก้ไข(ชื่อผู้เช่า/บริบัท)');
                                              setState(() {
                                                read_GC_rental();
                                              });
                                            } else {}
                                          } catch (e) {}
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            bill_name_Check = value;
                                          });
                                        },
                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          fillColor: AppbackgroundColor
                                              .Sub_Abg_Colors.withOpacity(0.5),
                                          filled: true,
                                          // prefixIcon:
                                          //     const Icon(Icons.key, color: Colors.black),
                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          labelStyle: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      )
                                      // Text(
                                      //   '$bill_name',
                                      //   textAlign: TextAlign.start,
                                      //   style: TextStyle(
                                      //       color: SettingScreen_Color.Colors_Text2_,
                                      //       fontFamily: Font_.Fonts_T
                                      //       //fontWeight: FontWeight.bold,
                                      //       //fontSize: 10.0
                                      //       ),
                                      // ),
                                      ),
                                ),
                                if (bill_name.toString().trim() !=
                                    bill_name_Check.toString().trim())
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () async {
                                        print(bill_name);
                                        print(bill_name_Check);
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String? ren =
                                            preferences.getString('renTalSer');
                                        String? ser_user =
                                            preferences.getString('ser');
                                        String value = bill_name_Check!;
                                        String url =
                                            '${MyConstant().domain}/UpC_rentel_bill_name.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                        try {
                                          var response =
                                              await http.get(Uri.parse(url));

                                          var result =
                                              json.decode(response.body);
                                          print(result);
                                          setState(() {
                                            bill_name = null;
                                            bill_name_Check = null;
                                          });
                                          read_GC_rental();
                                          if (result.toString() == 'true') {
                                            Insert_log.Insert_logs('ตั้งค่า',
                                                'เอกสาร>>แก้ไข(ชื่อผู้เช่า/บริบัท)');
                                          } else {}
                                        } catch (e) {}
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Translate.TranslateAndSetText(
                                              'บันทึก',
                                              Colors.white,
                                              TextAlign.left,
                                              null,
                                              Font_.Fonts_T,
                                              14,
                                              1),
                                          // const Text(
                                          //   'บันทึก',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontFamily: Font_.Fonts_T
                                          //       //fontWeight: FontWeight.bold,
                                          //       //fontSize: 10.0
                                          //       ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade100,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(6),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Translate.TranslateAndSetText(
                                            'นิติบุคคล',
                                            SettingScreen_Color.Colors_Text2_,
                                            TextAlign.center,
                                            null,
                                            Font_.Fonts_T,
                                            14,
                                            1),
                                        // Text(
                                        //   'นิติบุคคล',
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(
                                        //       color: SettingScreen_Color
                                        //           .Colors_Text2_,
                                        //       fontFamily: Font_.Fonts_T
                                        //       //fontWeight: FontWeight.bold,
                                        //       //fontSize: 10.0
                                        //       ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: Font_.Fonts_T
                                        //fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: Font_.Fonts_T
                                        //fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Translate.TranslateAndSetText(
                                      'ที่อยู่',
                                      SettingScreen_Color.Colors_Text2_,
                                      TextAlign.left,
                                      null,
                                      Font_.Fonts_T,
                                      14,
                                      1),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                      // decoration: BoxDecoration(
                                      //   // color: Colors.green,
                                      //   borderRadius: const BorderRadius.only(
                                      //     topLeft: Radius.circular(6),
                                      //     topRight: Radius.circular(6),
                                      //     bottomLeft: Radius.circular(6),
                                      //     bottomRight: Radius.circular(6),
                                      //   ),
                                      //   border: Border.all(color: Colors.grey, width: 1),
                                      // ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        initialValue: bill_addr!.trim(),
                                        onFieldSubmitted: (value) async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? ren = preferences
                                              .getString('renTalSer');
                                          String? ser_user =
                                              preferences.getString('ser');

                                          String url =
                                              '${MyConstant().domain}/UpC_rentel_bill_addr.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            print(result);
                                            if (result.toString() == 'true') {
                                              Insert_log.Insert_logs('ตั้งค่า',
                                                  'เอกสาร>>แก้ไข(ที่อยู่)');
                                              setState(() {
                                                read_GC_rental();
                                              });
                                            } else {}
                                          } catch (e) {}
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            bill_addr_Check = value;
                                          });
                                        },
                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          fillColor: AppbackgroundColor
                                              .Sub_Abg_Colors.withOpacity(0.5),
                                          filled: true,
                                          // prefixIcon:
                                          //     const Icon(Icons.key, color: Colors.black),
                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          labelStyle: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      )),
                                ),
                                if (bill_addr.toString().trim() !=
                                    bill_addr_Check.toString().trim())
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String? ren =
                                            preferences.getString('renTalSer');
                                        String? ser_user =
                                            preferences.getString('ser');
                                        String value = bill_addr_Check!;
                                        String url =
                                            '${MyConstant().domain}/UpC_rentel_bill_addr.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                        try {
                                          var response =
                                              await http.get(Uri.parse(url));

                                          var result =
                                              json.decode(response.body);
                                          print(result);
                                          if (result.toString() == 'true') {
                                            Insert_log.Insert_logs('ตั้งค่า',
                                                'เอกสาร>>แก้ไข(ที่อยู่)');
                                            setState(() {
                                              read_GC_rental();
                                            });
                                          } else {}
                                        } catch (e) {}
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Translate.TranslateAndSetText(
                                              'บันทึก',
                                              Colors.white,
                                              TextAlign.left,
                                              null,
                                              Font_.Fonts_T,
                                              14,
                                              1),
                                          // const Text(
                                          //   'บันทึก',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontFamily: Font_.Fonts_T
                                          //       //fontWeight: FontWeight.bold,
                                          //       //fontSize: 10.0
                                          //       ),
                                          // ),
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
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      width: (!Responsive.isDesktop(context))
                                          ? MediaQuery.of(context).size.width +
                                              200
                                          : MediaQuery.of(context).size.width *
                                              0.84,
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'TAX ID',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: SettingScreen_Color
                                                      .Colors_Text2_,
                                                  fontFamily: Font_.Fonts_T
                                                  //fontWeight: FontWeight.bold,
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                // decoration: BoxDecoration(
                                                //   // color: Colors.green,
                                                //   borderRadius: const BorderRadius.only(
                                                //     topLeft: Radius.circular(6),
                                                //     topRight: Radius.circular(6),
                                                //     bottomLeft: Radius.circular(6),
                                                //     bottomRight: Radius.circular(6),
                                                //   ),
                                                //   border: Border.all(color: Colors.grey, width: 1),
                                                // ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  initialValue:
                                                      bill_tax!.trim(),
                                                  onFieldSubmitted:
                                                      (value) async {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? ren = preferences
                                                        .getString('renTalSer');
                                                    String? ser_user =
                                                        preferences
                                                            .getString('ser');

                                                    String url =
                                                        '${MyConstant().domain}/UpC_rentel_bill_tax.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                                    try {
                                                      var response = await http
                                                          .get(Uri.parse(url));

                                                      var result = json.decode(
                                                          response.body);
                                                      print(result);
                                                      if (result.toString() ==
                                                          'true') {
                                                        Insert_log.Insert_logs(
                                                            'ตั้งค่า',
                                                            'เอกสาร>>แก้ไข(TAX ID)');
                                                        setState(() {
                                                          read_GC_rental();
                                                        });
                                                      } else {}
                                                    } catch (e) {}
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      bill_tax_Check = value;
                                                    });
                                                  },
                                                  // maxLength: 13,
                                                  cursorColor: Colors.green,
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        AppbackgroundColor
                                                                .Sub_Abg_Colors
                                                            .withOpacity(0.5),
                                                    filled: true,
                                                    // prefixIcon:
                                                    //     const Icon(Icons.key, color: Colors.black),
                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    labelStyle: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                )),
                                          ),
                                          if (bill_tax.toString().trim() !=
                                              bill_tax_Check.toString().trim())
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () async {
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? ren = preferences
                                                      .getString('renTalSer');
                                                  String? ser_user = preferences
                                                      .getString('ser');
                                                  String value =
                                                      bill_tax_Check!;
                                                  String url =
                                                      '${MyConstant().domain}/UpC_rentel_bill_tax.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                                  try {
                                                    var response = await http
                                                        .get(Uri.parse(url));

                                                    var result = json
                                                        .decode(response.body);
                                                    print(result);
                                                    if (result.toString() ==
                                                        'true') {
                                                      Insert_log.Insert_logs(
                                                          'ตั้งค่า',
                                                          'เอกสาร>>แก้ไข(TAX ID)');
                                                      setState(() {
                                                        read_GC_rental();
                                                      });
                                                    } else {}
                                                  } catch (e) {}
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'บันทึก',
                                                            Colors.white,
                                                            TextAlign.left,
                                                            null,
                                                            Font_.Fonts_T,
                                                            14,
                                                            1),
                                                    // const Text(
                                                    //   'บันทึก',
                                                    //   textAlign:
                                                    //       TextAlign.center,
                                                    //   style: TextStyle(
                                                    //       color: Colors.white,
                                                    //       fontFamily:
                                                    //           Font_.Fonts_T
                                                    //       //fontWeight: FontWeight.bold,
                                                    //       //fontSize: 10.0
                                                    //       ),
                                                    // ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'เบอร์โทร',
                                                    SettingScreen_Color
                                                        .Colors_Text2_,
                                                    TextAlign.left,
                                                    null,
                                                    Font_.Fonts_T,
                                                    14,
                                                    1),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                // decoration: BoxDecoration(
                                                //   // color: Colors.green,
                                                //   borderRadius: const BorderRadius.only(
                                                //     topLeft: Radius.circular(6),
                                                //     topRight: Radius.circular(6),
                                                //     bottomLeft: Radius.circular(6),
                                                //     bottomRight: Radius.circular(6),
                                                //   ),
                                                //   border: Border.all(color: Colors.grey, width: 1),
                                                // ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  initialValue:
                                                      bill_tel!.trim(),
                                                  onFieldSubmitted:
                                                      (value) async {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? ren = preferences
                                                        .getString('renTalSer');
                                                    String? ser_user =
                                                        preferences
                                                            .getString('ser');

                                                    String url =
                                                        '${MyConstant().domain}/UpC_rentel_bill_tel.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                                    try {
                                                      var response = await http
                                                          .get(Uri.parse(url));

                                                      var result = json.decode(
                                                          response.body);
                                                      print(result);
                                                      if (result.toString() ==
                                                          'true') {
                                                        Insert_log.Insert_logs(
                                                            'ตั้งค่า',
                                                            'เอกสาร>>แก้ไข(เบอร์โทร)');
                                                        setState(() {
                                                          read_GC_rental();
                                                        });
                                                      } else {}
                                                    } catch (e) {}
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      bill_tel_Check = value;
                                                    });
                                                  },
                                                  maxLength: 10,
                                                  cursorColor: Colors.green,
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        AppbackgroundColor
                                                                .Sub_Abg_Colors
                                                            .withOpacity(0.5),
                                                    filled: true,
                                                    // prefixIcon:;
                                                    //     const Icon(Icons.key, color: Colors.black),
                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    labelStyle: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                  inputFormatters: <TextInputFormatter>[
                                                    // for below version 2 use this
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                    // for version 2 and greater youcan also use this
                                                    // FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                )),
                                          ),
                                          if (bill_tel.toString().trim() !=
                                              bill_tel_Check.toString().trim())
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () async {
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? ren = preferences
                                                      .getString('renTalSer');
                                                  String? ser_user = preferences
                                                      .getString('ser');
                                                  String value = bill_tel!;

                                                  String url =
                                                      '${MyConstant().domain}/UpC_rentel_bill_tel.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                                  try {
                                                    var response = await http
                                                        .get(Uri.parse(url));

                                                    var result = json
                                                        .decode(response.body);
                                                    print(result);
                                                    if (result.toString() ==
                                                        'true') {
                                                      Insert_log.Insert_logs(
                                                          'ตั้งค่า',
                                                          'เอกสาร>>แก้ไข(เบอร์โทร)');
                                                      setState(() {
                                                        read_GC_rental();
                                                      });
                                                    } else {}
                                                  } catch (e) {}
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'บันทึก',
                                                            Colors.white,
                                                            TextAlign.left,
                                                            null,
                                                            Font_.Fonts_T,
                                                            14,
                                                            1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'อีเมล',
                                                    SettingScreen_Color
                                                        .Colors_Text2_,
                                                    TextAlign.left,
                                                    null,
                                                    Font_.Fonts_T,
                                                    14,
                                                    1),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                // decoration: BoxDecoration(
                                                //   // color: Colors.green,
                                                //   borderRadius: const BorderRadius.only(
                                                //     topLeft: Radius.circular(6),
                                                //     topRight: Radius.circular(6),
                                                //     bottomLeft: Radius.circular(6),
                                                //     bottomRight: Radius.circular(6),
                                                //   ),
                                                //   border: Border.all(color: Colors.grey, width: 1),
                                                // ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  initialValue:
                                                      bill_email!.trim(),
                                                  onFieldSubmitted:
                                                      (value) async {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? ren = preferences
                                                        .getString('renTalSer');
                                                    String? ser_user =
                                                        preferences
                                                            .getString('ser');

                                                    String url =
                                                        '${MyConstant().domain}/UpC_rentel_bill_email.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                                    try {
                                                      var response = await http
                                                          .get(Uri.parse(url));

                                                      var result = json.decode(
                                                          response.body);
                                                      print(result);
                                                      if (result.toString() ==
                                                          'true') {
                                                        Insert_log.Insert_logs(
                                                            'ตั้งค่า',
                                                            'เอกสาร>>แก้ไข(อีเมล)');
                                                        setState(() {
                                                          read_GC_rental();
                                                        });
                                                      } else {}
                                                      // ScaffoldMessenger.of(context).showSnackBar(
                                                      //   SnackBar(
                                                      //       content: Text('บันทึกสำเร็จ',
                                                      //           style: TextStyle(
                                                      //               color: Colors.white,
                                                      //               fontFamily: Font_.Fonts_T))),
                                                      // );
                                                    } catch (e) {}
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      bill_email_Check = value;
                                                    });
                                                  },
                                                  // maxLength: 13,
                                                  cursorColor: Colors.green,
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        AppbackgroundColor
                                                                .Sub_Abg_Colors
                                                            .withOpacity(0.5),
                                                    filled: true,
                                                    // prefixIcon:
                                                    //     const Icon(Icons.key, color: Colors.black),
                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    labelStyle: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                )),
                                          ),
                                          if (bill_email.toString().trim() !=
                                              bill_email_Check
                                                  .toString()
                                                  .trim())
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () async {
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? ren = preferences
                                                      .getString('renTalSer');
                                                  String? ser_user = preferences
                                                      .getString('ser');
                                                  String value =
                                                      bill_email_Check!;
                                                  String url =
                                                      '${MyConstant().domain}/UpC_rentel_bill_email.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                                  try {
                                                    var response = await http
                                                        .get(Uri.parse(url));

                                                    var result = json
                                                        .decode(response.body);
                                                    print(result);
                                                    if (result.toString() ==
                                                        'true') {
                                                      Insert_log.Insert_logs(
                                                          'ตั้งค่า',
                                                          'เอกสาร>>แก้ไข(อีเมล)');
                                                      setState(() {
                                                        read_GC_rental();
                                                      });
                                                    } else {}
                                                    // ScaffoldMessenger.of(context).showSnackBar(
                                                    //   SnackBar(
                                                    //       content: Text('บันทึกสำเร็จ',
                                                    //           style: TextStyle(
                                                    //               color: Colors.white,
                                                    //               fontFamily: Font_.Fonts_T))),
                                                    // );
                                                  } catch (e) {}
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'บันทึก',
                                                            Colors.white,
                                                            TextAlign.left,
                                                            null,
                                                            Font_.Fonts_T,
                                                            14,
                                                            1),
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
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Translate.TranslateAndSetText(
                              'การรับเลขเอกสาร',
                              SettingScreen_Color.Colors_Text1_,
                              TextAlign.left,
                              null,
                              Font_.Fonts_T,
                              14,
                              1),
                          // Text(
                          //   'การรับเลขเอกสาร',
                          //   style: TextStyle(
                          //       color: SettingScreen_Color.Colors_Text1_,
                          //       fontFamily: FontWeight_.Fonts_T
                          //       //fontSize: 10.0
                          //       ),
                          // ),
                        ),
                      ],
                    ),
                    (!Responsive.isDesktop(context))
                        ? widget_mobile()
                        : Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppbackgroundColor
                                                        .TiTile_Colors,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          'ประเภทเอกสาร',
                                                          SettingScreen_Color
                                                              .Colors_Text1_,
                                                          TextAlign.left,
                                                          null,
                                                          Font_.Fonts_T,
                                                          14,
                                                          1),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Translate
                                                    .TranslateAndSetText(
                                                        'หัวบิล',
                                                        SettingScreen_Color
                                                            .Colors_Text1_,
                                                        TextAlign.left,
                                                        null,
                                                        Font_.Fonts_T,
                                                        14,
                                                        1),
                                                // Text(
                                                //   'หัวบิล',
                                                //   maxLines: 1,
                                                //   textAlign: TextAlign.center,
                                                //   style: TextStyle(
                                                //       color: SettingScreen_Color
                                                //           .Colors_Text1_,
                                                //       fontFamily:
                                                //           FontWeight_.Fonts_T
                                                //       //fontSize: 10.0
                                                //       ),
                                                // ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Translate
                                                    .TranslateAndSetText(
                                                        'เลขรับเริ่มต้น',
                                                        SettingScreen_Color
                                                            .Colors_Text1_,
                                                        TextAlign.left,
                                                        null,
                                                        Font_.Fonts_T,
                                                        14,
                                                        1),
                                                // const Text(
                                                //   'เลขรับเริ่มต้น',
                                                //   maxLines: 1,
                                                //   textAlign: TextAlign.center,
                                                //   style: TextStyle(
                                                //       color: SettingScreen_Color
                                                //           .Colors_Text1_,
                                                //       fontFamily:
                                                //           FontWeight_.Fonts_T
                                                //       //fontSize: 10.0
                                                //       ),
                                                // ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppbackgroundColor
                                                      .TiTile_Colors,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10),
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
                                                child: const Text(
                                                  '',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
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
                                      Container(
                                        height: 380,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
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
                                          // controller: _scrollController1,
                                          // itemExtent: 50,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: doctypeOneModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return doctypeOneModels.isEmpty
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
                                                                      50),
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
                                                                      .all(8.0),
                                                              child: (elapsed >
                                                                      3.00)
                                                                  ? Translate.TranslateAndSetText(
                                                                      'ไม่พบข้อมูล',
                                                                      SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      TextAlign
                                                                          .center,
                                                                      null,
                                                                      Font_
                                                                          .Fonts_T,
                                                                      14,
                                                                      1)
                                                                  : const Column(
                                                                      children: [
                                                                        CircularProgressIndicator(),
                                                                        // Text(
                                                                        //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                        //   style: const TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text2_,
                                                                        //       fontFamily:
                                                                        //           Font_
                                                                        //               .Fonts_T
                                                                        //       //fontSize: 10.0
                                                                        //       ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Material(
                                                    color: tappedIndex_1 ==
                                                            index.toString()
                                                        ? tappedIndex_Color
                                                            .tappedIndex_Colors
                                                        : AppbackgroundColor
                                                            .Sub_Abg_Colors,
                                                    child: Container(
                                                      // color: tappedIndex_1 ==
                                                      //         index.toString()
                                                      //     ? Colors.grey.shade300
                                                      //     : null,
                                                      child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            tappedIndex_1 =
                                                                index
                                                                    .toString();
                                                          });
                                                        },
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
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: Translate.TranslateAndSetText(
                                                                    '${doctypeOneModels[index].bills}',
                                                                    SettingScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .left,
                                                                    null,
                                                                    Font_
                                                                        .Fonts_T,
                                                                    14,
                                                                    1),
                                                                // Text(
                                                                //   '${doctypeOneModels[index].bills}',
                                                                //   textAlign:
                                                                //       TextAlign
                                                                //           .start,
                                                                //   style: const TextStyle(
                                                                //       color: SettingScreen_Color
                                                                //           .Colors_Text2_,
                                                                //       fontFamily:
                                                                //           Font_
                                                                //               .Fonts_T
                                                                //       //fontWeight: FontWeight.bold,
                                                                //       //fontSize: 10.0
                                                                //       ),
                                                                // ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${doctypeOneModels[index].doccode}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T
                                                                      //fontWeight: FontWeight.bold,
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  '${doctypeOneModels[index].startbill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T
                                                                      //fontWeight: FontWeight.bold,
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        DialogEdit(
                                                                          index,
                                                                          '${doctypeOneModels[index].bills}',
                                                                          '${doctypeOneModels[index].doccode}',
                                                                          '${doctypeOneModels[index].startbill}',
                                                                          '${doctypeOneModels[index].ser}',
                                                                          '${doctypeOneModels[index].dtype}',
                                                                          '${doctypeOneModels[index].yy}',
                                                                          '${doctypeOneModels[index].mm}',
                                                                        );
                                                                        // print(
                                                                        //     'แก้ไข${doctypeOneModels[index].bills} // ser : ${doctypeOneModels[index].ser}');
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.blueGrey.shade100,
                                                                            borderRadius:
                                                                                const BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10),
                                                                            ),
                                                                            // border: Border.all(
                                                                            //     color: Colors.grey, width: 1),
                                                                          ),
                                                                          padding: const EdgeInsets.all(4.0),
                                                                          child: Translate.TranslateAndSetText('แก้ไข', SettingScreen_Color.Colors_Text1_, TextAlign.left, null, Font_.Fonts_T, 14, 1)),
                                                                    ),
                                                                  ],
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
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .TiTile_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'REFประเภทค่าบริการ',
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                            TextAlign.left,
                                                            null,
                                                            Font_.Fonts_T,
                                                            14,
                                                            1)

                                                    //  Text(
                                                    //   'REFประเภทค่าบริการ',
                                                    //   textAlign: TextAlign.center,
                                                    //   style: TextStyle(
                                                    //     color: SettingScreen_Color
                                                    //         .Colors_Text1_,
                                                    //     fontFamily:
                                                    //         FontWeight_.Fonts_T,
                                                    //     fontWeight:
                                                    //         FontWeight.bold,
                                                    //     //fontSize: 10.0
                                                    //   ),
                                                    // ),
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  color: AppbackgroundColor
                                                      .TiTile_Colors,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          'หัวบิล',
                                                          SettingScreen_Color
                                                              .Colors_Text1_,
                                                          TextAlign.left,
                                                          null,
                                                          Font_.Fonts_T,
                                                          14,
                                                          1)

                                                  //  const Text(
                                                  //   'หัวบิล',
                                                  //   textAlign: TextAlign.center,
                                                  //   style: TextStyle(
                                                  //     color: SettingScreen_Color
                                                  //         .Colors_Text1_,
                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //     fontWeight: FontWeight.bold,
                                                  //     //fontSize: 10.0
                                                  //   ),
                                                  // ),
                                                  ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppbackgroundColor
                                                      .TiTile_Colors,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10),
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
                                                child: const Text(
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
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 380,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
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
                                          // controller: _scrollController1,
                                          // itemExtent: 50,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: doctypeTwoModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return doctypeTwoModels.isEmpty
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
                                                                      50),
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
                                                                      .all(8.0),
                                                              child: (elapsed >
                                                                      3.00)
                                                                  ? Translate.TranslateAndSetText(
                                                                      'ไม่พบข้อมูล',
                                                                      SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      TextAlign
                                                                          .left,
                                                                      null,
                                                                      Font_
                                                                          .Fonts_T,
                                                                      14,
                                                                      1)
                                                                  : const Column(
                                                                      children: [
                                                                        CircularProgressIndicator(),
                                                                        // Text(
                                                                        //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                        //   style: const TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text2_,
                                                                        //       fontFamily:
                                                                        //           Font_
                                                                        //               .Fonts_T
                                                                        //       //fontSize: 10.0
                                                                        //       ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Material(
                                                    color: tappedIndex_2 ==
                                                            index.toString()
                                                        ? tappedIndex_Color
                                                            .tappedIndex_Colors
                                                        : AppbackgroundColor
                                                            .Sub_Abg_Colors,
                                                    child: Container(
                                                      // color: tappedIndex_2 ==
                                                      //         index.toString()
                                                      //     ? Colors.grey.shade300
                                                      //     : null,
                                                      child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            tappedIndex_2 =
                                                                index
                                                                    .toString();
                                                          });
                                                        },
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
                                                            children: [
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Translate.TranslateAndSetText(
                                                                      '${doctypeTwoModels[index].bills}',
                                                                      SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      TextAlign
                                                                          .left,
                                                                      null,
                                                                      Font_
                                                                          .Fonts_T,
                                                                      14,
                                                                      1)

                                                                  //  Text(
                                                                  //   '${doctypeTwoModels[index].bills}',
                                                                  //   textAlign:
                                                                  //       TextAlign
                                                                  //           .start,
                                                                  //   style: const TextStyle(
                                                                  //       color: SettingScreen_Color
                                                                  //           .Colors_Text2_,
                                                                  //       fontFamily:
                                                                  //           Font_
                                                                  //               .Fonts_T
                                                                  //       //fontWeight: FontWeight.bold,
                                                                  //       //fontSize: 10.0
                                                                  //       ),
                                                                  // ),
                                                                  ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${doctypeTwoModels[index].doccode}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T
                                                                      //fontWeight: FontWeight.bold,
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  '${doctypeTwoModels[index].startbill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T
                                                                      //fontWeight: FontWeight.bold,
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        DialogEdit(
                                                                          index,
                                                                          '${doctypeTwoModels[index].bills}',
                                                                          '${doctypeTwoModels[index].doccode}',
                                                                          '${doctypeTwoModels[index].startbill}',
                                                                          '${doctypeTwoModels[index].ser}',
                                                                          '${doctypeTwoModels[index].dtype}',
                                                                          '${doctypeTwoModels[index].yy}',
                                                                          '${doctypeTwoModels[index].mm}',
                                                                        );
                                                                        // print(
                                                                        //     'แก้ไข${doctypeTwoModels[index].bills}// ser : ${doctypeTwoModels[index].ser}');
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.blueGrey.shade100,
                                                                            borderRadius:
                                                                                const BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10),
                                                                            ),
                                                                            // border: Border.all(
                                                                            //     color: Colors.grey, width: 1),
                                                                          ),
                                                                          padding: const EdgeInsets.all(4.0),
                                                                          child: Translate.TranslateAndSetText('แก้ไข', SettingScreen_Color.Colors_Text1_, TextAlign.left, null, Font_.Fonts_T, 14, 1)
                                                                          //     const Text(
                                                                          //   'แก้ไข',
                                                                          //   textAlign:
                                                                          //       TextAlign.center,
                                                                          //   style: TextStyle(
                                                                          //       color: SettingScreen_Color.Colors_Text2_,
                                                                          //       fontFamily: Font_.Fonts_T
                                                                          //       //fontWeight: FontWeight.bold,
                                                                          //       //fontSize: 10.0
                                                                          //       ),
                                                                          // ),
                                                                          ),
                                                                    ),
                                                                  ],
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
                        child: Row(
                          children: [
                            Container(
                              width: (!Responsive.isDesktop(context))
                                  ? 500
                                  : MediaQuery.of(context).size.width * 0.85,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 250,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        // padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(0)),
                                                // border: Border.all(color: Colors.white, width: 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              'ตัวอย่างรูปแบบเลขเอกสาร',
                                                              SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              TextAlign.left,
                                                              null,
                                                              Font_.Fonts_T,
                                                              14,
                                                              1)

                                                      //  Text(
                                                      //   'ตัวอย่างรูปแบบเลขเอกสาร',
                                                      //   textAlign:
                                                      //       TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color:
                                                      //         SettingScreen_Color
                                                      //             .Colors_Text2_,
                                                      //     fontFamily:
                                                      //         FontWeight_.Fonts_T,
                                                      //     fontWeight:
                                                      //         FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                      ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '$expbill_name',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily: Font_.Fonts_T
                                                    //fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                color: Colors.blueGrey.shade100,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '$expbill/R-000001',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text2_,
                                                      fontFamily: Font_.Fonts_T
                                                      //fontWeight: FontWeight.bold,
                                                      //fontSize: 10.0
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 250,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        // padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(0)),
                                                // border: Border.all(color: Colors.white, width: 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              'ค่า DEFAULT การออกบิล',
                                                              SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              TextAlign.left,
                                                              null,
                                                              Font_.Fonts_T,
                                                              14,
                                                              1)

                                                      // Text(
                                                      //   'ค่า DEFAULT การออกบิล',
                                                      //   textAlign:
                                                      //       TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color:
                                                      //         SettingScreen_Color
                                                      //             .Colors_Text2_,
                                                      //     fontFamily:
                                                      //         FontWeight_.Fonts_T,
                                                      //     fontWeight:
                                                      //         FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                      ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4.0),
                                                              child: Translate
                                                                  .TranslateAndSetText(
                                                                      'ภาษา',
                                                                      SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      TextAlign
                                                                          .left,
                                                                      null,
                                                                      Font_
                                                                          .Fonts_T,
                                                                      14,
                                                                      1)

                                                              // Text(
                                                              //   'ภาษา',
                                                              //   textAlign:
                                                              //       TextAlign
                                                              //           .start,
                                                              //   style: TextStyle(
                                                              //     color: SettingScreen_Color
                                                              //         .Colors_Text2_,
                                                              //     fontFamily:
                                                              //         FontWeight_
                                                              //             .Fonts_T,
                                                              //     fontWeight:
                                                              //         FontWeight
                                                              //             .bold,
                                                              //     //fontSize: 10.0
                                                              //   ),
                                                              // ),
                                                              ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
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
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            width: 200,
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
                                                                              10),
                                                                ),
                                                              ),
                                                              isExpanded: true,
                                                              hint: Text(
                                                                (Language ==
                                                                            'TH' ||
                                                                        Language ==
                                                                            null)
                                                                    ? 'THI'
                                                                    : 'LAO',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: SettingScreen_Color
                                                                        .Colors_Text2_,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                              ),
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              iconSize: 30,
                                                              buttonHeight: 40,
                                                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                              dropdownDecoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              items: [
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: 'TH',
                                                                  child: Text(
                                                                    'TH',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                ),
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: 'LA',
                                                                  child: Text(
                                                                    'LA',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                              onChanged:
                                                                  (value) async {
                                                                var Language = (value ==
                                                                            'TH' ||
                                                                        value ==
                                                                            null)
                                                                    ? 'TH'
                                                                    : 'LA';
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
                                                                    '${MyConstant().domain}/UpC_rentel_bill_set.php?isAdd=true&ren=$ren&Language=$Language&ser_user=$ser_user&sertype=3';

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
                                                                        'เอกสาร>>แก้ไข(DEFAULT การออกบิล)');
                                                                    setState(
                                                                        () {
                                                                      read_GC_rental();
                                                                    });
                                                                  } else {}
                                                                  // ScaffoldMessenger.of(context).showSnackBar(
                                                                  //   SnackBar(
                                                                  //       content: Text('บันทึกสำเร็จ',
                                                                  //           style: TextStyle(
                                                                  //               color: Colors.white,
                                                                  //               fontFamily: Font_.Fonts_T))),
                                                                  // );
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          child: Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      4.0),
                                                              child: Translate.TranslateAndSetText(
                                                                  'รูปแบบบิล',
                                                                  SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .left,
                                                                  null,
                                                                  Font_.Fonts_T,
                                                                  14,
                                                                  1)

                                                              //  Text(
                                                              //   'รูปแบบบิล',
                                                              //   textAlign:
                                                              //       TextAlign
                                                              //           .start,
                                                              //   style: TextStyle(
                                                              //     color: SettingScreen_Color
                                                              //         .Colors_Text2_,
                                                              //     fontFamily:
                                                              //         FontWeight_
                                                              //             .Fonts_T,
                                                              //     fontWeight:
                                                              //         FontWeight
                                                              //             .bold,
                                                              //     //fontSize: 10.0
                                                              //   ),
                                                              // ),
                                                              ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
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
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            width: 200,
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
                                                                              10),
                                                                ),
                                                              ),
                                                              isExpanded: true,
                                                              hint: Translate.TranslateAndSetText(
                                                                  bill_default ==
                                                                          'P'
                                                                      ? 'บิลธรรมดา'
                                                                      : 'ใบกำกับภาษี',
                                                                  SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .left,
                                                                  null,
                                                                  Font_.Fonts_T,
                                                                  14,
                                                                  1),

                                                              // Text(
                                                              //   bill_default ==
                                                              //           'P'
                                                              //       ? 'บิลธรรมดา'
                                                              //       : 'ใบกำกับภาษี',
                                                              //   style: const TextStyle(
                                                              //       fontSize:
                                                              //           14,
                                                              //       color: SettingScreen_Color
                                                              //           .Colors_Text2_,
                                                              //       fontFamily:
                                                              //           Font_
                                                              //               .Fonts_T),
                                                              // ),
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              iconSize: 30,
                                                              buttonHeight: 40,
                                                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                              dropdownDecoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              items: bill_tser ==
                                                                      '1'
                                                                  ? Default_.map((item) =>
                                                                          DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                item,
                                                                            child:
                                                                                Text(
                                                                              item,
                                                                              style: const TextStyle(
                                                                                color: SettingScreen_Color.Colors_Text1_,
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ))
                                                                      .toList()
                                                                  : Default2_.map((item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            item,
                                                                        child: Translate.TranslateAndSetText(
                                                                            item,
                                                                            SettingScreen_Color.Colors_Text1_,
                                                                            TextAlign.left,
                                                                            null,
                                                                            Font_.Fonts_T,
                                                                            14,
                                                                            1),
                                                                        //     Text(
                                                                        //   item,
                                                                        //   style:
                                                                        //       const TextStyle(
                                                                        //     color:
                                                                        //         SettingScreen_Color.Colors_Text1_,
                                                                        //     fontSize:
                                                                        //         14,
                                                                        //   ),
                                                                        // ),
                                                                      )).toList(),
                                                              // validator: (value) {
                                                              //   if (value == null) {
                                                              //     return 'ค้นหายี่ห้อ.';
                                                              //   } else {}
                                                              // },
                                                              onChanged:
                                                                  (value) async {
                                                                var bill_set =
                                                                    value ==
                                                                            'บิลธรรมดา'
                                                                        ? 'P'
                                                                        : 'F';
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
                                                                    '${MyConstant().domain}/UpC_rentel_bill_set.php?isAdd=true&ren=$ren&value=$bill_set&ser_user=$ser_user&sertype=0';

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
                                                                        'เอกสาร>>แก้ไข(DEFAULT การออกบิล)');
                                                                    setState(
                                                                        () {
                                                                      read_GC_rental();
                                                                    });
                                                                  } else {}
                                                                  // ScaffoldMessenger.of(context).showSnackBar(
                                                                  //   SnackBar(
                                                                  //       content: Text('บันทึกสำเร็จ',
                                                                  //           style: TextStyle(
                                                                  //               color: Colors.white,
                                                                  //               fontFamily: Font_.Fonts_T))),
                                                                  // );
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 80,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            child: Translate
                                                                .TranslateAndSetText(
                                                                    'ใบเสร็จ',
                                                                    SettingScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .left,
                                                                    null,
                                                                    Font_
                                                                        .Fonts_T,
                                                                    14,
                                                                    1),
                                                            // Text(
                                                            //   'ใบเสร็จ',
                                                            //   textAlign:
                                                            //       TextAlign
                                                            //           .start,
                                                            //   style: TextStyle(
                                                            //     color: SettingScreen_Color
                                                            //         .Colors_Text2_,
                                                            //     fontFamily:
                                                            //         FontWeight_
                                                            //             .Fonts_T,
                                                            //     fontWeight:
                                                            //         FontWeight
                                                            //             .bold,
                                                            //     //fontSize: 10.0
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
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
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            width: 200,
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
                                                                              10),
                                                                ),
                                                              ),
                                                              isExpanded: true,
                                                              hint: Translate.TranslateAndSetText(
                                                                  (Receipt_default ==
                                                                          'N')
                                                                      ? 'ไม่ออกใบเสร็จ'
                                                                      : 'ออกใบเสร็จ',
                                                                  SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .left,
                                                                  null,
                                                                  Font_.Fonts_T,
                                                                  14,
                                                                  1),
                                                              // Text(
                                                              //   (Receipt_default ==
                                                              //           'N')
                                                              //       ? 'ไม่ออกใบเสร็จ'
                                                              //       : 'ออกใบเสร็จ',
                                                              //   style: const TextStyle(
                                                              //       fontSize:
                                                              //           14,
                                                              //       color: SettingScreen_Color
                                                              //           .Colors_Text2_,
                                                              //       fontFamily:
                                                              //           Font_
                                                              //               .Fonts_T),
                                                              // ),
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              iconSize: 30,
                                                              buttonHeight: 40,
                                                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                              dropdownDecoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              items: Default_Receipt
                                                                  .map((item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            item,
                                                                        child: Translate.TranslateAndSetText(
                                                                            item,
                                                                            SettingScreen_Color.Colors_Text1_,
                                                                            TextAlign.left,
                                                                            null,
                                                                            Font_.Fonts_T,
                                                                            14,
                                                                            1),
                                                                        // Text(
                                                                        //   item,
                                                                        //   style:
                                                                        //       const TextStyle(
                                                                        //     color:
                                                                        //         SettingScreen_Color.Colors_Text1_,
                                                                        //     fontSize:
                                                                        //         14,
                                                                        //   ),
                                                                        // ),
                                                                      )).toList(),
                                                              // validator: (value) {
                                                              //   if (value == null) {
                                                              //     return 'ค้นหายี่ห้อ.';
                                                              //   } else {}
                                                              // },
                                                              onChanged:
                                                                  (value) async {
                                                                var bill_set =
                                                                    value ==
                                                                            'ออกใบเสร็จ'
                                                                        ? 'Y'
                                                                        : 'N';
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
                                                                    '${MyConstant().domain}/UpC_rentel_bill_set.php?isAdd=true&ren=$ren&printbill=$bill_set&sertype=1';

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
                                                                        'เอกสาร>>แก้ไข(DEFAULT การออกบิล)');
                                                                    setState(
                                                                        () {
                                                                      read_GC_rental();
                                                                    });
                                                                  } else {}
                                                                  // ScaffoldMessenger.of(context).showSnackBar(
                                                                  //   SnackBar(
                                                                  //       content: Text('บันทึกสำเร็จ',
                                                                  //           style: TextStyle(
                                                                  //               color: Colors.white,
                                                                  //               fontFamily: Font_.Fonts_T))),
                                                                  // );
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 80,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            child: Translate
                                                                .TranslateAndSetText(
                                                                    'หัวบิล',
                                                                    SettingScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .left,
                                                                    null,
                                                                    Font_
                                                                        .Fonts_T,
                                                                    14,
                                                                    1),
                                                            // Text(
                                                            //   'หัวบิล',
                                                            //   textAlign:
                                                            //       TextAlign
                                                            //           .start,
                                                            //   style: TextStyle(
                                                            //     color: SettingScreen_Color
                                                            //         .Colors_Text2_,
                                                            //     fontFamily:
                                                            //         FontWeight_
                                                            //             .Fonts_T,
                                                            //     fontWeight:
                                                            //         FontWeight
                                                            //             .bold,
                                                            //     //fontSize: 10.0
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
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
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            width: 200,
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
                                                                              10),
                                                                ),
                                                              ),
                                                              isExpanded: true,
                                                              hint: Translate.TranslateAndSetText(
                                                                  '${TitleType_Default_Receipt_[Receipt_defaultTitle]}',
                                                                  SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .left,
                                                                  null,
                                                                  Font_.Fonts_T,
                                                                  14,
                                                                  1),

                                                              // Text(
                                                              //   '${TitleType_Default_Receipt_[Receipt_defaultTitle]}',
                                                              //   style: const TextStyle(
                                                              //       fontSize:
                                                              //           14,
                                                              //       color: SettingScreen_Color
                                                              //           .Colors_Text2_,
                                                              //       fontFamily:
                                                              //           Font_
                                                              //               .Fonts_T),
                                                              // ),
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              iconSize: 30,
                                                              buttonHeight: 40,
                                                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                              dropdownDecoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              items: TitleType_Default_Receipt_
                                                                  .map((item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            item,
                                                                        child: Translate.TranslateAndSetText(
                                                                            item,
                                                                            SettingScreen_Color.Colors_Text1_,
                                                                            TextAlign.left,
                                                                            null,
                                                                            Font_.Fonts_T,
                                                                            14,
                                                                            1),
                                                                        // Text(
                                                                        //   item,
                                                                        //   style:
                                                                        //       const TextStyle(
                                                                        //     color:
                                                                        //         SettingScreen_Color.Colors_Text1_,
                                                                        //     fontSize:
                                                                        //         14,
                                                                        //   ),
                                                                        // ),
                                                                      )).toList(),
                                                              // validator: (value) {
                                                              //   if (value == null) {
                                                              //     return 'ค้นหายี่ห้อ.';
                                                              //   } else {}
                                                              // },
                                                              onChanged:
                                                                  (value) async {
                                                                var bill_set = (value
                                                                            .toString()
                                                                            .trim() ==
                                                                        'ไม่ระบุ')
                                                                    ? '0'
                                                                    : (value.toString().trim() ==
                                                                            'ต้นฉบับ')
                                                                        ? '1'
                                                                        : (value.toString().trim() ==
                                                                                'สำเนา')
                                                                            ? '2'
                                                                            : '0';
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
                                                                    '${MyConstant().domain}/UpC_rentel_bill_set.php?isAdd=true&ren=$ren&valuetitle=$bill_set&sertype=2';

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
                                                                        'เอกสาร>>แก้ไข(DEFAULT การออกบิล)');
                                                                    setState(
                                                                        () {
                                                                      read_GC_rental();
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
      ],
    );
  }

  Widget widget_mobile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Translate.TranslateAndSetText(
                    'การรับเลขเอกสาร',
                    SettingScreen_Color.Colors_Text1_,
                    TextAlign.left,
                    null,
                    Font_.Fonts_T,
                    14,
                    1),
                // Text(
                //   'การรับเลขเอกสาร',
                //   style: TextStyle(
                //     color: SettingScreen_Color.Colors_Text1_,
                //     fontWeight: FontWeight.bold,
                //     //fontSize: 10.0
                //   ),
                // ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.TiTile_Colors,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Translate.TranslateAndSetText(
                                'ประเภทเอกสาร',
                                SettingScreen_Color.Colors_Text1_,
                                TextAlign.left,
                                null,
                                Font_.Fonts_T,
                                14,
                                1),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: AppbackgroundColor.TiTile_Colors,
                          padding: const EdgeInsets.all(8.0),
                          child: Translate.TranslateAndSetText(
                              'หัวบิล',
                              SettingScreen_Color.Colors_Text1_,
                              TextAlign.left,
                              null,
                              Font_.Fonts_T,
                              14,
                              1),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: AppbackgroundColor.TiTile_Colors,
                          padding: const EdgeInsets.all(8.0),
                          child: Translate.TranslateAndSetText(
                              'เลขรับเริ่มต้น',
                              SettingScreen_Color.Colors_Text1_,
                              TextAlign.left,
                              null,
                              Font_.Fonts_T,
                              14,
                              1),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppbackgroundColor.TiTile_Colors,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            // border: Border.all(
                            //     color: Colors.grey, width: 1),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: SettingScreen_Color.Colors_Text1_,
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
                  height: 380,
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
                    // controller: _scrollController1,
                    // itemExtent: 50,
                    physics:
                        // const AlwaysScrollableScrollPhysics(),
                        const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctypeOneModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return doctypeOneModels.isEmpty
                          ? SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StreamBuilder(
                                    stream: Stream.periodic(
                                        const Duration(milliseconds: 50),
                                        (i) => i),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData)
                                        return const Text('');
                                      double elapsed = double.parse(
                                              snapshot.data.toString()) *
                                          0.05;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: (elapsed > 3.00)
                                            ? Translate.TranslateAndSetText(
                                                'ไม่พบข้อมูล',
                                                SettingScreen_Color
                                                    .Colors_Text1_,
                                                TextAlign.center,
                                                null,
                                                Font_.Fonts_T,
                                                14,
                                                1)
                                            : const Column(
                                                children: [
                                                  CircularProgressIndicator(),
                                                  // Text(
                                                  //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                  //   style: const TextStyle(
                                                  //       color: PeopleChaoScreen_Color
                                                  //           .Colors_Text2_,
                                                  //       fontFamily:
                                                  //           Font_
                                                  //               .Fonts_T
                                                  //       //fontSize: 10.0
                                                  //       ),
                                                  // ),
                                                ],
                                              ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Material(
                              color: tappedIndex_1 == index.toString()
                                  ? tappedIndex_Color.tappedIndex_Colors
                                  : AppbackgroundColor.Sub_Abg_Colors,
                              child: Container(
                                // color: tappedIndex_1 == index.toString()
                                //     ? Colors.grey.shade300
                                //     : null,
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      tappedIndex_1 = index.toString();
                                    });
                                  },
                                  title: Container(
                                    decoration: const BoxDecoration(
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
                                            child: Translate.TranslateAndSetText(
                                                '${doctypeOneModels[index].bills}',
                                                SettingScreen_Color
                                                    .Colors_Text1_,
                                                TextAlign.center,
                                                null,
                                                Font_.Fonts_T,
                                                14,
                                                1)

                                            // Text(
                                            //   '${doctypeOneModels[index].bills}',
                                            //   textAlign: TextAlign.start,
                                            //   style: const TextStyle(
                                            //       color: SettingScreen_Color
                                            //           .Colors_Text2_,
                                            //       fontFamily: Font_.Fonts_T
                                            //       //fontWeight: FontWeight.bold,
                                            //       //fontSize: 10.0
                                            //       ),
                                            // ),
                                            ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${doctypeOneModels[index].doccode}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: SettingScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                //fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '${doctypeOneModels[index].startbill}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: SettingScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                //fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  DialogEdit(
                                                    index,
                                                    '${doctypeOneModels[index].bills}',
                                                    '${doctypeOneModels[index].doccode}',
                                                    '${doctypeOneModels[index].startbill}',
                                                    '${doctypeOneModels[index].ser}',
                                                    '${doctypeOneModels[index].dtype}',
                                                    '${doctypeOneModels[index].yy}',
                                                    '${doctypeOneModels[index].mm}',
                                                  );
                                                  // print(
                                                  //     'แก้ไข${doctypeOneModels[index].bills} // ser : ${doctypeOneModels[index].ser}');
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .blueGrey.shade100,
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
                                                      // border: Border.all(
                                                      //     color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'แก้ไข',
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                            TextAlign.center,
                                                            null,
                                                            Font_.Fonts_T,
                                                            14,
                                                            1)
                                                    // const Text(
                                                    //   'แก้ไข',
                                                    //   textAlign: TextAlign.center,
                                                    //   style: TextStyle(
                                                    //       color:
                                                    //           SettingScreen_Color
                                                    //               .Colors_Text2_,
                                                    //       fontFamily:
                                                    //           Font_.Fonts_T
                                                    //       //fontWeight: FontWeight.bold,
                                                    //       //fontSize: 10.0
                                                    //       ),
                                                    // ),
                                                    ),
                                              ),
                                            ],
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Container(
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.TiTile_Colors,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                                // border: Border.all(
                                //     color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Translate.TranslateAndSetText(
                                  'REFประเภทค่าบริการ',
                                  SettingScreen_Color.Colors_Text1_,
                                  TextAlign.center,
                                  null,
                                  Font_.Fonts_T,
                                  14,
                                  1)
                              //  const Text(
                              //   'REFประเภทค่าบริการ',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: FontWeight_.Fonts_T,
                              //     fontWeight: FontWeight.bold,
                              //     //fontSize: 10.0
                              //   ),
                              // ),
                              ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            color: AppbackgroundColor.TiTile_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: Translate.TranslateAndSetText(
                                'หัวบิล',
                                SettingScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                null,
                                Font_.Fonts_T,
                                14,
                                1)
                            // const Text(
                            //   'หัวบิล',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: SettingScreen_Color.Colors_Text1_,
                            //     fontFamily: FontWeight_.Fonts_T,
                            //     fontWeight: FontWeight.bold,
                            //     //fontSize: 10.0
                            //   ),
                            // ),
                            ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppbackgroundColor.TiTile_Colors,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            // border: Border.all(
                            //     color: Colors.grey, width: 1),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: SettingScreen_Color.Colors_Text1_,
                              fontFamily: FontWeight_.Fonts_T,
                              fontWeight: FontWeight.bold,
                              //fontSize: 10.0
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 380,
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
                    // controller: _scrollController1,
                    // itemExtent: 50,
                    physics:
                        // const AlwaysScrollableScrollPhysics(),
                        const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctypeTwoModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return doctypeTwoModels.isEmpty
                          ? SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StreamBuilder(
                                    stream: Stream.periodic(
                                        const Duration(milliseconds: 50),
                                        (i) => i),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData)
                                        return const Text('');
                                      double elapsed = double.parse(
                                              snapshot.data.toString()) *
                                          0.05;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: (elapsed > 3.00)
                                            ? Translate.TranslateAndSetText(
                                                'ไม่พบข้อมูล',
                                                SettingScreen_Color
                                                    .Colors_Text1_,
                                                TextAlign.center,
                                                null,
                                                Font_.Fonts_T,
                                                14,
                                                1)
                                            : const Column(
                                                children: [
                                                  CircularProgressIndicator(),
                                                  // Text(
                                                  //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                  //   style: const TextStyle(
                                                  //       color: PeopleChaoScreen_Color
                                                  //           .Colors_Text2_,
                                                  //       fontFamily:
                                                  //           Font_
                                                  //               .Fonts_T
                                                  //       //fontSize: 10.0
                                                  //       ),
                                                  // ),
                                                ],
                                              ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Material(
                              color: tappedIndex_2 == index.toString()
                                  ? tappedIndex_Color.tappedIndex_Colors
                                  : AppbackgroundColor.Sub_Abg_Colors,
                              child: Container(
                                // color: tappedIndex_2 == index.toString()
                                //     ? Colors.grey.shade300
                                //     : null,
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      tappedIndex_2 = index.toString();
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
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Translate.TranslateAndSetText(
                                                '${doctypeTwoModels[index].bills}',
                                                SettingScreen_Color
                                                    .Colors_Text1_,
                                                TextAlign.left,
                                                null,
                                                Font_.Fonts_T,
                                                14,
                                                1)
                                            //  Text(
                                            //   '${doctypeTwoModels[index].bills}',
                                            //   textAlign: TextAlign.start,
                                            //   style: const TextStyle(
                                            //       color: SettingScreen_Color
                                            //           .Colors_Text2_,
                                            //       fontFamily: Font_.Fonts_T
                                            //       //fontWeight: FontWeight.bold,
                                            //       //fontSize: 10.0
                                            //       ),
                                            // ),
                                            ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${doctypeTwoModels[index].doccode}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: SettingScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                //fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '${doctypeTwoModels[index].startbill}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: SettingScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                //fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  DialogEdit(
                                                    index,
                                                    '${doctypeTwoModels[index].bills}',
                                                    '${doctypeTwoModels[index].doccode}',
                                                    '${doctypeTwoModels[index].startbill}',
                                                    '${doctypeTwoModels[index].ser}',
                                                    '${doctypeTwoModels[index].dtype}',
                                                    '${doctypeTwoModels[index].yy}',
                                                    '${doctypeTwoModels[index].mm}',
                                                  );
                                                  // print(
                                                  //     'แก้ไข${doctypeTwoModels[index].bills}// ser : ${doctypeTwoModels[index].ser}');
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .blueGrey.shade100,
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
                                                      // border: Border.all(
                                                      //     color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'แก้ไข',
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                            TextAlign.center,
                                                            null,
                                                            Font_.Fonts_T,
                                                            14,
                                                            1)),
                                              ),
                                            ],
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
    );
  }
}
