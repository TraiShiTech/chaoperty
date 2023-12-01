// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/Model/GetRenTal_Model.dart';
import 'package:fl_pin_code/pin_code.dart';
import 'package:fl_pin_code/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;
import 'package:im_stepper/stepper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetC_Otp.dart';
import '../Model/GetRentalType_Model.dart';
import '../Model/GetTypeX_Model.dart';
import '../Model/GetType_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/GetZoneAll_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'SignIn_Screen.dart';

class SingUpScreen2 extends StatefulWidget {
  const SingUpScreen2({super.key});

  @override
  State<SingUpScreen2> createState() => _SingUpScreen2State();
}

class _SingUpScreen2State extends State<SingUpScreen2> {
  DateTime datex = DateTime.now();

  ///------------------------------------------------------------>(stepper)
  int activeStep = 1; // stepper
  int upperBound = 1; // stepper

  ///----------------------------------------->(FormStep1)
  String? Value_SerName_; //ชื่อ
  String? Value_lastName_; //นามสกุล
  String Value_Number_ = ''; //เบอร์
  String? Value_Email_; //อีเมล
  String Value_PassW1_ = ''; //รหัส
  String Value_PassW2_ = ''; //ยืนยันรหัส
  String accept_ = 'true'; //ยอมรับเงื่อนไข(false,true)
  String Value_randomNumber = ''; //รหัสrandomส่งไปmaill

  List<UserModel> userModels = [];
  List<TypeXModel> typeXModels = [];
  List<TypeModel> typeModels = [];
  List<RentalTypeModel> rentalTypeModels = [];
  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];
  List<ZoneAllModel> zoneAllModels = [];
  List<OtpModel> otpModels = [];
  String? ser_id, tem_id, user_id;
  String? lncodeser, areaser, lnser, rentser, serUser, serzn, qtyzn;
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_typex();
    read_GC_type();
    read_GC_rental_type();
    read_GC_otp();
  }

  Future<Null> read_GC_otp() async {
    if (otpModels.isNotEmpty) {
      setState(() {
        otpModels.clear();
      });
    }

    String url = '${MyConstant().domain}/GC_otp.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('read_GC_rental///// $result');
      for (var map in result) {
        OtpModel otpModel = OtpModel.fromJson(map);
        var ser_idx = otpModel.ser_id;
        var tem_idx = otpModel.tem_id;
        var user_idx = otpModel.user_id;
        var use_idx = otpModel.use_id;
        setState(() {
          if (use_idx == '1') {
            ser_id = ser_idx;
            tem_id = tem_idx;
            user_id = user_idx;
          }

          otpModels.add(otpModel);
        });
      }
    } catch (e) {}
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('ser', userModel.ser.toString());

    setState(() {
      serUser = preferences.getString('ser');
      Value_SerName_ = preferences.getString('fname'); //ชื่อ
      Value_lastName_ = preferences.getString('lname'); //นามสกุล
      Value_Email_ = preferences.getString('email'); //อีเมล
    });

    print('Email>>>>>> $Value_Email_ $serUser');
  }

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  ///------------------------------------------------------------>(FormStep2)
  String CheckValueStep2 = '0';
  String Value_Area_ = '';
  int Value_AreaSer_ = 0; //ลักษณะพื้นที่เช่า
  String Value_Rent_ = '';
  int Value_RentSer_ = 0; //ชื่การคิดค่าเช่า
  String Value_Usage_ = '';
  int Value_UsageSer_ = 0; //การใช้งาน
  ////------------------------------------------------------------>(FormStep3)
  int SerBody_Step3_ = 0;
  String Value_lacotion_ = ''; //ชื่อสถานที่
  String Value_Zone_ = ''; //ชื่อโซนชั้น
  String Value_QTYROOM_ = ''; //จำนวนห้อง
  ///------------------------------------------------------------>
  // Future<Null> xxxxx() async {
  //   if (mBSettingModels.length != 0) {
  //     mBSettingModels.clear();
  //     mBSettingModels.clear();
  //   }
  //   // String url = 'http://localhost/API/getItem.php';

  //   String url = "${MyConstant().domain}/GetMBSetting.php";
  //   //String url = 'https://mbstar.co.th/API/GetCar.php';
  //   await http.get(Uri.parse(url)).then((value) {
  //     if (value.toString() != 'null') {
  //       var result = json.decode(value.body);
  //       for (var item in result) {
  //         //print(result);
  //         MBSettingModel mBSettingModelss = MBSettingModel.fromJson(item);
  //         setState(() {
  //           mBSettingModels.add(mBSettingModelss);
  //         });
  //       }

  //       //print('mBSettingModels');sss
  //       //print('${mBSettingModels.length}');
  //     } else {
  //       // print('no');
  //     }
  //   });

  ///------------------------------------------------------------>
  ScrollController _scrollController1 = ScrollController();

  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 100,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 100,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///------------------------------------------------------------>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   foregroundColor: Colors.black,
      //   titleSpacing: 00.0,
      //   centerTitle: true,
      //   toolbarHeight: 50.2,
      //   // toolbarOpacity: 0.8,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomRight: Radius.circular(0),
      //       bottomLeft: Radius.circular(0),
      //     ),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      // ),
      body: Container(
        color: const Color(0xfff3f3ee),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    child: const Image(
                      image: AssetImage('images/LOGO.png'),
                      width: 200,
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(headerText(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                        fontSize: 30,
                        color: SingupScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T)),
              ),
              const SizedBox(
                height: 20,
              ),
              IconStepper(
                enableNextPreviousButtons: false,
                enableStepTapping: false,
                icons: [
                  Icon(Icons.filter_1),
                  Icon(Icons.filter_2),
                  Icon(Icons.filter_3),
                  Icon(Icons.filter_4),
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              Manbody(),
            ],
          ),
        ),
      ),
    );
  }

//////////////------------------------------------------------------>
  Widget Manbody() {
    switch (activeStep) {
      // case 0:
      //   return Body1(); //Stepper 1

      case 1:
        return Body2(); //Stepper 2

      case 2:
        return Body3(); //Stepper 3
      case 3:
        return Body4(); //Stepper 4

      default:
        return Body2();
    }
  }

////////////////------------------------------------------------>(Stepper 1)
  Widget Body1() {
    final _formKeyBody1 = GlobalKey<FormState>();
    bool _isObscure = true;
    // bool _validate = false;
    final Form1_text = TextEditingController();
    final Form2_text = TextEditingController();
    final Form3_text = TextEditingController();
    final Form4_text = TextEditingController();
    final Form5_text = TextEditingController();
    final Form6_text = TextEditingController();
    return Container(
      child: Form(
        key: _formKeyBody1,
        child: Container(
          // color: Colors.grey[100],
          // height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 1.05,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Form1_text,
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
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.black),
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
                            labelText: 'ชื่อ',
                            labelStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: Font_.Fonts_T)),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter(
                              RegExp("[1-9@.!#%&'*+/=?^_`{|}~-]"),
                              allow: false),
                          FilteringTextInputFormatter.deny(RegExp("[' ']")),
                          // for below version 2 use this
                          // FilteringTextInputFormatter.deny(
                          //     RegExp("[ก-ฮ ' ']")),
                          // for version 2 and greater youcan also use this
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Form2_text,
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
                            labelText: 'นามสกุล',
                            labelStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: Font_.Fonts_T)),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter(
                              RegExp("[1-9@.!#%&'*+/=?^_`{|}~-]"),
                              allow: false),
                          // for below version 2 use this
                          FilteringTextInputFormatter.deny(RegExp("[' ']")),
                          // for version 2 and greater youcan also use this
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: Form3_text,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 10) {
                      return 'ใส่ข้อมูลให้ครบถ้วน ';
                    }
                    // if (int.parse(value.toString()) < 13) {
                    //   return '< 13';
                    // }
                    return null;
                  },
                  maxLength: 10,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.3),
                      filled: true,
                      prefixIcon: const Icon(Icons.phone, color: Colors.black),
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
                      labelText: 'เบอร์ติดต่อ',
                      labelStyle: const TextStyle(
                          color: Colors.black54, fontFamily: Font_.Fonts_T)),
                  inputFormatters: <TextInputFormatter>[
                    // for below version 2 use this
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    // for version 2 and greater youcan also use this
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: Form4_text,
                  validator: (value) {
                    // String pattern =
                    //     r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                    //     r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                    //     r"{0,253}[a-zA-Z0-9])?)*$";
                    // RegExp regex = RegExp(pattern);
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'ตย. เช่น "abc@gmail.com"และไม่มีอัษรพิเศษ';
                    }
                    return null;
                  },
                  // maxLength: 13,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.3),
                      filled: true,
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
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
                      labelText: 'อีเมล',
                      labelStyle: const TextStyle(
                          color: Colors.black54, fontFamily: Font_.Fonts_T)),
                  inputFormatters: <TextInputFormatter>[
                    // FilteringTextInputFormatter(RegExp("[' ']"), allow: false),
                    // for below version 2 use this
                    FilteringTextInputFormatter.deny(RegExp("[ก-ฮ ' ']")),

                    // for version 2 and greater youcan also use this
                    // FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    //  TextFormField(
                    //   decoration: const InputDecoration(
                    //       labelText: 'Password',
                    //       icon: const Padding(
                    //           padding: const EdgeInsets.only(top: 15.0),
                    //           child: const Icon(Icons.lock))),
                    //   obscureText: _obscured,
                    // )

                    TextFormField(
                  keyboardType: TextInputType.number,
                  controller: Form5_text,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'ใส่ข้อมูลให้ครบถ้วน ตัวเลข6หลักขึ้นไป ';
                    }
                    // if (int.parse(value.toString()) < 13) {
                    //   return '< 13';
                    // }
                    return null;
                  },
                  obscureText: _obscured,
                  // maxLength: 13,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.3),
                      filled: true,
                      prefixIcon: const Icon(Icons.key, color: Colors.black),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 24,
                            color: Colors.green,
                          ),
                        ),
                      ),
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
                      labelText: 'รหัสผ่าน',
                      labelStyle: const TextStyle(
                          color: Colors.black54, fontFamily: Font_.Fonts_T)),
                  // inputFormatters: <TextInputFormatter>[
                  //   // for below version 2 use this
                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  //   // for version 2 and greater youcan also use this
                  //   FilteringTextInputFormatter.digitsOnly
                  // ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: Form6_text,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length < 6 ||
                        Form6_text.text != Form5_text.text) {
                      return (Form6_text.text != Form5_text.text)
                          ? 'รหัสไม่ตรงกัน'
                          : 'ใส่ข้อมูลให้ครบถ้วน ตัวเลข6หลักขึ้นไป ';
                    }
                    // if (int.parse(value.toString()) < 13) {
                    //   return '< 13';
                    // }
                    return null;
                  },
                  obscureText: _obscured,
                  // maxLength: 13,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.3),
                      filled: true,
                      prefixIcon:
                          const Icon(Icons.password, color: Colors.black),
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
                      labelText: 'รหัสผ่านอีกครั้ง',
                      labelStyle: const TextStyle(
                          color: Colors.black54, fontFamily: Font_.Fonts_T)),
                  // inputFormatters: <TextInputFormatter>[
                  //   // for below version 2 use this
                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  //   // for version 2 and greater youcan also use this
                  //   FilteringTextInputFormatter.digitsOnly
                  // ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        (accept_ != 'true')
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    accept_ = 'true';
                                  });
                                },
                                child: Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.black,
                                ))
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    accept_ = 'false';
                                  });
                                },
                                child: Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                )),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: const BoxDecoration(
                            // color: Colors.lightGreen[600],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Text(
                                'คุณได้อ่านและยอมรับ เงื่อนไขการใช้บริการ และ นโยบายความเป็นส่วนตัว ( ดูคลิก📝) ',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: SingupScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T
                                    // fontWeight: FontWeight.bold,
                                    )),
                            onTap: () async {
                              final data = await SideSheet.right(
                                  width: 350,
                                  body: Container(
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black,
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
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Icon(
                                                          Icons.arrow_back,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'เงื่อนไขการใช้บริการ',
                                              style: TextStyle(
                                                  color: SingupScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText('1.1 XXXXXX',
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  maxFontSize: 20,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: SingupScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T)),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText(
                                                  'เว็บไซต์นี้มีขึ้นเพื่อวัตถุประสงค์ในการให้ข้อมูลข่าวสารเกี่ยวกับการเงิน - การลงทุนเท่านั้น ดังนั้น บรรดาข้อมูลต่างๆ ที่เผยแพร่บนเว็บไซต์นี้ (ซึ่งต่อไปนี้จะรวมเรียกว่า “บรรดาข้อมูลที่เผยแพร่”) จึงเป็นข้อมูลที่ผู้ใช้งานสามารถพบเห็นได้เป็นการทั่วไป และไม่ให้ถือว่าบรรดาข้อมูลที่เผยแพร่นั้นเป็นการให้คำแนะนำหรือให้ความเห็นในทางกฎหมาย และไม่ให้ถือว่าเป็นการให้คำแนะนำเกี่ยวกับการซื้อขายหรือการลงทุนในหลักทรัพย์ใด ๆ ที่ปรากฏในเว็บไซต์นี้',
                                                  //  maxLines: 1,
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  // overflow: TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      // fontSize: 20,
                                                      color: SingupScreen_Color
                                                          .Colors_Text2_,
                                                      fontFamily: Font_.Fonts_T
                                                      // fontWeight: FontWeight.bold,
                                                      )),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText('1.2 XXXXXX',
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  maxFontSize: 20,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: SingupScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T)),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText(
                                                  'ออนไลน์ แอสเซ็ทสงวนสิทธิ์ในการพิจารณาไม่อนุญาตให้ผู้ใช้งานใช้งานเว็บไซต์นี้ รวมถึงสงวนสิทธิ์ในการเปลี่ยนแปลง หรือระงับการให้บริการเว็บไซต์ไม่ว่าบางส่วนหรือทั้งหมดและไม่ว่าในเวลาใด ๆ แก่ผู้ใช้งาน โดยไม่จำเป็นต้องบอกกล่าวล่วงหน้าหรือระบุเหตุผลในการดำเนินการนั้น',
                                                  //  maxLines: 1,
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  // overflow: TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      // fontSize: 20,
                                                      color: SingupScreen_Color
                                                          .Colors_Text2_,
                                                      fontFamily: Font_.Fonts_T
                                                      // fontWeight: FontWeight.bold,
                                                      )),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText('1.3 XXXXXX',
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  maxFontSize: 20,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: SingupScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T)),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText(
                                                  '	ในการใช้งานเว็บไซต์ด้วยการเข้าสู่ระบบ         (Login) สมาชิก efin Member ผู้ใช้งานจะต้องมีรหัสประจำตัว (Username) และรหัสผ่าน (Password) ของตนเอง โดยผู้ใช้งานจะต้องเก็บรักษารหัสประจำตัวและรหัสผ่านของตนเองไว้เป็นความลับ การเข้าใช้งานและทำรายการใด ๆ ที่เกิดขึ้นจากการ Login ผ่านรหัสประจำตัวและรหัสผ่านของผู้ใช้งานในเว็บไซต์นี้ให้ถือว่าการกระทำดังกล่าวถูกต้องสมบูรณ์และเป็นการกระทำของผู้ใช้งานเอง หากมีความเสียหายใด ๆ เกิดขึ้น ไม่ว่าจะด้วยเหตุใดก็ตาม ผู้ใช้งานจะต้องรับผิดชอบในการกระทำดังกล่าวทุกประการ และผู้ใช้งานตกลงจะไม่โต้แย้งหรือเรียกร้องให้ออนไลน์ แอสเซ็ทรับผิดชอบชดใช้ค่าเสียหายแทนผู้ใช้งานทุกกรณี',

                                                  //  maxLines: 1,
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  // overflow: TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      // fontSize: 20,
                                                      color: SingupScreen_Color
                                                          .Colors_Text2_,
                                                      fontFamily: Font_.Fonts_T
                                                      // fontWeight: FontWeight.bold,
                                                      )),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            // height: 40,
                                            decoration: const BoxDecoration(
                                              color: AppBarColors.ABar_Colors,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0)),
                                            ),
                                            child: const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  '© 2022  Dzentric Co.,Ltd. All Rights Reserved',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: SingupScreen_Color
                                                          .Colors_Text2_,
                                                      fontFamily: Font_.Fonts_T,
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  context: context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // nextButton(),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        Random random = Random();

                        // setState(() {
                        //   activeStep++;
                        // });

                        if (_formKeyBody1.currentState!.validate()) {
                          if (Value_PassW1_ != Value_PassW2_) {
                          } else if (accept_ != 'true') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red.withOpacity(0.5),
                                content: Text(
                                    '** กรุณายอมรับเงื่อนไขการใช้บริการ !! ',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: Font_.Fonts_T
                                        // fontWeight: FontWeight.bold,
                                        )),
                              ),
                            );
                          } else {
                            // for (int i = 0; i < 4; i++) {
                            //   Value_randomNumber = Value_randomNumber +
                            //       random.nextInt(9).toString();
                            // }
                            Random random = Random();
                            int c = random.nextInt(9000) + 1000;

                            print('/////----- Data Step 1  ------- >');
                            print(Form1_text.text); //ชื่อ
                            print(Form2_text.text); //นามสกุล
                            print(Form3_text.text); //เบอร์
                            print(Form4_text.text); //อีเมล
                            print(Form5_text.text); //รหัส
                            print(Form6_text.text); //ยืนยันรหัส
                            print(' ----------------------------->');
                            setState(() {
                              Value_randomNumber = c.toString();
                              Value_SerName_ = Form1_text.text;
                              Value_lastName_ = Form2_text.text;
                              Value_Number_ = Form3_text.text;
                              Value_Email_ = Form4_text.text;
                              Value_PassW1_ = Form5_text.text;
                              Value_PassW2_ = Form6_text.text;
                              // Value_randomNumber = '$randomNumber';
                            });

                            upUser();
                          }
                        }
                      },
                      child: Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: const Center(
                          child: Text('Continue',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: FontWeight_.Fonts_T)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future SendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        }, //This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': ser_id,
          'template_id': tem_id,
          'user_id': user_id,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': 'OTP : $message'
          }
        }));
    return response.statusCode;
  }

///////////////////--------------------------------------------->(Stepper 2)
  Widget Body2() {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final pinController = TextEditingController();
    final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: const TextStyle(
    //     fontSize: 22,
    //     color: Color.fromRGBO(30, 60, 87, 1),
    //   ),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(19),
    //     border: Border.all(color: borderColor),
    //   ),
    // );
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Email : ${Value_Email_.toString()}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    fontSize: 20,
                    color: SingupScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('กรอกรหัสผ่านที่ได้รับจาก Email',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    fontSize: 20,
                    color: SingupScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              child: PinCode(
                numberOfFields: 4,
                fieldWidth: 40.0,
                style: TextStyle(color: Colors.black, fontSize: 15),
                fieldStyle: PinCodeStyle.box,
                onCompleted: (text) async {
                  // setState(() {
                  //   activeStep++;
                  // });

                  if (text.trim() == Value_randomNumber) {
                    String url =
                        '${MyConstant().domain}/UpC_user.php?isAdd=true&email=$Value_Email_';
                    try {
                      var response = await http.get(Uri.parse(url));
                      var result = json.decode(response.body);
                      print(result);
                      if (result == true) {
                        setState(() {
                          activeStep++;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('เกิดข้อผิดพลาดกรุณาลองใหม่')));
                      }
                    } catch (e) {}
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('รหัสไม่ถูกต้อง')));
                  }
                },
                // onChanged: (_) {},
              ),
            ),
          ),
          // InkWell(
          //   onTap: () async {
          //     Random random = Random();
          //     int c = random.nextInt(9000) + 1000;
          //     setState(() {
          //       Value_randomNumber = c.toString();
          //     });

          //     final response = await SendEmail(
          //         '$Value_lastName_ $Value_lastName_',
          //         Value_Email_,
          //         c.toString());
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       response == 200
          //           ? const SnackBar(
          //               content:
          //                   Text('ส่งรหัสยืนยันตัวตนไปยัง Email ของท่านแล้ว!!'),
          //               backgroundColor: Colors.green)
          //           : const SnackBar(
          //               content: Text('Failed to send message!'),
          //               backgroundColor: Colors.red),
          //     );
          //     // Random random = Random();

          //     // for (int i = 0; i < 4; i++) {
          //     //   Value_randomNumber =
          //     //       Value_randomNumber + random.nextInt(9).toString();
          //     // }
          //     print(Value_randomNumber);
          //   },
          //   child: const Text('ส่งรหัสอีกครั้ง',
          //       maxLines: 3,
          //       overflow: TextOverflow.ellipsis,
          //       softWrap: false,
          //       style: TextStyle(
          //           fontSize: 15,
          //           color: Colors.blue,
          //           fontWeight: FontWeight.bold,
          //           decoration: TextDecoration.underline)),
          // ),
          TapDebouncer(onTap: () async {
            await Future<void>.delayed(
              Duration(seconds: 3),
            );

            Random random = Random();
            int c = random.nextInt(9000) + 1000;
            setState(() {
              Value_randomNumber = c.toString();
            });
            String url =
                '${MyConstant().domain}/EDC_user.php?isAdd=true&femail=$Value_Email_&Value_randomNumber=$Value_randomNumber';

            try {
              var response = await http.get(Uri.parse(url));

              var result = json.decode(response.body);
              print(result.toString());

              if (result.toString() == 'true') {
                final response = await SendEmail(
                    '$Value_lastName_ $Value_lastName_',
                    Value_Email_!,
                    c.toString());
              }
            } catch (e) {}

            final response = await SendEmail(
                '$Value_lastName_ $Value_lastName_',
                Value_Email_!,
                c.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              response == 200
                  ? const SnackBar(
                      content:
                          Text('ส่งรหัสยืนยันตัวตนไปยัง Email ของท่านแล้ว!!'),
                      backgroundColor: Colors.green)
                  : const SnackBar(
                      content: Text('Failed to send message!'),
                      backgroundColor: Colors.red),
            );
          }, builder: (_, TapDebouncerFunc? onTap) {
            return Container(
              width: 130,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: onTap,
                child: const Center(
                    child: Text(
                  'ส่งรหัสอีกครั้ง',
                  style: TextStyle(
                      color: SingupScreen_Color.Colors_Text2_,
                      fontFamily: Font_.Fonts_T),
                )),
              ),
            );
          }),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<Null> upUser() async {
    // Value_SerName_  //ชื่อ
    // Value_lastName_ //นามสกุล
    // Value_Number_ //เบอร์
    // Value_Email_//อีเมล
    // Value_PassW1_ //รหัส
    // Value_randomNumber //otp

    String url =
        '${MyConstant().domain}/InC_user.php?isAdd=true&fname=$Value_SerName_&lname=$Value_lastName_&tel=$Value_Number_&email=$Value_Email_&password=$Value_PassW1_&otp=$Value_randomNumber';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());

      if (result.toString() != 'Not data') {
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          var serUserx = userModel.ser;
          setState(() {
            activeStep++;
            userModels.add(userModel);
            serUser = serUserx;
          });
        }

        final response = await SendEmail('$Value_lastName_ $Value_lastName_',
            Value_Email_!, Value_randomNumber);
        ScaffoldMessenger.of(context).showSnackBar(
          response == 200
              ? const SnackBar(
                  content: Text('ส่งรหัสยืนยันตัวตนไปยัง Email ของท่านแล้ว!!'),
                  backgroundColor: Colors.green)
              : const SnackBar(
                  content: Text('Failed to send message!'),
                  backgroundColor: Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email ของคุณเคยสมัครการใช้งานแล้ว!!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email ของคุณเคยสมัครการใช้งานแล้ว!!')),
      );
    }
  }

///////////////////--------------------------------------------->(Stepper 3)
  ///

  Future<Null> read_GC_typex() async {
    if (typeXModels.isNotEmpty) {
      typeXModels.clear();
    }

    String url = '${MyConstant().domain}/GC_typex.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TypeXModel typeXModel = TypeXModel.fromJson(map);
          setState(() {
            typeXModels.add(typeXModel);
          });
        }
      } else {}
    } catch (e) {}
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
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_rental_type() async {
    if (rentalTypeModels.isNotEmpty) {
      rentalTypeModels.clear();
    }

    String url = '${MyConstant().domain}/GC_rental_type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          RentalTypeModel rentalTypeModel = RentalTypeModel.fromJson(map);
          setState(() {
            rentalTypeModels.add(rentalTypeModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Widget Body3() {
    double Width_ = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.grey[100],
      height: MediaQuery.of(context).size.height / 1.5,
      width: (Width_ < 500)
          ? MediaQuery.of(context).size.width / 1.05
          : MediaQuery.of(context).size.width / 1.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 150,
                decoration: const BoxDecoration(
                  // color: Colors.lightGreen[600],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child:
                      (Value_Area_.toString() == '' && CheckValueStep2 == '1')
                          ? const Text('ลักษณะพื้นที่เช่า( X ระบุพื้นที่เช่า )',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T))
                          : const Text('ลักษณะพื้นที่เช่า',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: SingupScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T)),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.05,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: 100,
                          maxWidth: 600,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: RadioGroup<TypeXModel>.builder(
                            direction: Axis.horizontal,
                            groupValue: typeXModels.elementAt(Value_AreaSer_),
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) {
                              setState(() {
                                Value_AreaSer_ = int.parse(value!.ser!) - 1;
                                Value_Area_ = value.typex!;
                              });
                            },
                            items: typeXModels,
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            itemBuilder: (typeXModels) => RadioButtonBuilder(
                              typeXModels.typex!,
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
          Row(
            children: [
              Container(
                width: 150,
                decoration: const BoxDecoration(
                  // color: Colors.lightGreen[600],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child:
                      (Value_Rent_.toString() == '' && CheckValueStep2 == '1')
                          ? const Text('การคิดค่าเช่า( X ระบุค่าเช่า)',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T))
                          : const Text('การคิดค่าเช่า',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: SingupScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T)),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.05,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 80,
                              maxWidth: 400,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: RadioGroup<TypeModel>.builder(
                                direction: Axis.horizontal,
                                groupValue:
                                    typeModels.elementAt(Value_RentSer_),
                                horizontalAlignment:
                                    MainAxisAlignment.spaceAround,
                                onChanged: (value) {
                                  setState(() {
                                    Value_RentSer_ = int.parse(value!.ser!) - 1;
                                    Value_Rent_ = value.type!;
                                  });
                                },
                                items: typeModels,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item.type!,
                                ),
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
          ),
          Row(
            children: [
              Container(
                width: 150,
                decoration: const BoxDecoration(
                  // color: Colors.lightGreen[600],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child:
                      (Value_Usage_.toString() == '' && CheckValueStep2 == '1')
                          ? const Text('การใช้งาน( X ระบุการใช้งาน)',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T))
                          : const Text('การใช้งาน',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: SingupScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T)),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.05,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 80,
                              maxWidth: 400,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: RadioGroup<RentalTypeModel>.builder(
                                direction: Axis.horizontal,
                                groupValue:
                                    rentalTypeModels.elementAt(Value_UsageSer_),
                                horizontalAlignment:
                                    MainAxisAlignment.spaceAround,
                                onChanged: (value) {
                                  setState(() {
                                    Value_UsageSer_ =
                                        int.parse(value!.ser!) - 1;
                                    Value_Usage_ = value.rtname!;
                                  });
                                },
                                items: rentalTypeModels,
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: SingupScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item.rtname!,
                                ),
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
          ),
          // Button2(),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      CheckValueStep2 = '0';
                      Value_Area_ = '';
                      Value_Rent_ = '';
                      Value_Usage_ = '';
                    });
                    if (activeStep > 0) {
                      setState(() {
                        activeStep--;
                      });
                    }
                  },
                  child: Container(
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text('Black',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //----------------------------------->
                    setState(() {
                      CheckValueStep2 = '1';
                    });
                    //----------------------------------->
                    if (Value_Area_.toString() == '' ||
                        Value_Rent_.toString() == '' ||
                        Value_Usage_.toString() == '') {
                    } else {
                      print('//----------------- > DATA Stepper 2 ');
                      print('ลักษณะพื้นที่เช่า : $Value_Area_');
                      print('การคิดค่าเช่า :$Value_Rent_');
                      print('การใช้งาน : $Value_Usage_');
                      // if (activeStep <= upperBound) {
                      setState(() {
                        activeStep++;
                      });
                      // }
                    }
                    //----------------------------------->
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
                      child: Text('Continue',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

///////////////////------------------------------------------>(Stepper 4)
  Widget Body4() {
    final Body3_formKey_1 = GlobalKey<FormState>();
    final Body3_formKey_2 = GlobalKey<FormState>();

    bool _isObscure = true;
    // bool _validate = false;
    final Body3Form1_text = TextEditingController();
    final Body3Form2_text = TextEditingController();
    final Body3Form3_text = TextEditingController();
    return Container(
      // color: Colors.grey[100],
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 1.05,

      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Form(
              key: Body3_formKey_1,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          '3.1 ชื่อสถานที่',
                          minFontSize: 5,
                          maxFontSize: 15,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SingupScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.05,
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (SerBody_Step3_ == 0)
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.42,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: Body3Form1_text,
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
                                        labelText:
                                            'ชื่อสถานที่ (ภาษาอังกฤษเท่านั่น)',
                                        labelStyle: const TextStyle(
                                            color: Colors.black54)),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter(
                                          RegExp("[@!#%&*+/=?^`{|}~]"),
                                          allow: false),
                                      // // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp("['A-Z a-z 1-9 ']")),
                                      FilteringTextInputFormatter.deny(
                                          RegExp("[ก-ฮ ' ']")),
                                      // for version 2 and greater youcan also use this
                                      // FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width / 1.42,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    // border:
                                    //     Border.all(color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Center(
                                        child: AutoSizeText(
                                          '$Value_lacotion_',
                                          // minFontSize: 5,
                                          // maxFontSize: 15,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: SingupScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T
                                              // fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      const Center(
                                          child: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )),
                                    ],
                                  ),
                                ),
                          if (SerBody_Step3_ == 0)
                            InkWell(
                              onTap: () async {
                                if (Body3_formKey_1.currentState!.validate()) {
                                  String dab = Body3Form1_text.text;
                                  int txser = Value_AreaSer_ + 1;
                                  int tser = Value_RentSer_ + 1;
                                  int rtser = Value_UsageSer_ + 1;

                                  String url =
                                      '${MyConstant().domain}/CR_resister.php?isAdd=true&txser=$txser&tser=$tser&rtser=$rtser&dab=$dab&email=$Value_Email_';

                                  try {
                                    var response =
                                        await http.get(Uri.parse(url));

                                    var result = json.decode(response.body);
                                    print(result);
                                    if (result.toString() != 'Not data') {
                                      setState(() {
                                        Body3Form2_text.text = 'A';
                                        Body3Form3_text.text = '2';
                                      });
                                      for (var map in result) {
                                        RenTalModel userModel =
                                            RenTalModel.fromJson(map);
                                        setState(() {
                                          // SerBody_Step3_ = 1;
                                          Value_lacotion_ =
                                              Body3Form1_text.text;
                                          Value_Zone_ = Body3Form2_text.text;
                                          Value_QTYROOM_ = Body3Form3_text.text;
                                        });
                                      }
                                      upZoneTable();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'ชื่อสถานที่นี้มีผู้ใช้ท่านอื่นใช้แล้ว กรุณาใช้ชื่ออื่น')),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'ชื่อสถานที่นี้มีผู้ใช้ท่านอื่นใช้แล้ว กรุณาใช้ชื่ออื่น')),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: AutoSizeText(
                                    'ต่อไป',
                                    minFontSize: 5,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          '*** สมัครทดลองใช้งานพรี 2 พื้นที่',
                          minFontSize: 5,
                          maxFontSize: 15,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              // color: SingupScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (SerBody_Step3_ != 0)
            Container(
              child: Form(
                key: Body3_formKey_2,
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            '3.2 โซน/ชั้น จำนวนห้อง',
                            minFontSize: 5,
                            maxFontSize: 15,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: SingupScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.05,
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (SerBody_Step3_ == 1)
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: Body3Form2_text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'ใส่ข้อมูลให้ครบถ้วน ';
                                        } else {
                                          return null;
                                        }
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
                                          labelText: 'โซน/ชั้น',
                                          labelStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontFamily: Font_.Fonts_T)),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter(
                                            RegExp("[1-9@.!#%&'*+/=?^_`{|}~-]"),
                                            allow: false),
                                        // for below version 2 use this
                                        FilteringTextInputFormatter.deny(
                                            RegExp("[' ']")),
                                        // for version 2 and greater youcan also use this
                                        // FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      // border:
                                      //     Border.all(color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Center(
                                          child: AutoSizeText(
                                            '$Value_Zone_',
                                            // minFontSize: 5,
                                            // maxFontSize: 15,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: SingupScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                // fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        const Center(
                                            child: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )),
                                      ],
                                    ),
                                  ),
                            (SerBody_Step3_ == 1)
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: TextFormField(
                                      // keyboardType: TextInputType.number,
                                      controller: Body3Form3_text,
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
                                          labelText: 'จำนวน',
                                          labelStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontFamily: Font_.Fonts_T)),
                                      inputFormatters: <TextInputFormatter>[
                                        // for below version 2 use this
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                        // for version 2 and greater youcan also use this
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      // border:
                                      //     Border.all(color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Center(
                                          child: AutoSizeText(
                                            '$Value_QTYROOM_',
                                            // minFontSize: 5,
                                            // maxFontSize: 15,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: SingupScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                // fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        const Center(
                                            child: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )),
                                      ],
                                    ),
                                  ),
                            (SerBody_Step3_ == 1)
                                ? InkWell(
                                    onTap: () async {
                                      if (Body3_formKey_2.currentState!
                                          .validate()) {
                                        setState(() {
                                          SerBody_Step3_ = 2;
                                          Value_Zone_ = Body3Form2_text.text;
                                          Value_QTYROOM_ = Body3Form3_text.text;
                                        });
                                        upZoneTable();

                                        print('------------> (3.2 Stepper 3 )');
                                        print('ชื่อสถานที่ : $Value_lacotion_');
                                        print('โซนชั้น : $Value_Zone_');
                                        print('จำนวนห้อง : $Value_QTYROOM_');
                                        print('----------------------->');
                                      } else {}
                                    },
                                    child: Container(
                                      height: 50,
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Center(
                                        child: AutoSizeText(
                                          'บันทึก',
                                          minFontSize: 5,
                                          maxFontSize: 15,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T),
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      setState(() {
                                        SerBody_Step3_ = 1;
                                        Value_Zone_ = '';
                                        Value_QTYROOM_ = '';
                                        Body3Form2_text.clear();
                                        Body3Form3_text.clear();
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[900],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Center(
                                        child: AutoSizeText(
                                          '+เพิ่มโซนอีก',
                                          minFontSize: 5,
                                          maxFontSize: 15,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T),
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
          const SizedBox(
            height: 20,
          ),
          if (SerBody_Step3_ != 0 && SerBody_Step3_ != 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'ชื่อสถานที่ : $Value_lacotion_ ',
                              minFontSize: 10,
                              maxFontSize: 20,
                              style: TextStyle(
                                  color: SingupScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
                                  //fontSize: 10.0
                                  ),
                            ),
                            AutoSizeText(
                              'โซน : $Value_Zone_',
                              minFontSize: 10,
                              maxFontSize: 20,
                              style: TextStyle(
                                  color: SingupScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
                                  //fontSize: 10.0
                                  ),
                            )
                          ],
                        )),
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.brown[200],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text('รหัสพื้นที่',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          // fontSize: 15,
                                          color:
                                              SingupScreen_Color.Colors_Text2_,
                                          fontFamily: Font_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                color: Colors.brown[200],
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text('ชื้อพื้นที่เช่า',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          //fontSize: 15,
                                          color:
                                              SingupScreen_Color.Colors_Text2_,
                                          fontFamily: Font_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                color: Colors.brown[200],
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text('ขนาดพื้นที่(ต.ร.ม.)',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          //fontSize: 15,
                                          color:
                                              SingupScreen_Color.Colors_Text2_,
                                          fontFamily: Font_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                color: Colors.brown[200],
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                      'ค่าบริการหลัก(ต่อครั้ง/วัน/เดือน)',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          // fontSize: 15,
                                          color:
                                              SingupScreen_Color.Colors_Text2_,
                                          fontFamily: Font_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.brown[200],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text('แก้ไข/ลบ',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          //fontSize: 15,
                                          color:
                                              SingupScreen_Color.Colors_Text2_,
                                          fontFamily: Font_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: Center(
                                      child: Text(
                                    'ลบโซน : $Value_Zone_ ?',
                                    style: TextStyle(
                                        color: SingupScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  )),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      print(
                                                          'ลบ (โซน : $Value_Zone_)');
                                                      setState(() {
                                                        SerBody_Step3_ = 1;
                                                        Value_Zone_ = '';
                                                        Value_QTYROOM_ = '';
                                                        Body3Form2_text.clear();
                                                        Body3Form3_text.clear();
                                                      });
                                                      Navigator.pop(
                                                          context, 'OK');
                                                    },
                                                    child: const Text(
                                                      'ยืนยัน',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.redAccent,
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
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text(
                                                          'ยกเลิก',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
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
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ),
                          ))
                    ],
                  ),
                  // StreamBuilder(
                  //     stream: Stream.periodic(const Duration(seconds: 0)),
                  //     builder: (context, snapshot) {
                  //       return
                  Container(
                    height: 260,
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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: areaModels.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${areaModels[index].lncode}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: SingupScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T

                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${areaModels[index].ln}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: SingupScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T

                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${areaModels[index].area}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: SingupScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T

                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${areaModels[index].rent}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: SingupScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T

                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            lncodeser =
                                                areaModels[index].lncode;
                                            areaser = areaModels[index].area;
                                            lnser = areaModels[index].ln;
                                            rentser = areaModels[index].ln;
                                          });
                                          editDialog(index);

                                          print(
                                              'แก้ไข ${areaModels[index].ln}');
                                        },
                                        child: (!Responsive.isDesktop(context))
                                            ? Icon(
                                                Icons.edit,
                                                color: Colors.green[700],
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green[700],
                                                  borderRadius:
                                                      const BorderRadius.only(
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
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: SingupScreen_Color
                                                      .Colors_Text1_,
                                                )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          deleteDialog(index);
                                          print('ลบ ${index + 1}');
                                        },
                                        child: (!Responsive.isDesktop(context))
                                            ? Icon(
                                                Icons.delete,
                                                color: Colors.red[700],
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red[700],
                                                  borderRadius:
                                                      const BorderRadius.only(
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
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: SingupScreen_Color
                                                      .Colors_Text1_,
                                                )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                      },
                    ),
                  ),
                  // }),
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
                                        duration: Duration(seconds: 1),
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
                                        duration: Duration(seconds: 1),
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
          SizedBox(
            height: 10,
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (SerBody_Step3_ == 2)
                  InkWell(
                    onTap: () {
                      if (activeStep <= upperBound) {
                        setState(() {
                          activeStep++;
                        });
                        setState(() {
                          SerBody_Step3_ = 0;
                          Value_lacotion_ = '';
                          Value_Zone_ = '';
                          Value_QTYROOM_ = '';
                          Body3Form1_text.clear();
                          Body3Form2_text.clear();
                          Body3Form3_text.clear();
                        });
                      }
                      readZoneDialog();
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: const Center(
                        child: AutoSizeText('ดูโซนที่บันทึกทั้งหมด',
                            maxLines: 1,
                            minFontSize: 10,
                            maxFontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                // fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T)),
                      ),
                    ),
                  ),
                if (SerBody_Step3_ == 2)
                  InkWell(
                    onTap: () {
                      // if (activeStep <= upperBound) {
                      setState(() {
                        activeStep++;
                      });
                      setState(() {
                        SerBody_Step3_ = 0;
                        Value_lacotion_ = '';
                        Value_Zone_ = '';
                        Value_QTYROOM_ = '';
                        Body3Form1_text.clear();
                        Body3Form2_text.clear();
                        Body3Form3_text.clear();
                      });
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      );
                      Navigator.pushAndRemoveUntil(
                          context, route, (route) => false);
                    },
                    child: Container(
                      width: 150,
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
                        child: AutoSizeText('เริ่มใช้งาน',
                            maxLines: 1,
                            minFontSize: 10,
                            maxFontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<void> readZoneDialog() async {
    if (zoneAllModels != 0) {
      setState(() {
        zoneAllModels.clear();
      });
    }
    String location = Value_lacotion_;
    String url =
        '${MyConstant().domain}/GC_zoneAll.php?isAdd=true&location=$location';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());

      if (result.toString() != 'Not data') {
        for (var map in result) {
          ZoneAllModel zoneAllModel = ZoneAllModel.fromJson(map);
          setState(() {
            zoneAllModels.add(zoneAllModel);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
      );
    }

    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text('โซนที่บันทึก'),
              children: [
                Column(
                  children: [
                    Container(
                      width: 500,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.TiTile_Colors,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        // border: Border.all(
                        //     color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'โซน/ชั้น',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: SingupScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T

                                  //fontSize: 10.0
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'จำนวนพื้นที่',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: SingupScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T

                                  //fontSize: 10.0
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 500,
                      height: 260,
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
                        // controller: _scrollController1,

                        // itemExtent: 50,
                        // physics: ScrollPhysics(),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: zoneAllModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${zoneAllModels[index].zn}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color:
                                              SingupScreen_Color.Colors_Text2_,
                                          fontFamily: Font_.Fonts_T

                                          //fontSize: 10.0
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${zoneAllModels[index].qty}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color:
                                              SingupScreen_Color.Colors_Text2_,
                                          fontFamily: Font_.Fonts_T

                                          //fontSize: 10.0
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                            ],
                          ));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ignore: deprecated_member_use
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                            color: SingupScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }

  Future<Null> upZoneTable() async {
    if (zoneModels != 0) {
      setState(() {
        zoneModels.clear();
      });
    }
    print('ชื่อสถานที่ : $Value_lacotion_');
    print('โซนชั้น : $Value_Zone_');
    print('จำนวนห้อง : $Value_QTYROOM_');
    String location = Value_lacotion_;
    String zone = Value_Zone_;
    String qtyroom = Value_QTYROOM_;

    String? nameuser = serUser;

    String url =
        '${MyConstant().domain}/InC_Zone.php?isAdd=true&location=$location&zone=$zone&qtyroom=$qtyroom&nameuser=$nameuser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());

      if (result.toString() != 'Not data') {
        for (var map in result) {
          ZoneModel zoneModel = ZoneModel.fromJson(map);
          var serznx = zoneModel.ser;
          var qtyznx = zoneModel.qty;
          setState(() {
            serzn = serznx;
            qtyzn = qtyznx;
            zoneModels.add(zoneModel);
          });
        }
        upAreaTable();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
      );
    }
  }

  Future<void> editDialog(int index) async {
    final Body3_formKey_3 = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('${areaModels[index].ln}'),
        children: [
          Column(
            children: [
              Form(
                key: Body3_formKey_3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => lncodeser = value.trim(),
                        initialValue: areaModels[index].lncode,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
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
                            labelText: 'รหัสพื้นที่',
                            labelStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: Font_.Fonts_T)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        //keyboardType: TextInputType.none,
                        onChanged: (value) => lnser = value.trim(),
                        initialValue: areaModels[index].ln,
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
                            labelText: 'ชื่อพื้นที่',
                            labelStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: Font_.Fonts_T)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => areaser = value.trim(),
                        initialValue: areaModels[index].area,
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
                            labelText: 'ขนาดพื้นที่(ต.ร.ม.)',
                            labelStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: Font_.Fonts_T)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => rentser = value.trim(),
                        initialValue: areaModels[index].rent,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
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
                            labelText: 'ค่าบริการหลัก(ต่อ ครั้ง/วัน/เดือน)',
                            labelStyle: const TextStyle(
                                color: Colors.black54,
                                fontFamily: Font_.Fonts_T)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ignore: deprecated_member_use
                  TextButton(
                    onPressed: () {
                      upeditAreaTable(index);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.black, fontFamily: Font_.Fonts_T),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> deleteDialog(int index) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('ลบ ${areaModels[index].ln}'),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ignore: deprecated_member_use
                  TextButton(
                    onPressed: () {
                      deleteAreaTable(index);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: SingupScreen_Color.Colors_Text2_,
                          fontFamily: Font_.Fonts_T),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<Null> upAreaTable() async {
    if (areaModels != 0) {
      setState(() {
        areaModels.clear();
      });
    }

    String? zone = serzn;
    String location = Value_lacotion_;
    String? nameuser = serUser;

    for (var iz = 0; iz < int.parse(qtyzn!); iz++) {
      String? zoneln = '$Value_Zone_ ${iz + 1}';
      String? codeln = '${iz + 1}';
      String url =
          '${MyConstant().domain}/InC_Area.php?isAdd=true&zoneln=$zoneln&zone=$zone&codeln=$codeln&location=$location&nameuser=$nameuser';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result.toString());

        if (result.toString() != 'Not data') {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);
            setState(() {
              areaModels.add(areaModel);
            });
          }

          setState(() {
            readAreaTable(zone);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
        );
      }
    }
  }

  Future<Null> deleteAreaTable(int index) async {
    String? areaid = areaModels[index].ser;
    String? zserid = areaModels[index].zser;
    String location = Value_lacotion_;

    String url =
        '${MyConstant().domain}/DC_Area.php?isAdd=true&areaid=$areaid&location=$location&zserid=$zserid';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());

      if (result.toString() == 'true') {
        setState(() {
          readAreaTable(zserid);
        });
      } else {
        setState(() {
          readAreaTable(zserid);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
      );
    }
  }

  Future<Null> upeditAreaTable(int index) async {
    String? areaid = areaModels[index].ser;
    String location = Value_lacotion_;
    String? zone = areaModels[index].zser;

    String url =
        '${MyConstant().domain}/UDC_Area.php?isAdd=true&areaid=$areaid&location=$location&lncodeser=$lncodeser&areaser=$areaser&lnser=$lnser&rentser=$rentser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());

      if (result.toString() == 'true') {
        setState(() {
          readAreaTable(zone);
        });
      } else {
        setState(() {
          readAreaTable(zone);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
      );
    }
  }

  Future<Null> readAreaTable(zone) async {
    if (areaModels != 0) {
      setState(() {
        areaModels.clear();
      });
    }

    // String? zone = areaModels[index].zser;
    String location = Value_lacotion_;

    String url =
        '${MyConstant().domain}/GRC_Area.php?isAdd=true&zone=$zone&location=$location';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());

      if (result.toString() != 'Not data') {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          setState(() {
            areaModels.add(areaModel);
          });
        }

        setState(() {
          Value_QTYROOM_ = areaModels.length.toString();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การเชื่อมต่อผิดพลาด')),
      );
    }
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: SingupScreen_Color.Colors_Text1_,
                fontWeight: FontWeight.bold,
                fontFamily: FontWeight_.Fonts_T,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 0:
        return 'ลงทะเบียนผู้ใช้';

      case 1:
        return 'รูปแบบบการเช่า';

      case 2:
        return 'พื้นที่เช่า';
      case 3:
        return 'พื้นที่เช่า';

      default:
        return '';
    }
  }
}
