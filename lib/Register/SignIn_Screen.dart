// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chaoperty/Constant/Myconstant.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/GetC_color.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetC_Otp.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/Get_Image_pro_model.dart';
import '../Model/Get_Image_pro_set_model.dart';
import '../Model/Get_Image_text_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'SignIn_admin.dart';
import 'SignUp_Screen.dart';
import 'SignUp_Screen2.dart';
import 'package:crypto/crypto.dart' as crypto;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Color BG_cl = Color(0xfff3f3ee);
  Color Fool_cl = Color.fromARGB(255, 141, 185, 90);
  String? Fool_text, logo_url;
//--------------------------------------->
  DateTime datex = DateTime.now();
  final Formbecause_ = TextEditingController();
  List<OtpModel> otpModels = [];
  String? ser_id, tem_id, user_id, Value_randomNumber, text_card = 'ID Card';
  // EmailOTP myauth = EmailOTP();
  //////------------------------------>
  List<ImageTextModel> imgList = [];
  List<Widget> imageSliders = [];
  List<String> textList = [];
  List<ImageProModel> imageProModels = [];
  List<ImageProSetModel> imageProSetModels = [];
  List<RenTalModel> renTalModels = [];
//////------------------------------>
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_otp();
    read_GC_rental();
    read_GC_color().then((value) {
      for (var i = 0; i < imgList.length; i++) {
        Widget imageSlider = Container(
          child: Container(
            margin: EdgeInsets.all(2.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {},
                      child: Image.network(imgList[i].image.toString(),
                          fit: BoxFit.cover, width: 1500.0),
                    ),
                  ],
                )),
          ),
        );
        setState(() {
          imageSliders.add(imageSlider);
        });
      }
    });
  }

  Future<Null> read_GC_rental() async {
    setState(() {
      renTalModels.clear();
    });
    String url = '${MyConstant().domain}/GC_rental_admin.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('read_GC_rental///// $result');
      for (var map in result) {
        RenTalModel renTalModel = RenTalModel.fromJson(map);

        setState(() {
          renTalModels.add(renTalModel);
        });
      }
    } catch (e) {}
  }

////////------------------------------------>
  Future<Null> read_GC_color() async {
    String url = '${MyConstant().domain}/GC_color.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      for (var map in result) {
        Color_Model colorModels = Color_Model.fromJson(map);
        if (colorModels.color_bg != null ||
            colorModels.color_bg.toString() != '') {
          setState(() {
            BG_cl = Color(int.parse(colorModels.color_bg.toString()));
          });
        }

        if (colorModels.color_fool != null ||
            colorModels.color_fool.toString() != '') {
          setState(() {
            Fool_cl = Color(int.parse(colorModels.color_fool.toString()));
          });
        }
        if (colorModels.text != null || colorModels.text.toString() != '') {
          setState(() {
            Fool_text = colorModels.text.toString();
          });
        }
        if (colorModels.img != null || colorModels.img.toString() != '') {
          setState(() {
            logo_url = colorModels.img.toString();
          });
        }

        setState(() {
          if (colorModels.img == null || colorModels.img.toString() == '') {
          } else {
            var foderx = '${MyConstant().domain}/${colorModels.img.toString()}';
            var urlx = colorModels.img;
            Map<String, dynamic> map = Map();
            map['image'] = foderx;
            map['url'] = urlx;

            ImageTextModel imageTextModel = ImageTextModel.fromJson(map);

            imgList.add(imageTextModel);
          }
          if (colorModels.img2 == null || colorModels.img2.toString() == '') {
          } else {
            var foderx =
                '${MyConstant().domain}/${colorModels.img2.toString()}';
            var urlx = colorModels.img2;
            Map<String, dynamic> map = Map();
            map['image'] = foderx;
            map['url'] = urlx;

            ImageTextModel imageTextModel = ImageTextModel.fromJson(map);

            imgList.add(imageTextModel);
          }

          if (colorModels.img3 == null || colorModels.img3.toString() == '') {
          } else {
            var foderx =
                '${MyConstant().domain}/${colorModels.img3.toString()}';
            var urlx = colorModels.img3;
            Map<String, dynamic> map = Map();
            map['image'] = foderx;
            map['url'] = urlx;

            ImageTextModel imageTextModel = ImageTextModel.fromJson(map);

            imgList.add(imageTextModel);
          }
          if (colorModels.img4 == null || colorModels.img4.toString() == '') {
          } else {
            var foderx =
                '${MyConstant().domain}/${colorModels.img4.toString()}';
            var urlx = colorModels.img4;
            Map<String, dynamic> map = Map();
            map['image'] = foderx;
            map['url'] = urlx;

            ImageTextModel imageTextModel = ImageTextModel.fromJson(map);

            imgList.add(imageTextModel);
          }
          if (colorModels.img5 == null || colorModels.img5.toString() == '') {
          } else {
            var foderx =
                '${MyConstant().domain}/${colorModels.img5.toString()}';
            var urlx = colorModels.img5;
            Map<String, dynamic> map = Map();
            map['image'] = foderx;
            map['url'] = urlx;

            ImageTextModel imageTextModel = ImageTextModel.fromJson(map);

            imgList.add(imageTextModel);
          }
        });
      }
    } catch (e) {}
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

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? utype = preferences.getString('utype');
      String? verify = preferences.getString('verify');

      // print('$utype');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: BG_cl,
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
                        color: BG_cl,
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
                                  ? const EdgeInsets.all(15)
                                  : const EdgeInsets.all(8),
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: (Responsive.isDesktop(context))
                                      ? 200
                                      : 100,
                                  maxWidth: (Responsive.isDesktop(context))
                                      ? 600
                                      : 300,
                                  maxHeight: (Responsive.isDesktop(context))
                                      ? 260
                                      : 200,
                                  minHeight: (Responsive.isDesktop(context))
                                      ? 200
                                      : 100,
                                ),
                                child: Center(
                                  child: Image(
                                    image: AssetImage('images/LOGO.png'),
                                    // width: 200,
                                  ),
                                ),
                              ),
                            ),
                            // Padding(
                            //       padding: (Responsive.isDesktop(context))
                            //           ? const EdgeInsets.all(15)
                            //           : const EdgeInsets.all(8),
                            //       child: Container(
                            //         constraints: BoxConstraints(
                            //           minWidth: (Responsive.isDesktop(context))
                            //               ? 200
                            //               : 100,
                            //           maxWidth: (Responsive.isDesktop(context))
                            //               ? 600
                            //               : 300,
                            //           maxHeight: (Responsive.isDesktop(context))
                            //               ? 260
                            //               : 200,
                            //           minHeight: (Responsive.isDesktop(context))
                            //               ? 200
                            //               : 100,
                            //         ),
                            //         child: (imgList.length > 0)
                            //             ? Padding(
                            //                 padding: const EdgeInsets.all(0.0),
                            //                 child: Row(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Expanded(
                            //                       child: Container(
                            //                         padding: EdgeInsets.all(0),
                            //                         child: CarouselSlider(
                            //                           options: CarouselOptions(
                            //                             autoPlay: true,
                            //                             aspectRatio: 2.0,
                            //                             enlargeCenterPage: true,
                            //                           ),
                            //                           items: imageSliders,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               )
                            //             : (logo_url != null ||
                            //                     logo_url.toString() != '' ||
                            //                     logo_url.toString() != 'null')
                            //                 ? Center(
                            //                     child: Image.network(
                            //                       logo_url.toString(),
                            //                     ),
                            //                   )
                            //                 :
                            // Image(
                            //                     image:
                            //                         AssetImage('images/LOGO.png'),
                            //                     // width: 200,
                            //                   ),
                            //       ),
                            //     ),
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
                                            'เข้าสู่ระบบ',
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
                                              prefixIcon: const Icon(
                                                  Icons.person,
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
                                              labelText: 'USERNAME',
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
                                            if (_formKey.currentState!
                                                .validate()) {
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
                                              labelText: 'PASSWORD',
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
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
                                          height:
                                              (Responsive.isDesktop(context))
                                                  ? 60
                                                  : 40,
                                          decoration: BoxDecoration(
                                            color: Fool_cl,
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                          ),
                                          child: Center(
                                            child: Text('เข้าสู่ระบบ',
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
                                        height: (Responsive.isDesktop(context))
                                            ? 20
                                            : 10,
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
                Container(
                  //   constraints: BoxConstraints(
                  //   maxWidth: MediaQuery.of(context).size.width / 1.05,
                  // ),
                  width: MediaQuery.of(context).size.width,
                  height: (Responsive.isDesktop(context)) ? 80 : 50,
                  decoration: BoxDecoration(
                    color: Fool_cl,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                  ),

                  child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              title: const Center(
                                  child: Text(
                                'Admin Only',
                                style: TextStyle(
                                    color: AdminScafScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              )),
                              actions: <Widget>[
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        // keyboardType: TextInputType.number,
                                        controller: Formbecause_,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'ใส่ข้อมูลให้ครบถ้วน ';
                                          }
                                          // if (int.parse(value.toString()) < 13) {
                                          //   return '< 13';
                                          // }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) async {
                                          print('value>>>>$value');
                                          String url =
                                              '${MyConstant().domain}/Gc_user_Admin.php?isAdd=true&puser=$value';

                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            print(result);
                                            if (result.toString() == 'true') {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUnAdmin(),
                                              );
                                              Navigator.pushAndRemoveUntil(
                                                      context,
                                                      route,
                                                      (route) => true)
                                                  .then((value) {
                                                setState(() {
                                                  Formbecause_.clear();
                                                });
                                                Navigator.pop(context, 'OK');
                                              });
                                            } else {
                                              setState(() {
                                                Formbecause_.clear();
                                              });
                                              Navigator.pop(context, 'OK');
                                            }
                                          } catch (e) {}

                                          // if (Formbecause_.text == 'DzenCha0') {
                                          //   print('DzenCha0');
                                          //   MaterialPageRoute route =
                                          //       MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         SignUnAdmin(),
                                          //   );
                                          //   Navigator.pushAndRemoveUntil(
                                          //       context,
                                          //       route,
                                          //       (route) => true).then((value) {
                                          //     setState(() {
                                          //       Formbecause_.clear();
                                          //     });
                                          //     Navigator.pop(context, 'OK');
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     Formbecause_.clear();
                                          //   });
                                          //   Navigator.pop(context, 'OK');
                                          // }
                                        },

                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            filled: true,
                                            // prefixIcon: const Icon(Icons.water,
                                            //     color: Colors.blue),
                                            // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
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
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            labelText: 'Password',
                                            labelStyle: const TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text2_,
                                              // fontWeight:
                                              //     FontWeight.bold,
                                              fontFamily: Font_.Fonts_T,
                                            )),
                                        // inputFormatters: <TextInputFormatter>[
                                        //   // for below version 2 use this
                                        //   FilteringTextInputFormatter.allow(
                                        //       RegExp(r'[0-9]')),
                                        //   // for version 2 and greater youcan also use this
                                        //   FilteringTextInputFormatter.digitsOnly
                                        // ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 150,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButton(
                                              onPressed: () async {
                                                var vel =
                                                    Formbecause_.text.trim();
                                                print('vel>>>>$vel');
                                                String url =
                                                    '${MyConstant().domain}/Gc_user_Admin.php?isAdd=true&puser=$vel';

                                                try {
                                                  var response = await http
                                                      .get(Uri.parse(url));

                                                  var result = json
                                                      .decode(response.body);
                                                  print(result);
                                                  if (result.toString() ==
                                                      'true') {
                                                    MaterialPageRoute route =
                                                        MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUnAdmin(),
                                                    );
                                                    Navigator
                                                            .pushAndRemoveUntil(
                                                                context,
                                                                route,
                                                                (route) => true)
                                                        .then((value) {
                                                      setState(() {
                                                        Formbecause_.clear();
                                                      });
                                                      Navigator.pop(
                                                          context, 'OK');
                                                    });
                                                  } else {
                                                    setState(() {
                                                      Formbecause_.clear();
                                                    });
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  }
                                                } catch (e) {}
                                                // if (Formbecause_.text ==
                                                //     'DzenCha0') {
                                                //   print('DzenCha0');
                                                //   MaterialPageRoute route =
                                                //       MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         SignUnAdmin(),
                                                //   );
                                                //   Navigator.pushAndRemoveUntil(
                                                //           context,
                                                //           route,
                                                //           (route) => true)
                                                //       .then((value) {
                                                //     setState(() {
                                                //       Formbecause_.clear();
                                                //     });
                                                //     Navigator.pop(
                                                //         context, 'OK');
                                                //   });
                                                // } else {
                                                //   setState(() {
                                                //     Formbecause_.clear();
                                                //   });
                                                //   Navigator.pop(context, 'OK');
                                                // }
                                              },
                                              child: const Text(
                                                'Submit',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
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
                          );
                        },
                        child: AutoSizeText(
                            minFontSize:
                                (Responsive.isDesktop(context)) ? 20 : 15,
                            maxFontSize: 40,
                            maxLines: 1,
                            (Fool_text != null ||
                                    Fool_text.toString() != '' ||
                                    Fool_text.toString() != 'null')
                                ? '${Fool_text}'
                                : '© 2023  Dzentric Co.,Ltd. All Rights Reserved',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                                // fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T))),
                  ),
                ),
              ],
            )));

    // Scaffold(
    //     body: Container(
    //   color: const Color(0xfff3f3ee),
    //   height: MediaQuery.of(context).size.height,
    //   child: Column(children: [
    //     Expanded(
    //       flex: 2,
    //       child:
    // Padding(
    //           padding: const EdgeInsets.all(30),
    //           child: Container(
    //             constraints: const BoxConstraints(
    //               minWidth: 200,
    //               maxWidth: 400,
    //             ),
    //             child: const Image(
    //               image: AssetImage('images/LOGO.png'),
    //               // width: 200,
    //             ),
    //           )),
    //     ),
    //     Expanded(
    //       flex: 4,
    //       child: Padding(
    //           padding: const EdgeInsets.all(30),
    //           child: Container(
    //               child: Column(
    //             children: [
    //               Expanded(
    //                 flex: 1,
    //                 child: Container(
    //                   constraints: const BoxConstraints(
    //                     minWidth: 300,
    //                     maxWidth: 320,
    //                   ),
    //                   child: SingleChildScrollView(
    //                     child:
    // Column(
    //                       children: [
    //                         Form(
    //                           key: _formKey,
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               const Padding(
    //                                 padding: EdgeInsets.all(8.0),
    //                                 child: Text('เข้าสู่ระบบ',
    //                                     maxLines: 3,
    //                                     overflow: TextOverflow.ellipsis,
    //                                     softWrap: false,
    //                                     style: TextStyle(
    //                                         fontSize: 30,
    //                                         color: SinginScreen_Color
    //                                             .Colors_Text1_,
    //                                         fontWeight: FontWeight.bold,
    //                                         fontFamily: FontWeight_.Fonts_T)),
    //                               ),
    //                               SizedBox(
    //                                 height: 20,
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: TextFormField(
    //                                   //keyboardType: TextInputType.none,
    //                                   controller: Form1_text,
    //                                   onChanged: (value) =>
    //                                       email_username = value.trim(),
    //                                   validator: (value) {
    //                                     // if (value == null ||
    //                                     //     value.isEmpty ||
    //                                     //     value.length < 13) {
    //                                     //   return 'ใส่ข้อมูลให้ครบถ้วน ';
    //                                     if (!((value!.contains('@')) &&
    //                                         (value.contains('.')))) {
    //                                       return 'กรุณากรอก Email  ตย.you@email.com';
    //                                     }
    //                                     // if (int.parse(value.toString()) < 13) {
    //                                     //   return '< 13';
    //                                     // }
    //                                     return null;
    //                                   },
    //                                   // maxLength: 13,
    //                                   cursorColor: Colors.green,
    //                                   decoration: InputDecoration(
    //                                       fillColor:
    //                                           Colors.white.withOpacity(0.3),
    //                                       filled: true,
    //                                       prefixIcon: const Icon(Icons.person,
    //                                           color: Colors.black),
    //                                       // suffixIcon: Icon(Icons.clear, color: Colors.black),
    //                                       focusedBorder:
    //                                           const OutlineInputBorder(
    //                                         borderRadius: BorderRadius.only(
    //                                           topRight: Radius.circular(15),
    //                                           topLeft: Radius.circular(15),
    //                                           bottomRight: Radius.circular(15),
    //                                           bottomLeft: Radius.circular(15),
    //                                         ),
    //                                         borderSide: BorderSide(
    //                                           width: 1,
    //                                           color: Colors.black,
    //                                         ),
    //                                       ),
    //                                       errorStyle: TextStyle(
    //                                           fontFamily: Font_.Fonts_T),
    //                                       enabledBorder:
    //                                           const OutlineInputBorder(
    //                                         borderRadius: BorderRadius.only(
    //                                           topRight: Radius.circular(15),
    //                                           topLeft: Radius.circular(15),
    //                                           bottomRight: Radius.circular(15),
    //                                           bottomLeft: Radius.circular(15),
    //                                         ),
    //                                         borderSide: BorderSide(
    //                                           width: 1,
    //                                           color: Colors.black,
    //                                         ),
    //                                       ),
    //                                       labelText: 'USERNAME',
    //                                       labelStyle: const TextStyle(
    //                                           color: Colors.black54,
    //                                           fontFamily: Font_.Fonts_T)),
    //                                   // inputFormatters: <TextInputFormatter>[
    //                                   //   // for below version 2 use this
    //                                   //   FilteringTextInputFormatter(RegExp("[a-zA-Z1-9@.]"),
    //                                   //       allow: true),
    //                                   //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    //                                   //   // for version 2 and greater youcan also use this
    //                                   //   // FilteringTextInputFormatter.digitsOnly
    //                                   // ],
    //                                 ),
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: TextFormField(
    //                                   //keyboardType: TextInputType.none,
    //                                   obscureText: true,
    //                                   controller: Form2_text,
    //                                   onChanged: (value) =>
    //                                       password_username = value.trim(),
    //                                   validator: (value) {
    //                                     if (value == null || value.isEmpty
    //                                         // || value.length < 13
    //                                         ) {
    //                                       //   return 'ใส่ข้อมูลให้ครบถ้วน ';

    //                                       return 'กรุณากรอก Password!!';
    //                                     }
    //                                     // if (int.parse(value.toString()) < 13) {
    //                                     //   return '< 13';
    //                                     // }
    //                                     return null;
    //                                   },

    //                                   onFieldSubmitted: (value) {
    //                                     if (_formKey.currentState!.validate()) {
    //                                       signInThread();
    //                                     }
    //                                   },
    //                                   // maxLength: 13,
    //                                   cursorColor: Colors.green,
    //                                   decoration: InputDecoration(
    //                                       fillColor:
    //                                           Colors.white.withOpacity(0.3),
    //                                       filled: true,
    //                                       prefixIcon: const Icon(Icons.key,
    //                                           color: Colors.black),
    //                                       // suffixIcon: Icon(Icons.clear, color: Colors.black),
    //                                       focusedBorder:
    //                                           const OutlineInputBorder(
    //                                         borderRadius: BorderRadius.only(
    //                                           topRight: Radius.circular(15),
    //                                           topLeft: Radius.circular(15),
    //                                           bottomRight: Radius.circular(15),
    //                                           bottomLeft: Radius.circular(15),
    //                                         ),
    //                                         borderSide: BorderSide(
    //                                           width: 1,
    //                                           color: Colors.black,
    //                                         ),
    //                                       ),
    //                                       errorStyle: TextStyle(
    //                                           fontFamily: Font_.Fonts_T),
    //                                       enabledBorder:
    //                                           const OutlineInputBorder(
    //                                         borderRadius: BorderRadius.only(
    //                                           topRight: Radius.circular(15),
    //                                           topLeft: Radius.circular(15),
    //                                           bottomRight: Radius.circular(15),
    //                                           bottomLeft: Radius.circular(15),
    //                                         ),
    //                                         borderSide: BorderSide(
    //                                           width: 1,
    //                                           color: Colors.black,
    //                                         ),
    //                                       ),
    //                                       labelText: 'PASSWORD',
    //                                       labelStyle: const TextStyle(
    //                                           color: Colors.black54,
    //                                           fontFamily: Font_.Fonts_T)),
    //                                   // inputFormatters: <TextInputFormatter>[
    //                                   //   // for below version 2 use this
    //                                   //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    //                                   //   // for version 2 and greater youcan also use this
    //                                   //   FilteringTextInputFormatter.digitsOnly
    //                                   // ],
    //                                 ),
    //                               ),
    //                               SizedBox(
    //                                 height: 30,
    //                               ),
    //                               InkWell(
    //                                 onTap: () async {
    //                                   if (_formKey.currentState!.validate()) {
    //                                     signInThread();
    //                                   }

    //                                   // final response = await SendEmail(
    //                                   //     'dzentric.com@gmail.com',
    //                                   //     'tys000555@gmail.com',
    //                                   //     '1234');
    //                                   // ScaffoldMessenger.of(context).showSnackBar(
    //                                   //   response == 200
    //                                   //       ? const SnackBar(
    //                                   //           content: Text('Message Sent!'),
    //                                   //           backgroundColor: Colors.green)
    //                                   //       : const SnackBar(
    //                                   //           content:
    //                                   //               Text('Failed to send message!'),
    //                                   //           backgroundColor: Colors.red),
    //                                   // );
    //                                 },
    //                                 child: Container(
    //                                   width: 150,
    //                                   height: 60,
    //                                   decoration: BoxDecoration(
    //                                     color: Colors.lime[800],
    //                                     borderRadius: const BorderRadius.only(
    //                                         topLeft: Radius.circular(20),
    //                                         topRight: Radius.circular(20),
    //                                         bottomLeft: Radius.circular(20),
    //                                         bottomRight: Radius.circular(20)),
    //                                   ),
    //                                   child: const Center(
    //                                     child: Text('เข้าสู่ระบบ',
    //                                         maxLines: 3,
    //                                         overflow: TextOverflow.ellipsis,
    //                                         softWrap: false,
    //                                         style: TextStyle(
    //                                             fontSize: 20,
    //                                             color: Colors.white,
    //                                             fontWeight: FontWeight.bold,
    //                                             fontFamily:
    //                                                 FontWeight_.Fonts_T)),
    //                                   ),
    //                                 ),
    //                               ),
    //                               SizedBox(
    //                                 height: 20,
    //                               ),
    //                               InkWell(
    //                                 onTap: () {
    //                                   Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                         builder: (context) =>
    //                                             SingUpScreen()),
    //                                   );
    //                                 },
    //                                 child: Container(
    //                                   child: const Center(
    //                                     child: Text('ลงทะเบียนผู้ใช้',
    //                                         maxLines: 3,
    //                                         overflow: TextOverflow.ellipsis,
    //                                         softWrap: false,
    //                                         style: TextStyle(
    //                                             fontSize: 18,
    //                                             color: Colors.grey,
    //                                             fontFamily: Font_.Fonts_T)),
    //                                   ),
    //                                 ),
    //                               ),
    //                               SizedBox(
    //                                 height: 20,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           )
    // )),
    //     ),
    //     Expanded(
    //       child:
    // Container(
    //         //   constraints: BoxConstraints(
    //         //   maxWidth: MediaQuery.of(context).size.width / 1.05,
    //         // ),
    //         width: MediaQuery.of(context).size.width,
    //         height: 150,
    //         decoration: BoxDecoration(
    //           color: Colors.lightGreen[600],
    //           borderRadius: const BorderRadius.only(
    //               topLeft: Radius.circular(0),
    //               topRight: Radius.circular(0),
    //               bottomLeft: Radius.circular(0),
    //               bottomRight: Radius.circular(0)),
    //         ),

    //         child: Center(
    //           child: Text('© 2023  Dzentric Co.,Ltd. All Rights Reserved',
    //               maxLines: 3,
    //               overflow: TextOverflow.ellipsis,
    //               softWrap: false,
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.bold,
    //                   fontFamily: FontWeight_.Fonts_T)),
    //         ),
    //       ),
    //     ),
    //   ]),
    // )
    // );
  }

  Future<Null> signInThread() async {
    Random random = Random();
    int c = random.nextInt(9000) + 1000;
    setState(() {
      Value_randomNumber = c.toString();
    });

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
        var onoff = int.parse(userModel.onoff!);
        var ser = userModel.ser;

        if ((email_username.toString() == 'T_T@gmail.com' ||
                email_username.toString() == 'style@gmail.com' ||
                email_username.toString() == 'teeraponkaewkanta@Gmail.com' ||
                email_username.toString() == 'Sunitipanon2000@gmail.com' ||
                email_username.toString() == 'nararat19gmail.com' ||
                email_username.toString() == 'nararattananuwat@gmail.com') &&
            userModel.type.toString() == '@min') {
          // print('T_T@gmail.com ${renTalModels.length}');
          _showMyDialog_admin(userModel.ser, userModel.rser);
        } else {
          if (onoff == 0) {
            if (password.trim() == userModel.passwd!.trim()) {
              String verify = userModel.verify!;
              if (verify == "1") {
                // Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ');
                routeToService(AdminScafScreen(route: 'หน้าหลัก'), userModel);
                var on = '1';
                var randomNumber = Value_randomNumber;
                String url =
                    '${MyConstant().domain}/U_user_onoff.php?isAdd=true&ser=$ser&on=$on&randomNumber=$randomNumber';

                try {
                  var response = await http.get(Uri.parse(url));

                  var result = json.decode(response.body);
                  print(result);
                  if (result.toString() == 'true') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('ยินดีต้อนรับ')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('ยินดีต้อนรับ (ผิดพลาด)')),
                    );
                  }
                } catch (e) {}
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
          } else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: const Center(
                    child: Text(
                  'รหัสผู้ใช้งานนี้กำลังใช้งานอยู่ โปรดลองใหม่อีกครั้ง',
                  style: TextStyle(
                      color: AdminScafScreen_Color.Colors_Text1_,
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
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
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
                                      changLoginOut();
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text(
                                      'ออกระบบจากเครื่องอื่นๆ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
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
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text(
                                      'ยืนยัน',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
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
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //       content: Text('รหัสผู้ใช้งานนี้กำลังใช้งานอยู่ โปรดลองใหม่อีกครั้ง',
            //           style: TextStyle(
            //               color: Colors.white, fontFamily: Font_.Fonts_T))),
            // );
          }
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

  Future<Null> signInThread_Admin() async {
    Random random = Random();
    int c = random.nextInt(9000) + 1000;
    setState(() {
      Value_randomNumber = c.toString();
    });

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
        var onoff = int.parse(userModel.onoff!);
        var ser = userModel.ser;
        if (onoff == 0) {
          if (password.trim() == userModel.passwd!.trim()) {
            String verify = userModel.verify!;
            if (verify == "1") {
              // Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ');
              routeToService(AdminScafScreen(route: 'หน้าหลัก'), userModel);
              var on = '1';
              var randomNumber = Value_randomNumber;
              String url =
                  '${MyConstant().domain}/U_user_onoff.php?isAdd=true&ser=$ser&on=$on&randomNumber=$randomNumber';

              try {
                var response = await http.get(Uri.parse(url));

                var result = json.decode(response.body);
                print(result);
                if (result.toString() == 'true') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('ยินดีต้อนรับ')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('ยินดีต้อนรับ (ผิดพลาด)')),
                  );
                }
              } catch (e) {}
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
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: const Center(
                  child: Text(
                'รหัสผู้ใช้งานนี้กำลังใช้งานอยู่ โปรดลองใหม่อีกครั้ง',
                style: TextStyle(
                    color: AdminScafScreen_Color.Colors_Text1_,
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
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
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
                                    changLoginOut();
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text(
                                    'ออกระบบจากเครื่องอื่นๆ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
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
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text(
                                    'ยืนยัน',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
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

  Future<void> _showMyDialog_admin(U_ser, U_rser) async {
    String new_pn = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: AppbackgroundColor.Sub_Abg_Colors,
          titlePadding: const EdgeInsets.all(4.0),
          contentPadding: const EdgeInsets.all(10.0),
          actionsPadding: const EdgeInsets.all(6.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, 'OK');
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 22,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'Hi..@min',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: Font_.Fonts_T),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '(${email_username.toString()})',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: Font_.Fonts_T),
                ),
              ),
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
            ],
          ),
          content: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 0)),
              builder: (context, snapshot) {
                return SizedBox(
                  // width: 200,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ตอนนี้อยู๋ตลาด : ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                renTalModels
                                        .where((model) =>
                                            model.ser.toString() == '${U_rser}')
                                        .map((renTalModels) =>
                                            renTalModels.rtname)
                                        .isEmpty
                                    ? '??'
                                    : renTalModels
                                        .firstWhere((model) =>
                                            model.ser.toString() == '${U_rser}')
                                        .pn
                                        .toString(),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                // '${userModels[index].rser}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ],
                        ),
                        (new_pn == '')
                            ? SizedBox(
                                height: 10,
                              )
                            : Center(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Icon(
                                      Icons.swap_vert_sharp,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'เปลี่ยนตลาด : ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Text(
                              '${new_pn}',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange[900],
                                  // fontWeight: FontWeight.w600,
                                  fontFamily: Font_.Fonts_T),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  child: PopupMenuButton<int>(
                                    color: Colors.green[50],
                                    tooltip: '',
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.orange[900],
                                      size: 20,
                                    ),
                                    itemBuilder: (context) {
                                      return [
                                        for (int index = 0;
                                            index < renTalModels.length;
                                            index++)
                                          PopupMenuItem<int>(
                                              value: int.parse(
                                                  '${renTalModels[index].ser}'),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    // color: Colors.green[100]!
                                                    //     .withOpacity(0.5),
                                                    border: const Border(
                                                      bottom: BorderSide(
                                                        color: Colors.black12,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  width: 220,
                                                  child: Text(
                                                      "${index + 1}. ${renTalModels[index].pn}",
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              AdminScafScreen_Color
                                                                  .Colors_Text1_,
                                                          fontFamily:
                                                              Font_.Fonts_T)))),
                                      ];
                                    },
                                    onOpened: () {},
                                    onCanceled: () {},
                                    onSelected: (value) async {
                                      ///UP_emailAdminSer
                                      print(value);
                                      try {
                                        final url =
                                            '${MyConstant().domain}/UP_emailAdminSer.php';

                                        final response = await http
                                            .post(Uri.parse(url), body: {
                                          'isAdd': 'true',
                                          'seruser': '${U_ser}',
                                          'serrenTal': '$value',
                                        });
                                        setState(() {
                                          new_pn = renTalModels
                                              .firstWhere((model) =>
                                                  model.ser.toString() ==
                                                  '${value}')
                                              .pn
                                              .toString();
                                        });
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'เปลี่ยนตลาด ผิดพลาด กรุณาลองใหม่!',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          Font_.Fonts_T))),
                                        );
                                      }
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Fool_cl,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                    signInThread_Admin();
                                  },
                                  child: const Text(
                                    'เข้าสู่ระบบ',
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<Null> changLoginOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = email_username;

    String url =
        '${MyConstant().domain}/changLoginOutAll.php?isAdd=true&ren=$ren&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('changLoginOut>>>>${result.toString()}');
      if (result.toString() == 'true') {
        signInThread();
        // deall_Trans_select();
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // var ser = preferences.getString('ser');
        // var on = '0';
        // String url =
        //     '${MyConstant().domain}/U_user_onoff.php?isAdd=true&ser=$ser&on=$on';

        // try {
        //   var response = await http.get(Uri.parse(url));

        //   var result = json.decode(response.body);
        //   print(result);
        //   if (result.toString() == 'true') {
        //     SharedPreferences preferences =
        //         await SharedPreferences.getInstance();
        //     preferences.clear();
        //     routToService(SignInScreen());
        //   } else {
        //     // ScaffoldMessenger.of(context).showSnackBar(
        //     //   SnackBar(content: Text('(ผิดพลาด)')),
        //     // );
        //   }
        // } catch (e) {}
      }
    } catch (e) {}
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
    preferences.setString('rser', userModel.rser.toString());
    preferences.setString('Muser', userModel.user.toString());
    preferences.setString('lavel', userModel.user_id.toString());
    preferences.setString('route', 'หน้าหลัก');
    preferences.setString('pakanPay', 0.toString());
    preferences.setString('login', Value_randomNumber.toString());
    Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ');
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
