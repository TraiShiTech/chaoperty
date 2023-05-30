import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/GetType_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class Add_Custo_Screen extends StatefulWidget {
  const Add_Custo_Screen({super.key});

  @override
  State<Add_Custo_Screen> createState() => _Add_Custo_ScreenState();
}

class _Add_Custo_ScreenState extends State<Add_Custo_Screen> {
  List<TypeModel> typeModels = [];
  List<TransModel> _TransModels = [];
  final _formKey = GlobalKey<FormState>();
  final Status4Form_nameshop = TextEditingController();
  final Status4Form_typeshop = TextEditingController();
  final Status4Form_bussshop = TextEditingController();
  final Status4Form_bussscontact = TextEditingController();
  final Status4Form_address = TextEditingController();
  final Status4Form_tel = TextEditingController();
  final Status4Form_email = TextEditingController();
  final Status4Form_tax = TextEditingController();
  final Status5Form_NoArea_ = TextEditingController();
  final Status5Form_NoArea_ren = TextEditingController();
  String? _Form_nameshop,
      _Form_typeshop,
      _Form_bussshop,
      _Form_bussscontact,
      _Form_address,
      _Form_tel,
      _Form_email,
      _Form_tax;
  String? renTal_user,
      renTal_name,
      zone_ser,
      zone_name,
      Value_cid,
      fname_,
      pdate,
      number_custno;
  String _verticalGroupValue = '';
  int Value_AreaSer_ = 0;
  @override
  void initState() {
    super.initState();
    checkPreferance();
    checkPreferance();
    read_GC_type();
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');
    });
  }

  Future<Null> read_GC_type() async {
    if (typeModels.isNotEmpty) {
      typeModels.clear();
    }

    String url = '${MyConstant().domain}/GC_type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TypeModel typeModel = TypeModel.fromJson(map);
          setState(() {
            typeModels.add(typeModel);
          });
        }
        // setState(() {
        //   for (var i = 0; i < typeModels.length; i++) {
        //     _verticalGroupValue = typeModels[i].type!;
        //   }
        // });
      } else {}
    } catch (e) {}
  }

  Future<Null> Save_FormText() async {
    // Value_AreaSer_ = int.parse(value!.ser!) - 1;
    // _verticalGroupValue = value.type!;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');

    String? nameshop = Status4Form_nameshop.text.toString();
    String? typeshop = Status4Form_typeshop.text.toString();
    String? bussshop = Status4Form_bussshop.text.toString();
    String? bussscontact =
        (_verticalGroupValue.toString().trim() == 'ส่วนตัว/บุคคลธรรมดา')
            ? Status4Form_bussshop.text.toString()
            : Status4Form_bussscontact.text.toString();
    String? address = Status4Form_address.text.toString();
    String? tel = Status4Form_tel.text.toString();
    String? email = Status4Form_email.text.toString();
    String? tax = Status4Form_tax.text.toString();

    // print(_verticalGroupValue);

    // print(nameshop);
    // print(typeshop);
    // print(bussshop);
    // print(bussscontact);
    // print(address);
    // print(tel);
    // print(email);
    // print(tax);

    String url =
        '${MyConstant().domain}/Inc_customer_Bureau.php?isAdd=true&ren=$ren&nameshop=$nameshop&typeshop=$typeshop&bussshop=$bussshop&bussscontact=$bussscontact&address=$address&tel=$tel&email=$email&tax=$tax&type=$_verticalGroupValue&user=$ser_user&typeapi=1';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        Insert_log.Insert_logs('ทะเบียน', 'เพิ่มข้อมูลลูกค้า>>($nameshop)');
        setState(() {
          // select_coutumer();
        });
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            Form(
              key: _formKey,
              child: Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                // height: 450,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              minFontSize: 10,
                              maxFontSize: 20,
                              'เพิ่มข้อมูลทะเบียนลูกค้า',
                              style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // _searchBar(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'ประเภท',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: StreamBuilder(
                                        stream: Stream.periodic(
                                            const Duration(seconds: 0)),
                                        builder: (context, snapshot) {
                                          return RadioGroup<TypeModel>.builder(
                                            direction: Axis.horizontal,
                                            groupValue: typeModels
                                                .elementAt(Value_AreaSer_),
                                            horizontalAlignment:
                                                MainAxisAlignment.spaceAround,
                                            onChanged: (value) {
                                              Status4Form_nameshop.clear();
                                              Status4Form_bussshop.clear();
                                              Status4Form_bussscontact.clear();
                                              setState(() {
                                                Value_AreaSer_ =
                                                    int.parse(value!.ser!) - 1;
                                                _verticalGroupValue =
                                                    value.type!;
                                                _TransModels = [];
                                              });
                                              print(Value_AreaSer_);
                                            },
                                            items: typeModels,
                                            textStyle: const TextStyle(
                                              fontSize: 15,
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                            ),
                                            itemBuilder: (typeXModels) =>
                                                RadioButtonBuilder(
                                              typeXModels.type!,
                                            ),
                                          );
                                        })),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'ชื่อร้านค้า',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  // keyboardType: TextInputType.name,
                                  controller: Status4Form_nameshop,
                                  // onChanged: (value) {
                                  //   // Status4Form_nameshop.text = value.trim();
                                  //   (Value_AreaSer_ + 1) == 1
                                  //       ? Status4Form_bussshop.text =
                                  //           value.trim()
                                  //       : Status4Form_bussscontact.text =
                                  //           value.trim();
                                  // },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรอกข้อมูลให้ครบถ้วน ';
                                    }
                                    // if (int.parse(value.toString()) < 13) {
                                    //   return '< 13';
                                    // }
                                    return null;
                                  },
                                  //  controller: (Value_AreaSer_ + 1) == 1
                                  //                                         ? Status4Form_bussshop
                                  //                                         : Status4Form_bussscontact,
                                  //                                     onChanged: (value) {
                                  //                                       Status4Form_nameshop.text = value.trim();
                                  //                                       if ((Value_AreaSer_ + 1) == 1) {
                                  //                                         _Form_bussshop = value.trim();
                                  //                                         Status4Form_bussshop.text =
                                  //                                                 value.trim()
                                  //                                       } else {
                                  //                                         _Form_bussscontact = value.trim();
                                  //                                         Status4Form_bussscontact.text =
                                  //                                                 value.trim()
                                  //                                       }
                                  //                                     },

                                  // maxLength: 13,
                                  cursorColor: Colors.green,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.3),
                                      filled: true,
                                      // prefixIcon:
                                      //     const Icon(Icons.person, color: Colors.black),
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
                                      labelText: 'ระบุชื่อร้านค้า',
                                      labelStyle: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      )),
                                  // inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                  // ],
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'ประเภทร้านค้า',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  //keyboardType: TextInputType.none,
                                  controller: Status4Form_typeshop,
                                  // onChanged: (value) =>
                                  //     _Form_typeshop =
                                  //         value.trim(),
                                  //initialValue: _Form_typeshop,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'กรอกข้อมูลให้ครบถ้วน ';
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
                                      //     const Icon(Icons.person, color: Colors.black),
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
                                      labelText: 'ระบุประเภทร้านค้า',
                                      labelStyle: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      )),
                                  // inputFormatters: <TextInputFormatter>[
                                  //   // for below version 2 use this
                                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  //   // for version 2 and greater youcan also use this
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
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
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'ชื่อผู้เช่า/บริษัท',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  //keyboardType: TextInputType.none,
                                  controller: (Value_AreaSer_ + 1) == 1
                                      ? Status4Form_bussshop
                                      : Status4Form_bussscontact,
                                  onChanged: (value) {
                                    // Status4Form_nameshop.text = value.trim();
                                    if ((Value_AreaSer_ + 1) == 1) {
                                      _Form_bussshop = value.trim();
                                    } else {
                                      _Form_bussscontact = value.trim();
                                    }
                                  },

                                  //initialValue: _Form_bussshop,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'กรอกข้อมูลให้ครบถ้วน ';
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
                                      //     const Icon(Icons.person, color: Colors.black),
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
                                      labelText: 'ระบุชื่อผู้เช่า/บริษัท',
                                      labelStyle: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      )),
                                  // inputFormatters: <TextInputFormatter>[
                                  //   // for below version 2 use this
                                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  //   // for version 2 and greater youcan also use this
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'ชื่อบุคคลติดต่อ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  //keyboardType: TextInputType.none,
                                  controller: Status4Form_bussshop,
                                  onChanged: (value) {
                                    if ((Value_AreaSer_ + 1) == 1) {
                                      Status4Form_nameshop.text = value.trim();
                                    } else {}
                                  },
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'กรอกข้อมูลให้ครบถ้วน ';
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
                                      //     const Icon(Icons.person, color: Colors.black),
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
                                      labelText: 'ระบุชื่อบุคคลติดต่อ',
                                      labelStyle: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      )),
                                  // inputFormatters: <TextInputFormatter>[
                                  //   // for below version 2 use this
                                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  //   // for version 2 and greater youcan also use this
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
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
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'ที่อยู่',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  //keyboardType: TextInputType.none,
                                  controller: Status4Form_address,
                                  // onChanged: (value) =>
                                  //     _Form_address =
                                  //         value.trim(),
                                  //initialValue: _Form_address,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'กรอกข้อมูลให้ครบถ้วน ';
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
                                      //     const Icon(Icons.person, color: Colors.black),
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
                                      labelText: 'ระบุที่อยู่',
                                      labelStyle: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      )),
                                  // inputFormatters: <TextInputFormatter>[
                                  //   // for below version 2 use this
                                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  //   // for version 2 and greater youcan also use this
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
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
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'เบอร์โทร',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  //keyboardType: TextInputType.none,
                                  controller: Status4Form_tel,
                                  // onChanged: (value) =>
                                  //     _Form_tel =
                                  //         value.trim(),
                                  //initialValue: _Form_tel,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'กรอกข้อมูลให้ครบถ้วน ';
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
                                      //     const Icon(Icons.person, color: Colors.black),
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
                                      labelText: 'ระบุเบอร์โทร',
                                      labelStyle: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      )),
                                  // inputFormatters: <TextInputFormatter>[
                                  //   // for below version 2 use this
                                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  //   // for version 2 and greater youcan also use this
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'อีเมล',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  //keyboardType: TextInputType.none,
                                  controller: Status4Form_email,
                                  // onChanged: (value) =>
                                  //     _Form_email =
                                  //         value.trim(),
                                  //initialValue: _Form_email,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'กรอกข้อมูลให้ครบถ้วน ';
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
                                      //     const Icon(Icons.person, color: Colors.black),
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
                                      labelText: 'ระบุอีเมล',
                                      labelStyle: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      )),
                                  // inputFormatters: <TextInputFormatter>[
                                  //   // for below version 2 use this
                                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  //   // for version 2 and greater youcan also use this
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
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
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'ID/TAX ID',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  //keyboardType: TextInputType.none,
                                  controller: Status4Form_tax,
                                  // onChanged: (value) =>
                                  //     _Form_tax =
                                  //         value.trim(),
                                  //initialValue: _Form_tax,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรอกข้อมูลให้ครบถ้วน ';
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
                                      //     const Icon(Icons.person, color: Colors.black),
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
                                      labelText: 'ระบุID/TAX ID',
                                      labelStyle: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      )),
                                  // inputFormatters: <TextInputFormatter>[
                                  //   // for below version 2 use this
                                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  //   // for version 2 and greater youcan also use this
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Text(
                                '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                // child: const Icon(Icons.check_box_outline_blank)
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                // Status4Form_nameshop.text =
                                //     _Form_nameshop.toString();
                                // Status4Form_typeshop.text =
                                //     _Form_typeshop.toString();
                                // Status4Form_bussshop.text =
                                //     _Form_bussshop.toString();
                                // Status4Form_bussscontact.text =
                                //     _Form_bussscontact.toString();
                                // Status4Form_address.text =
                                //     _Form_address.toString();
                                // Status4Form_tel.text = _Form_tel.toString();
                                // Status4Form_email.text = _Form_email.toString();
                                // Status4Form_tax.text = _Form_tax == null
                                //     ? "-"
                                //     : _Form_tax.toString();
                                //----------------------------------->

                                if (_formKey.currentState!.validate()) {
                                  print('---------------------------------->');
                                  print(Value_AreaSer_);
                                  print(_verticalGroupValue);
                                  print(
                                      '${typeModels.elementAt(Value_AreaSer_).type}');

                                  print('---------------------------------->');

                                  print(Status4Form_nameshop.text);
                                  print(Status4Form_typeshop.text);
                                  print(Status4Form_nameshop.text);
                                  print(Status4Form_bussshop.text);
                                  print(Status4Form_bussscontact.text);

                                  print(Status4Form_address.text);
                                  print(Status4Form_email.text);
                                  print(Status4Form_tax.text);
                                  print('----------------------------------');
                                  // Value_AreaSer_ = int.parse(value!.ser!) - 1;
                                  // _verticalGroupValue = value.type!;
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  var ren = preferences.getString('renTalSer');
                                  var user = preferences.getString('ser');

                                  String? nameshop =
                                      Status4Form_nameshop.text.toString();
                                  String? typeshop =
                                      Status4Form_typeshop.text.toString();
                                  String? bussshop =
                                      Status4Form_bussshop.text.toString();
                                  String? bussscontact =
                                      (_verticalGroupValue.toString().trim() ==
                                              'ส่วนตัว/บุคคลธรรมดา')
                                          ? Status4Form_bussshop.text.toString()
                                          : Status4Form_bussscontact.text
                                              .toString();
                                  String? address =
                                      Status4Form_address.text.toString();
                                  String? tel = Status4Form_tel.text.toString();
                                  String? email =
                                      Status4Form_email.text.toString();
                                  String? tax = Status4Form_tax.text.toString();

                                  // print(_verticalGroupValue);

                                  // print(nameshop);
                                  // print(typeshop);
                                  // print(bussshop);
                                  // print(bussscontact);
                                  // print(address);
                                  // print(tel);
                                  // print(email);
                                  // print(tax);

                                  // String url =
                                  //     '${MyConstant().domain}/InC_CustoAdd_Bureau.php?isAdd=true&ren=$ren&nameshop=$nameshop&typeshop=$typeshop&bussshop=$bussshop&bussscontact=$bussscontact&address=$address&tel=$tel&email=$email&tax=$tax&type=$_verticalGroupValue&user=$ser_user&typeapi=1';

                                  // String url =
                                  //     '${MyConstant().domain}/InC_CustoAdd_Bureau.php?isAdd=true&ren=$ren&nameshop=$nameshop&typeshop=$typeshop&bussshop=$bussshop&bussscontact=$bussscontact&address=$address&tel=$tel&email=$email&tax=$tax&type=$_verticalGroupValue';

                                  // try {
                                  //   var response =
                                  //       await http.get(Uri.parse(url));

                                  //   var result = json.decode(response.body);
                                  //   print(result);
                                  //   setState(() async {
                                  //     Status4Form_nameshop.text = '';
                                  //     Status4Form_typeshop.text = '';
                                  //     Status4Form_bussshop.text = '';
                                  //     Status4Form_bussscontact.text = '';
                                  //     Status4Form_address.text = '';
                                  //     Status4Form_tel.text = '';
                                  //     Status4Form_email.text = '';
                                  //     Status4Form_tax.text = '';
                                  //     Status5Form_NoArea_.text = '';
                                  //   });
                                  // } catch (e) {}
                                  String url =
                                      '${MyConstant().domain}/InC_CustoAdd_Bureau.php?isAdd=true&ren=$ren';

                                  var response =
                                      await http.post(Uri.parse(url), body: {
                                    'ciddoc': '',
                                    'qutser': '',
                                    'user': '',
                                    'sumdis': '',
                                    'sumdisp': '',
                                    'dateY': '',
                                    'dateY1': '',
                                    'time': '',
                                    'payment1': '',
                                    'payment2': '',
                                    'pSer1': '',
                                    'pSer2': '',
                                    'sum_whta': '',
                                    'bill': '',
                                    'fileNameSlip': '',
                                    'areaSer': '',
                                    'typeModels':
                                        '${typeModels.elementAt(Value_AreaSer_).type}',
                                    'typeshop':
                                        Status4Form_typeshop.text.toString(),
                                    'nameshop':
                                        Status4Form_nameshop.text.toString(),
                                    'bussshop':
                                        Status4Form_bussshop.text.toString(),
                                    'bussscontact': (Value_AreaSer_ + 1) == 1
                                        ? Status4Form_bussshop.text.toString()
                                        : Status4Form_bussscontact.text
                                            .toString(),
                                    'address':
                                        Status4Form_address.text.toString(),
                                    'tel': Status4Form_tel.text.toString(),
                                    'tax': Status4Form_tax.text.toString(),
                                    'email': Status4Form_email.text.toString(),
                                    'Serbool': '',
                                    'area_rent_sum': '',
                                    'comment': '',
                                    'zser': ''.trim().toString(),
                                  }).then((value) async {
                                    setState(() {
                                      Status4Form_nameshop.clear();
                                      Status4Form_typeshop.clear();
                                      Status4Form_nameshop.clear();
                                      Status4Form_bussshop.clear();
                                      Status4Form_bussscontact.clear();
                                      Status4Form_address.clear();
                                      Status4Form_email.clear();
                                      Status4Form_tax.clear();
                                    });
                                    print('$value');
                                    var result = json.decode(value.body);
                                    print('$result ');
                                    setState(() {
                                      Status4Form_nameshop.clear();
                                      Status4Form_typeshop.clear();
                                      Status4Form_nameshop.clear();
                                      Status4Form_bussshop.clear();
                                      Status4Form_bussscontact.clear();
                                      Status4Form_address.clear();
                                      Status4Form_email.clear();
                                      Status4Form_tax.clear();
                                    });
                                  });
                                }
                              },
                              child: Container(
                                width: 130,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: const Center(
                                  child: Text('บันทึก',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
