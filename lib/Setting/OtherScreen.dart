import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
// import 'package:hsv_color_pickers/hsv_color_pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../Model/GetPerMission_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetType_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Style/colors.dart';
import 'package:http/http.dart' as http;

class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
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
      tel_user,
      modeclor_;
  String password_U = '';
  int? perMissioncount;
  List<RenTalModel> renTalModels = [];
  List<PerMissionModel> perMissionModels = [];
  final _formKey = GlobalKey<FormState>();
  final Pasw1_text = TextEditingController();
  final Pasw2_text = TextEditingController();
///////////------------------------------------------->
  String tappedIndex_ = '';
///////---------------------------------------------------->
  @override
  void initState() {
    super.initState();

    signInThread();
  }

  String _verticalGroupValue = "สว่าง";
  final _status = ["มืด", "สว่าง"];
  String _singleValue = "Text alignment right";
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
          position_user = userModel.position;
          fname_user = userModel.fname;
          lname_user = userModel.lname;
          email_user = userModel.email;
          utype_user = userModel.utype;
          tel_user = userModel.tel;
          permission_user = userModel.permission;
          modeclor_ = userModel.modeclor;
        });
      }
    } catch (e) {}
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
              const Padding(
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
            ],
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              // color: AppbackgroundColor2.TiTile_Colors(int.parse('1')),
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
                      'โหมดโทนสี',
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
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     padding: const EdgeInsets.all(8.0),
                //     child: const Text(
                //       'สีพื้นหลัง',
                //       maxLines: 1,
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         color: SettingScreen_Color.Colors_Text1_,
                //         fontFamily: FontWeight_.Fonts_T,
                //         fontWeight: FontWeight.bold,
                //         //fontSize: 10.0
                //       ),
                //     ),
                //   ),
                // ),
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     padding: const EdgeInsets.all(8.0),
                //     child: const Text(
                //       'สีพื้นหลังหัวตาราง',
                //       maxLines: 1,
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         color: SettingScreen_Color.Colors_Text1_,
                //         fontFamily: FontWeight_.Fonts_T,
                //         fontWeight: FontWeight.bold,
                //         //fontSize: 10.0
                //       ),
                //     ),
                //   ),
                // ),
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     decoration: const BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(0),
                //         topRight: Radius.circular(10),
                //         bottomLeft: Radius.circular(0),
                //         bottomRight: Radius.circular(0),
                //       ),
                //       // border: Border.all(
                //       //     color: Colors.grey, width: 1),
                //     ),
                //     padding: const EdgeInsets.all(8.0),
                //     child: const Text(
                //       'สีพื้นหลังแทบเมนูหลัก',
                //       maxLines: 1,
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         color: SettingScreen_Color.Colors_Text1_,
                //         fontFamily: FontWeight_.Fonts_T,
                //         fontWeight: FontWeight.bold,
                //         //fontSize: 10.0
                //       ),
                //     ),
                //   ),
                // ),
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
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      child: StreamBuilder(
                          stream: Stream.periodic(Duration(seconds: 0)),
                          builder: (context, snapshot) {
                            return RadioGroup<String>.builder(
                              groupValue: _verticalGroupValue,
                              onChanged: (value) => setState(() {
                                _verticalGroupValue = value ?? '';
                              }),
                              items: _status,
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,
                                textPosition: RadioButtonTextPosition.left,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //       width: 100,
                //       child: StreamBuilder(
                //           stream: Stream.periodic(Duration(seconds: 0)),
                //           builder: (context, snapshot) {
                //             return HuePicker(
                //               initialColor: HSVColor.fromColor(Colors.red),
                //               onChanged: (HSVColor color) async {
                //                 SharedPreferences preferences =
                //                     await SharedPreferences.getInstance();
                //                 preferences.setString(
                //                     'color', color.alpha.toString());
                //                 String? _seruser =
                //                     preferences.getString('color');
                //                 print(_seruser);
                //                 // do something with color
                //               },
                //             );
                //           })),
                // ),
                // Expanded(
                //   flex: 2,
                //   child: Text(
                //     '$email_user',
                //     maxLines: 1,
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //         color: SettingScreen_Color.Colors_Text2_,
                //         fontFamily: Font_.Fonts_T
                //         //fontWeight: FontWeight.bold,
                //         //fontSize: 10.0
                //         ),
                //   ),
                // ),
                // Expanded(
                //   flex: 2,
                //   child: Text(
                //     '$tel_user',
                //     maxLines: 1,
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         color: SettingScreen_Color.Colors_Text2_,
                //         fontFamily: Font_.Fonts_T
                //         //fontWeight: FontWeight.bold,
                //         //fontSize: 10.0
                //         ),
                //   ),
                // ),
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
}
