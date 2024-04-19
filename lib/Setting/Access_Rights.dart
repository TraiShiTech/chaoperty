// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';
import 'dart:js_util';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto/crypto.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/Count_user_model.dart';
import '../Model/GetPerMission_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/per_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class Accessrights extends StatefulWidget {
  const Accessrights({super.key});

  @override
  State<Accessrights> createState() => _AccessrightsState();
}

class _AccessrightsState extends State<Accessrights> {
  List<UserModel> userModels = [];
  List<UserModel> _userModels = <UserModel>[];
  List<String> checked_edit = [];
  List<PerMissionModel> perMissionModels = [];
  /////---------------------------------------------------------->
  String tappedIndex_ = '';
  /////---------------------------------------------------------->
  String? renTal_user, renTal_name, zone_ser, zone_name, checked_value = '';
  /////---------------------------------------------------------->
  int? perMissioncount;

  final List<Per> list = [];
  List<bool> _isChecks = [];
  List<RenTalModel> renTalModels = [];
  int? pkqty, pkuser, countarae;
  int renTal_lavel = 0;
  String? rtname,
      type,
      typex,
      renname,
      pkname,
      ser_Zonex,
      laveluser,
      renTal_utype;

  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_User();
    read_GC_permission();
    read_GC_rental();
    read_GC_user_count();

    _userModels = userModels;
  }

  Future<Null> read_GC_user_count() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_userCount.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          UserCountModel userCountModel = UserCountModel.fromJson(map);
          var c = int.parse(userCountModel.countu!);
          print('AAAAA>>>>>>>>>>>>>>>>>>>> $c');
          setState(() {
            countarae = c;
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      setState(() {
        renTalModels.clear();
      });
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
          setState(() {
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            pkqty = pkqtyx;
            pkuser = pkuserx;
            pkname = pkx;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  Future<Null> read_GC_permission() async {
    if (perMissionModels.length != 0) {
      setState(() {
        perMissionModels.clear();
      });
    }

    String url = '${MyConstant().domain}/GC_permissionAll.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      for (var map in result) {
        PerMissionModel perMissionModel = PerMissionModel.fromJson(map);
        setState(() {
          perMissionModels.add(perMissionModel);
        });
      }
      setState(() {
        perMissioncount = perMissionModels.length;
      });
    } catch (e) {}
  }

  /////---------------------------------------------------------->
  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      renTal_utype = preferences.getString('utype');
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
    });
  }

  Future<Null> read_GC_User() async {
    if (userModels.isNotEmpty) {
      setState(() {
        userModels.clear();
        _userModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_userSetting.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          setState(() {
            userModels.add(userModel);
            _userModels = userModels;
          });
        }
      } else {}
    } catch (e) {}
  }

  /////---------------------------------------------------------->
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
        hintText: ' Search...email',
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
          userModels = _userModels.where((userModelss) {
            var notTitle = userModelss.email!.toLowerCase();
            return notTitle.contains(text);
          }).toList();
        });
      },
    );
  }

  /////---------------------------------------------------------->
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

  /////---------------------------------------------------------->

//////////------------------------------------------------>
  Future<Null> Add_userAcess() async {
    final _formKey = GlobalKey<FormState>();
    final FormName_text = TextEditingController();
    final FormLame_text = TextEditingController();
    final FormTel_text = TextEditingController();
    final FormEmail_text = TextEditingController();
    final FormPassword_text = TextEditingController();
    final FormRank_text = TextEditingController();

    // List<String> checked_Add = [];

    _isChecks.clear();
    list.clear();

    for (int i = 0; i < perMissionModels.length; i++) {
      list.add(
          Per('${perMissionModels[i].ser}', '${perMissionModels[i].perm}'));
      _isChecks.add(false);
    }

    print(_isChecks);

    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Form(
        key: _formKey,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Center(
              child: Text(
            'เพิ่มผู้ใช้งาน',
            style: TextStyle(
              color: SettingScreen_Color.Colors_Text1_,
              fontFamily: FontWeight_.Fonts_T,
              fontWeight: FontWeight.bold,
            ),
          )),
          content: Container(
            height: MediaQuery.of(context).size.height / 1.5,
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
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'ชื่อ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
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
                                keyboardType: TextInputType.text,
                                controller: FormName_text,
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
                                    labelText: 'ชื่อ',
                                    labelStyle: const TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: Font_.Fonts_T)),
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
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'นามสกุล',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
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
                                keyboardType: TextInputType.text,
                                controller: FormLame_text,
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
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: Font_.Fonts_T)),
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
                        ],
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'ตำแหน่ง',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
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
                                keyboardType: TextInputType.text,
                                controller: FormRank_text,
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
                                    labelText: 'ตำแหน่ง',
                                    labelStyle: const TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: Font_.Fonts_T)),
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
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'เบอร์โทร',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
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
                                controller: FormTel_text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                    labelText: 'เบอร์โทร',
                                    labelStyle: const TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: Font_.Fonts_T)),
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'อีเมล',
                                textAlign: TextAlign.left,
                                style: TextStyle(
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
                              keyboardType: TextInputType.text,
                              controller: FormEmail_text,
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
                                  labelText: 'อีเมล',
                                  labelStyle: const TextStyle(
                                      color: SettingScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T)),
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
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'รหัสผ่าน',
                                textAlign: TextAlign.left,
                                style: TextStyle(
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
                              keyboardType: TextInputType.text,
                              controller: FormPassword_text,
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
                                  labelText: 'รหัสผ่าน',
                                  labelStyle: const TextStyle(
                                      color: SettingScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T)),
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
                      ],
                    ))
                  ]),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: StreamBuilder(
                                      stream: Stream.periodic(
                                          const Duration(seconds: 0)),
                                      builder: (context, snapshot) {
                                        return const Text(
                                          'สิทธิการเข้าถึง',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                // color: Colors.grey[400],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder(
                                  stream: Stream.periodic(
                                      const Duration(seconds: 0)),
                                  builder: (context, snapshot) {
                                    return Column(
                                      children: [
                                        for (int index = 0;
                                            index < perMissionModels.length;
                                            index++)
                                          if (perMissionModels[index]
                                                  .perm
                                                  .toString() !=
                                              'จัดการข้อมูลส่วนตัว')
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Checkbox(
                                                      activeColor: Colors
                                                          .blue, // ​​color when activated
                                                      value: _isChecks[index],
                                                      onChanged: (bool? val) {
                                                        setState(() {
                                                          _isChecks[index] =
                                                              val!;
                                                        });
                                                        // print(checked_Add);
                                                        checked_value = '';
                                                        for (var i = 0;
                                                            i < list.length;
                                                            i++) {
                                                          String idmenu =
                                                              list[i].title;
                                                          String pnmenu =
                                                              list[i].content;
                                                          if (_isChecks[i] ==
                                                              true) {
                                                            setState(() {
                                                              checked_value =
                                                                  '$checked_value' +
                                                                      '$idmenu' +
                                                                      ',';
                                                            });
                                                          }
                                                        }
                                                        print('$checked_value');
                                                      }),
                                                ),
                                                Expanded(
                                                  flex: 8,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    '${perMissionModels[index].perm}',
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      )),
                      const Expanded(
                        child: SizedBox(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
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
                                  if (checked_value == '') {
                                  } else {
                                    print(
                                        'ชื่อผู้ใช้ : ${FormName_text.text.toString()}');
                                    print(
                                        'ตำแหน่ง : ${FormRank_text.text.toString()}');
                                    print(
                                        'อีเมล : ${FormEmail_text.text.toString()}');
                                    // print(
                                    //     'สิทธิ์ 8: ${checked_Add} $checked_value');

                                    var cl = checked_value!.length;
                                    var cle =
                                        checked_value!.substring(0, cl - 1);
                                    print('สิทธิ์ 9: $cle');

                                    var name = FormName_text.text.toString();
                                    var lame = FormLame_text.text.toString();
                                    var tel = FormTel_text.text.toString();
                                    var email = FormEmail_text.text.toString();
                                    var password = md5
                                        .convert(utf8.encode(
                                            FormPassword_text.text.toString()))
                                        .toString();
                                    var renk = FormRank_text.text.toString();

                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');

                                    String url =
                                        '${MyConstant().domain}/InC_Useradd.php?isAdd=true&ren=$ren&ser_user=$ser_user&name=$name&lame=$lame&tel=$tel&email=$email&password=$password&renk=$renk&checked_value=$cle';

                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        Insert_log.Insert_logs('ตั้งค่า',
                                            'สิทธิการเข้าถึง>>เพิ่ม(*${FormName_text.text.toString()})');
                                        setState(() {
                                          FormName_text.clear();
                                          FormLame_text.clear();
                                          FormTel_text.clear();
                                          FormEmail_text.clear();
                                          FormPassword_text.clear();
                                          FormRank_text.clear();
                                          // read_GC_User();
                                        });
                                      } else {}
                                    } catch (e) {}
                                    setState(() {
                                      read_GC_User();
                                      list.clear();
                                      _isChecks.clear();
                                      read_GC_user_count();
                                    });
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: const Text(
                                'ตกลง',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text(
                                'ปิด',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
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
              'Level Information',
              style: TextStyle(
                color: SettingScreen_Color.Colors_Text1_,
                fontFamily: FontWeight_.Fonts_T,
                fontWeight: FontWeight.bold,
              ),
            )),
            content: Container(
                padding: EdgeInsets.all(8),
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
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('Level 1')),
                        Expanded(flex: 6, child: Text('แสดงข้อมูล')),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('Level 2')),
                        Expanded(flex: 6, child: Text('บันทึกมิเตอร์')),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('Level 3')),
                        Expanded(
                            flex: 6,
                            child: Text('ทำสัญญา,รับชำระ,บันทึกมิเตอร์')),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('Level 4')),
                        Expanded(
                            flex: 6,
                            child: Text(
                                'ทำสัญญา,รับชำระ,บันทึกมิเตอร์,แก้ไขทะเบียน,แก้ไขสัญญา')),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('Level 5')),
                        Expanded(
                            flex: 6,
                            child: Text(
                                'ทำสัญญา,รับชำระ,บันทึกมิเตอร์,แก้ไขทะเบียน,แก้ไขสัญญา,ออกรายงาน,ตั้งค่าต่างๆ')),
                      ],
                    ),
                  ],
                )))));
  }

//////////------------------------------------------------>
  Future<Null> Edit_userAcess(int index) async {
    final _formKey = GlobalKey<FormState>();
    final FormName_text = TextEditingController();
    final FormLame_text = TextEditingController();
    final FormTel_text = TextEditingController();
    final FormEmail_text = TextEditingController();
    final FormPassword_text = TextEditingController();
    final FormRank_text = TextEditingController();
    String? laveluid = userModels[index].user_id;
    String? ser_ = userModels[index].ser;
    String? fname_ = userModels[index].fname;
    String? lname_ = userModels[index].lname;
    String? position_ = userModels[index].position;
    String? permission_ = userModels[index].permission;
    String? utype_ = userModels[index].utype;

    // String value_thai_ = '${accessthai_}';
    // List<String> splitvalue_thai_ = value_thai_.split(',');
    //////////////////////--------------------------------->
    // String value_int_ = '${permission_}';
    // List<String> splitvalue_int_ = value_int_.split(',');
    List<String> checked_editindex = [];

    List<String> permissions =
        (userModels[index].permission!.trim().split(','));

    _isChecks.clear();
    list.clear();

    for (int index = 0; index < perMissionModels.length; index++) {
      setState(() {
        list.add(Per('${perMissionModels[index].ser}',
            '${perMissionModels[index].perm}'));
      });
    }

    print('>>>>>>123500>>> $permissions');
    checked_value = '';
    for (int i = 0; i < list.length; i++) {
      if (permissions.contains(list[i].title) == true) {
        setState(() {
          _isChecks.add(true);
          checked_value = '$checked_value' + '${list[i].title}' + ',';
        });
      } else {
        setState(() {
          _isChecks.add(false);
        });
      }
    }

    print(_isChecks);

    setState(() {
      FormName_text.text = userModels[index].fname!;
      FormLame_text.text = userModels[index].lname!;
      FormTel_text.text = userModels[index].tel!;
      FormEmail_text.text = userModels[index].email!;
      FormPassword_text.clear();
      FormRank_text.text = userModels[index].position!;
    });

    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Form(
        key: _formKey,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Center(
              child: Text(
            'แก้ไขผู้ใช้งาน',
            style: TextStyle(
              color: SettingScreen_Color.Colors_Text1_,
              fontFamily: FontWeight_.Fonts_T,
              fontWeight: FontWeight.bold,
            ),
          )),
          content: Container(
            height: MediaQuery.of(context).size.height / 1.5,
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
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'ชื่อ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
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
                                controller: FormName_text,
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
                                    labelText: 'ชื่อ',
                                    labelStyle: const TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: Font_.Fonts_T)),
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
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'นามสกุล',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
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
                                controller: FormLame_text,
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
                                        color:
                                            SettingScreen_Color.Colors_Text2_,
                                        fontFamily: Font_.Fonts_T)),
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
                        ],
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ตำแหน่ง',
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
                                    keyboardType: TextInputType.number,
                                    controller: FormRank_text,
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
                                        labelText: 'ตำแหน่ง',
                                        labelStyle: const TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T)),
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
                            ],
                          )),
                      renTal_lavel < 5
                          ? SizedBox()
                          : Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Level',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            infomation();
                                          },
                                          icon: Icon(Icons.info_outline))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      // width: 200,
                                      child: DropdownButtonFormField2(
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        isExpanded: true,
                                        hint: Text(
                                          'Level $laveluid',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: TextHome_Color.TextHome_Colors,
                                        ),
                                        style: TextStyle(
                                          color: Colors.green.shade900,
                                        ),
                                        iconSize: 20,
                                        buttonHeight: 50,
                                        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: '1',
                                            child: Text(
                                              'Level 1',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '2',
                                            child: Text(
                                              'Level 2',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '3',
                                            child: Text(
                                              'Level 3',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '4',
                                            child: Text(
                                              'Level 4',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '5',
                                            child: Text(
                                              'Level 5',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          )
                                        ],

                                        onChanged: (value) async {
                                          setState(() {
                                            laveluid = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                      renTal_lavel <= 2
                          ? SizedBox()
                          : Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'All Maket',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  renTal_utype != 'M'
                                      ? Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.lime[800],
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
                                            ),
                                            child: Text(
                                              utype_ == 'S' ? 'ปิด' : 'เปิด',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: SettingScreen_Color
                                                    .Colors_Text1_,
                                                fontFamily: FontWeight_.Fonts_T,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            // width: 200,
                                            child: DropdownButtonFormField2(
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              isExpanded: true,
                                              hint: Text(
                                                utype_ == 'S' ? 'ปิด' : 'เปิด',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: TextHome_Color
                                                    .TextHome_Colors,
                                              ),
                                              style: TextStyle(
                                                color: Colors.green.shade900,
                                              ),
                                              iconSize: 20,
                                              buttonHeight: 50,
                                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                              dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              items: [
                                                DropdownMenuItem<String>(
                                                  value: 'S',
                                                  child: Text(
                                                    'ปิด',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                DropdownMenuItem<String>(
                                                  value: 'MS',
                                                  child: Text(
                                                    'เปิด',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                              ],

                                              onChanged: (value) async {
                                                setState(() {
                                                  utype_ = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                ],
                              )),
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'เบอร์โทร',
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
                                    keyboardType: TextInputType.number,
                                    controller: FormTel_text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
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
                                        labelText: 'เบอร์โทร',
                                        labelStyle: const TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T)),
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                      // for version 2 and greater youcan also use this
                                      // FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'อีเมล',
                                textAlign: TextAlign.left,
                                style: TextStyle(
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
                              controller: FormEmail_text,
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
                                  labelText: 'อีเมล',
                                  labelStyle: const TextStyle(
                                      color: SettingScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T)),
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
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'รหัสผ่าน',
                                textAlign: TextAlign.left,
                                style: TextStyle(
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
                              controller: FormPassword_text,
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
                                  labelText: 'รหัสผ่านใหม่',
                                  labelStyle: const TextStyle(
                                      color: SettingScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T)),
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
                      ],
                    ))
                  ]),
                  renTal_lavel <= 1
                      ? SizedBox()
                      : Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: StreamBuilder(
                                            stream: Stream.periodic(
                                                const Duration(seconds: 0)),
                                            builder: (context, snapshot) {
                                              return const Text(
                                                'สิทธิการเข้าถึง( *กรุณากำหนดสิทธิ )',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: SettingScreen_Color
                                                      .Colors_Text1_,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      // color: Colors.grey[400],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: StreamBuilder(
                                        stream: Stream.periodic(
                                            const Duration(seconds: 0)),
                                        builder: (context, snapshot) {
                                          return Column(
                                            children: [
                                              for (int index = 0;
                                                  index <
                                                      perMissionModels.length;
                                                  index++)
                                                if (perMissionModels[index]
                                                        .perm
                                                        .toString() !=
                                                    'จัดการข้อมูลส่วนตัว')
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Checkbox(
                                                            activeColor: Colors
                                                                .blue, // ​​color when activated
                                                            value: _isChecks[
                                                                index],
                                                            onChanged:
                                                                (bool? val) {
                                                              setState(() {
                                                                _isChecks[
                                                                        index] =
                                                                    val!;
                                                              });
                                                              // print(checked_Add);
                                                              checked_value =
                                                                  '';
                                                              for (var i = 0;
                                                                  i < list.length;
                                                                  i++) {
                                                                String idmenu =
                                                                    list[i]
                                                                        .title;
                                                                String pnmenu =
                                                                    list[i]
                                                                        .content;
                                                                if (_isChecks[
                                                                        i] ==
                                                                    true) {
                                                                  setState(() {
                                                                    checked_value =
                                                                        '$checked_value' +
                                                                            '$idmenu' +
                                                                            ',';
                                                                  });
                                                                }
                                                              }
                                                              print(
                                                                  '$checked_value');
                                                            }),
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          '${perMissionModels[index].perm}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: const TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            )),
                            const Expanded(
                              child: SizedBox(),
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
                ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: (!Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width * 0.85,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      String? ren =
                                          preferences.getString('renTalSer');
                                      String? ser_user =
                                          preferences.getString('ser');
                                      String? ser_id = userModels[index].ser;

                                      String url =
                                          '${MyConstant().domain}/DeC_Useradd.php?isAdd=true&ren=$ren&ser_id=$ser_id&ser_user=$ser_user';

                                      try {
                                        var response =
                                            await http.get(Uri.parse(url));

                                        var result = json.decode(response.body);
                                        Insert_log.Insert_logs('ตั้งค่า',
                                            'สิทธิการเข้าถึง>>ลบ(*${FormEmail_text.text.toString()})');
                                        print(result);
                                        if (result.toString() == 'true') {
                                          setState(() {
                                            FormName_text.clear();
                                            FormLame_text.clear();
                                            FormTel_text.clear();
                                            FormEmail_text.clear();
                                            FormPassword_text.clear();
                                            FormRank_text.clear();
                                            read_GC_User();
                                          });
                                        } else {}
                                      } catch (e) {}
                                      setState(() {
                                        read_GC_User();
                                        read_GC_user_count();
                                        list.clear();
                                        _isChecks.clear();
                                      });
                                      Navigator.pop(context);
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
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: StreamBuilder(
                                      stream: Stream.periodic(
                                          const Duration(seconds: 0)),
                                      builder: (context, snapshot) {
                                        return TextButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (checked_value == '') {
                                              } else {
                                                print(
                                                    'ชื่อผู้ใช้ : ${FormName_text.text.toString()}');
                                                print(
                                                    'ตำแหน่ง : ${FormRank_text.text.toString()}');
                                                print(
                                                    'อีเมล : ${FormEmail_text.text.toString()}');
                                                // print(
                                                //     'สิทธิ์ 8: ${checked_Add} $checked_value');

                                                var cl = checked_value!.length;
                                                var cle = checked_value!
                                                    .substring(0, cl - 1);
                                                print(
                                                    'สิทธิ์ 9: $cle ${FormPassword_text.text.toString()}');

                                                var name = FormName_text.text
                                                    .toString();
                                                var lame = FormLame_text.text
                                                    .toString();
                                                var tel = FormTel_text.text
                                                    .toString();
                                                var email = FormEmail_text.text
                                                    .toString();
                                                var password = FormPassword_text
                                                            .text
                                                            .toString() ==
                                                        ''
                                                    ? userModels[index].passwd
                                                    : md5
                                                        .convert(utf8.encode(
                                                            FormPassword_text
                                                                .text
                                                                .toString()))
                                                        .toString();
                                                var renk = FormRank_text.text
                                                    .toString();

                                                print('สิทธิ์ 10: $password');

                                                SharedPreferences preferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                String? ren = preferences
                                                    .getString('renTalSer');
                                                String? ser_user = preferences
                                                    .getString('ser');
                                                String? ser_id =
                                                    userModels[index].ser;

                                                String url =
                                                    '${MyConstant().domain}/UpC_Useradd.php?isAdd=true&ren=$ren&ser_id=$ser_id&ser_user=$ser_user&name=$name&lame=$lame&tel=$tel&email=$email&password=$password&renk=$renk&checked_value=$cle&laveluser=$laveluid&utype=$utype_';
                                                Insert_log.Insert_logs(
                                                    'ตั้งค่า',
                                                    'สิทธิการเข้าถึง>>แก้ไขผู้ใช้งาน(${FormEmail_text.text.toString()})');
                                                try {
                                                  var response = await http
                                                      .get(Uri.parse(url));

                                                  var result = json
                                                      .decode(response.body);
                                                  print(result);

                                                  if (result.toString() ==
                                                      'true') {
                                                    setState(() {
                                                      FormName_text.clear();
                                                      FormLame_text.clear();
                                                      FormTel_text.clear();
                                                      FormEmail_text.clear();
                                                      FormPassword_text.clear();
                                                      FormRank_text.clear();
                                                      // read_GC_User();
                                                    });
                                                  } else {}
                                                } catch (e) {}
                                                setState(() {
                                                  read_GC_User();
                                                  list.clear();
                                                  _isChecks.clear();
                                                });
                                                Navigator.pop(context);
                                              }
                                            }
                                          },
                                          child: const Text(
                                            'ตกลง',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: FontWeight_.Fonts_T,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }),
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
                                    onPressed: () {
                                      setState(() {
                                        checked_edit.clear();
                                      });
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text(
                                      'ปิด',
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//////////------------------------------------------>
  Future<Null> OK_Edit(
    context,
    String ser_OK,
    String fname_OK,
    String lname_OK,
    String position_OK,
    String permission_OK,
  ) async {
    String New_permission_OK = permission_OK;
    New_permission_OK =
        New_permission_OK.replaceAll('[', '').replaceAll(']', '');
    print('OK_Edit');
    print('-------------------------');
    print('Ser : $ser_OK');
    print('ชื่อ : $fname_OK');
    print('นามสกุล: $lname_OK');
    print('ตำแหน่ง : $position_OK');
    print('สิทธิ์: $permission_OK');
    print('-------------------------');
    String url =
        '${MyConstant().domain}/EditC_userSetting.php?isAdd=true&ser_U=$ser_OK&fname_U=$fname_OK&lname_U=$lname_OK&position_U=$lname_OK&permission_U=$New_permission_OK';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('การเชื่อมต่อผิดพลาด',
                style:
                    TextStyle(color: Colors.black, fontFamily: Font_.Fonts_T))),
      );
    }
    read_GC_User();
    Navigator.pop(context, 'OK');
  }

  ///-------------------------------------------------------->
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
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ผู้ใช้งานระบบ',
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
                  onTap: () {
                    print('000 >>> $pkuser >>> $countarae');
                    if (countarae! < pkuser!) {
                      Add_userAcess();
                      print('1111 >>> $pkuser >>> $countarae');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'จำนวนผู้ใช้งานสูงสุดแล้วหากต้องการเพิ่มผู้ใช้งานกรุณา ซื้อ Package เพิ่ม !!!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: Font_.Fonts_T))),
                      );
                      print('2222 >>> $pkuser >>> $countarae');
                    }
                    // Add_userAcess();
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
                        color: Colors.white,

                        fontFamily: FontWeight_.Fonts_T,
                        fontWeight: FontWeight.bold,
                        //fontSize: 10.0
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                child: _searchBar(),
              )
            ],
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
                  SizedBox(
                    width: (!Responsive.isDesktop(context))
                        ? 800
                        : MediaQuery.of(context).size.width * 0.84,
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
                              bottomRight: Radius.circular(0),
                            ),
                            // border: Border.all(
                            //     color: Colors.grey, width: 1),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'ชื่อผู้ใช้',
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
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
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'อีเมล',
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
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
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'ตำแหน่ง',
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
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
                                    'สิทธิ์การเข้าถึง',
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
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
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'จัดการ',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.55,
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
                          child: userModels.isEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
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
                                      const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: userModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<String> value = [
                                      for (int i = 0;
                                          i < perMissionModels.length;
                                          i++)
                                        '${perMissionModels[i].perm}',
                                    ];
                                    String valueindex =
                                        '${userModels[index].permission}';
                                    List<String> splitValues =
                                        valueindex.split(',');

                                    String newValue = '';

                                    for (String index in splitValues) {
                                      if (index == '0') {
                                        for (int i2 = 0;
                                            i2 < value.length - 1;
                                            i2++) {
                                          newValue = newValue + value[i2] + ',';
                                        }
                                      } else {
                                        int i = int.parse(index);
                                        newValue =
                                            newValue + value[i - 1] + ',';
                                      }
                                    }
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
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${userModels[index].fname} ${userModels[index].lname}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 2,
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
                                                  child: Text(
                                                    '${userModels[index].email} ',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
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
                                                  child: Text(
                                                    '${userModels[index].position} ',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
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
                                                    '${newValue}',
                                                    // '${userModels[index].permission} ',
                                                    // (newValue.endsWith(','))
                                                    //     ? '${newValue.substring(0, newValue.length - 1)}'
                                                    //     : '${newValue}',
                                                    //  'ผู้เช่า',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
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
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                const BorderRadius
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
                                                                  .all(1.0),
                                                          child: const Text(
                                                            'แก้ไข',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
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
                                                        onTap: () {
                                                          if (renTal_lavel >
                                                              2) {
                                                            Edit_userAcess(
                                                                index);
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'ระดับการใช้งานของคุณไม่สามารถแก้ไขได้ !!!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              Font_.Fonts_T))),
                                                            );
                                                          }

                                                          // Edit_userAcess(index,
                                                          //     '${newValue.substring(0, newValue.length - 1)}');
                                                        },
                                                      ),
                                                    ),
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
