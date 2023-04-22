import 'dart:async';
import 'dart:convert';

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
import '../Register/SignIn_Screen.dart';
import '../Register/SignUp_Screen.dart';
import '../Report/Report_Screen.dart';
import 'package:http/http.dart' as http;
import '../Responsive/responsive.dart';

import '../Setting/SettingScreen.dart';
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
      renTal_name;
  int? perMissioncount;
  List<RenTalModel> renTalModels = [];
  List<PerMissionModel> perMissionModels = [];
  List<AreakModel> areakModels = [];
  int? timeoutper = null;
  DateTime? alert;
  Timer? timer;
  bool isActive = false;
  String? rtname, type, typex, renname, pkname, ser_Zonex;
  int? pkqty, pkuser, countarae;
  String? base64_Imgmap, foder;
  String? tel_user, img_, img_logo;
  @override
///////////------------------------------------------->
  @override
  void initState() {
    super.initState();
    checkPreferance();
    signInThread();
    Value_Route = widget.route!;
    alert = DateTime.now().add(Duration(seconds: 300));
    readTime();
    read_GC_rental();
    read_GC_areak();
  }

  Future<Null> read_GC_areak() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/In_c_areak.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          AreakModel areakModel = AreakModel.fromJson(map);
        
          setState(() {
            areakModels.add(areakModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
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
          var foderx = renTalModel.dbn;
          var img = renTalModel.img;
          var imglogo = renTalModel.imglogo;
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
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
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
        print('Time Outttt $Value_Route $reached');
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
                  print('Times up!');
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

    print('perMissionModels  == > ${perMissionModels.length}');
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
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

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context))
      print(
          '$position_user, $fname_user, $lname_user,$email_user, $utype_user, $permission_user');
    setState(() {
      serBody_modile_wiget = 0;
    });
    if (perMissionModels.length < perMissioncount!) {
      return Center(
        child: const CircularProgressIndicator(),
      );
    }
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
                  return Row(
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
                              fontWeight: FontWeight.bold,
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
                  );
                }),
          ),
          actions: [
            Column(
              children: [
                Row(
                  children: [
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
                                                SharedPreferences preferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                preferences.clear();
                                                routToService(SignInScreen());
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
              ],
            ),
          ],
          elevation: 0,
          backgroundColor: AppBarColors.ABar_Colors,
        ),
        sideBar: SideBar(
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
              child: const Center(
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
                            : (Value_Route == 'รายงาน')
                                ? const ReportScreen()
                                : (Value_Route == 'ทะเบียน')
                                    ? const BureauScreen()
                                    : const SettingScreen());
  }

  void routToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
