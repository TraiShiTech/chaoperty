// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names, curly_braces_in_flow_control_structures
import 'dart:async';
import 'dart:convert';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:marquee/marquee.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_sheet/side_sheet.dart';
// import 'package:timer_builder/timer_builder.dart';

import '../Account/Account_Screen.dart';
import '../Account/Play_column.dart';
import '../Bureau_Registration/Bureau_Screen.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../Constant/Myconstant.dart';
import '../Bureau_Registration/Customer_Screen.dart';
import '../Home/Home_Screen.dart';
import '../Manage/Manage_Screen.dart';
import '../Model/GetPerMission_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/areak_model.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Register/SignIn_License.dart';
import '../Register/SignIn_Screen.dart';
import '../Register/SignUp_Screen.dart';
import '../Report/Report_Screen.dart';
import 'package:http/http.dart' as http;
import '../Report_cm/Report_cm_Screen.dart';
import '../Responsive/responsive.dart';

import '../Setting/Access_Rights.dart';
import '../Setting/SettingScreen.dart';
import '../Setting/SettingScreen_user.dart';
import '../Setting/ttt.dart';
import '../Style/colors.dart';

class AdminScafScreen extends StatefulWidget {
  // const AdminScafScreen({super.key});

  @override
  State<AdminScafScreen> createState() => _AdminScafScreenState();
  final String? route;
  AdminScafScreen({
    super.key,
    this.route,
  });
}

class _AdminScafScreenState extends State<AdminScafScreen> {
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
      renTal_Email,
      passcode;
  int? perMissioncount;
  List<RenTalModel> renTalModels = [];
  List<PerMissionModel> perMissionModels = [];
  List<AreakModel> areakModels = [];
  List<UserModel> userModels = [];
  int? timeoutper = null;
  DateTime? alert;
  Timer? timer;
  bool isActive = false;
  String? rtname, type, typex, renname, pkname, ser_Zonex, pkldate, data_update;
  int? pkqty, pkuser, countarae, renTal_lavel = 0;
  String? base64_Imgmap, foder;
  String? tel_user, img_, img_logo;
  String singleDeviceName = "Unknown";
  String singleDeviceNameFromModel = "Unknown";
  String deviceNames = "Unknown";
  String deviceNamesFromModel = "Unknown";
  final _keybar = GlobalKey<ScaffoldState>();
///////////------------------------------------------->
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_rental();
    signInThread();
    Value_Route = widget.route!;
    alert = DateTime.now().add(Duration(seconds: 300));
    readTime();
    read_GC_areak();
    initPlugin();
    changLogin();
  }

  String? system_datex_;
  String? showst_update_;

  Future<Null> System_User() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var email_ = preferences.getString('email');
    String url = '${MyConstant().domain}/GC_user.php?isAdd=true&email=$email_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);

          setState(() {
            system_datex_ = userModel.system_datex!;
            showst_update_ = userModel.showst_update!;
          });
        }
      } else {}
    } catch (e) {}
    print('userModel  --------- >${system_datex_}');
    print('userModel  --------- >${showst_update_}');
    if (showst_update_ == '0') {
      System_New_Update();
    }
  }

  Future<Null> System_New_Update() async {
    String accept_ = showst_update_!;
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(
          '📢 ${system_datex_}',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontFamily: Font_.Fonts_T,
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("images/pngegg.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    'images/update.png',
                    // fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ขออภัย ขณะนี้ระบบได้มีการอัพเดต ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'คำแนะนำโปรดออกจากระบบ และทำการรีเฟรช',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    accept_ = '0';
                                  });
                                },
                                child: Icon(
                                  (accept_ == '0')
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: (accept_ == '0')
                                      ? Colors.red
                                      : Colors.black,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'แสดงทุกครั้ง',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  accept_ = '1';
                                });
                              },
                              child: Icon(
                                  (accept_ == '0')
                                      ? Icons.check_box_outline_blank
                                      : Icons.check_box,
                                  color: (accept_ == '0')
                                      ? Colors.black
                                      : Colors.red),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'แสดงอีกครั้งเมื่อมีการอัพเดต',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                var email_ = preferences.getString('email');
                                print(accept_);
                                if (accept_ == '1') {
                                  String url =
                                      '${MyConstant().domain}/UP_Show_System.php?isAdd=true&email=$email_';

                                  try {
                                    var response =
                                        await http.get(Uri.parse(url));

                                    var result = json.decode(response.body);

                                    if (result.toString() == 'true') {
                                      Navigator.pop(context, 'OK');
                                    } else {
                                      Navigator.pop(context, 'OK');
                                    }
                                  } catch (e) {}
                                } else {
                                  Navigator.pop(context, 'OK');
                                }
                              },
                              child: const Text(
                                'รับทราบ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

  Future<Null> changLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var email = preferences.getString('email');
    if (email != 'dzentric.com@gmail.com') {
      Timer.periodic(const Duration(seconds: 15), (timer) {
        changLoginOut(timer);
      });
    }
  }

  Future<Null> changLoginOut(timer) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var login = preferences.getString('login');
    var ipAddress = IpAddress(type: RequestType.json);

    /// Get the IpAddress based on requestType.
    dynamic data = await ipAddress.getIpAddress();
    // print(data.toString());

    var data0 = data.toString().substring(5, data.toString().length - 1).trim();
    // print(data0.toString());

    String url =
        '${MyConstant().domain}/changLoginOut.php?isAdd=true&user=$user&iplogin=$data0';
    // print(url.toString());
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('changLoginOut>$login>$user>>${result.toString()}');
      if (result.toString() != login) {
        deall_Trans_select();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        routToService(SignInScreen());
        timer.cancel();
      }
    } catch (e) {}
  }

  Future<Null> passcode_in() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    String url =
        '${MyConstant().domain}/Inc_passcode.php?isAdd=true&ren=$ren&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'false') {
        print('Inc_passcode>>>>true');
        setState(() {
          passcode = result.toString();
        });
      } else {
        print('Inc_passcode>>>>false $result');
      }
    } catch (e) {
      // print('rrrrrrrrrrrrrr $e');
    }
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

  Future<void> initPlugin() async {
    const model = "Device : ";
    final deviceMarketingNames = DeviceMarketingNames();
    final currentSingleDeviceName = await deviceMarketingNames.getSingleName();
    final currentDeviceNames = await deviceMarketingNames.getNames();
    setState(() {
      singleDeviceName = currentSingleDeviceName;
      deviceNames = currentDeviceNames;
      singleDeviceNameFromModel = deviceMarketingNames.getSingleNameFromModel(
          DeviceType.android, model);
      deviceNamesFromModel =
          deviceMarketingNames.getNamesFromModel(DeviceType.android, model);
    });
  }

  String? connected_Minutes;
  void startTimer() {
    Check_connected();
    upConnected();

    // Create a timer that runs the read_connected function every 1 minute
    Timer.periodic(Duration(seconds: 50), (timer) {
      Check_connected();
      upConnected();
    });
  }

  Future<void> upConnected() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    DateTime currentTime = DateTime.now();
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(currentTime);
    print('$ren-----$user ----- ${formattedDateTime}');
    String url =
        '${MyConstant().domain}/UP_Connected_User.php?isAdd=true&seruser=$user&value=$formattedDateTime';
    try {
      var response = await http.get(Uri.parse(url));

      // if (response.statusCode == 200) {
      //   // Check if the response status code is OK (200)
      //   print('Success: ${response.body}');
      // } else {
      //   // Handle other response status codes if needed
      //   print('HTTP Error: ${response.statusCode}');
      // }
    } catch (e) {
      print('Error: $e');
    }
  }

  String read_data_davtext = '';
  Future<Null> Check_connected() async {
    if (userModels.isNotEmpty) {
      userModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/Connected_User.php?isAdd=true&ren=$ren&emailrental=$renTal_Email';
    int indexfor = 0;
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          String connected_ = '${userModel.connected}';

          DateTime connectedTime = DateTime.parse(connected_);

          DateTime currentTime = DateTime.now();

          Duration difference = currentTime.difference(connectedTime);

          int minutesPassed = difference.inMinutes;
          if (minutesPassed > 15) {
          } else {
            setState(() {
              userModels.add(userModel);
            });
          }
          if (indexfor == 0) {
            read_data_davtext = '${userModel.dev_text}';
          }
          indexfor++;
        }
      } else {}
    } catch (e) {}
    // print('name>>>>>  $renname');
  }

  Future<Null> read_GC_areak() async {
    if (areakModels.isNotEmpty) {
      areakModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/In_c_areak.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          AreakModel areakModel = AreakModel.fromJson(map);

          setState(() {
            areakModels.add(areakModel);
          });
        }
      } else {}
    } catch (e) {}
    // print('name>>>>>  $renname');
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('GC_rental_setring>> $result');
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
          var data_updatex = renTalModel.data_update;
          setState(() {
            preferences.setString(
                'renTalName', renTalModel.pn!.trim().toString());
            renTal_name = preferences.getString('renTalName');
            renTal_Email = renTalModel.bill_email.toString();
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
            pkldate = pkldatex;
            data_update = data_updatex;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> readTime() async {
    var now = DateTime.now();
    var reached = now.compareTo(alert!) >= 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Future.delayed(Duration(seconds: 1), () async {
      setState(() {
        timeoutper = preferences.getInt('timeoutper');
      });
      if (reached) {
        // normalDialog(context, 'Time Out');
        // print('Time Outttt $Value_Route $reached');
      } else {
        // print('${reached.toString()}');

        setState(() {
          // if (timeoutper != null) {
          //   alert = DateTime.now().add(Duration(seconds: timeoutper!));
          // }
          // readTime();

          // preferences.setInt('timeoutper', 100);

          timeoutper == -5
              ? -5
              : alert = DateTime.now().add(Duration(seconds: timeoutper!));
          preferences.setInt('timeoutper', -5);
        });
      }

      var timrNow = DateTime.now();
      String orderDates = DateFormat('yyyy-MM-dd').format(timrNow);
      final eventTime = DateTime.parse('$orderDates 00:00:00');

      const duration = const Duration(seconds: 1);
      int timeDiff = eventTime.difference(DateTime.now()).inSeconds;
      if (timer == null) {
        timer = Timer.periodic(duration, (Timer t) {
          if (timeDiff > 0) {
            if (isActive) {
              setState(() {
                // sharedPreferencesUser();
                if (eventTime != DateTime.now()) {
                  timeDiff = timeDiff - 1;
                } else {
                  // print('Times up!');
                  //Do something
                }
              });
            }
          }
        });
      }

      // int day = eventTime.difference(DateTime.now()).inDays;
      // // timeDiff ~/ (24 * 60 * 60) % 24;
      // int hour = timeDiff ~/ (60 * 60) % 24;
      // int minute = (timeDiff ~/ 60) % 60;
      // int second = timeDiff % 60;

      // setState(() {
      //   days = day;
      //   hours = hour;
      //   minutes = minute;
      //   seconds = second;
      // });
    });
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f((d.inHours) % 24)}:${f((d.inMinutes) % 60)}:${f(d.inSeconds % 60)} \t\t";
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
          position_user = userModel.position;
          fname_user = userModel.fname;
          lname_user = userModel.lname;
          email_user = userModel.email;
          ser_user = userModel.ser;
          utype_user = userModel.utype;
          permission_user = userModel.permission;
        });
      }
      setState(() {
        read_GC_permission();
      });
    } catch (e) {}
  }

  Future<Null> read_GC_permission() async {
    startTimer();
    if (perMissionModels.length != 0) {
      perMissionModels.clear();
    }
    if (permission_user == '0') {
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
      } catch (e) {}
    } else {
      List<String> permissions = (permission_user!.split(','));
      for (var i = 0; i < permissions.length; i++) {
        var permission = permissions[i];
        String url =
            '${MyConstant().domain}/GC_permission.php?isAdd=true&ser=$permission';

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
        } catch (e) {}
      }
    }
    setState(() {
      perMissioncount = perMissionModels.length;
    });

    // print('perMissionModels  == > ${perMissionModels.length}');
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var rser = preferences.getString('rser');
    if (rser == '0') {
      setState(() {
        renTal_user = preferences.getString('renTalSer');
        renTal_name = preferences.getString('renTalName');
        renTal_lavel = int.parse(preferences.getString('lavel').toString());
      });
    } else {
      setState(() {
        preferences.setString('renTalSer', rser.toString());
        renTal_user = preferences.getString('renTalSer');
        renTal_lavel = int.parse(preferences.getString('lavel').toString());
      });
    }
    print('renTal_lavel>>> $renTal_lavel');
    setState(() {
      passcode_in();

      //   renTal_user = preferences.getString('renTalSer');
      //   renTal_name = preferences.getString('renTalName');
    });
    System_User();
  }

  // List MenuList_ = [
  //   'หน้าหลัก',
  //   'พื้นที่เช่า',
  //   'ผู้เช่า',
  //   'บัญชี',
  //   'จัดการ',
  //   'รายงาน',
  //   'ตั้งค่า',
  // ];
  List Menu_IconList_ = [
    Icons.home,
    Icons.location_pin,
    Icons.person,
    Icons.calendar_month,
    Icons.key,
    Icons.inventory,
    Icons.settings,
  ];
  double _scaleFactor = 1.0; // define the initial scale factor

  void _zoomIn() {
    setState(() {
      _scaleFactor *= 1.2; // increase the scale factor by 20%
    });
  }

  void _zoomOut() {
    setState(() {
      _scaleFactor /= 1.2; // decrease the scale factor by 20%
    });
  }

  Future<void> _showMyDialogImg(String Url, String title_) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
              child: Text(
            title_.toString(),
            style: const TextStyle(
              // fontSize: 15,
              color: Colors.black,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
            ),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InteractiveViewer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: (img_ == null || img_.toString() == '')
                        ? const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.black,
                            ),
                          )
                        : Image.network(
                            '$Url',
                            fit: BoxFit.contain,
                          ),
                  ),
                  scaleEnabled: true,
                  minScale: 0.5,
                  maxScale: 5.0,
                  transformationController: TransformationController()
                    ..value =
                        Matrix4.diagonal3Values(_scaleFactor, _scaleFactor, 1),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // StreamBuilder(
            //     stream: Stream.periodic(const Duration(milliseconds: 0)),
            //     builder: (
            //       context,
            //       snapshot,
            //     ) {
            //       return SizedBox(
            //         child: Row(
            //           children: [
            //             IconButton(
            //               icon: Icon(Icons.add),
            //               onPressed: _zoomIn,
            //             ),
            //             IconButton(
            //               icon: Icon(Icons.remove),
            //               onPressed: _zoomOut,
            //             ),
            //           ],
            //         ),
            //       );
            //     }),
            InkWell(
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(4.0),
                child: const Center(
                  child: Text(
                    'ปิด',
                    style: TextStyle(
                      // fontSize: 15,
                      color: Colors.white,
                      fontFamily: Font_.Fonts_T,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final Dev_text = TextEditingController();
  Future<void> _showMyDialogDev() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: Dev_text,
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String? value) {
                        return (value != null && value.contains('@'))
                            ? 'Do not use the @ char.'
                            : null;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.3),
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.chat, color: Colors.black),
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
                          errorStyle: TextStyle(fontFamily: Font_.Fonts_T),
                          enabledBorder: const OutlineInputBorder(
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
                          labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: Font_.Fonts_T)),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 250,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                        child: Text(
                          'ข้อความแจ้งเตือน',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (Dev_text.text != '') {
                        String url =
                            '${MyConstant().domain}/Awat_UP_sytem.php?isAdd=true&dev_tex=${Dev_text.text}';

                        try {
                          var response = await http.get(Uri.parse(url));

                          var result = json.decode(response.body);
                          if (result.toString() == 'true') {
                            setState(() {
                              Dev_text.clear();
                            });
                            Navigator.of(context).pop();
                          }
                        } catch (e) {
                          setState(() {
                            Dev_text.clear();
                          });
                        }
                      } else {}
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 250,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                        child: Text(
                          'ยกเลิกข้อความแจ้งเตือน',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      String tex_t = '';
                      String url =
                          '${MyConstant().domain}/Awat_UP_sytem.php?isAdd=true&dev_tex=${tex_t}';

                      try {
                        var response = await http.get(Uri.parse(url));

                        var result = json.decode(response.body);
                        if (result.toString() == 'true') {
                          setState(() {
                            Dev_text.clear();
                          });
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        setState(() {
                          Dev_text.clear();
                        });
                      }
                    },
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 250,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                        child: Text(
                          'แจ้งเตือน Dialog หลังอัพเดต',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

                      String url =
                          '${MyConstant().domain}/OK_UP_sytem.php?isAdd=true&datex=${formattedDate}';

                      try {
                        var response = await http.get(Uri.parse(url));

                        var result = json.decode(response.body);
                        if (result.toString() == 'true') {
                          Navigator.of(context).pop();
                        }
                      } catch (e) {}
                    },
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
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Center(
                  child: Text(
                    'ปิด',
                    style: TextStyle(
                      // fontSize: 15,
                      color: Colors.white,
                      fontFamily: Font_.Fonts_T,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context))
      // print(
      //     '$position_user, $fname_user, $lname_user,$email_user, $utype_user, $permission_user');
      setState(() {
        if (passcode == null) {
          passcode_in();
        }

        serBody_modile_wiget = 0;
      });
    if (perMissionModels.length < perMissioncount!) {
      return Center(
        child: const CircularProgressIndicator(),
      );
    }

    return (Responsive.isDesktop(context)) ? adminweb() : adminmobile();
  }

  AdminScaffold adminweb() {
    return AdminScaffold(
      backgroundColor: AppbackgroundColor.Abg_Colors,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.black,
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 50.2,
        // toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (Responsive.isDesktop(context))
                        (img_logo == null || img_logo.toString() == '')
                            ? SizedBox()
                            : InkWell(
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(
                                      '${MyConstant().domain}/files/$foder/logo/$img_logo'),
                                  backgroundColor: Colors.transparent,
                                ),
                                onTap: () {
                                  if (img_logo == null ||
                                      img_logo.toString() == '') {
                                  } else {
                                    String url =
                                        '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                    _showMyDialogImg(
                                        url,
                                        renTal_name == null
                                            ? ' '
                                            : ' $renTal_name');
                                  }
                                },
                              ),
                      InkWell(
                        child: Text(
                          renTal_name == null ? ' ภาพรวม' : ' $renTal_name',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AdminScafScreen_Color.Colors_Text1_,
                              fontWeight: (Responsive.isDesktop(context))
                                  ? FontWeight.bold
                                  : null,
                              fontSize:
                                  (Responsive.isDesktop(context)) ? null : 12,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                        onTap: () {
                          if (img_logo == null || img_logo.toString() == '') {
                          } else {
                            String url =
                                '${MyConstant().domain}/files/$foder/logo/$img_logo';
                            _showMyDialogImg(url,
                                renTal_name == null ? ' ' : ' $renTal_name');
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
        actions: [
          Row(
            children: [
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 0)),
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        if (!Responsive.isMobile(context) &&
                            read_data_davtext != '')
                          Container(
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width / 4
                                : MediaQuery.of(context).size.width / 2,
                            child: Marquee(
                              text:
                                  '   📢 แจ้งเตือน : $read_data_davtext     ||   ',

                              // text: '$read_data_davtext',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 179, 92, 85),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // blankSpace: 20.0,
                              // velocity: 100.0,
                              pauseAfterRound: Duration(seconds: 1),
                              // startPadding: 10.0,
                              // accelerationDuration: Duration(seconds: 5),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(seconds: 5),
                              decelerationCurve: Curves.easeInOut,
                            ),
                          ),
                      ],
                    );
                  }),
              if (pkldate != null)
                if (datex.isAfter(DateTime.parse(pkldate == '0000-00-00'
                            ? '$data_update'
                            : '$pkldate 00:00:00.000')
                        .subtract(const Duration(days: 7))) ==
                    true)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => SignInLicense(route: 'Yes'),
                        );
                        Navigator.pushAndRemoveUntil(
                            context, route, (route) => true);
                      },
                      child: Container(
                        width: 50,
                        // color: Colors.yellow,
                        child: Center(
                          child: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              if (Responsive.isDesktop(context) && ser_user == '63' ||
                  ser_user == '56' ||
                  ser_user == '61' ||
                  ser_user == '37')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _showMyDialogDev();
                    },
                    child: Container(
                      color: Colors.yellow,
                      child: Center(
                          child: Text(
                        '  DEV  ',
                        style: TextStyle(
                            color: AdminScafScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T),
                      )),
                    ),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(0.5),
                child: Row(
                  children: [
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 0)),
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: renTal_name == null
                                    ? null
                                    : () async {
                                        startTimer();
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            title: Center(
                                                child: Text(
                                              'ผู้ใช้งานระบบขณะนี้ ',
                                              style: TextStyle(
                                                  color: AdminScafScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            )),
                                            content: ScrollConfiguration(
                                              behavior: ScrollConfiguration.of(
                                                      context)
                                                  .copyWith(dragDevices: {
                                                PointerDeviceKind.touch,
                                                PointerDeviceKind.mouse,
                                              }),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                dragStartBehavior:
                                                    DragStartBehavior.start,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: (Responsive
                                                              .isDesktop(
                                                                  context))
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.85
                                                          : 800,
                                                      child: StreamBuilder(
                                                          stream:
                                                              Stream.periodic(
                                                                  const Duration(
                                                                      seconds:
                                                                          0)),
                                                          builder: (context,
                                                              snapshot) {
                                                            return Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'ทั้งหมด : ${userModels.length} คน',
                                                                      style: TextStyle(
                                                                          color: AdminScafScreen_Color
                                                                              .Colors_Text1_,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: AppbackgroundColor
                                                                        .TiTile_Colors,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0),
                                                                    ),
                                                                    // border: Border.all(
                                                                    //     color: Colors.grey, width: 1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: const [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          '...',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          'Email',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          'ชื่อ',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          'ตำแหน่ง',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          'เวลาอัพเดตล่าสุด',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.4,
                                                                    width: (Responsive.isDesktop(
                                                                            context))
                                                                        ? MediaQuery.of(context).size.width *
                                                                            0.85
                                                                        : 800,
                                                                    child: ListView.builder(
                                                                        padding: const EdgeInsets.all(8),
                                                                        itemCount: userModels.length,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          String
                                                                              email =
                                                                              '${userModels[index].email}';
                                                                          int emailLength =
                                                                              email.length;
                                                                          String
                                                                              firstTwoCharacters =
                                                                              email.substring(0, 2);
                                                                          String
                                                                              lastFourCharacters =
                                                                              email.substring(emailLength - 4);
                                                                          String
                                                                              censoredEmail =
                                                                              '$firstTwoCharacters${'*' * (emailLength - 6)}$lastFourCharacters';

                                                                          String
                                                                              connected_ =
                                                                              '${userModels[index].connected}';

                                                                          DateTime
                                                                              connectedTime =
                                                                              DateTime.parse(connected_);

                                                                          DateTime
                                                                              currentTime =
                                                                              DateTime.now();

                                                                          Duration
                                                                              difference =
                                                                              currentTime.difference(connectedTime);

                                                                          int minutesPassed =
                                                                              difference.inMinutes;
                                                                          return Container(
                                                                            padding:
                                                                                const EdgeInsets.all(8),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Text(
                                                                                    '${index + 1}',
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: TextStyle(
                                                                                        color: AdminScafScreen_Color.Colors_Text1_,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Text(
                                                                                    '${censoredEmail} ',
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: TextStyle(
                                                                                        color: AdminScafScreen_Color.Colors_Text1_,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Text(
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    '${userModels[index].fname} ${userModels[index].lname}',
                                                                                    style: TextStyle(
                                                                                        color: AdminScafScreen_Color.Colors_Text1_,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Text(
                                                                                    '${userModels[index].position}',
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: TextStyle(
                                                                                        color: AdminScafScreen_Color.Colors_Text1_,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Expanded(flex: 1, child: Icon((minutesPassed > 1) ? Icons.motion_photos_off_rounded : Icons.motion_photos_on_rounded, color: (minutesPassed > 1) ? Colors.red : Colors.green)
                                                                                          // Text(
                                                                                          //   '🟢',
                                                                                          //   maxLines: 2,
                                                                                          //   textAlign: TextAlign.end,
                                                                                          //   style: TextStyle(color: (minutesPassed > 1) ? Colors.red : Colors.green, fontFamily: Font_.Fonts_T),
                                                                                          // )
                                                                                          ),
                                                                                      Expanded(
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          (minutesPassed > 1) ? 'ใช้งานเมื่อ $minutesPassed นาทีที่แล้ว' : ' ${userModels[index].connected}',
                                                                                          textAlign: TextAlign.center,
                                                                                          maxLines: 2,
                                                                                          style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        })),
                                                              ],
                                                            );
                                                          }),
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
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: RichText(
                                                        text: const TextSpan(
                                                          text: '**หมายเหตุ : ',
                                                          style: TextStyle(
                                                              color: AdminScafScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: ' สีเขียว ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' กำลังใช้งาน (ไม่เกิน 1 นาที) ,',
                                                              style: TextStyle(
                                                                  color: AdminScafScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                            TextSpan(
                                                              text: ' สีแดง ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' ใช้งานล่าสุด (ไม่เกิน 15 นาที)',
                                                              style: TextStyle(
                                                                  color: AdminScafScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                    height: 4.0,
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius: BorderRadius.only(
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK'),
                                                                  child:
                                                                      const Text(
                                                                    'ปิด',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
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
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.people,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          // decoration: const BoxDecoration(
                                          //   color: Colors.white,
                                          //   borderRadius: BorderRadius.only(
                                          //       topLeft: Radius.circular(20),
                                          //       topRight: Radius.circular(20),
                                          //       bottomLeft: Radius.circular(20),
                                          //       bottomRight: Radius.circular(20)),
                                          // ),
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            renTal_name == null
                                                ? '0'
                                                : '${userModels.length}',
                                            // '${userModels.length}***/$connected_Minutes/$ser_user/$email_user',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ))
                                  ],
                                )),
                          );
                        }),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 0)),
                          builder: (context, snapshot) {
                            return Text(
                              'สวัสดีคุณ $fname_user',
                              style: TextStyle(
                                  color: AdminScafScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                            );
                          }),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            title: const Center(
                                child: Text(
                              'ออกจากระบบ',
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButton(
                                              onPressed: () async {
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
                                              child: const Text(
                                                'ยืนยัน',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 100,
                                                decoration: const BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(10),
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
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                  child: const Text(
                                                    'ยกเลิก',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.logout_rounded),
                      ),
                    ),
                    // TimerBuilder.scheduled([alert!], builder: (context) {
                    //   // This function will be called once the alert time is reached
                    //   var now = DateTime.now();
                    //   var reached = now.compareTo(alert!) >= 0;
                    //   // final textStyle = Theme.of(context).textTheme.title;
                    //   return Center(
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: <Widget>[
                    //         // Icon(
                    //         //   reached ? Icons.alarm_on : Icons.alarm,
                    //         //   color: reached ? Colors.red : Colors.green,
                    //         //   size: 48,
                    //         // ),
                    //         !reached
                    //             ? TimerBuilder.periodic(Duration(seconds: 1),
                    //                 alignment: Duration.zero,
                    //                 builder: (context) {
                    //                 // This function will be called every second until the alert time
                    //                 var now = DateTime.now();
                    //                 var remaining = alert!.difference(now);
                    //                 return Text(
                    //                   formatDuration(remaining),
                    //                   // style: textStyle,
                    //                 );
                    //               })
                    //             : Text(
                    //                 "00:00:00 \t\t",
                    //                 // style: textStyle
                    //               ),
                    //         // RaisedButton(
                    //         //   child: Text("Reset"),
                    //         //   onPressed: () {
                    //         //     setState(() {
                    //         //       alert =
                    //         //           DateTime.now().add(Duration(seconds: 120));
                    //         //     });
                    //         //   },
                    //         // ),
                    //       ],
                    //     ),
                    //   );
                    // }),
                  ],
                ),
              ),
            ],
          ),
        ],
        elevation: 0,
        backgroundColor: AppBarColors.ABar_Colors,
      ),
      sideBar: SideBar(
        key: _keybar,
        textStyle:
            const TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T),
        iconColor: Colors.white,
        backgroundColor: AppBarColors.ABar_Colors,
        items: [
          for (int i = 0; i < perMissionModels.length; i++)
            if (int.parse(perMissionModels[i].ser!) <= 3)
              AdminMenuItem(
                title: perMissionModels[i].perm!.trim(),
                route: '/${perMissionModels[i].perm!.trim()}',
                icon: IconData(
                  int.parse(
                    '${perMissionModels[i].icon}',
                  ),
                  fontFamily: 'MaterialIcons',
                ),
              ),
          AdminMenuItem(
            title: 'อื่นๆ',
            // icon: Icons.more_horiz,
            icon: IconData(
              int.parse(
                '0xf8d9',
              ),
              fontFamily: 'MaterialIcons',
            ),
            children: [
              for (int i = 0; i < perMissionModels.length; i++)
                if (int.parse(perMissionModels[i].ser!) > 3)
                  AdminMenuItem(
                    title: perMissionModels[i].perm!.trim(),
                    route: '/${perMissionModels[i].perm!.trim()}',
                    icon: IconData(
                      int.parse(
                        '${perMissionModels[i].icon}',
                      ),
                      fontFamily: 'MaterialIcons',
                    ),
                  ),
            ],
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) async {
          for (int i = 0; i < perMissionModels.length; i++) {
            if (item.route == '/${perMissionModels[i].perm!.trim()}') {
              if (renTal_user != null) {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString(
                    'route', perMissionModels[i].perm!.trim().toString());
                setState(() {
                  Value_Route = perMissionModels[i].perm!.trim();
                  _keybar.currentState?.closeDrawer();
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('กรุณาเลือกสถานที่ของท่านเพื่อเรียกดูข้อมูล')),
                );
              }
            }
          }
          // if (item.route == '/หน้าหลัก') {
          //   setState(() {
          //     Value_Route = 'หน้าหลัก';
          //   });
          //   // Navigator.push(context,
          //   //     MaterialPageRoute(builder: (context) => const HomeScreen()));
          //   print('1หน้าหลัก');
          // } else if ((item.route == '/พื้นที่เช่า')) {
          //   setState(() {
          //     Value_Route = 'พื้นที่เช่า';
          //   });
          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //         builder: (context) => const ChaoAreaScreen()));
          //   print('2พื้นที่เช่า');
          // } else if ((item.route == '/ผู้เช่า')) {
          //   setState(() {
          //     Value_Route = 'ผู้เช่า';
          //   });
          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //         builder: (context) => const PeopleChaoScreen()));
          //   print('3');
          // } else if ((item.route == '/บัญชี')) {
          //   setState(() {
          //     Value_Route = 'บัญชี';
          //   });
          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //         builder: (context) => const AccountScreen()));
          //   print('4บัญชี');
          // } else if ((item.route == '/จัดการ')) {
          //   setState(() {
          //     Value_Route = 'จัดการ';
          //   });
          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //         builder: (context) => const ManageScreen()));
          //   print('5');
          // } else if ((item.route == '/รายงาน')) {
          //   setState(() {
          //     Value_Route = 'รายงาน';
          //   });
          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //         builder: (context) => const ReportScreen()));
          //   print('6รายงาน');
          // } else if ((item.route == '/ตั้งค่า')) {
          //   setState(() {
          //     Value_Route = 'ตั้งค่า';
          //   });
          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //         builder: (context) => const SettingScreen()));
          //   print('7ตั้งค่า');
          // }
        },
        header: Container(
          color: AppBarColors.ABar_Colors,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                ),
                child: const Image(
                  image: AssetImage('images/LOGO.png'),
                ),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    Value_Route = 'หน้าหลัก';
                  });
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString('route', 'หน้าหลัก');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text(
                        'เมนูหลัก',
                        style: TextStyle(
                            color: AdminScafScreen_Color.Colors_Text1_,
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
        footer: Container(
          // height: 50,
          width: double.infinity,
          color: AppBarColors.ABar_Colors,
          child: Container(
            // height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
            ),
            child: Column(
              children: [
                renTal_lavel! <= 1
                    ? SizedBox()
                    : passcode == null
                        ? SizedBox()
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '$passcode',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.orange.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '© 2023  Dzentric Co.,Ltd. All Rights Reserved',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AdminScafScreen_Color.Colors_Text2_,
                          // fontWeight: FontWeight.bold,
                          fontFamily: Font_.Fonts_T,
                          fontSize: 10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: (Value_Route == 'หน้าหลัก')
          ? const HomeScreen()
          : (Value_Route == 'พื้นที่เช่า')
              ? const ChaoAreaScreen()
              : (Value_Route == 'ผู้เช่า')
                  ? const PeopleChaoScreen()
                  : (Value_Route == 'บัญชี')
                      ? const AccountScreen()
                      : (Value_Route == 'จัดการ')
                          ? const ManageScreen()
                          : (Value_Route == 'รายงาน' &&
                                  renTal_user.toString() == '65')
                              ? const Report_cm_Screen()
                              : (Value_Route == 'รายงาน' &&
                                      renTal_user.toString() != '65')
                                  ? ReportScreen()
                                  : (Value_Route == 'ทะเบียน')
                                      ? const BureauScreen()
                                      : (Value_Route == 'ตั้งค่า')
                                          ? const SettingScreen()
                                          : (Value_Route ==
                                                  'จัดการข้อมูลส่วนตัว')
                                              ? const SettingUserScreen()
                                              : const SettingUserScreen(),
    );
  }

  Scaffold adminmobile() {
    return Scaffold(
      backgroundColor: AppbackgroundColor.Abg_Colors,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.black,
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 50.2,
        // toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (Responsive.isDesktop(context))
                        (img_logo == null || img_logo.toString() == '')
                            ? SizedBox()
                            : InkWell(
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(
                                      '${MyConstant().domain}/files/$foder/logo/$img_logo'),
                                  backgroundColor: Colors.transparent,
                                ),
                                onTap: () {
                                  if (img_logo == null ||
                                      img_logo.toString() == '') {
                                  } else {
                                    String url =
                                        '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                    _showMyDialogImg(
                                        url,
                                        renTal_name == null
                                            ? ' '
                                            : ' $renTal_name');
                                  }
                                },
                              ),
                      InkWell(
                        child: Text(
                          renTal_name == null ? ' ภาพรวม' : ' $renTal_name',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AdminScafScreen_Color.Colors_Text1_,
                              fontWeight: (Responsive.isDesktop(context))
                                  ? FontWeight.bold
                                  : null,
                              fontSize:
                                  (Responsive.isDesktop(context)) ? null : 12,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                        onTap: () {
                          if (img_logo == null || img_logo.toString() == '') {
                          } else {
                            String url =
                                '${MyConstant().domain}/files/$foder/logo/$img_logo';
                            _showMyDialogImg(url,
                                renTal_name == null ? ' ' : ' $renTal_name');
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
        actions: [
          Row(
            children: [
              (Responsive.isMobile(context))
                  ? Text('')
                  : StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 0)),
                      builder: (context, snapshot) {
                        return Row(
                          children: [
                            if (read_data_davtext != '')
                              Container(
                                width: (Responsive.isDesktop(context))
                                    ? MediaQuery.of(context).size.width / 4
                                    : MediaQuery.of(context).size.width / 5,
                                child: Marquee(
                                  text:
                                      '   📢 แจ้งเตือน : $read_data_davtext     ||   ',

                                  /// velocity: 50.0, //speed
                                  // text: '$read_data_davtext',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 179, 92, 85),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // blankSpace: 20.0,
                                  // velocity: 100.0,
                                  pauseAfterRound: Duration(seconds: 1),
                                  // startPadding: 10.0,
                                  // accelerationDuration: Duration(seconds: 5),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration: Duration(seconds: 5),
                                  decelerationCurve: Curves.easeInOut,
                                ),
                              ),
                          ],
                        );
                      }),
              if (!Responsive.isMobile(context) && ser_user == '63' ||
                  ser_user == '56' ||
                  ser_user == '61' ||
                  ser_user == '37')
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      _showMyDialogDev();
                    },
                    child: Container(
                      color: Colors.yellow,
                      child: Center(
                          child: Text(
                        '  DEV  ',
                        style: TextStyle(
                            color: AdminScafScreen_Color.Colors_Text1_,
                            fontFamily: FontWeight_.Fonts_T),
                      )),
                    ),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(0.5),
                child: Row(
                  children: [
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 0)),
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: renTal_name == null
                                    ? null
                                    : () async {
                                        startTimer();
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            title: Center(
                                                child: Text(
                                              'ผู้ใช้งานระบบขณะนี้ $deviceNames',
                                              style: TextStyle(
                                                  color: AdminScafScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            )),
                                            content: ScrollConfiguration(
                                              behavior: ScrollConfiguration.of(
                                                      context)
                                                  .copyWith(dragDevices: {
                                                PointerDeviceKind.touch,
                                                PointerDeviceKind.mouse,
                                              }),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                dragStartBehavior:
                                                    DragStartBehavior.start,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: (Responsive
                                                              .isDesktop(
                                                                  context))
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.85
                                                          : 800,
                                                      child: StreamBuilder(
                                                          stream:
                                                              Stream.periodic(
                                                                  const Duration(
                                                                      seconds:
                                                                          0)),
                                                          builder: (context,
                                                              snapshot) {
                                                            return Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'ทั้งหมด : ${userModels.length} คน',
                                                                      style: TextStyle(
                                                                          color: AdminScafScreen_Color
                                                                              .Colors_Text1_,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: AppbackgroundColor
                                                                        .TiTile_Colors,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0),
                                                                    ),
                                                                    // border: Border.all(
                                                                    //     color: Colors.grey, width: 1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: const [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          '...',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          'Email',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          'ชื่อ',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          'ตำแหน่ง',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          'เวลาอัพเดตล่าสุด',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.4,
                                                                    width: (Responsive.isDesktop(
                                                                            context))
                                                                        ? MediaQuery.of(context).size.width *
                                                                            0.85
                                                                        : 800,
                                                                    child: ListView.builder(
                                                                        padding: const EdgeInsets.all(8),
                                                                        itemCount: userModels.length,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          String
                                                                              email =
                                                                              '${userModels[index].email}';
                                                                          int emailLength =
                                                                              email.length;
                                                                          String
                                                                              firstTwoCharacters =
                                                                              email.substring(0, 2);
                                                                          String
                                                                              lastFourCharacters =
                                                                              email.substring(emailLength - 4);
                                                                          String
                                                                              censoredEmail =
                                                                              '$firstTwoCharacters${'*' * (emailLength - 6)}$lastFourCharacters';

                                                                          String
                                                                              connected_ =
                                                                              '${userModels[index].connected}';

                                                                          DateTime
                                                                              connectedTime =
                                                                              DateTime.parse(connected_);

                                                                          DateTime
                                                                              currentTime =
                                                                              DateTime.now();

                                                                          Duration
                                                                              difference =
                                                                              currentTime.difference(connectedTime);

                                                                          int minutesPassed =
                                                                              difference.inMinutes;
                                                                          return Container(
                                                                            padding:
                                                                                const EdgeInsets.all(8),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Text(
                                                                                    '${index + 1}',
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: TextStyle(
                                                                                        color: AdminScafScreen_Color.Colors_Text1_,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Text(
                                                                                    '${censoredEmail} ',
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: TextStyle(
                                                                                        color: AdminScafScreen_Color.Colors_Text1_,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Text(
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    '${userModels[index].fname} ${userModels[index].lname}',
                                                                                    style: TextStyle(
                                                                                        color: AdminScafScreen_Color.Colors_Text1_,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Text(
                                                                                    '${userModels[index].position}',
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: TextStyle(
                                                                                        color: AdminScafScreen_Color.Colors_Text1_,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Expanded(flex: 1, child: Icon((minutesPassed > 1) ? Icons.motion_photos_off_rounded : Icons.motion_photos_on_rounded, color: (minutesPassed > 1) ? Colors.red : Colors.green)
                                                                                          // Text(
                                                                                          //   '🟢',
                                                                                          //   maxLines: 2,
                                                                                          //   textAlign: TextAlign.end,
                                                                                          //   style: TextStyle(color: (minutesPassed > 1) ? Colors.red : Colors.green, fontFamily: Font_.Fonts_T),
                                                                                          // )
                                                                                          ),
                                                                                      Expanded(
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          (minutesPassed > 1) ? 'ใช้งานเมื่อ $minutesPassed นาทีที่แล้ว' : ' ${userModels[index].connected}',
                                                                                          textAlign: TextAlign.center,
                                                                                          maxLines: 2,
                                                                                          style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        })),
                                                              ],
                                                            );
                                                          }),
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
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: RichText(
                                                        text: const TextSpan(
                                                          text: '**หมายเหตุ : ',
                                                          style: TextStyle(
                                                              color: AdminScafScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: ' สีเขียว ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' กำลังใช้งาน (ไม่เกิน 1 นาที) ,',
                                                              style: TextStyle(
                                                                  color: AdminScafScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                            TextSpan(
                                                              text: ' สีแดง ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' ใช้งานล่าสุด (ไม่เกิน 15 นาที)',
                                                              style: TextStyle(
                                                                  color: AdminScafScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                    height: 4.0,
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius: BorderRadius.only(
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK'),
                                                                  child:
                                                                      const Text(
                                                                    'ปิด',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
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
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.people,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          // decoration: const BoxDecoration(
                                          //   color: Colors.white,
                                          //   borderRadius: BorderRadius.only(
                                          //       topLeft: Radius.circular(20),
                                          //       topRight: Radius.circular(20),
                                          //       bottomLeft: Radius.circular(20),
                                          //       bottomRight: Radius.circular(20)),
                                          // ),
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            renTal_name == null
                                                ? '0'
                                                : '${userModels.length}',
                                            // '${userModels.length}***/$connected_Minutes/$ser_user/$email_user',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ))
                                  ],
                                )),
                          );
                        }),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 0)),
                          builder: (context, snapshot) {
                            return Text(
                              'สวัสดีคุณ $fname_user',
                              style: TextStyle(
                                  color: AdminScafScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                            );
                          }),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            title: const Center(
                                child: Text(
                              'ออกจากระบบ',
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButton(
                                              onPressed: () async {
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
                                              child: const Text(
                                                'ยืนยัน',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 100,
                                                decoration: const BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(10),
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
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                  child: const Text(
                                                    'ยกเลิก',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.logout_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        elevation: 0,
        backgroundColor: AppBarColors.ABar_Colors,
      ),
      drawer: SideBar(
        textStyle:
            const TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T),
        iconColor: Colors.white,
        backgroundColor: AppBarColors.ABar_Colors,
        items: [
          for (int i = 0; i < perMissionModels.length; i++)
            if (int.parse(perMissionModels[i].ser!) <= 3)
              AdminMenuItem(
                title: perMissionModels[i].perm!.trim(),
                route: '/${perMissionModels[i].perm!.trim()}',
                icon: IconData(
                  int.parse(
                    '${perMissionModels[i].icon}',
                  ),
                  fontFamily: 'MaterialIcons',
                ),
              ),
          AdminMenuItem(
            title: 'อื่นๆ',
            // icon: Icons.more_horiz,
            icon: IconData(
              int.parse(
                '0xf8d9',
              ),
              fontFamily: 'MaterialIcons',
            ),
            children: [
              for (int i = 0; i < perMissionModels.length; i++)
                if (int.parse(perMissionModels[i].ser!) > 3)
                  AdminMenuItem(
                    title: perMissionModels[i].perm!.trim(),
                    route: '/${perMissionModels[i].perm!.trim()}',
                    icon: IconData(
                      int.parse(
                        '${perMissionModels[i].icon}',
                      ),
                      fontFamily: 'MaterialIcons',
                    ),
                  ),
            ],
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) async {
          for (int i = 0; i < perMissionModels.length; i++) {
            if (item.route == '/${perMissionModels[i].perm!.trim()}') {
              if (renTal_user != null) {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString(
                    'route', perMissionModels[i].perm!.trim().toString());
                setState(() {
                  Value_Route = perMissionModels[i].perm!.trim();
                  print(Value_Route);
                  Navigator.pop(context);
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('กรุณาเลือกสถานที่ของท่านเพื่อเรียกดูข้อมูล')),
                );
              }
            }
          }
          // print(Value_Route);
        },
        header: Container(
          color: AppBarColors.ABar_Colors,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                ),
                child: const Image(
                  image: AssetImage('images/LOGO.png'),
                ),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    Value_Route = 'หน้าหลัก';
                    Navigator.pop(context);
                  });
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString('route', 'หน้าหลัก');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text(
                        'เมนูหลัก',
                        style: TextStyle(
                            color: AdminScafScreen_Color.Colors_Text1_,
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
        footer: Container(
          // height: 50,
          width: double.infinity,
          color: AppBarColors.ABar_Colors,
          child: Container(
            // height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
            ),
            child: Column(
              children: [
                renTal_lavel! <= 1
                    ? SizedBox()
                    : passcode == null
                        ? SizedBox()
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '$passcode',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.orange.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '© 2023  Dzentric Co.,Ltd. All Rights Reserved',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AdminScafScreen_Color.Colors_Text2_,
                          // fontWeight: FontWeight.bold,
                          fontFamily: Font_.Fonts_T,
                          fontSize: 10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: (Value_Route == 'หน้าหลัก')
          ? const HomeScreen()
          : (Value_Route == 'พื้นที่เช่า')
              ? const ChaoAreaScreen()
              : (Value_Route == 'ผู้เช่า')
                  ? const PeopleChaoScreen()
                  : (Value_Route == 'บัญชี')
                      ? const AccountScreen()
                      : (Value_Route == 'จัดการ')
                          ? const ManageScreen()
                          : (Value_Route == 'รายงาน' &&
                                  renTal_user.toString() == '65')
                              ? const Report_cm_Screen()
                              : (Value_Route == 'รายงาน' &&
                                      renTal_user.toString() != '65')
                                  ? ReportScreen()
                                  : (Value_Route == 'ทะเบียน')
                                      ? const BureauScreen()
                                      : (Value_Route == 'ตั้งค่า')
                                          ? const SettingScreen()
                                          : (Value_Route ==
                                                  'จัดการข้อมูลส่วนตัว')
                                              ? const Accessrights()
                                              : const Accessrights(),
    );
  }

  void routToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) {
      return false;
    });
  }
}
