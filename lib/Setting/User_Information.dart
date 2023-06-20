import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetPerMission_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'package:http/http.dart' as http;

class USerInformation extends StatefulWidget {
  const USerInformation({super.key});

  @override
  State<USerInformation> createState() => _USerInformationState();
}

class _USerInformationState extends State<USerInformation> {
  DateTime datex = DateTime.now();
  int serBody_modile_wiget = 0;
  String Value_Route = 'หน้าหลัก';

  String? ser_user,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      renTal_user,
      renTal_name,
      tel_user;
  String password_U = '';
  int? perMissioncount;
  List<RenTalModel> renTalModels = [];
  List<PerMissionModel> perMissionModels = [];
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final Pasw1_text = TextEditingController();
  final Pasw2_text = TextEditingController();
///////////------------------------------------------->
  String tappedIndex_ = '';
///////---------------------------------------------------->
  final fname_text = TextEditingController();
  final lname_text = TextEditingController();
  final Posi_text = TextEditingController();
  final email_text = TextEditingController();

  final tel_text = TextEditingController();

  ///
  @override
  void initState() {
    super.initState();

    signInThread();
  }

  Future<Null> signInThread() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? _seruser = preferences.getString('ser');
    String url =
        '${MyConstant().domain}/GC_userHome.php?isAdd=true&ser=$_seruser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        setState(() {
          ser_user = userModel.ser;
          position_user = userModel.position;
          fname_user = userModel.fname;
          fname_text.text = userModel.fname!;
          lname_user = userModel.lname;
          lname_text.text = userModel.lname!;
          email_user = userModel.email;
          email_text.text = userModel.email!;
          utype_user = userModel.utype;
          tel_user = userModel.tel;
          tel_text.text = userModel.tel!;
          permission_user = userModel.permission;
          Posi_text.text = userModel.position!;
        });
      }
    } catch (e) {}
  }

  Future<Null> ResetPass(context) async {
    String url =
        '${MyConstant().domain}/ResetPasswd.php?isAdd=true&ser_U=$ser_user&pass_U=$password_U&type=0';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      Insert_log.Insert_logs('ตั้งค่า',
          'ข้อมูลผู้ใช้งาน>>แก้ไขรหัสผ่าน(*${email_user.toString()})');
      print(result.toString());
      signInThread();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('การเชื่อมต่อผิดพลาด',
                style:
                    TextStyle(color: Colors.black, fontFamily: Font_.Fonts_T))),
      );
    }
    Navigator.pop(context, 'OK');
  }

  Future<Null> Resetdata2(context) async {
    String url =
        '${MyConstant().domain}/ResetPasswd.php?isAdd=true&ser_U=$ser_user&fname_U=${fname_text.text}&lname_U=${lname_text.text}&email_U=${email_text.text}&tel_U=${tel_text.text}&posi_U=${Posi_text.text}&type=1';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      Insert_log.Insert_logs('ตั้งค่า',
          'ข้อมูลผู้ใช้งาน>>แก้ไขข้อมูลผู้ใช้(*${email_user.toString()})');
      print(result.toString());
      signInThread();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('การเชื่อมต่อผิดพลาด',
                style:
                    TextStyle(color: Colors.black, fontFamily: Font_.Fonts_T))),
      );
    }
    Navigator.pop(context, 'OK');
  }

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
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ข้อมูลผู้ใช้',
                  style: TextStyle(
                    color: SettingScreen_Color.Colors_Text1_,
                    fontFamily: FontWeight_.Fonts_T,
                    fontWeight: FontWeight.bold,
                    //fontSize: 10.0
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    // border: Border.all(
                    //     color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: const [
                      Text(
                        'แก้ไข',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontWeight_.Fonts_T,
                          fontWeight: FontWeight.bold,
                          //fontSize: 10.0
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  showDialog<String>(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => Form(
                      key: _formKey2,
                      child: AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: const Center(
                            child: Text(
                          'แก้ไขข้อมูลผู้ใช้',
                          style: TextStyle(
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
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'ชื่อ-นามสกุล',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //     'นามสกุล',
                                    //     textAlign: TextAlign.left,
                                    //     style: TextStyle(
                                    //       color:
                                    //           SettingScreen_Color.Colors_Text1_,
                                    //       fontFamily: FontWeight_.Fonts_T,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // width: 200,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            controller: fname_text,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                                fillColor: Colors.white
                                                    .withOpacity(0.3),
                                                filled: true,
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
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black,
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
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                labelText: 'ชื่อ',
                                                labelStyle: const TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                )),
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.deny(
                                                  RegExp(r'\s')),
                                            ],
                                            // inputFormatters: <TextInputFormatter>[
                                            //   // for below version 2 use this
                                            //   // FilteringTextInputFormatter.allow(
                                            //   //     RegExp(r'[0-9]')),
                                            //   // for version 2 and greater youcan also use this
                                            //   // FilteringTextInputFormatter.digitsOnly
                                            // ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // width: 200,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            controller: lname_text,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                                fillColor: Colors.white
                                                    .withOpacity(0.3),
                                                filled: true,
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
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black,
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
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                labelText: 'นามสกุล',
                                                labelStyle: const TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                )),
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.deny(
                                                  RegExp(r'\s')),
                                            ],
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
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: const [
                                //     Padding(
                                //       padding: EdgeInsets.all(8.0),
                                //       child: Text(
                                //         'นามสกุล',
                                //         textAlign: TextAlign.left,
                                //         style: TextStyle(
                                //           color:
                                //               SettingScreen_Color.Colors_Text1_,
                                //           fontFamily: FontWeight_.Fonts_T,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'อีเมล',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
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
                                      keyboardType: TextInputType.text,
                                      controller: email_text,
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
                                          labelText: 'อีเมล',
                                          labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontFamily: FontWeight_.Fonts_T,
                                          )),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s')),
                                      ],
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
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'เบอร์โทร-ตำแหน่ง',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T,
                                          fontWeight: FontWeight.bold,
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // width: 200,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: tel_text,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                                fillColor: Colors.white
                                                    .withOpacity(0.3),
                                                filled: true,
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
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black,
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
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                labelText: 'เบอร์โทร',
                                                labelStyle: const TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                )),
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              // for below version 2 use this
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                              // for version 2 and greater youcan also use this
                                              // FilteringTextInputFormatter.digitsOnly
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // width: 200,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            controller: Posi_text,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                              }
                                              // if (int.parse(value.toString()) < 13) {
                                              //   return '< 13';
                                              // }
                                              return null;
                                            },
                                            // maxLength: 10,
                                            cursorColor: Colors.green,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white
                                                    .withOpacity(0.3),
                                                filled: true,
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
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black,
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
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                labelText: 'ตำแหน่ง',
                                                labelStyle: const TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                )),
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.deny(
                                                  RegExp(r'\s')),
                                            ],
                                            // inputFormatters: <
                                            //     TextInputFormatter>[
                                            //   // for below version 2 use this
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9]')),
                                            //   // for version 2 and greater youcan also use this
                                            //   // FilteringTextInputFormatter.digitsOnly
                                            // ],
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
                                            if (_formKey2.currentState!
                                                .validate()) {
                                              print(fname_text.text);
                                              print(lname_text.text);
                                              print(email_text.text);
                                              print(tel_text.text);
                                              Resetdata2(context);
                                            }
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.TiTile_Colors,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              // border: Border.all(
              //     color: Colors.grey, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'ชื่อผู้ใช้งาน',
                      maxLines: 1,
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
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'ตำแหน่ง',
                      maxLines: 1,
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
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'อีเมล',
                      maxLines: 1,
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
                    decoration: const BoxDecoration(
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
                      'เบอร์โทร',
                      maxLines: 1,
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
            height: 100,
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
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '$fname_user $lname_user',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: SettingScreen_Color.Colors_Text2_,
                        fontFamily: Font_.Fonts_T
                        //fontWeight: FontWeight.bold,
                        //fontSize: 10.0
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '$position_user',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: SettingScreen_Color.Colors_Text2_,
                        fontFamily: Font_.Fonts_T
                        //fontWeight: FontWeight.bold,
                        //fontSize: 10.0
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '$email_user',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: SettingScreen_Color.Colors_Text2_,
                        fontFamily: Font_.Fonts_T
                        //fontWeight: FontWeight.bold,
                        //fontSize: 10.0
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '$tel_user',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: SettingScreen_Color.Colors_Text2_,
                        fontFamily: Font_.Fonts_T
                        //fontWeight: FontWeight.bold,
                        //fontSize: 10.0
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'รหัสผ่าน : ',
                  style: TextStyle(
                    color: SettingScreen_Color.Colors_Text1_,
                    fontFamily: FontWeight_.Fonts_T,
                    fontWeight: FontWeight.bold,
                    //fontSize: 10.0
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    // border: Border.all(
                    //     color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: const [
                      Text(
                        'แก้ไข',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontWeight_.Fonts_T,
                          fontWeight: FontWeight.bold,
                          //fontSize: 10.0
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  showDialog<String>(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => Form(
                      key: _formKey,
                      child: AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: const Center(
                            child: Text(
                          'แก้ไขรหัสผ่าน',
                          style: TextStyle(
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
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'รหัสผ่านใหม่',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
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
                                      keyboardType: TextInputType.text,
                                      controller: Pasw1_text,
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
                                          labelText: 'รหัสผ่านใหม่',
                                          labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontFamily: FontWeight_.Fonts_T,
                                          )),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s')),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'ยืนยันรหัสผ่าน',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              SettingScreen_Color.Colors_Text1_,
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
                                      keyboardType: TextInputType.text,
                                      controller: Pasw2_text,
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
                                          labelText: 'ยืนยันรหัสผ่าน',
                                          labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontFamily: FontWeight_.Fonts_T,
                                          )),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s')),
                                      ],
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
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (Pasw1_text.text !=
                                                  Pasw2_text.text) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'รหัสผ่านไม่ตรงกัน กรุณาลองใหม่ !',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily: Font_
                                                                  .Fonts_T))),
                                                );
                                              } else {
                                                setState(() {
                                                  password_U = md5
                                                      .convert(utf8.encode(
                                                          Pasw1_text.text))
                                                      .toString();
                                                });
                                                /////---------------------------
                                                print(
                                                    'password Md5 $password_U');
                                                /////---------------------------
                                                setState(() {
                                                  Pasw1_text.clear();
                                                  Pasw2_text.clear();
                                                });
                                                /////---------------------------
                                                ResetPass(context);

                                                /////---------------------------
                                              }
                                            }
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
