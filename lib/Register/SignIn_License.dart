// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable, prefer_void_to_null
import 'dart:convert';
import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/Constant/Myconstant.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../AdminScaffold/AdminScaffold.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetC_Otp.dart';
import '../Model/GetLicensekey_Modely.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'SignIn_Screen.dart';
import 'SignIn_admin.dart';
import 'SignUp_Screen.dart';
import 'SignUp_Screen2.dart';
import 'package:crypto/crypto.dart' as crypto;

import 'Signup_License.dart';

class SignInLicense extends StatefulWidget {
  final String? route;
  const SignInLicense({
    super.key,
    this.route,
  });

  @override
  State<SignInLicense> createState() => _SignInLicenseState();
}

class _SignInLicenseState extends State<SignInLicense> {
  DateTime datex = DateTime.now();
  final Formbecause_ = TextEditingController();
  List<OtpModel> otpModels = [];
  List<RenTalModel> renTalModels = [];
  List<LicensekeyModel> licensekeyModels = [];
  String? ser_id, tem_id, user_id;
  // EmailOTP myauth = EmailOTP();
  @override
  void initState() {
    super.initState();

    // read_GC_rental();
    // checkPreferance();
    // read_GC_otp();
  }

  Future<Null> read_GC_packageGen() async {
    if (licensekeyModels.isNotEmpty) {
      setState(() {
        licensekeyModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_package_Gen.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('read_GC_rental///// $result');
      for (var map in result) {
        LicensekeyModel licensekeyModel = LicensekeyModel.fromJson(map);

        setState(() {
          licensekeyModels.add(licensekeyModel);
        });
      }
    } catch (e) {}
  }
  // Future<Null> read_GC_rental() async {
  //   if (renTalModels.isNotEmpty) {
  //     renTalModels.clear();
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var utype = preferences.getString('utype');
  //   var seruser = preferences.getString('ser');
  //   String url =
  //       '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result != null) {
  //       for (var map in result) {
  //         RenTalModel renTalModel = RenTalModel.fromJson(map);
  //         var rtnamex = renTalModel.rtname;
  //         var typexs = renTalModel.type;
  //         var typexx = renTalModel.typex;
  //         var name = renTalModel.pn!.trim();
  //         var pkqtyx = int.parse(renTalModel.pkqty!);
  //         var pkuserx = int.parse(renTalModel.pkuser!);
  //         var pkx = renTalModel.pk!.trim();
  //         var foderx = renTalModel.dbn;
  //         var img = renTalModel.img;
  //         var imglogo = renTalModel.imglogo;
  //         var img = renTalModel.pksdate;
  //         var imglogo = renTalModel.pkldate;
  //         setState(() {
  //           foder = foderx;
  //           rtname = rtnamex;
  //           type = typexs;
  //           typex = typexx;
  //           renname = name;
  //           pkqty = pkqtyx;
  //           pkuser = pkuserx;
  //           pkname = pkx;
  //           img_ = img;
  //           img_logo = imglogo;
  //           renTalModels.add(renTalModel);
  //         });
  //       }
  //     } else {}
  //   } catch (e) {}
  //   print('name>>>>>  $renname');
  // }

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
            'message': 'License Key : $message'
          }
        }));
    return response.statusCode;
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? renTalSer = preferences.getString('renTalSer');

      // print('$utype');

      // if (utype != null && utype.isNotEmpty) {
      //   if (verify != '0') {
      //     routToService(AdminScafScreen(route: 'หน้าหลัก'));
      //   }
      // }
    } catch (e) {}
  }

  void routToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  // bool _validate = false;
  final Form1_text = TextEditingController();
  final Form2_text = TextEditingController();

  String? email_username, password_username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0xfff3f3ee),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      //   constraints: BoxConstraints(
                      //   maxWidth: MediaQuery.of(context).size.width / 1.05,
                      // ),
                      width: MediaQuery.of(context).size.width,

                      decoration: BoxDecoration(
                        color: const Color(0xfff3f3ee),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                      ),
                      child: SingleChildScrollView(
                        // scrollDirection: Axis.horizontal,
                        dragStartBehavior: DragStartBehavior.down,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: (Responsive.isDesktop(context))
                                    ? const EdgeInsets.all(30)
                                    : const EdgeInsets.all(8),
                                child: Container(
                                  constraints: BoxConstraints(
                                    minWidth: (Responsive.isDesktop(context))
                                        ? 200
                                        : 100,
                                    maxWidth: (Responsive.isDesktop(context))
                                        ? 400
                                        : 200,
                                  ),
                                  child: const Image(
                                    image: AssetImage('images/LOGO.png'),
                                    // width: 200,
                                  ),
                                )),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                constraints: const BoxConstraints(
                                  minWidth: 300,
                                  maxWidth: 320,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: AutoSizeText(
                                            minFontSize:
                                                (Responsive.isDesktop(context))
                                                    ? 30
                                                    : 20,
                                            maxFontSize: 50,
                                            maxLines: 1,
                                            'License Key',
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                // fontSize: 20,
                                                color: SinginScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T)),
                                      ),
                                      SizedBox(
                                        height: (Responsive.isDesktop(context))
                                            ? 20
                                            : 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          //keyboardType: TextInputType.none,
                                          controller: Form1_text,
                                          onChanged: (value) =>
                                              email_username = value.trim(),
                                          validator: (value) {
                                            // if (value == null ||
                                            //     value.isEmpty ||
                                            //     value.length < 13) {
                                            //   return 'ใส่ข้อมูลให้ครบถ้วน ';
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'กรุณากรอก License Key';
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
                                              prefixIcon: const Icon(
                                                  Icons.key_outlined,
                                                  color: Colors.black),
                                              // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15),
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
                                              errorStyle: TextStyle(
                                                  fontFamily: Font_.Fonts_T),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15),
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
                                              labelText: 'License Key',
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                  fontFamily: Font_.Fonts_T)),
                                          // inputFormatters: <TextInputFormatter>[
                                          //   // for below version 2 use this
                                          //   FilteringTextInputFormatter(RegExp("[a-zA-Z1-9@.]"),
                                          //       allow: true),
                                          //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          //   // for version 2 and greater youcan also use this
                                          //   // FilteringTextInputFormatter.digitsOnly
                                          // ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: (Responsive.isDesktop(context))
                                            ? 30
                                            : 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            signInThread();
                                          }
                                        },
                                        child: Container(
                                          width: 150,
                                          height:
                                              (Responsive.isDesktop(context))
                                                  ? 60
                                                  : 40,
                                          decoration: BoxDecoration(
                                            color: Colors.lime[800],
                                            borderRadius: const BorderRadius
                                                .only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                          ),
                                          child: Center(
                                            child: Text('Submit',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize:
                                                        (Responsive.isDesktop(
                                                                context))
                                                            ? 20
                                                            : 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (Responsive.isDesktop(context))
                                            ? 20
                                            : 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUPLicense()),
                                          );
                                        },
                                        child: Container(
                                          child: const Center(
                                            child: Text('Register License Key',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                    fontFamily: Font_.Fonts_T)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (Responsive.isDesktop(context))
                                            ? 30
                                            : 20,
                                      ),
                                      widget.route! == 'No'
                                          ? InkWell(
                                              onTap: () async {
                                                deall_Trans_select();
                                                SharedPreferences preferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                var ser = preferences
                                                    .getString('ser');
                                                var on = '0';
                                                String url =
                                                    '${MyConstant().domain}/U_user_onoff.php?isAdd=true&ser=$ser&on=$on';

                                                try {
                                                  var response = await http
                                                      .get(Uri.parse(url));

                                                  var result = json
                                                      .decode(response.body);
                                                  print(result);
                                                  if (result.toString() ==
                                                      'true') {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    preferences.clear();
                                                    routToService(
                                                        SignInScreen());
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              '(ผิดพลาด)')),
                                                    );
                                                  }
                                                } catch (e) {}
                                              },
                                              child: Container(
                                                child: const Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.logout),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text('Logout',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily: Font_
                                                                  .Fonts_T)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                Navigator.pop(context, 'OK');
                                              },
                                              child: Container(
                                                child: const Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                          Icons.arrow_back_ios),
                                                      // Text('Back',
                                                      //     maxLines: 3,
                                                      //     overflow:
                                                      //         TextOverflow.ellipsis,
                                                      //     softWrap: false,
                                                      //     style: TextStyle(
                                                      //         fontSize: 18,
                                                      //         color: Colors.black,
                                                      //         fontFamily:
                                                      //             Font_.Fonts_T)),
                                                    ],
                                                  ),
                                                ),
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
                    ),
                  ),
                ),
              ],
            )));
  }

  Future<Null> deall_Trans_select() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    String url =
        '${MyConstant().domain}/D_tran_select.php?isAdd=true&ren=$ren&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
      } else if (result.toString() == 'false') {
        print('rrrrrrrrrrrrrrfalse');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
      }
    } catch (e) {
      // print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> signInThread() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var _Licens = email_username;

    String url =
        '${MyConstant().domain}/up_rentel_pacnow.php?isAdd=true&serren=$ren&lisen=$_Licens';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        Insert_log.Insert_logs('Update Licens', 'License Key');
        String? _route = preferences.getString('route');
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => AdminScafScreen(route: _route));
        Navigator.pushAndRemoveUntil(
            context, materialPageRoute, (route) => false);

        // MaterialPageRoute route = MaterialPageRoute(
        //   builder: (context) => AdminScafScreen(),
        // );
        // Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('License Key ผิดพลาด กรุณาลองใหม่!',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
      }
    } catch (e) {}
  }
}
