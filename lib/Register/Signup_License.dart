// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable, prefer_void_to_null
import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/Constant/Myconstant.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../AdminScaffold/AdminScaffold.dart';
import '../CRC_16_Prompay/generate_qrcode.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GC_package_model.dart';
import '../Model/GC_package_user_model.dart';
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

class SignUPLicense extends StatefulWidget {
  const SignUPLicense({
    super.key,
  });

  @override
  State<SignUPLicense> createState() => _SignUPLicenseState();
}

class _SignUPLicenseState extends State<SignUPLicense> {
  GlobalKey qrImageKey = GlobalKey();
  DateTime datex = DateTime.now();
  final Formbecause_ = TextEditingController();
  List<OtpModel> otpModels = [];
  List<RenTalModel> renTalModels = [];
  List<PackageModel> packageModels = [];
  List<PackageUserModel> packageUserModels = [];
  String? packSelext, payment;
  List<LicensekeyModel> licensekeyModels = [];
  String? ser_id, tem_id, user_id;
  String? pac_pk,
      pac_qty,
      pac_user,
      pac_rpri,
      pac_ser,
      day_date = 'Y',
      bill_email;
  int? pkqty, pkuser, packint, screen_pay = 0, num_date;
  String? addpac_pk,
      addpac_qty,
      addpac_user,
      addpac_rpri,
      addpac_ser,
      base64_Slip,
      extension_;
  String? rtname,
      type,
      typex,
      renname,
      pkname,
      ser_Zonex,
      img_,
      img_logo,
      foder,
      pkldate,
      data_update;
  @override
  void initState() {
    super.initState();

    read_GC_rental();

    // checkPreferance();
    read_GC_otp();
  }

  Future<Null> read_GC_package() async {
    if (packageModels.isNotEmpty) {
      setState(() {
        packageModels.clear();
      });
    }

    String url = '${MyConstant().domain}/GC_package.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          PackageModel packageModel = PackageModel.fromJson(map);
          var qqty = int.parse(packageModel.qty!);
          var qq = packageModel.payment;
          setState(() {
            if (qq != '') {
              payment = qq;
            }
            if (int.parse(pac_qty!) < qqty) {
              packageModels.add(packageModel);
            }
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var utype = preferences.getString('utype');
    var seruser = preferences.getString('ser');
    // var utype = 'S';
    // var seruser = '50';
    String url =
        '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
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
          var foderx = renTalModel.dbn;
          var img = renTalModel.img;
          var imglogo = renTalModel.imglogo;
          var pksdatex = renTalModel.pksdate;
          var pkldatex = renTalModel.pkldate;
          var bi_email = renTalModel.bill_email;
          setState(() {
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            pkqty = pkqtyx;
            pkuser = pkuserx;
            pkname = pkx;
            img_ = img;
            img_logo = imglogo;
            img_logo = imglogo;
            Form2_text.text = bi_email!;
            bill_email = bi_email;

            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('pkname>> $pkname');
    setState(() {
      read_GC_package_user().then((value) => read_GC_package());
    });
  }

  Future<Null> read_GC_package_user() async {
    if (packageUserModels.isNotEmpty) {
      setState(() {
        packageUserModels.clear();
      });
    }

    String url =
        '${MyConstant().domain}/GC_package_user.php?isAdd=true&pkname=$pkname';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('read_GC_rental///// $result');
      for (var map in result) {
        PackageUserModel packageUserModel = PackageUserModel.fromJson(map);
        var pk = packageUserModel.pk;
        var qty = packageUserModel.qty;
        var user = packageUserModel.user;
        var rpri = packageUserModel.rpri;
        var ser = packageUserModel.ser;

        setState(() {
          pac_pk = pk;
          pac_qty = qty;
          pac_user = user;
          pac_rpri = rpri;
          pac_ser = ser;

          packageUserModels.add(packageUserModel);
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
  final Form_time = TextEditingController();

  String? email_username, password_username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0xfff3f3ee),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: (Responsive.isDesktop(context))
                                        ? const EdgeInsets.all(30)
                                        : const EdgeInsets.all(8),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxHeight: 200,
                                        minWidth:
                                            (Responsive.isDesktop(context))
                                                ? 200
                                                : 100,
                                        maxWidth:
                                            (Responsive.isDesktop(context))
                                                ? 400
                                                : 200,
                                      ),
                                      child: const Image(
                                        image: AssetImage('images/LOGO.png'),
                                        // width: 200,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                        minFontSize: 18,
                                        maxFontSize: 20,
                                        maxLines: 1,
                                        'Register License Key',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                            // fontSize: 20,
                                            color: SinginScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T)),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.arrow_back_ios,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Back',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: Font_.Fonts_T,
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
                            Container(
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: Responsive.isDesktop(context)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1)
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: Responsive
                                                              .isDesktop(
                                                                  context)
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.22,
                                                      child: InkWell(
                                                        onTap: () async {},
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.orange
                                                                .shade100,
                                                            borderRadius: const BorderRadius
                                                                .only(
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
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  'Package $pac_pk',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  '$pac_qty',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  'ล็อก/แผง',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '$pac_user สิทธิผู้ใช้งาน',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${NumberFormat("#,##0.00", "en_US").format(double.parse(pac_rpri!))} บาท/เดือน',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height: Responsive
                                                            .isDesktop(context)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.12
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  'Package ของคุณ : ',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            ),
                                                            Expanded(
                                                              flex: 4,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  'Package $pac_pk',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  'จำนวนล็อก/แผง : ',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            ),
                                                            Expanded(
                                                              flex: 4,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  '$pac_qty ล็อก/แผง',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  'จำนวนสิทธิผู้ใช้งาน : ',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            ),
                                                            Expanded(
                                                              flex: 4,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  '$pac_user สิทธิ',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  'Package ราคา : ',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            ),
                                                            Expanded(
                                                              flex: 4,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  '${NumberFormat("#,##0.00", "en_US").format(double.parse(pac_rpri!))} บาท/เดือน',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: AutoSizeText(
                                                                  minFontSize: 9,
                                                                  maxFontSize: 18,
                                                                  maxLines: 1,
                                                                  '',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  softWrap: false,
                                                                  style: TextStyle(
                                                                      // fontSize: 20,
                                                                      color: SinginScreen_Color.Colors_Text1_,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),
                                                            ),
                                                            Expanded(
                                                              flex: 4,
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    screen_pay =
                                                                        1;
                                                                    Form1_text
                                                                            .text =
                                                                        '1';
                                                                    num_date =
                                                                        1;

                                                                    packSelext =
                                                                        null;
                                                                    packint = 0;
                                                                    addpac_pk =
                                                                        pac_pk;
                                                                    addpac_qty =
                                                                        pac_qty;
                                                                    addpac_user =
                                                                        pac_user;
                                                                    addpac_rpri =
                                                                        pac_rpri;
                                                                    addpac_ser =
                                                                        pac_ser;
                                                                    base64_Slip =
                                                                        null;
                                                                    Form_time
                                                                        .clear();
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .green
                                                                        .shade900,
                                                                    borderRadius: const BorderRadius
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
                                                                            Radius.circular(10)),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Center(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(
                                                                          'ต่อ License Key',
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: AutoSizeText(
                                                        minFontSize: 9,
                                                        maxFontSize: 18,
                                                        maxLines: 1,
                                                        'ซื้อ Package ใหม่',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            // fontSize: 20,
                                                            color: SinginScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T)),
                                                  ),
                                                ],
                                              ),
                                              ScrollConfiguration(
                                                behavior:
                                                    ScrollConfiguration.of(
                                                            context)
                                                        .copyWith(dragDevices: {
                                                  PointerDeviceKind.touch,
                                                  PointerDeviceKind.mouse,
                                                }),
                                                child: SingleChildScrollView(
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: Responsive
                                                            .isDesktop(context)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.12
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                    child: GridView.count(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      crossAxisCount: 1,
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                packageModels
                                                                    .length;
                                                            i++)
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                width: Responsive
                                                                        .isDesktop(
                                                                            context)
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.1
                                                                    : MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.22,
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      if (packSelext ==
                                                                          packageModels[i]
                                                                              .ser) {
                                                                        packSelext =
                                                                            null;
                                                                        packint =
                                                                            0;
                                                                        screen_pay =
                                                                            0;
                                                                      } else {
                                                                        packint =
                                                                            i;
                                                                        packSelext =
                                                                            packageModels[i].ser;
                                                                        screen_pay =
                                                                            2;
                                                                        Form1_text.text =
                                                                            '1';
                                                                        num_date =
                                                                            1;

                                                                        addpac_pk =
                                                                            packageModels[i].pk;
                                                                        addpac_qty =
                                                                            packageModels[i].qty;
                                                                        addpac_user =
                                                                            packageModels[i].user;
                                                                        addpac_rpri =
                                                                            packageModels[i].rpri;
                                                                        addpac_ser =
                                                                            packageModels[i].ser;
                                                                        base64_Slip =
                                                                            null;
                                                                        Form_time
                                                                            .clear();
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: packSelext ==
                                                                              packageModels[i]
                                                                                  .ser
                                                                          ? Colors
                                                                              .purple
                                                                          : Colors
                                                                              .white38,
                                                                      borderRadius: const BorderRadius
                                                                          .only(
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight: Radius.circular(
                                                                              10),
                                                                          bottomLeft: Radius.circular(
                                                                              10),
                                                                          bottomRight:
                                                                              Radius.circular(10)),
                                                                      border: (packSelext ==
                                                                              packageModels[i]
                                                                                  .ser)
                                                                          ? Border.all(
                                                                              color: Colors
                                                                                  .white,
                                                                              width:
                                                                                  1)
                                                                          : Border.all(
                                                                              color: Colors.black,
                                                                              width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            'Package ${packageModels[i].pk}',
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(
                                                                              color: (packSelext == packageModels[i].ser) ? Colors.white : Colors.green,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            '${packageModels[i].qty}',
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(
                                                                              color: (packSelext == packageModels[i].ser) ? Colors.white : Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            'ล็อก/แผง',
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(
                                                                              color: (packSelext == packageModels[i].ser) ? Colors.white : Colors.black,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '${packageModels[i].user} สิทธิผู้ใช้งาน',
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(
                                                                              color: (packSelext == packageModels[i].ser) ? Colors.white : Colors.black,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '${NumberFormat("#,##0.00", "en_US").format(double.parse(packageModels[i].rpri!))} บาท/เดือน',
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(
                                                                              color: (packSelext == packageModels[i].ser) ? Colors.white : Colors.black,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: screen_pay == 0
                                            ? screen00()
                                            : screen_pay == 1
                                                ? screen01()
                                                : screen02(),
                                      )
                                    ],
                                  )
                                ],
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

  Column screen02() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: AutoSizeText(
                  minFontSize: 18,
                  maxFontSize: 25,
                  maxLines: 1,
                  'ซื้อ Package And License Key',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      // fontSize: 20,
                      color: SinginScreen_Color.Colors_Text1_,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T)),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'Package : ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'Package $addpac_pk',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'จำนวนล็อก/แผง : ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          '$addpac_qty ล็อก/แผง',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'จำนวนสิทธิผู้ใช้งาน : ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          '$addpac_user สิทธิ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'Package ราคา : ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          '${NumberFormat("#,##0.00", "en_US").format(double.parse(addpac_rpri!))} บาท/เดือน',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    )
                  ],
                ),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Card(
                          color: const Color(0xfff3f3ee),
                          child: TextFormField(
                            textAlign: TextAlign.end,
                            controller: Form1_text,
                            keyboardType: TextInputType.number,
                            onChanged: (value) async {
                              setState(() {
                                num_date = int.parse(value);
                                base64_Slip = null;
                                Form_time.clear();
                              });
                            },
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                    horizontal: 25),
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
                                labelText: 'จำนวน',
                                labelStyle: const TextStyle(
                                  color: ManageScreen_Color.Colors_Text2_,
                                  // fontWeight:
                                  //     FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
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
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  day_date = 'M';
                                  base64_Slip = null;
                                  Form_time.clear();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: day_date == 'M'
                                      ? Colors.green.shade900
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'รายเดือน',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: day_date == 'M'
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  day_date = 'Y';
                                  base64_Slip = null;
                                  Form_time.clear();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: day_date == 'Y'
                                      ? Colors.green.shade900
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'รายปี',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: day_date == 'Y'
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ],
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
            )),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: InkWell(
                  // onTap: () async {},
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 20,
                                    maxFontSize: 30,
                                    maxLines: 1,
                                    'รายละเอียด Package ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'Package : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'Package $addpac_pk',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'จำนวนล็อก/แผง : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    '$addpac_qty ล็อก/แผง',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'จำนวนสิทธิผู้ใช้งาน : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    '$addpac_user สิทธิ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'ราคา : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    '${NumberFormat("#,##0.00", "en_US").format(double.parse(addpac_rpri!))} บาท/เดือน',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'จำนวน : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    '${Form1_text.text} ${day_date == 'M' ? 'เดือน' : 'ปี'}',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'รวมยอดชำระ : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 30,
                                    maxFontSize: 50,
                                    maxLines: 1,
                                    day_date == 'M'
                                        ? '${NumberFormat("#,##0.00", "en_US").format(double.parse(addpac_rpri!) * int.parse(Form1_text.text))} บาท'
                                        : '${NumberFormat("#,##0.00", "en_US").format((double.parse(addpac_rpri!) * int.parse(Form1_text.text)) * 12)} บาท',
                                    //  '${Form1_text.text} ${day_date == 'M' ? 'เดือน' : 'ปี'}',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: Colors.orange.shade900,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 50,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ' เวลา/หลักฐาน :',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                              ),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            // padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              textAlign: TextAlign.end,
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: Form_time,
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              // maxLength: 13,
                                              cursorColor: Colors.green,
                                              decoration: InputDecoration(
                                                  fillColor: Colors.white
                                                      .withOpacity(0.3),
                                                  filled: true,
                                                  // prefixIcon:
                                                  //     const Icon(Icons.person, color: Colors.black),
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
                                                  hintText: '00:00',
                                                  // helperText: '00:00:00',
                                                  // labelText: '00:00:00',
                                                  labelStyle: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T)),

                                              inputFormatters: [
                                                MaskedInputFormatter('##:##'),
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              // inputFormatters: <TextInputFormatter>[
                                              //   // for below version 2 use this
                                              //   FilteringTextInputFormatter.allow(
                                              //       RegExp(r'[0-9 .]')),
                                              //   // for version 2 and greater youcan also use this
                                              //   // FilteringTextInputFormatter.digitsOnly
                                              // ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          // flex: 2,
                                          child: InkWell(
                                            onTap: () {
                                              (base64_Slip == null)
                                                  ? uploadFile_Slip()
                                                  : showDialog<void>(
                                                      context: context,
                                                      // barrierDismissible:
                                                      //     false, // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0))),
                                                          title: const Center(
                                                              child: Text(
                                                            'มีไฟล์ slip อยู่แล้ว',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          )),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: ListBody(
                                                              children: const <Widget>[
                                                                Center(
                                                                  child: Text(
                                                                    'มีไฟล์ slip อยู่แล้ว หากต้องการอัพโหลดกรุณาลบไฟล์ที่มีอยู่แล้วก่อน',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  // width: 150,
                                                                  // height: 400,
                                                                  child: Image
                                                                      .memory(
                                                                    base64Decode(
                                                                        base64_Slip
                                                                            .toString()),
                                                                    height: 400,
                                                                    // fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Container(
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              Colors.red[600],
                                                                          borderRadius: const BorderRadius
                                                                              .only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          'ลบไฟล์',
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text3_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ))),
                                                                    onTap:
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        base64_Slip =
                                                                            null;
                                                                        Form_time
                                                                            .clear();
                                                                      });
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Container(
                                                                        width: 100,
                                                                        decoration: const BoxDecoration(
                                                                          color:
                                                                              Colors.black,
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          'ปิด',
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text3_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ))),
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
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
                                              child: Text(
                                                base64_Slip == null
                                                    ? 'เพิ่มไฟล์'
                                                    : 'ดูไฟล์',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
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
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.03,
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(
                                    //     width: 1,
                                    //   ),
                                    //   color: Colors.white,
                                    //   borderRadius: const BorderRadius.only(
                                    //       topLeft: Radius.circular(15),
                                    //       topRight: Radius.circular(15),
                                    //       bottomLeft: Radius.circular(15),
                                    //       bottomRight: Radius.circular(15)),
                                    // ),
                                    child: TextFormField(
                                      controller: Form2_text,
                                      textAlign: TextAlign.end,
                                      onChanged: (value) async {
                                        setState(() {
                                          bill_email = value;
                                        });
                                      },
                                      cursorColor: Colors.green,
                                      decoration: InputDecoration(
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
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
                                          labelText: 'Gmail',
                                          labelStyle: const TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight:
                                            //     FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          )),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Center(
                    child: RepaintBoundary(
                      key: qrImageKey,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                width: 220,
                                decoration: BoxDecoration(
                                  color: Colors.green[300],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Chaoperty',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 220,
                              child: Image.asset(
                                "images/thai_qr_payment.png",
                                height: 60,
                                width: 220,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              child: Center(
                                child: SfBarcodeGenerator(
                                  value: generateQRCode(
                                    promptPayID: "$payment",
                                    amount: day_date == 'M'
                                        ? (double.parse(addpac_rpri!) *
                                            int.parse(Form1_text.text))
                                        : ((double.parse(addpac_rpri!) *
                                                int.parse(Form1_text.text)) *
                                            12),
                                  ),
                                  symbology: QRCode(),
                                  showValue: false,
                                ),
                                //     PrettyQr(
                                //   // typeNumber: 3,
                                //   image:
                                //       AssetImage(
                                //     "images/Icon-chao.png",
                                //   ),
                                //   size:
                                //       200,
                                //   data:
                                //       generateQRCode(promptPayID: "$selectedValue", amount: totalQr_),
                                //   errorCorrectLevel:
                                //       QrErrorCorrectLevel.M,
                                //   roundEdges:
                                //       true,
                                // ),
                              ),
                            ),
                            Text(
                              'พร้อมเพย์ : $payment',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              day_date == 'M'
                                  ? 'จำนวนเงิน ${NumberFormat("#,##0.00", "en_US").format(double.parse(addpac_rpri!) * int.parse(Form1_text.text))} บาท'
                                  : 'จำนวนเงิน ${NumberFormat("#,##0.00", "en_US").format((double.parse(addpac_rpri!) * int.parse(Form1_text.text)) * 12)} บาท',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '( ทำรายการ : ${DateFormat('dd-MM-yyyy').format(datex)} ${DateFormat('HH:mm:ss').format(datex)} )',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        var ser = preferences.getString('renTalSer');
                        if (base64_Slip != null && Form2_text.text != null) {
                          if (day_date != null && num_date != 0) {
                            String vv = getRandomString(16);
                            String dateTimeNow = DateTime.now().toString();
                            String date = DateFormat('ddMMyyyy')
                                .format(DateTime.parse('${dateTimeNow}'))
                                .toString();
                            final dateTimeNow2 = DateTime.now()
                                .toUtc()
                                .add(const Duration(hours: 7));
                            final formatter2 = DateFormat('HHmmss');
                            final formattedTime2 =
                                formatter2.format(dateTimeNow2);
                            String Time_ = formattedTime2.toString();
                            var fileName_Slip_ =
                                'slip_${renname}_${date}_$Time_.$extension_';
                            var nd = num_date;
                            var dd = day_date;
                            var ld = DateFormat('dd-MM-yyyy').format(datex);

                            var sta = 'N';
                            var ema = Form2_text.text;
                            var pack = addpac_ser;
                            var pri = day_date == 'M'
                                ? (double.parse(addpac_rpri!) *
                                        int.parse(Form1_text.text))
                                    .toString()
                                : ((double.parse(addpac_rpri!) *
                                            int.parse(Form1_text.text)) *
                                        12)
                                    .toString();
                            print(
                                'serren=$ser&lisen=$vv&num_date=$nd&day_date=$dd&ldate=$ld');
                            String url =
                                '${MyConstant().domain}/In_Package_put.php?isAdd=true&serren=$ser&lisen=$vv&num_date=$nd&day_date=$dd&ldate=$ld&sta=$sta&ema=$ema&pack=$pack&Slip=$fileName_Slip_&pri=$pri';

                            try {
                              var response = await http.get(Uri.parse(url));

                              var result = json.decode(response.body);
                              print(result);
                              if (result.toString() == 'true') {}
                            } catch (e) {}
                            final response = await SendEmail(
                                '$renname', Form2_text.text, vv); //ส่งเมล์
                            print(response);
                            OKuploadFile_Slip(fileName_Slip_);
                            sess();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('อายุการใช้งานไม่ถูกต้อง!')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'กรุณาแนบหลักฐานการโอน และที่อยู่ Gmail')),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.shade900,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'ยืนยันชำระ',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Column screen01() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: AutoSizeText(
                  minFontSize: 18,
                  maxFontSize: 25,
                  maxLines: 1,
                  'ต่อ License Key',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      // fontSize: 20,
                      color: SinginScreen_Color.Colors_Text1_,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T)),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'Package : ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'Package $addpac_pk',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'จำนวนล็อก/แผง : ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          '$addpac_qty ล็อก/แผง',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'จำนวนสิทธิผู้ใช้งาน : ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          '$addpac_user สิทธิ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          'Package ราคา : ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    ),
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                          minFontSize: 9,
                          maxFontSize: 18,
                          maxLines: 1,
                          '${NumberFormat("#,##0.00", "en_US").format(double.parse(addpac_rpri!))} บาท/เดือน',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              // fontSize: 20,
                              color: SinginScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                    )
                  ],
                ),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Card(
                          color: const Color(0xfff3f3ee),
                          child: TextFormField(
                            textAlign: TextAlign.end,
                            controller: Form1_text,
                            keyboardType: TextInputType.number,
                            onChanged: (value) async {
                              setState(() {
                                base64_Slip = null;
                                Form_time.clear();
                                num_date = int.parse(value);
                              });
                            },
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                    horizontal: 25),
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
                                labelText: 'จำนวน',
                                labelStyle: const TextStyle(
                                  color: ManageScreen_Color.Colors_Text2_,
                                  // fontWeight:
                                  //     FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
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
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  day_date = 'M';
                                  base64_Slip = null;
                                  Form_time.clear();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: day_date == 'M'
                                      ? Colors.green.shade900
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'รายเดือน',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: day_date == 'M'
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  day_date = 'Y';
                                  base64_Slip = null;
                                  Form_time.clear();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: day_date == 'Y'
                                      ? Colors.green.shade900
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'รายปี',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: day_date == 'Y'
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ],
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
            )),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: InkWell(
                  // onTap: () async {},
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 20,
                                    maxFontSize: 30,
                                    maxLines: 1,
                                    'รายละเอียด Package ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'Package : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'Package $addpac_pk',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'จำนวนล็อก/แผง : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    '$addpac_qty ล็อก/แผง',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'จำนวนสิทธิผู้ใช้งาน : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    '$addpac_user สิทธิ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'ราคา : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    '${NumberFormat("#,##0.00", "en_US").format(double.parse(addpac_rpri!))} บาท/เดือน',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'จำนวน : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    '${Form1_text.text} ${day_date == 'M' ? 'เดือน' : 'ปี'}',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    minFontSize: 9,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    'รวมยอดชำระ : ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: SinginScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                    minFontSize: 30,
                                    maxFontSize: 50,
                                    maxLines: 1,
                                    day_date == 'M'
                                        ? '${NumberFormat("#,##0.00", "en_US").format(double.parse(addpac_rpri!) * int.parse(Form1_text.text))} บาท'
                                        : '${NumberFormat("#,##0.00", "en_US").format((double.parse(addpac_rpri!) * int.parse(Form1_text.text)) * 12)} บาท',
                                    //  '${Form1_text.text} ${day_date == 'M' ? 'เดือน' : 'ปี'}',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: Colors.orange.shade900,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 50,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ' เวลา/หลักฐาน :',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                              ),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            // padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              textAlign: TextAlign.end,
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: Form_time,
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              // maxLength: 13,
                                              cursorColor: Colors.green,
                                              decoration: InputDecoration(
                                                  fillColor: Colors.white
                                                      .withOpacity(0.3),
                                                  filled: true,
                                                  // prefixIcon:
                                                  //     const Icon(Icons.person, color: Colors.black),
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
                                                  hintText: '00:00',
                                                  // helperText: '00:00:00',
                                                  // labelText: '00:00:00',
                                                  labelStyle: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T)),

                                              inputFormatters: [
                                                MaskedInputFormatter('##:##'),
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              // inputFormatters: <TextInputFormatter>[
                                              //   // for below version 2 use this
                                              //   FilteringTextInputFormatter.allow(
                                              //       RegExp(r'[0-9 .]')),
                                              //   // for version 2 and greater youcan also use this
                                              //   // FilteringTextInputFormatter.digitsOnly
                                              // ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          // flex: 2,
                                          child: InkWell(
                                            onTap: () {
                                              (base64_Slip == null)
                                                  ? uploadFile_Slip()
                                                  : showDialog<void>(
                                                      context: context,
                                                      // barrierDismissible:
                                                      //     false, // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0))),
                                                          title: const Center(
                                                              child: Text(
                                                            'มีไฟล์ slip อยู่แล้ว',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          )),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: ListBody(
                                                              children: const <Widget>[
                                                                Center(
                                                                  child: Text(
                                                                    'มีไฟล์ slip อยู่แล้ว หากต้องการอัพโหลดกรุณาลบไฟล์ที่มีอยู่แล้วก่อน',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  // width: 150,
                                                                  // height: 400,
                                                                  child: Image
                                                                      .memory(
                                                                    base64Decode(
                                                                        base64_Slip
                                                                            .toString()),
                                                                    height: 400,
                                                                    // fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Container(
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              Colors.red[600],
                                                                          borderRadius: const BorderRadius
                                                                              .only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          'ลบไฟล์',
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text3_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ))),
                                                                    onTap:
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        base64_Slip =
                                                                            null;
                                                                        Form_time
                                                                            .clear();
                                                                      });
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Container(
                                                                        width: 100,
                                                                        decoration: const BoxDecoration(
                                                                          color:
                                                                              Colors.black,
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          'ปิด',
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text3_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ))),
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
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
                                              child: Text(
                                                base64_Slip == null
                                                    ? 'เพิ่มไฟล์'
                                                    : 'ดูไฟล์',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
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
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.03,
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(
                                    //     width: 1,
                                    //   ),
                                    //   color: Colors.white,
                                    //   borderRadius: const BorderRadius.only(
                                    //       topLeft: Radius.circular(15),
                                    //       topRight: Radius.circular(15),
                                    //       bottomLeft: Radius.circular(15),
                                    //       bottomRight: Radius.circular(15)),
                                    // ),
                                    child: TextFormField(
                                      controller: Form2_text,
                                      textAlign: TextAlign.end,
                                      onChanged: (value) async {
                                        setState(() {
                                          bill_email = value;
                                        });
                                      },
                                      cursorColor: Colors.green,
                                      decoration: InputDecoration(
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
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
                                          labelText: 'Gmail',
                                          labelStyle: const TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight:
                                            //     FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          )),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Center(
                    child: RepaintBoundary(
                      key: qrImageKey,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                width: 220,
                                decoration: BoxDecoration(
                                  color: Colors.green[300],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Chaoperty',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 220,
                              child: Image.asset(
                                "images/thai_qr_payment.png",
                                height: 60,
                                width: 220,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              child: Center(
                                child: SfBarcodeGenerator(
                                  value: generateQRCode(
                                    promptPayID: "$payment",
                                    amount: day_date == 'M'
                                        ? (double.parse(addpac_rpri!) *
                                            int.parse(Form1_text.text))
                                        : ((double.parse(addpac_rpri!) *
                                                int.parse(Form1_text.text)) *
                                            12),
                                  ),
                                  symbology: QRCode(),
                                  showValue: false,
                                ),
                                //     PrettyQr(
                                //   // typeNumber: 3,
                                //   image:
                                //       AssetImage(
                                //     "images/Icon-chao.png",
                                //   ),
                                //   size:
                                //       200,
                                //   data:
                                //       generateQRCode(promptPayID: "$selectedValue", amount: totalQr_),
                                //   errorCorrectLevel:
                                //       QrErrorCorrectLevel.M,
                                //   roundEdges:
                                //       true,
                                // ),
                              ),
                            ),
                            Text(
                              'พร้อมเพย์ : $payment',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              day_date == 'M'
                                  ? 'จำนวนเงิน ${NumberFormat("#,##0.00", "en_US").format(double.parse(addpac_rpri!) * int.parse(Form1_text.text))} บาท'
                                  : 'จำนวนเงิน ${NumberFormat("#,##0.00", "en_US").format((double.parse(addpac_rpri!) * int.parse(Form1_text.text)) * 12)} บาท',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '( ทำรายการ : ${DateFormat('dd-MM-yyyy').format(datex)} ${DateFormat('HH:mm:ss').format(datex)} )',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        var ser = preferences.getString('renTalSer');
                        if (base64_Slip != null && Form2_text.text != null) {
                          if (day_date != null && num_date != 0) {
                            String vv = getRandomString(16);
                            String dateTimeNow = DateTime.now().toString();
                            String date = DateFormat('ddMMyyyy')
                                .format(DateTime.parse('${dateTimeNow}'))
                                .toString();
                            final dateTimeNow2 = DateTime.now()
                                .toUtc()
                                .add(const Duration(hours: 7));
                            final formatter2 = DateFormat('HHmmss');
                            final formattedTime2 =
                                formatter2.format(dateTimeNow2);
                            String Time_ = formattedTime2.toString();
                            var fileName_Slip_ =
                                'slip_${renname}_${date}_$Time_.$extension_';
                            var nd = num_date;
                            var dd = day_date;
                            var ld = DateFormat('dd-MM-yyyy').format(datex);

                            var sta = 'N';
                            var ema = Form2_text.text;
                            var pack = '0';
                            var pri = day_date == 'M'
                                ? (double.parse(addpac_rpri!) *
                                        int.parse(Form1_text.text))
                                    .toString()
                                : ((double.parse(addpac_rpri!) *
                                            int.parse(Form1_text.text)) *
                                        12)
                                    .toString();
                            print(
                                'serren=$ser&lisen=$vv&num_date=$nd&day_date=$dd&ldate=$ld');
                            String url =
                                '${MyConstant().domain}/In_Package_put.php?isAdd=true&serren=$ser&lisen=$vv&num_date=$nd&day_date=$dd&ldate=$ld&sta=$sta&ema=$ema&pack=$pack&Slip=$fileName_Slip_&pri=$pri';

                            try {
                              var response = await http.get(Uri.parse(url));

                              var result = json.decode(response.body);
                              print(result);
                              if (result.toString() == 'true') {}
                            } catch (e) {}

                            final response = await SendEmail(
                                '$renname', Form2_text.text, vv); //ส่งเมล์
                            print(response);
                            OKuploadFile_Slip(fileName_Slip_);
                            sess();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('อายุการใช้งานไม่ถูกต้อง!')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'กรุณาแนบหลักฐานการโอน และที่อยู่ Gmail')),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.shade900,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'ยืนยันชำระ',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> sess() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Center(
                child: Text(
              'ทำรายการเสร็จสิ้น',
              style: TextStyle(
                  color: PeopleChaoScreen_Color.Colors_Text1_,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T),
            )),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // width: 150,
                    // height: 400,
                    child: Image(
                      image: AssetImage('images/gif-LOGOchao.gif'),
                      // width: 200,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ขอบคุณที่เลือกใช้บริการกับเรา',
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text2_,
                          fontFamily: Font_.Fonts_T),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            // border: Border.all(color: Colors.white, width: 1),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(
                              child: Text(
                            'ตกลง',
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text3_,
                                fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ))),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future<void> OKuploadFile_Slip(fileName_Slip_) async {
    if (base64_Slip != null) {
      // String Path_foder = 'slip';
      // String dateTimeNow = DateTime.now().toString();
      // String date = DateFormat('ddMMyyyy')
      //     .format(DateTime.parse('${dateTimeNow}'))
      //     .toString();
      // final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      // final formatter2 = DateFormat('HHmmss');
      // final formattedTime2 = formatter2.format(dateTimeNow2);
      // String Time_ = formattedTime2.toString();

      try {
        // 2. Read the image as bytes
        // final imageBytes = await pickedFile.readAsBytes();

        // 3. Encode the image as a base64 string
        // final base64Image = base64Encode(imageBytes);

        // 4. Make an HTTP POST request to your server
        final url =
            '${MyConstant().domain}/File_uploadSlip_NewEdit.php?name=$fileName_Slip_&Foder=$foder&extension=$extension_';

        final response = await http.post(
          Uri.parse(url),
          body: {
            'image': base64_Slip,
            'Foder': 'chao_perty',
            'name': fileName_Slip_,
            'ex': extension_.toString()
          }, // Send the image as a form field named 'image'
        );

        if (response.statusCode == 200) {
          print('Image uploaded successfully');
        } else {
          print('Image upload failed');
        }
      } catch (e) {
        print('Error during image processing: $e');
      }
    } else {
      print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

  String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> uploadFile_Slip() async {
    // ignore: deprecated_member_use
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);

    if (pickedFile == null) {
      print('User canceled image selection');
      return;
    } else {
      // 2. Read the image as bytes
      final imageBytes = await pickedFile.readAsBytes();

      // 3. Encode the image as a base64 string
      final base64Image = base64Encode(imageBytes);
      setState(() {
        base64_Slip = base64Image;
      });
      // print(base64_Slip);
      setState(() {
        Form_time.text = DateFormat('HH:mm').format(datex);
        extension_ = 'png';
        // file_ = file;
      });
      print(extension_);
    }
  }

  Column screen00() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: AutoSizeText(
                  minFontSize: 8,
                  maxFontSize: 18,
                  maxLines: 1,
                  'กรุณาเลือกต่อ License Key หรือ ซื้อ Package ใหม่',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: TextStyle(
                      // fontSize: 20,
                      color: SinginScreen_Color.Colors_Text1_,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T)),
            ),
          ],
        ),
      ],
    );
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
