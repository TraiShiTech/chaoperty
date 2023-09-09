import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GC_package_model.dart';
import '../Model/GetLicensekey_Modely.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class SignUnAdmin extends StatefulWidget {
  const SignUnAdmin({super.key});

  @override
  State<SignUnAdmin> createState() => _SignUnAdminState();
}

class _SignUnAdminState extends State<SignUnAdmin> {
  List<RenTalModel> renTalModels = [];
  List<PackageModel> packageModels = [];
  List<LicensekeyModel> licensekeyModels = [];

  String? packSelext;
  int? packint;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_GC_rental();
    read_GC_package();
    read_GC_packageGen();
  }

  // String _chars =
  //     'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<Null> read_GC_rental() async {
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

  Future<Null> read_GC_packageGen() async {
    if (licensekeyModels.isNotEmpty) {
      setState(() {
        licensekeyModels.clear();
      });
    }
    String url = '${MyConstant().domain}/GC_package_Gen.php?isAdd=true';

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

          setState(() {
            packageModels.add(packageModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[600],
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Admin Program",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: Font_.Fonts_T,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Location',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: Responsive.isDesktop(context)
                            ? MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).size.width * 0.1)
                            : MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).size.width * 0.2),
                        child: GridView.count(
                          crossAxisCount: Responsive.isDesktop(context) ? 5 : 2,
                          children: [
                            for (int i = 0; i < renTalModels.length; i++)
                              Card(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () async {
                                    var serren = renTalModels[i].ser;
                                    signInThread(serren);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                '${renTalModels[i].pn}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                              AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 2,
                                                '${renTalModels[i].bill_name}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                              AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                '( ${renTalModels[i].pkldate} )',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Package',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).size.width * 0.1)
                          : MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).size.width * 0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            }),
                            child: SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: Responsive.isDesktop(context)
                                    ? MediaQuery.of(context).size.width * 0.12
                                    : MediaQuery.of(context).size.width * 0.35,
                                child: GridView.count(
                                  scrollDirection: Axis.horizontal,
                                  crossAxisCount: 1,
                                  children: [
                                    for (int i = 0;
                                        i < packageModels.length;
                                        i++)
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: Responsive.isDesktop(context)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                            child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  if (packSelext ==
                                                      packageModels[i].ser) {
                                                    packSelext = null;
                                                    packint = 0;
                                                  } else {
                                                    packint = i;
                                                    packSelext =
                                                        packageModels[i].ser;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: packSelext ==
                                                          packageModels[i].ser
                                                      ? Colors.purple
                                                      : Colors.white38,
                                                  borderRadius:
                                                      const BorderRadius.only(
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
                                                  border: (packSelext ==
                                                          packageModels[i].ser)
                                                      ? Border.all(
                                                          color: Colors.white,
                                                          width: 1)
                                                      : Border.all(
                                                          color: Colors.black,
                                                          width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Package ${packageModels[i].pk}',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: (packSelext ==
                                                                  packageModels[
                                                                          i]
                                                                      .ser)
                                                              ? Colors.white
                                                              : Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '${packageModels[i].qty}',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: (packSelext ==
                                                                  packageModels[
                                                                          i]
                                                                      .ser)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                        style: TextStyle(
                                                          color: (packSelext ==
                                                                  packageModels[
                                                                          i]
                                                                      .ser)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${packageModels[i].user} สิทธิผู้ใช้งาน',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: (packSelext ==
                                                                  packageModels[
                                                                          i]
                                                                      .ser)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${NumberFormat("#,##0.00", "en_US").format(double.parse(packageModels[i].rpri!))} บาท/เดือน',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: (packSelext ==
                                                                  packageModels[
                                                                          i]
                                                                      .ser)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'License Key',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    packSelext == null
                                        ? ""
                                        : 'Package ${packageModels[packint!].pk}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade900,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          // packint = i;
                                          //           packSelext =
                                          //               packageModels[i].ser;

                                          if (packSelext != null) {
                                            var vv = getRandomString(16);
                                            String url =
                                                '${MyConstant().domain}/In_Package.php?isAdd=true&serpk=$packSelext&lisen=$vv';

                                            try {
                                              var response = await http
                                                  .get(Uri.parse(url));

                                              var result =
                                                  json.decode(response.body);
                                              print(result);
                                              if (result.toString() == 'true') {
                                                setState(() {
                                                  read_GC_packageGen();
                                                });
                                                print(
                                                    '$vv  $packSelext  $packint');
                                              }
                                            } catch (e) {}
                                            setState(() {
                                              read_GC_packageGen();
                                            });
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            'Generator',
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Package',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Unit/User',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        'KEY',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Status',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                child: ListView.builder(
                                    itemCount: licensekeyModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'Package ${licensekeyModels[index].pk}',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${licensekeyModels[index].qty}/${licensekeyModels[index].user}',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: licensekeyModels[index]
                                                              .use ==
                                                          '0'
                                                      ? SelectableText(
                                                          '${licensekeyModels[index].key}',
                                                          maxLines: 1,
                                                          // ignore: deprecated_member_use
                                                          toolbarOptions:
                                                              ToolbarOptions(
                                                                  copy: true,
                                                                  selectAll:
                                                                      true,
                                                                  cut: false,
                                                                  paste: false),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        )
                                                      : Text(
                                                          '${licensekeyModels[index].key}',
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    licensekeyModels[index]
                                                                .use ==
                                                            '0'
                                                        ? 'ใช้งานได้'
                                                        : 'ไม่สามารถใช้งานได้',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: licensekeyModels[
                                                                      index]
                                                                  .use ==
                                                              '0'
                                                          ? Colors.green
                                                          : Colors.red,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> signInThread(serren) async {
    String url =
        '${MyConstant().domain}/GC_user.php?isAdd=true&email=dzentric.com@gmail.com';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        print('serren>>>>$serren');
        routeToService(AdminScafScreen(route: 'หน้าหลัก'), userModel, serren);
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
      Widget myWidget, UserModel userModel, serren) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ser', userModel.ser.toString());
    preferences.setString('position', userModel.position.toString());
    preferences.setString('fname', userModel.fname.toString());
    preferences.setString('lname', userModel.lname.toString());
    preferences.setString('email', userModel.email.toString());
    preferences.setString('utype', userModel.utype.toString());
    preferences.setString('verify', userModel.verify.toString());
    preferences.setString('permission', userModel.permission.toString());
    preferences.setString('rser', serren.toString());
    preferences.setString('lavel', userModel.user_id.toString());
    preferences.setString('route', 'หน้าหลัก');
    preferences.setString('pakanPay', 0.toString());
    Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ');
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
