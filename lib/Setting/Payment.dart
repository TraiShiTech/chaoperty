// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetBank_Model.dart';
import '../Model/GetBanktype_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetPayType_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<PayMentModel> payMentModels = [];
  List<PayTypeModel> payTypeModels = [];
  List<GetBankModel> getBankModels = [];
  List<BanktypeModel> banktypeModels = [];
  //////////////////////----------------------------------
  String? renTal_user, renTal_name, zone_ser, zone_name;
  int select_1 = 0;
  int select_2 = 0;
  String? ser_typepay,
      name_typepay,
      ser_bank,
      name_bank,
      ser_bank_type,
      name_bank_type;
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  final _formKey = GlobalKey<FormState>();
  final bank_bank = TextEditingController();
  final ptname_bank = TextEditingController();
  final bno_bank = TextEditingController();
  final bname_bank = TextEditingController();
  final bsaka_bank = TextEditingController();
  final btype_bank = TextEditingController();
  ///////---------------------------------------------------->
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_PayMentModel();
    type_PayMent();
    type_bank();
    type_bank_type();
  }

  Future<Null> type_PayMent() async {
    if (payTypeModels.length != 0) {
      payTypeModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('ren >>>>>> $ren');

    String url = '${MyConstant().domain}/GC_paytype.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          PayTypeModel payTypeModel = PayTypeModel.fromJson(map);
          setState(() {
            payTypeModels.add(payTypeModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> type_bank() async {
    if (getBankModels.length != 0) {
      getBankModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('ren >>>>>> $ren');

    Map<String, dynamic> map = Map();

    map['ser'] = '0';
    map['bcode'] = '0';
    map['bname'] = ' ';
    map['btype'] = ' ';
    map['st'] = '1';
    map['data_update'] = '0';

    GetBankModel getBankModel = GetBankModel.fromJson(map);

    setState(() {
      getBankModels.add(getBankModel);
    });

    String url = '${MyConstant().domain}/GC_bank.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          GetBankModel getBankModel = GetBankModel.fromJson(map);
          setState(() {
            getBankModels.add(getBankModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> type_bank_type() async {
    if (banktypeModels.length != 0) {
      banktypeModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('ren >>>>>> $ren');
    Map<String, dynamic> map = Map();

    map['ser'] = '0';
    map['btype'] = '';
    map['st'] = '1';
    map['data_update'] = '0';

    BanktypeModel banktypeModel = BanktypeModel.fromJson(map);

    setState(() {
      banktypeModels.add(banktypeModel);
    });

    String url = '${MyConstant().domain}/GC_bank_type.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          BanktypeModel banktypeModel = BanktypeModel.fromJson(map);
          setState(() {
            banktypeModels.add(banktypeModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  List typepay = [
    'เงินสด',
    'เงินโอน',
  ];

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
  }

  Future<Null> Edit_PayMent() async {
    if (payMentModels.length != 0) {
      payMentModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('ren >>>>>> $ren');

    String url = '${MyConstant().domain}/Edit_payMent.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          PayMentModel payMentModel = PayMentModel.fromJson(map);
          setState(() {
            payMentModels.add(payMentModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_PayMentModel() async {
    if (payMentModels.length != 0) {
      payMentModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('ren >>>>>> $ren');

    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          PayMentModel payMentModel = PayMentModel.fromJson(map);
          setState(() {
            payMentModels.add(payMentModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  /////////---------------------------------------------------->
  ScrollController _scrollController1 = ScrollController();

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        children: [
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
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
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
                        : MediaQuery.of(context).size.width * 0.84,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                child: Container(
                                  decoration: const BoxDecoration(
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
                                  child: Text(
                                    'รูปแบบ',
                                    maxLines: 2,
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
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 50,
                                color: AppbackgroundColor.TiTile_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'เปิดรับชำระผ่านเว็บ"',
                                  maxLines: 2,
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
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 50,
                                color: AppbackgroundColor.TiTile_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'ชื่อบัญชี',
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text1_,
                                        fontFamily: FontWeight_.Fonts_T,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 50,
                                color: AppbackgroundColor.TiTile_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'สาขา',
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text1_,
                                        fontFamily: FontWeight_.Fonts_T,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 50,
                                color: AppbackgroundColor.TiTile_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'ธนาคาร-เลขที่บัญชี',
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text1_,
                                        fontFamily: FontWeight_.Fonts_T,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                color: AppbackgroundColor.TiTile_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Auto',
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text1_,
                                        fontFamily: FontWeight_.Fonts_T,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
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
                                child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade900,
                                        borderRadius: const BorderRadius.only(
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
                                        'เพิ่มช่องทางการชำระ',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text3_,
                                            fontFamily: Font_.Fonts_T
                                            //fontWeight: FontWeight.bold,
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        bname_bank.text = '';
                                        bank_bank.text = '';
                                        bno_bank.text = '';
                                        bsaka_bank.text = '';
                                        btype_bank.text = '';
                                        ser_typepay = null;
                                        name_typepay = '';
                                        ser_bank = null;
                                        name_bank = '';
                                        ser_bank_type = null;
                                        name_bank_type = '';
                                      });

                                      showDialog<String>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => Form(
                                          key: _formKey,
                                          child: AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            title: const Center(
                                                child: Text(
                                              'แก้ไขการชำระ',
                                              style: TextStyle(
                                                color: SettingScreen_Color
                                                    .Colors_Text1_,
                                                fontFamily: FontWeight_.Fonts_T,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            content: Container(
                                              // height: MediaQuery.of(context).size.height / 1.5,
                                              width: (!Responsive.isDesktop(
                                                      context))
                                                  ? MediaQuery.of(context)
                                                      .size
                                                      .width
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                              decoration: const BoxDecoration(
                                                // color: Colors.grey[300],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                // border: Border.all(color: Colors.white, width: 1),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'ชื่อบัญชี',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 200,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              bname_bank,

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
                                                                  // prefixIcon:
                                                                  //     const Icon(Icons.person_pin, color: Colors.black),
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
                                                                  // labelText: 'ชื่อบัญชี',
                                                                  labelStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  )),
                                                          // inputFormatters: <TextInputFormatter>[
                                                          //   // for below version 2 use this
                                                          //   // FilteringTextInputFormatter.allow(
                                                          //   //     RegExp(r'[0-9]')),
                                                          //   // for version 2 and greater youcan also use this
                                                          //   FilteringTextInputFormatter.digitsOnly
                                                          // ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'ธนาคาร',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 200,
                                                        child:
                                                            DropdownButtonFormField2(
                                                          decoration:
                                                              InputDecoration(
                                                            //Add isDense true and zero Padding.
                                                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            //Add more decoration as you want here
                                                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                          ),
                                                          isExpanded: true,
                                                          // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                          hint: Row(
                                                            children: const [
                                                              Text(
                                                                'เลือก',
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ],
                                                          ),
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                          iconSize: 25,
                                                          buttonHeight: 42,
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
                                                          items: getBankModels
                                                              .map((item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        '${item.ser}:${item.bname}',
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            '${item.bname}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          onChanged:
                                                              (value) async {
                                                            // Do something when changing the item if you want.

                                                            var zones = value!
                                                                .indexOf(':');
                                                            var rtnameSer =
                                                                value.substring(
                                                                    0, zones);
                                                            var rtnameName =
                                                                value.substring(
                                                                    zones + 1);
                                                            print(
                                                                'mmmmm ${rtnameSer.toString()} $rtnameName');

                                                            setState(() {
                                                              ser_bank =
                                                                  rtnameSer;
                                                              name_bank =
                                                                  rtnameName;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'ประเภทบัญชี',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 200,
                                                        child:
                                                            DropdownButtonFormField2(
                                                          decoration:
                                                              InputDecoration(
                                                            //Add isDense true and zero Padding.
                                                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            //Add more decoration as you want here
                                                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                          ),
                                                          isExpanded: true,
                                                          // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                          hint: Row(
                                                            children: const [
                                                              Text(
                                                                'เลือก',
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ],
                                                          ),
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                          iconSize: 25,
                                                          buttonHeight: 42,
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
                                                          items: banktypeModels
                                                              .map((item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        '${item.ser}:${item.btype}',
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            '${item.btype}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          onChanged:
                                                              (value) async {
                                                            // Do something when changing the item if you want.

                                                            var zones = value!
                                                                .indexOf(':');
                                                            var rtnameSer =
                                                                value.substring(
                                                                    0, zones);
                                                            var rtnameName =
                                                                value.substring(
                                                                    zones + 1);
                                                            print(
                                                                'mmmmm ${rtnameSer.toString()} $rtnameName');

                                                            setState(() {
                                                              ser_bank_type =
                                                                  rtnameSer;
                                                              name_bank_type =
                                                                  rtnameName;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'เลขบัญชีธนาคาร/พร้อมเพย์(PromptPay)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 200,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller: bno_bank,

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
                                                                  // prefixIcon:
                                                                  //     const Icon(Icons.person_pin, color: Colors.black),
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
                                                                  labelStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  )),
                                                          // inputFormatters: <TextInputFormatter>[
                                                          //   // for below version 2 use this
                                                          //   // FilteringTextInputFormatter.allow(
                                                          //   //     RegExp(r'[0-9]')),
                                                          //   // for version 2 and greater youcan also use this
                                                          //   FilteringTextInputFormatter.digitsOnly
                                                          // ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'สาขา',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 200,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              bsaka_bank,

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
                                                                  // prefixIcon:
                                                                  //     const Icon(Icons.person_pin, color: Colors.black),
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
                                                                  labelStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  )),
                                                          // inputFormatters: <TextInputFormatter>[
                                                          //   // for below version 2 use this
                                                          //   // FilteringTextInputFormatter.allow(
                                                          //   //     RegExp(r'[0-9]')),
                                                          //   // for version 2 and greater youcan also use this
                                                          //   FilteringTextInputFormatter.digitsOnly
                                                          // ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'รูปแบบชำระ',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 200,

                                                        child:
                                                            DropdownButtonFormField2(
                                                          decoration:
                                                              InputDecoration(
                                                            //Add isDense true and zero Padding.
                                                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            //Add more decoration as you want here
                                                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                          ),
                                                          isExpanded: true,
                                                          // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                          hint: Row(
                                                            children: const [
                                                              Text(
                                                                'เลือก',
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ],
                                                          ),
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                          iconSize: 25,
                                                          buttonHeight: 42,
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
                                                          items: payTypeModels
                                                              .map((item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        '${item.ser}:${item.ptname}',
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            '${item.ptname}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          onChanged:
                                                              (value) async {
                                                            // Do something when changing the item if you want.

                                                            var zones = value!
                                                                .indexOf(':');
                                                            var rtnameSer =
                                                                value.substring(
                                                                    0, zones);
                                                            var rtnameName =
                                                                value.substring(
                                                                    zones + 1);
                                                            print(
                                                                'mmmmm ${rtnameSer.toString()} $rtnameName');

                                                            setState(() {
                                                              ser_typepay =
                                                                  rtnameSer;
                                                              name_typepay =
                                                                  rtnameName;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.green,
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
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                // if (_formKey
                                                                //     .currentState!
                                                                //     .validate()) {

                                                                //     }

                                                                var name_name =
                                                                    bname_bank
                                                                        .text;
                                                                // var name_bank =
                                                                //     bank_bank.text;
                                                                var name_num =
                                                                    bno_bank
                                                                        .text;
                                                                var name_sub =
                                                                    bsaka_bank
                                                                        .text;
                                                                var name_btype =
                                                                    btype_bank
                                                                        .text;
                                                                var name_type =
                                                                    ser_typepay;
                                                                var name_tpname =
                                                                    name_typepay;

                                                                var ser_banks =
                                                                    ser_bank;
                                                                var name_banks =
                                                                    name_bank;

                                                                var ser_bank_types =
                                                                    ser_bank_type;
                                                                var name_bank_types =
                                                                    name_bank_type;
                                                                print(
                                                                    '$name_name\n$name_num\n$name_sub\n$name_btype\n$name_type\n$name_tpname\n$ser_banks\n$name_banks\n$ser_bank_types\n$name_bank_types');
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
                                                                    '${MyConstant().domain}/In_c_payment.php?isAdd=true&ren=$ren&ser_user=$ser_user&name_name=$name_name&ser_banks=$ser_banks&name_banks=$name_banks&name_num=$name_num&name_sub=$name_sub&name_btype=$name_btype&name_tpname=$name_tpname&name_type=$name_type&ser_bank_types=$ser_bank_types&name_bank_types=$name_bank_types';

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
                                                                        'การรับชำระ>>เพิ่มช่องทางการชำระ(${bname_bank.text.toString()})');
                                                                    setState(
                                                                        () {
                                                                      bname_bank
                                                                          .clear();
                                                                      bank_bank
                                                                          .clear();
                                                                      bno_bank
                                                                          .clear();
                                                                      bsaka_bank
                                                                          .clear();
                                                                      btype_bank
                                                                          .clear();
                                                                      ser_typepay =
                                                                          null;
                                                                      name_typepay =
                                                                          null;
                                                                      ser_bank =
                                                                          null;
                                                                      name_bank =
                                                                          null;
                                                                      ser_bank_type =
                                                                          null;
                                                                      name_bank_type =
                                                                          null;
                                                                      read_GC_PayMentModel();
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  } else {}
                                                                } catch (e) {}
                                                              },
                                                              child: const Text(
                                                                'บันทึก',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.black,
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
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context,
                                                                      'OK'),
                                                              child: const Text(
                                                                'ยกเลิก',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: (!Responsive.isDesktop(context))
                                ? 800
                                : MediaQuery.of(context).size.width * 0.84,
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
                            child: payMentModels.isEmpty
                                ? SizedBox(
                                    width: (!Responsive.isDesktop(context))
                                        ? 800
                                        : MediaQuery.of(context).size.width *
                                            0.84,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: payMentModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Material(
                                        color: tappedIndex_ == index.toString()
                                            ? tappedIndex_Color
                                                .tappedIndex_Colors
                                            : AppbackgroundColor.Sub_Abg_Colors,
                                        child: Container(
                                          // color:
                                          //     tappedIndex_ == index.toString()
                                          //         ? tappedIndex_Color
                                          //             .tappedIndex_Colors
                                          //         : null,
                                          child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                tappedIndex_ = index.toString();
                                              });
                                            },
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${payMentModels[index].ptname}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            SettingScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T
                                                        //fontWeight: FontWeight.bold,
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: (payMentModels[
                                                                          index]
                                                                      .co
                                                                      .toString()
                                                                      .trim() ==
                                                                  'AC' ||
                                                              payMentModels[
                                                                          index]
                                                                      .co
                                                                      .toString()
                                                                      .trim() ==
                                                                  'OP')
                                                          ? InkWell(
                                                              child: Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    // color: Colors.grey.shade300,
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
                                                                  child: payMentModels[index]
                                                                              .ser_payweb ==
                                                                          '1'
                                                                      ? const Icon(
                                                                          Icons
                                                                              .toggle_on,
                                                                          color:
                                                                              Colors.green,
                                                                          size:
                                                                              50,
                                                                        )
                                                                      : const Icon(
                                                                          Icons
                                                                              .toggle_off,
                                                                          size:
                                                                              50,
                                                                        )),
                                                              onTap: () async {
                                                                var serx =
                                                                    payMentModels[
                                                                            index]
                                                                        .ser;
                                                                var serpayweb_ =
                                                                    payMentModels[index].ser_payweb ==
                                                                            '1'
                                                                        ? '0'
                                                                        : '1';

                                                                SharedPreferences
                                                                    preferences =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                var ren = preferences
                                                                    .getString(
                                                                        'renTalSer');
                                                                var user = preferences
                                                                    .getString(
                                                                        'ser');

                                                                String url =
                                                                    '${MyConstant().domain}/Up_Payment_ser_payweb.php?isAdd=true&ren=$ren&serx=$serx&serpayweb=$serpayweb_&user=$user';
                                                                try {
                                                                  var response =
                                                                      await http.get(
                                                                          Uri.parse(
                                                                              url));

                                                                  var result =
                                                                      json.decode(
                                                                          response
                                                                              .body);
                                                                  // print(result);
                                                                  if (result
                                                                          .toString() ==
                                                                      'true') {
                                                                    Insert_log.Insert_logs(
                                                                        'ตั้งค่า',
                                                                        (serpayweb_ ==
                                                                                '0')
                                                                            ? 'การรับชำระ>>ปรับการรับชำระผ่านหน้าเว็ป(ปิด ${payMentModels[index].ptname})'
                                                                            : 'การรับชำระ>>ปรับการรับชำระผ่านหน้าเว็ป(เปิด ${payMentModels[index].ptname})');
                                                                    setState(
                                                                        () {
                                                                      read_GC_PayMentModel();
                                                                    });
                                                                    print(
                                                                        'rrrrrrrrrrrrrr');
                                                                  }
                                                                } catch (e) {}
                                                              },
                                                            )
                                                          : Text('')),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${payMentModels[index].bname}',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 4,
                                                    style: const TextStyle(
                                                        color:
                                                            SettingScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T
                                                        //fontWeight: FontWeight.bold,
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${payMentModels[index].bsaka}',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 4,
                                                    style: const TextStyle(
                                                        color:
                                                            SettingScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T
                                                        //fontWeight: FontWeight.bold,
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${payMentModels[index].bank} ${payMentModels[index].bno}',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 4,
                                                    style: const TextStyle(
                                                        color:
                                                            SettingScreen_Color
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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            // color: Colors.grey.shade300,
                                                            borderRadius:
                                                                BorderRadius
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
                                                                          10),
                                                            ),
                                                            // border: Border.all(
                                                            //     color: Colors.grey, width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: payMentModels[
                                                                          index]
                                                                      .auto ==
                                                                  '1'
                                                              ? const Icon(
                                                                  Icons
                                                                      .toggle_on,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 50,
                                                                )
                                                              : const Icon(
                                                                  Icons
                                                                      .toggle_off,
                                                                  size: 50,
                                                                )),
                                                      onTap: () async {
                                                        var serx =
                                                            payMentModels[index]
                                                                .ser;
                                                        var autox =
                                                            payMentModels[index]
                                                                        .auto ==
                                                                    '1'
                                                                ? '0'
                                                                : '1';

                                                        SharedPreferences
                                                            preferences =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        var ren = preferences
                                                            .getString(
                                                                'renTalSer');
                                                        var user = preferences
                                                            .getString('ser');

                                                        String url =
                                                            '${MyConstant().domain}/Up_Payment_auto.php?isAdd=true&ren=$ren&serx=$serx&autox=$autox&user=$user';
                                                        try {
                                                          var response =
                                                              await http.get(
                                                                  Uri.parse(
                                                                      url));

                                                          var result = json
                                                              .decode(response
                                                                  .body);
                                                          // print(result);
                                                          if (result
                                                                  .toString() ==
                                                              'true') {
                                                            Insert_log.Insert_logs(
                                                                'ตั้งค่า',
                                                                (autox == '0')
                                                                    ? 'การรับชำระ>>ปรับการรับชำระ(ปิดAuto ${payMentModels[index].ptname})'
                                                                    : 'การรับชำระ>>ปรับการรับชำระ(เปิดAuto ${payMentModels[index].ptname})');
                                                            setState(() {
                                                              read_GC_PayMentModel();
                                                            });
                                                            print(
                                                                'rrrrrrrrrrrrrr');
                                                          }
                                                        } catch (e) {}
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blueGrey
                                                              .shade100,
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
                                                                .all(8.0),
                                                        child: const Text(
                                                          'แก้ไข',
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text2_,
                                                              fontFamily:
                                                                  Font_.Fonts_T
                                                              //fontWeight: FontWeight.bold,
                                                              //fontSize: 10.0
                                                              ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          bname_bank.text =
                                                              payMentModels[
                                                                      index]
                                                                  .bname!;
                                                          bank_bank.text =
                                                              payMentModels[
                                                                      index]
                                                                  .bank!;
                                                          bno_bank.text =
                                                              payMentModels[
                                                                      index]
                                                                  .bno!;
                                                          bsaka_bank.text =
                                                              payMentModels[
                                                                      index]
                                                                  .bsaka!;
                                                          btype_bank.text =
                                                              payMentModels[
                                                                      index]
                                                                  .btype!;
                                                          ser_typepay =
                                                              payMentModels[
                                                                      index]
                                                                  .ptser;
                                                          name_typepay =
                                                              payMentModels[
                                                                      index]
                                                                  .ptname;

                                                          ser_bank =
                                                              payMentModels[
                                                                      index]
                                                                  .bser;

                                                          name_bank =
                                                              payMentModels[
                                                                      index]
                                                                  .bank;

                                                          ser_bank_type =
                                                              payMentModels[
                                                                      index]
                                                                  .btser;

                                                          name_bank_type =
                                                              payMentModels[
                                                                      index]
                                                                  .btype;
                                                        });

                                                        showDialog<String>(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Form(
                                                            key: _formKey,
                                                            child: AlertDialog(
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.0))),
                                                              title:
                                                                  const Center(
                                                                      child:
                                                                          Text(
                                                                'แก้ไขการชำระ',
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
                                                                ),
                                                              )),
                                                              content:
                                                                  Container(
                                                                // height: MediaQuery.of(context).size.height / 1.5,
                                                                width: (!Responsive
                                                                        .isDesktop(
                                                                            context))
                                                                    ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width
                                                                    : MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.5,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  // color: Colors.grey[300],
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
                                                                  // border: Border.all(color: Colors.white, width: 1),
                                                                ),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'ชื่อบัญชี',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          // width: 200,
                                                                          child:
                                                                              TextFormField(
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            controller:
                                                                                bname_bank,

                                                                            // maxLength: 13,
                                                                            cursorColor:
                                                                                Colors.green,
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
                                                                                labelText: 'แก้ไขชื่อบัญชี',
                                                                                labelStyle: const TextStyle(
                                                                                  color: Colors.black54,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                )),
                                                                            // inputFormatters: <TextInputFormatter>[
                                                                            //   // for below version 2 use this
                                                                            //   // FilteringTextInputFormatter.allow(
                                                                            //   //     RegExp(r'[0-9]')),
                                                                            //   // for version 2 and greater youcan also use this
                                                                            //   FilteringTextInputFormatter.digitsOnly
                                                                            // ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'ธนาคาร',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          // width: 200,
                                                                          child:
                                                                              DropdownButtonFormField2(
                                                                            decoration:
                                                                                InputDecoration(
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
                                                                            isExpanded:
                                                                                true,
                                                                            // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                            hint:
                                                                                Text(
                                                                              payMentModels[index].bank == null ? 'เลือก' : '${payMentModels[index].bank}',
                                                                              style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.arrow_drop_down,
                                                                              color: Colors.black45,
                                                                            ),
                                                                            iconSize:
                                                                                25,
                                                                            buttonHeight:
                                                                                42,
                                                                            buttonPadding:
                                                                                const EdgeInsets.only(left: 10, right: 10),
                                                                            dropdownDecoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                            items: getBankModels
                                                                                .map((item) => DropdownMenuItem<String>(
                                                                                      value: '${item.ser}:${item.bname}',
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              '${item.bname}',
                                                                                              textAlign: TextAlign.start,
                                                                                              style: const TextStyle(
                                                                                                  fontSize: 14,
                                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                  // fontWeight: FontWeight.bold,
                                                                                                  fontFamily: Font_.Fonts_T),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ))
                                                                                .toList(),
                                                                            onChanged:
                                                                                (value) async {
                                                                              // Do something when changing the item if you want.

                                                                              var zones = value!.indexOf(':');
                                                                              var rtnameSer = value.substring(0, zones);
                                                                              var rtnameName = value.substring(zones + 1);
                                                                              print('mmmmm ${rtnameSer.toString()} $rtnameName');

                                                                              setState(() {
                                                                                ser_bank = rtnameSer;
                                                                                name_bank = rtnameName;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'ประเภทบัญชี',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          // width: 200,
                                                                          child:
                                                                              DropdownButtonFormField2(
                                                                            decoration:
                                                                                InputDecoration(
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
                                                                            isExpanded:
                                                                                true,
                                                                            // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                            hint:
                                                                                Text(
                                                                              payMentModels[index].btype == null ? 'เลือก' : '${payMentModels[index].btype}',
                                                                              style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.arrow_drop_down,
                                                                              color: Colors.black45,
                                                                            ),
                                                                            iconSize:
                                                                                25,
                                                                            buttonHeight:
                                                                                42,
                                                                            buttonPadding:
                                                                                const EdgeInsets.only(left: 10, right: 10),
                                                                            dropdownDecoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                            items: banktypeModels
                                                                                .map((item) => DropdownMenuItem<String>(
                                                                                      value: '${item.ser}:${item.btype}',
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              '${item.btype}',
                                                                                              textAlign: TextAlign.start,
                                                                                              style: const TextStyle(
                                                                                                  fontSize: 14,
                                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                  // fontWeight: FontWeight.bold,
                                                                                                  fontFamily: Font_.Fonts_T),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ))
                                                                                .toList(),
                                                                            onChanged:
                                                                                (value) async {
                                                                              // Do something when changing the item if you want.

                                                                              var zones = value!.indexOf(':');
                                                                              var rtnameSer = value.substring(0, zones);
                                                                              var rtnameName = value.substring(zones + 1);
                                                                              print('mmmmm ${rtnameSer.toString()} $rtnameName');

                                                                              setState(() {
                                                                                ser_bank_type = rtnameSer;
                                                                                name_bank_type = rtnameName;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'เลขบัญชีธนาคาร/พร้อมเพย์(PromptPay)',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          // width: 200,
                                                                          child:
                                                                              TextFormField(
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            controller:
                                                                                bno_bank,

                                                                            // maxLength: 13,
                                                                            cursorColor:
                                                                                Colors.green,
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
                                                                                labelText: 'แก้ไขเลขบัญชีธนาคาร',
                                                                                labelStyle: const TextStyle(
                                                                                  color: Colors.black54,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                )),
                                                                            // inputFormatters: <TextInputFormatter>[
                                                                            //   // for below version 2 use this
                                                                            //   // FilteringTextInputFormatter.allow(
                                                                            //   //     RegExp(r'[0-9]')),
                                                                            //   // for version 2 and greater youcan also use this
                                                                            //   FilteringTextInputFormatter.digitsOnly
                                                                            // ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'สาขา',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          // width: 200,
                                                                          child:
                                                                              TextFormField(
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            controller:
                                                                                bsaka_bank,

                                                                            // maxLength: 13,
                                                                            cursorColor:
                                                                                Colors.green,
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
                                                                                labelText: 'แก้ไขสาขา',
                                                                                labelStyle: const TextStyle(
                                                                                  color: Colors.black54,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                )),
                                                                            // inputFormatters: <TextInputFormatter>[
                                                                            //   // for below version 2 use this
                                                                            //   // FilteringTextInputFormatter.allow(
                                                                            //   //     RegExp(r'[0-9]')),
                                                                            //   // for version 2 and greater youcan also use this
                                                                            //   FilteringTextInputFormatter.digitsOnly
                                                                            // ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'รูปแบบชำระ',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          // width: 200,

                                                                          child:
                                                                              DropdownButtonFormField2(
                                                                            decoration:
                                                                                InputDecoration(
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
                                                                            isExpanded:
                                                                                true,
                                                                            // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                            hint:
                                                                                Text(
                                                                              payMentModels[index].ptname == null ? 'เลือก' : '${payMentModels[index].ptname}',
                                                                              style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.arrow_drop_down,
                                                                              color: Colors.black45,
                                                                            ),
                                                                            iconSize:
                                                                                25,
                                                                            buttonHeight:
                                                                                42,
                                                                            buttonPadding:
                                                                                const EdgeInsets.only(left: 10, right: 10),
                                                                            dropdownDecoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                            items: payTypeModels
                                                                                .map((item) => DropdownMenuItem<String>(
                                                                                      value: '${item.ser}:${item.ptname}',
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              '${item.ptname}',
                                                                                              textAlign: TextAlign.start,
                                                                                              style: const TextStyle(
                                                                                                  fontSize: 14,
                                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                  // fontWeight: FontWeight.bold,
                                                                                                  fontFamily: Font_.Fonts_T),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ))
                                                                                .toList(),
                                                                            onChanged:
                                                                                (value) async {
                                                                              // Do something when changing the item if you want.

                                                                              var zones = value!.indexOf(':');
                                                                              var rtnameSer = value.substring(0, zones);
                                                                              var rtnameName = value.substring(zones + 1);
                                                                              print('mmmmm ${rtnameSer.toString()} $rtnameName');

                                                                              setState(() {
                                                                                ser_typepay = rtnameSer;
                                                                                name_typepay = rtnameName;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
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
                                                                      color: Colors
                                                                          .grey,
                                                                      height:
                                                                          4.0,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          5.0,
                                                                    ),
                                                                    ScrollConfiguration(
                                                                      behavior: ScrollConfiguration.of(
                                                                              context)
                                                                          .copyWith(
                                                                              dragDevices: {
                                                                            PointerDeviceKind.touch,
                                                                            PointerDeviceKind.mouse,
                                                                          }),
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              width: (!Responsive.isDesktop(context)) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.85,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Container(
                                                                                        width: 100,
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.red,
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: TextButton(
                                                                                          onPressed: () async {
                                                                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                            String? ren = preferences.getString('renTalSer');
                                                                                            String? ser_user = preferences.getString('ser');
                                                                                            var ser_pay = payMentModels[index].ser;
                                                                                            String url = '${MyConstant().domain}/Dec_payment.php?isAdd=true&ren=$ren&ser_pay=$ser_pay&ser_user=$ser_user';

                                                                                            try {
                                                                                              var response = await http.get(Uri.parse(url));

                                                                                              var result = json.decode(response.body);
                                                                                              print(result);
                                                                                              if (result.toString() == 'true') {
                                                                                                Insert_log.Insert_logs('ตั้งค่า', 'การรับชำระ>>ลบ(*${payMentModels[index].bname})');
                                                                                                setState(() {
                                                                                                  bname_bank.clear();
                                                                                                  bank_bank.clear();
                                                                                                  bno_bank.clear();
                                                                                                  bsaka_bank.clear();
                                                                                                  btype_bank.clear();
                                                                                                  ser_typepay = null;
                                                                                                  name_typepay = null;
                                                                                                  ser_bank = null;
                                                                                                  name_bank = null;
                                                                                                  ser_bank_type = null;
                                                                                                  name_bank_type = null;
                                                                                                  read_GC_PayMentModel();
                                                                                                });
                                                                                                Navigator.pop(context);
                                                                                              } else {}
                                                                                            } catch (e) {}
                                                                                          },
                                                                                          child: const Text(
                                                                                            'ลบ',
                                                                                            style: TextStyle(
                                                                                              color: Colors.white,
                                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(child: Container()),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Container(
                                                                                        width: 100,
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.green,
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: TextButton(
                                                                                          onPressed: () async {
                                                                                            // if (_formKey
                                                                                            //     .currentState!
                                                                                            //     .validate()) {

                                                                                            //     }

                                                                                            var name_name = bname_bank.text;
                                                                                            // var name_bank =
                                                                                            //     bank_bank.text;
                                                                                            var name_num = bno_bank.text;
                                                                                            var name_sub = bsaka_bank.text;
                                                                                            var name_btype = btype_bank.text;
                                                                                            var name_type = ser_typepay;
                                                                                            var name_tpname = name_typepay;

                                                                                            var ser_banks = ser_bank;
                                                                                            var name_banks = name_bank;

                                                                                            var ser_bank_types = ser_bank_type;
                                                                                            var name_bank_types = name_bank_type;
                                                                                            print('$name_name\n$name_num\n$name_sub\n$name_btype\n$name_type\n$name_tpname\n$ser_banks\n$name_banks\n$ser_bank_types\n$name_bank_types');
                                                                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                            String? ren = preferences.getString('renTalSer');
                                                                                            String? ser_user = preferences.getString('ser');
                                                                                            var ser_pay = payMentModels[index].ser;
                                                                                            String url = '${MyConstant().domain}/UpC_payment.php?isAdd=true&ren=$ren&ser_pay=$ser_pay&ser_user=$ser_user&name_name=$name_name&ser_banks=$ser_banks&name_banks=$name_banks&name_num=$name_num&name_sub=$name_sub&name_btype=$name_btype&name_tpname=$name_tpname&name_type=$name_type&ser_bank_types=$ser_bank_types&name_bank_types=$name_bank_types';

                                                                                            try {
                                                                                              var response = await http.get(Uri.parse(url));

                                                                                              var result = json.decode(response.body);
                                                                                              print(result);
                                                                                              if (result.toString() == 'true') {
                                                                                                Insert_log.Insert_logs('ตั้งค่า', 'การรับชำระ>>แก้ไข(*${payMentModels[index].bname})');
                                                                                                setState(() {
                                                                                                  bname_bank.clear();
                                                                                                  bank_bank.clear();
                                                                                                  bno_bank.clear();
                                                                                                  bsaka_bank.clear();
                                                                                                  btype_bank.clear();
                                                                                                  ser_typepay = null;
                                                                                                  name_typepay = null;
                                                                                                  ser_bank = null;
                                                                                                  name_bank = null;
                                                                                                  ser_bank_type = null;
                                                                                                  name_bank_type = null;
                                                                                                  read_GC_PayMentModel();
                                                                                                });
                                                                                                Navigator.pop(context);
                                                                                              } else {}
                                                                                            } catch (e) {}
                                                                                          },
                                                                                          child: const Text(
                                                                                            'บันทึก',
                                                                                            style: TextStyle(
                                                                                              color: Colors.white,
                                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Container(
                                                                                        width: 100,
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.black,
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: TextButton(
                                                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                                                          child: const Text(
                                                                                            'ยกเลิก',
                                                                                            style: TextStyle(
                                                                                              color: Colors.white,
                                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
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
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
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
                            onTap: () {},
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
                                      fontFamily: Font_.Fonts_T),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              decoration: BoxDecoration(
                                // color: AppbackgroundColor
                                //     .TiTile_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(3.0),
                              child: const Text(
                                'Down',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                    fontFamily: Font_.Fonts_T),
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
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(3.0),
                            child: const Text(
                              'Scroll',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                  fontFamily: Font_.Fonts_T),
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
    );
  }
}
