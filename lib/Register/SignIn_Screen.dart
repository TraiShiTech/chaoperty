import 'dart:convert';

import 'package:chaoperty/Constant/Myconstant.dart';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../AdminScaffold/AdminScaffold.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetUser_Model.dart';
import '../Style/colors.dart';
import 'SignUp_Screen.dart';
import 'SignUp_Screen2.dart';
import 'package:crypto/crypto.dart' as crypto;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  DateTime datex = DateTime.now();
  // EmailOTP myauth = EmailOTP();
  @override
  void initState() {
    super.initState();
    checkPreferance();
  }

  Future SendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    // const serviceId = 'service_8x6ajr8';
    // const templateId = 'template_ulify8d';
    // const userId = 'Xb8OnrjEz8t0FUpOr';
    const serviceId = 'service_njccq3b';
    const templateId = 'template_ulify8d';
    const userId = '8vgTm3ROqseE-a1vE';
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        }, //This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message
          }
        }));
    return response.statusCode;
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? utype = preferences.getString('utype');
      String? verify = preferences.getString('verify');

      print('$utype');

      if (utype != null && utype.isNotEmpty) {
        if (verify != '0') {
          routToService(AdminScafScreen(route: 'หน้าหลัก'));
        }
      }
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

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(0xfff3f3ee),
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: const Image(
                  image: AssetImage('images/LOGO.png'),
                  // width: 200,
                ),
              )),
        ),
        Expanded(
          flex: 4,
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                  child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 300,
                        maxWidth: 320,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('เข้าสู่ระบบ',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: SinginScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T)),
                                  ),
                                  SizedBox(
                                    height: 20,
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
                                        if (!((value!.contains('@')) &&
                                            (value.contains('.')))) {
                                          return 'กรุณากรอก Email  ตย.you@email.com';
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
                                          prefixIcon: const Icon(Icons.person,
                                              color: Colors.black),
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
                                          errorStyle: TextStyle(
                                              fontFamily: Font_.Fonts_T),
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
                                              color: Colors.black,
                                            ),
                                          ),
                                          labelText: 'USERNAME',
                                          labelStyle: const TextStyle(
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      //keyboardType: TextInputType.none,
                                      obscureText: true,
                                      controller: Form2_text,
                                      onChanged: (value) =>
                                          password_username = value.trim(),
                                      validator: (value) {
                                        if (value == null || value.isEmpty
                                            // || value.length < 13
                                            ) {
                                          //   return 'ใส่ข้อมูลให้ครบถ้วน ';

                                          return 'กรุณากรอก Password!!';
                                        }
                                        // if (int.parse(value.toString()) < 13) {
                                        //   return '< 13';
                                        // }
                                        return null;
                                      },

                                      onFieldSubmitted: (value) {
                                        if (_formKey.currentState!.validate()) {
                                          signInThread();
                                        }
                                      },
                                      // maxLength: 13,
                                      cursorColor: Colors.green,
                                      decoration: InputDecoration(
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
                                          prefixIcon: const Icon(Icons.key,
                                              color: Colors.black),
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
                                          errorStyle: TextStyle(
                                              fontFamily: Font_.Fonts_T),
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
                                              color: Colors.black,
                                            ),
                                          ),
                                          labelText: 'PASSWORD',
                                          labelStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontFamily: Font_.Fonts_T)),
                                      // inputFormatters: <TextInputFormatter>[
                                      //   // for below version 2 use this
                                      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      //   // for version 2 and greater youcan also use this
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        signInThread();
                                      }

                                      // final response = await SendEmail(
                                      //     'dzentric.com@gmail.com',
                                      //     'tys000555@gmail.com',
                                      //     '1234');
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   response == 200
                                      //       ? const SnackBar(
                                      //           content: Text('Message Sent!'),
                                      //           backgroundColor: Colors.green)
                                      //       : const SnackBar(
                                      //           content:
                                      //               Text('Failed to send message!'),
                                      //           backgroundColor: Colors.red),
                                      // );
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.lime[800],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                      ),
                                      child: const Center(
                                        child: Text('เข้าสู่ระบบ',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingUpScreen()),
                                      );
                                    },
                                    child: Container(
                                      child: const Center(
                                        child: Text('ลงทะเบียนผู้ใช้',
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
                                    height: 20,
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
              ))),
        ),
        Expanded(
          child: Container(
            //   constraints: BoxConstraints(
            //   maxWidth: MediaQuery.of(context).size.width / 1.05,
            // ),
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.lightGreen[600],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
            ),

            child: Center(
              child: Text('© 2023  Dzentric Co.,Ltd. All Rights Reserved',
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
      ]),
    ));
  }

  Future<Null> signInThread() async {
    String url =
        '${MyConstant().domain}/GC_user.php?isAdd=true&email=$email_username';

    String password = md5.convert(utf8.encode(password_username!)).toString();
    print('password Md5 $password');

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('$email_username $password')),
    // );
    // Form2_text.clear();
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password.trim() == userModel.passwd!.trim()) {
          String verify = userModel.verify!;
          if (verify == "1") {
            // Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ');
            routeToService(AdminScafScreen(route: 'หน้าหลัก'), userModel);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Email ของคุณ!')),
            // );
          } else {
            routeToService(SingUpScreen2(), userModel);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //       content: Text(
            //           'คุณยังไม่ยืนยันตัวตน กรุณายืนยันตัวตนที่ Email ของคุณ!')),
            // );
          }
        } else {
          Form2_text.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Password ผิดพลาด กรุณาลองใหม่!',
                    style: TextStyle(
                        color: Colors.white, fontFamily: Font_.Fonts_T))),
          );
        }
      }
    } catch (e) {
      Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ ผิดพลาด');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Username ผิดพลาด กรุณาลองใหม่!',
                style:
                    TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      );
    }
  }

  Future<Null> routeToService(
    Widget myWidget,
    UserModel userModel,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ser', userModel.ser.toString());
    preferences.setString('position', userModel.position.toString());
    preferences.setString('fname', userModel.fname.toString());
    preferences.setString('lname', userModel.lname.toString());
    preferences.setString('email', userModel.email.toString());
    preferences.setString('utype', userModel.utype.toString());
    preferences.setString('verify', userModel.verify.toString());
    preferences.setString('permission', userModel.permission.toString());
    preferences.setString('route', 'หน้าหลัก');
    Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ');
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}