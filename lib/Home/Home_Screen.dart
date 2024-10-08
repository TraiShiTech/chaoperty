// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_sheet/side_sheet.dart';

import '../Account/Account_Screen.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Manage/Manage_Screen.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetNote_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZoneAll_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_maintenance_model.dart';
import '../Model/Get_tenant_tow_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Register/SignIn_License.dart';
import '../Register/SignUp_Screen.dart';
import 'package:http/http.dart' as http;
import '../Responsive/responsive.dart';

import '../Setting/SettingScreen.dart';
import '../Setting/ttt.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import 'home_dashboard.dart';
import 'home_reservespace.dart';
import 'home_reservespace_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  final Form_note = TextEditingController();
  DateTime datex = DateTime.now();
  int serBody_modile_wiget = 0;
  List<RenTalModel> renTalModels = [];
  List<TeNantModel> teNantModels = [];
  List<TeNantTwoModel> teNantTwoModels = [];
  List<NoteModel> noteModels = [];
  List<CustomerModel> customerModels = [];
  List<TransReBillModel> _TransReBillModels = [];
  List<MaintenanceModel> maintenanceModels = [];
  String? renTal_user,
      renTal_name,
      sernote,
      pkldate,
      data_update,
      data_pn,
      renTal_utype;
  int app_port = 0, show_Dashboard = 0;
///////////------------------------------------------->
  @override
  void initState() {
    super.initState();
    read_GC_rental();
    checkPreferance();
    read_customer();
    read_GC_areaSelect();
    read_GC_note();
    red_Trans_bill();
    read_GC_tenantTwo();
    red_Trans_c_maintenance();
    Viewpagenow();
  }

  Future<Null> Viewpagenow() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var seremail_login = preferences.getString('ser');
    String url =
        '${MyConstant().domain}/Up_Viewpagenow.php?isAdd=true&ren=$ren&page=0&seruser=$seremail_login';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      if (result.toString() == 'true') {}
    } catch (e) {}
  }

  Future<Null> red_Trans_c_maintenance() async {
    if (maintenanceModels.length != 0) {
      setState(() {
        maintenanceModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_maintenance.php?isAdd=true&ren=$ren&serzone=0';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(map);
          setState(() {
            maintenanceModels.add(maintenanceModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> read_GC_tenantTwo() async {
    if (teNantTwoModels.isNotEmpty) {
      teNantTwoModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = '0';
    var zone_Sub = '0';

    String url = zone_Sub == null || zone_Sub == '0'
        ? zone == null
            ? '${MyConstant().domain}/GC_tenantAll_setring1.php?isAdd=true&ren=$ren&zone=$zone'
            : zone == '0'
                ? '${MyConstant().domain}/GC_tenantAll_setring1.php?isAdd=true&ren=$ren&zone=$zone'
                : '${MyConstant().domain}/GC_tenant_setring1.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == null
            ? '${MyConstant().domain}/GC_tenantAll_setring1_sub.php?isAdd=true&ren=$ren&zone=$zone_Sub'
            : zone == '0'
                ? '${MyConstant().domain}/GC_tenantAll_setring1_sub.php?isAdd=true&ren=$ren&zone=$zone_Sub'
                : '${MyConstant().domain}/GC_tenant_setring1.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantTwoModel teNantModel = TeNantTwoModel.fromJson(map);
          setState(() {
            if (teNantModel.count_bill != null) {
              var daterx = teNantModel.ldate;
              if (daterx != null) {
                int daysBetween(DateTime from, DateTime to) {
                  from = DateTime(from.year, from.month, from.day);
                  to = DateTime(to.year, to.month, to.day);
                  return (to.difference(from).inHours / 24).round();
                }

                var birthday = DateTime.parse('$daterx 00:00:00.000')
                    .add(const Duration(days: -30));
                var date2 = DateTime.now();
                var difference = daysBetween(birthday, date2);

                // print('difference == $difference');

                var daterx_now = DateTime.now();

                var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

                final now = DateTime.now();
                final earlier = daterx_ldate.subtract(const Duration(days: 0));
                var daterx_A = now.isAfter(earlier);
                // print(now.isAfter(earlier)); // true
                // print(now.isBefore(earlier)); // true

                if (daterx_A != true) {
                  setState(() {
                    teNantTwoModels.add(teNantModel);
                  });
                }
              }

              // setState(() {
              //   teNantModels.add(teNantModel);
              // });
            }
            // teNantModels.add(teNantModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> red_Trans_bill() async {
    if (_TransReBillModels.length != 0) {
      setState(() {
        _TransReBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          setState(() {
            _TransReBillModels.add(transReBillModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }

        // print('result ${_TransReBillModels.length}');
      }
    } catch (e) {}
  }

  Future<Null> read_GC_areaSelect() async {
    if (teNantModels.length != 0) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    String url =
        '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          var daterx = teNantModel.ldate == null
              ? teNantModel.ldate_q
              : teNantModel.ldate;

          if (daterx != null) {
            int daysBetween(DateTime from, DateTime to) {
              from = DateTime(from.year, from.month, from.day);
              to = DateTime(to.year, to.month, to.day);
              return (to.difference(from).inHours / 24).round();
            }

            var birthday = DateTime.parse('$daterx 00:00:00.000')
                .add(const Duration(days: -30));
            var date2 = DateTime.now();
            var difference = daysBetween(birthday, date2);

            // print('difference == $difference');

            var daterx_now = DateTime.now();

            var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

            final now = DateTime.now();
            final earlier = daterx_ldate.subtract(const Duration(days: 30));
            var daterx_A = now.isAfter(earlier);
            // print(now.isAfter(earlier)); // true
            // print(now.isBefore(earlier)); // true
            if (difference <= 30 && difference > 0) {
              setState(() {
                if (teNantModel.quantity == '1') {
                  teNantModels.add(teNantModel);
                }
              });
            }
            // if (daterx_A == true) {
            //   setState(() {
            //     teNantModels.add(teNantModel);
            //   });
            // }
          }
        }

        // print('00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_note() async {
    if (noteModels.length != 0) {
      noteModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ser_user = preferences.getString('ser');

    String url =
        '${MyConstant().domain}/GC_Note.php?isAdd=true&ren=$ren&ser_user=$ser_user';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          NoteModel noteModel = NoteModel.fromJson(map);
          setState(() {
            noteModels.add(noteModel);
            Form_note.text = noteModel.descr.toString();
            sernote = noteModel.ser.toString();
          });
        }

        // print('00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
      } else {}
    } catch (e) {}
  }

  Future<Null> read_customer() async {
    if (customerModels.isNotEmpty) {
      setState(() {
        customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? serzone = preferences.getString('zoneSer');
    // print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>>>>>>>>>>>>>>>>>>>>>>>>> $serzone');
    String url =
        '${MyConstant().domain}/GC_custo_home.php?isAdd=true&ren=$ren&ser_zone$serzone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            customerModels.add(customerModel);
          });
        }
      }
      // print(customerModels.map((e) => e.scname));
    } catch (e) {}
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      renTal_utype = preferences.getString('utype');
    });
  }

  Future<Null> read_GC_rental() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var seruser = preferences.getString('ser');
    var utype = preferences.getString('utype');
    var renTal = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype&ren=$renTal';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('GC_rental>>> $result');
      for (var map in result) {
        RenTalModel renTalModel = RenTalModel.fromJson(map);
        var pksdatex = renTalModel.pksdate;
        var pkldatex = renTalModel.pkldate;
        var data_updatex = renTalModel.data_update;
        var data_pnx = renTalModel.pn;
        setState(() {
          pkldate = pkldatex;
          data_update = data_updatex;
          data_pn = data_pnx;
          renTalModels.add(renTalModel);
        });
      }
    } catch (e) {}

    readupdate();
  }

  Future<Null> readupdate() async {
    print('$pkldate 0000-00-00  data_update >> $data_update');
    if (datex.isAfter(DateTime.parse(pkldate == '0000-00-00'
                ? '$data_update'
                : '$pkldate 00:00:00.000')
            .subtract(const Duration(days: 7))) ==
        true) {
      License_New_Update();
      // MaterialPageRoute route = MaterialPageRoute(
      //   builder: (context) => SignInLicense(route: 'No'),
      // );
      // Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else if (datex.isAfter(DateTime.parse(pkldate == '0000-00-00'
                ? '$data_update'
                : '$pkldate 00:00:00.000')
            .subtract(const Duration(days: 0))) ==
        true) {
      MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => SignInLicense(route: 'No'),
      );
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      // License_New_Update();
    }
  }

  Future<Null> License_New_Update() async {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(
          '📢 Plese Update License Key',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.red,
            fontFamily: Font_.Fonts_T,
          ),
        ),
        content: Container(
          // decoration: BoxDecoration(
          //   image: const DecorationImage(
          //     image: AssetImage("images/pngegg.png"),
          //     // fit: BoxFit.cover,
          //   ),
          // ),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'พื้นที่ $data_pn ของคุณจะหมดอายุ',
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
                    '${DateFormat.MMMMEEEEd('th').format(DateTime.parse(pkldate == '0000-00-00' ? '$data_update' : '$pkldate 00:00:00.000'))} ${int.parse(DateFormat('yyyy').format(DateTime.parse(pkldate == '0000-00-00' ? '$data_update' : '$pkldate 00:00:00.000'))) + 543}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'คำแนะนำ กรุณาต่อ License Key เพื่อการใช้งานต่อไป',
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
                      Navigator.pop(context, 'OK');
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
          //         ],
          //       );
          //     })
        ],
      ),
    );
  }

//////////------------------------------------------------->
  // Future<Null> readMBSetting() async {
  //   if (mBSettingModels.length != 0) {
  //     mBSettingModels.clear();
  //     mBSettingModels.clear();
  //   }
  //   // String url = 'http://localhost/API/getItem.php';

  //   String url = "${MyConstant().domain}/GetMBSetting.php";
  //   //String url = 'https://mbstar.co.th/API/GetCar.php';
  //   await http.get(Uri.parse(url)).then((value) {
  //     if (value.toString() != 'null') {
  //       var result = json.decode(value.body);
  //       for (var item in result) {
  //         //print(result);
  //         MBSettingModel mBSettingModelss = MBSettingModel.fromJson(item);
  //         setState(() {
  //           mBSettingModels.add(mBSettingModelss);
  //         });
  //       }

  //       //print('mBSettingModels');
  //       //print('${mBSettingModels.length}');
  //     } else {
  //       // print('no');
  //     }
  //   });
  // }

//////////---------------------------------------------------->
  String tappedIndex_1 = '';
  String tappedIndex_2 = '';
  String tappedIndex_3 = '';
  String tappedIndex_4 = '';
  String tappedIndex_5 = '';
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();
  ScrollController _scrollController4 = ScrollController();
  ScrollController _scrollController5 = ScrollController();

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///----------------->
  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///----------------->
  _moveUp3() {
    _scrollController3.animateTo(_scrollController3.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown3() {
    _scrollController3.animateTo(_scrollController3.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///----------------->
  _moveUp4() {
    _scrollController4.animateTo(_scrollController4.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown4() {
    _scrollController4.animateTo(_scrollController4.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///----------------->
  _moveUp5() {
    _scrollController5.animateTo(_scrollController5.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown5() {
    _scrollController5.animateTo(_scrollController5.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

//////////---------------------------------------------------->
  // List Area_ = [
  //   'คอมมูนิตี้มอลล์',
  //   'ออฟฟิศให้เช่า',
  //   'ตลาดนัด',
  //   'อื่นๆ',
  // ];

///////////--------------------------------------------->
  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context))
      setState(() {
        serBody_modile_wiget = 0;
      });
    return (!Responsive.isDesktop(context))
        ? show_Dashboard == 1
            ? const HomeDashboard()
            : show_Dashboard == 2
                ? HomeReserveSpace()
                : show_Dashboard == 3
                    ? Homereservespace_calendar()
                    : BodyHome_mobile()
        : show_Dashboard == 1
            ? const HomeDashboard()
            : show_Dashboard == 2
                ? HomeReserveSpace()
                : show_Dashboard == 3
                    ? Homereservespace_calendar()
                    : BodyHome_Web();
    // return (!Responsive.isDesktop(context))
    //     ? show_Dashboard == 1
    //         ? const HomeDashboard()
    //         :  show_Dashboard == 2
    //         ? HomeReserveSpace():BodyHome_mobile()
    //     : show_Dashboard == 1
    //         ? const HomeDashboard()
    //         :  show_Dashboard == 2
    //         ? HomeReserveSpace(): BodyHome_Web();
  }

/////////////---------------------------------------------------------->
  Widget BodyHome_Web() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: SizedBox(
          // flex: 1,
          child: Container(
            child: Column(
              children: [
                if (Responsive.isDesktop(context))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                show_Dashboard = 1;
                              });

                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              var name = preferences.getString('fname');
                              Insert_log.Insert_logs(
                                  'หน้าหลัก', '$name>Dashboard');
                            },
                            child: Container(
                                width: 130,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: AppBarColors.hexColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                child: Center(
                                  child: Translate.TranslateAndSetText(
                                      'แดชบอร์ด',
                                      Colors.white,
                                      TextAlign.center,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      14,
                                      1),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                show_Dashboard = 2;
                              });
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              var name = preferences.getString('fname');
                              Insert_log.Insert_logs(
                                  'หน้าหลัก', '$name>Reserve Space');
                            },
                            child: Container(
                                width: 130,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: AppBarColors.hexColor.withOpacity(0.8),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                child: Center(
                                  child: Translate.TranslateAndSetText(
                                      'จองล็อกเสียบ/พื้นที่สำรอง',
                                      Colors.white,
                                      TextAlign.center,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      14,
                                      1),
                                )),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 2,
                      //   child: Padding(
                      //     padding: EdgeInsets.all(4.0),
                      //     child: InkWell(
                      //       onTap: () async {
                      //         setState(() {
                      //           show_Dashboard = 3;
                      //         });

                      //         SharedPreferences preferences =
                      //             await SharedPreferences.getInstance();
                      //         var name = preferences.getString('fname');
                      //         Insert_log.Insert_logs(
                      //             'หน้าหลัก', '$name>Reserve Space Calendar');
                      //       },
                      //       child: Container(
                      //           width: 130,
                      //           padding: const EdgeInsets.all(8.0),
                      //           decoration: BoxDecoration(
                      //             color: AppBarColors.hexColor.withOpacity(0.8),
                      //             borderRadius: const BorderRadius.only(
                      //                 topLeft: Radius.circular(8),
                      //                 topRight: Radius.circular(8),
                      //                 bottomLeft: Radius.circular(8),
                      //                 bottomRight: Radius.circular(8)),
                      //             border:
                      //                 Border.all(color: Colors.white, width: 1),
                      //           ),
                      //           child: const Center(
                      //             child: Text(
                      //               'Reserve Space Calendar',
                      //               style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontFamily: FontWeight_.Fonts_T,
                      //               ),
                      //             ),
                      //           )),
                      //     ),
                      //   ),
                      // ),
                      Expanded(flex: 4, child: SizedBox()),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Translate.TranslateAndSetText(
                              'เลือกสถานที่/Portfolio',
                              HomeScreen_Color.Colors_Text1_,
                              TextAlign.end,
                              FontWeight.bold,
                              FontWeight_.Fonts_T,
                              14,
                              1),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            width: 200,
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              isExpanded: true,
                              hint: Translate.TranslateAndSetText(
                                  renTal_name == null
                                      ? 'ค้นหา'
                                      : '$renTal_name',
                                  HomeScreen_Color.Colors_Text2_,
                                  TextAlign.center,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  14,
                                  1),

                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              style: const TextStyle(
                                color: Colors.green,
                                fontFamily: Font_.Fonts_T,
                              ),
                              iconSize: 30,
                              buttonHeight: 40,
                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              items: renTalModels
                                  .map((item) => DropdownMenuItem<String>(
                                        value: '${item.ser},${item.pn}',
                                        child: Text(
                                          item.pn!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color:
                                                HomeScreen_Color.Colors_Text2_,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ))
                                  .toList(),

                              onChanged: (value) async {
                                var renTals = value!.indexOf(',');
                                var renTalSer = value.substring(0, renTals);
                                var renTalName = value.substring(renTals + 1);
                                print(
                                    'mmmmm ${renTalSer.toString()} $renTalName');

                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setString(
                                    'renTalSer', renTalSer.toString());
                                preferences.setString(
                                    'renTalName', renTalName.toString());
                                String? _route = preferences.getString('route');

                                preferences.remove('zoneSer');
                                preferences.remove('zonesName');
                                preferences.remove('zonePSer');
                                preferences.remove('zonesPName');

                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) =>
                                      AdminScafScreen(route: _route),
                                );
                                Navigator.pushAndRemoveUntil(
                                    context, route, (route) => false);
                              },
                              // onSaved: (value) {
                              //   // selectedValue = value.toString();
                              // },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                renTal_user == null
                    ? SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.4,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                        child: Translate.TranslateAndSetText(
                                            'กรุณาเลือกสถานที่',
                                            HomeScreen_Color.Colors_Text2_,
                                            TextAlign.center,
                                            FontWeight.bold,
                                            FontWeight_.Fonts_T,
                                            16,
                                            1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                      color: Colors.transparent,
                                      child: GridView.count(
                                        crossAxisCount:
                                            (Responsive.isDesktop(context))
                                                ? 8
                                                : 4,
                                        children: [
                                          Card(
                                              color:
                                                  AppbackgroundColor.Abg_Colors,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    app_port = 1;
                                                  });
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(50),
                                                              topRight: Radius
                                                                  .circular(50),
                                                              bottomLeft: Radius
                                                                  .circular(50),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          50)),
                                                    ),
                                                    // color: Colors.white,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    height: 50,
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(Icons.add)
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Translate.TranslateAndSet_TextAutoSize(
                                                                'เพิ่มสถานที่',
                                                                HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                TextAlign
                                                                    .center,
                                                                FontWeight.bold,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                8,
                                                                20,
                                                                1),
                                                          ],
                                                        ),
                                                      ],
                                                    ))),
                                              )),
                                          for (int i = 0;
                                              i < renTalModels.length;
                                              i++)
                                            Card(
                                                color: AppbackgroundColor
                                                    .Abg_Colors,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: InkWell(
                                                  onTap: () async {
                                                    var renTalSer =
                                                        renTalModels[i].ser;
                                                    var renTalName =
                                                        renTalModels[i].pn;
                                                    print(
                                                        'mmmmm ${renTalSer.toString()} $renTalName');

                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    preferences.setString(
                                                        'renTalSer',
                                                        renTalSer.toString());
                                                    preferences.setString(
                                                        'renTalName',
                                                        renTalName.toString());
                                                    String? _route = preferences
                                                        .getString('route');

                                                    preferences
                                                        .remove('zoneSer');
                                                    preferences
                                                        .remove('zonesName');
                                                    preferences
                                                        .remove('zonePSer');
                                                    preferences
                                                        .remove('zonesPName');

                                                    MaterialPageRoute route =
                                                        MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminScafScreen(
                                                              route: _route),
                                                    );
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            route,
                                                            (route) => false);
                                                  },
                                                  child: Container(
                                                      // color: Colors.green.shade200,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .green.shade200,
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(50),
                                                            topRight:
                                                                Radius.circular(
                                                                    50),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    50),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50)),
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                      height: 50,
                                                      child: renTalModels[i]
                                                                      .imglogo ==
                                                                  null ||
                                                              renTalModels[i]
                                                                      .imglogo ==
                                                                  'null'
                                                          ? Center(
                                                              child:
                                                                  AutoSizeText(
                                                              '${renTalModels[i].pn}',
                                                              minFontSize: 10,
                                                              maxFontSize: 18,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                // fontSize: 20,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                              ),
                                                              maxLines: 4,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ))
                                                          : Center(
                                                              child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                renTalModels[i].imglogo ==
                                                                            null ||
                                                                        renTalModels[i].imglogo ==
                                                                            'null'
                                                                    ? SizedBox()
                                                                    : Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          // Container(
                                                                          //   width: 100,
                                                                          //   height: 60,
                                                                          //   decoration: BoxDecoration(
                                                                          //     image: DecorationImage(
                                                                          //       image: NetworkImage('${MyConstant().domain}/files/${renTalModels[i].dbn}/logo/${renTalModels[i].imglogo}'),
                                                                          //     ),
                                                                          //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                          //   ),
                                                                          // ),
                                                                          CircleAvatar(
                                                                            radius:
                                                                                25,
                                                                            backgroundImage:
                                                                                NetworkImage('${MyConstant().domain}/files/${renTalModels[i].dbn}/logo/${renTalModels[i].imglogo}'),
                                                                            backgroundColor:
                                                                                Colors.transparent,
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
                                                                    AutoSizeText(
                                                                      '${renTalModels[i].pn}',
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          18,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        // fontSize: 20,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                      ),
                                                                      maxLines:
                                                                          4,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    if (datex.isAfter(DateTime.parse(renTalModels[i].pkldate == '0000-00-00' ? '${renTalModels[i].data_update}' : '${renTalModels[i].pkldate} 00:00:00.000').subtract(const Duration(days: 0))) == true)
                                                                      Translate.TranslateAndSet_TextAutoSize(
                                                                          'หมดอายุ',
                                                                          HomeScreen_Color
                                                                              .Colors_Text2_,
                                                                          TextAlign
                                                                              .center,
                                                                          FontWeight
                                                                              .bold,
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                          8,
                                                                          20,
                                                                          1)
                                                                    else if (datex.isAfter(DateTime.parse(renTalModels[i].pkldate == '0000-00-00' ? '${renTalModels[i].data_update}' : '${renTalModels[i].pkldate} 00:00:00.000').subtract(const Duration(
                                                                            days:
                                                                                7))) ==
                                                                        true)
                                                                      Translate.TranslateAndSet_TextAutoSize(
                                                                          'ใกล้หมดอายุ',
                                                                          HomeScreen_Color
                                                                              .Colors_Text2_,
                                                                          TextAlign
                                                                              .center,
                                                                          FontWeight
                                                                              .bold,
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                          8,
                                                                          20,
                                                                          1)
                                                                  ],
                                                                )
                                                              ],
                                                            ))),
                                                )),
                                        ],
                                      )),
                                  (app_port == 1)
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Body4(),
                                            )
                                          ],
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 4, 0, 4),
                                        child: Container(
                                            // width: MediaQuery.of(context)
                                            //     .size
                                            //     .width,
                                            decoration: BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
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
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    // Icon(
                                                    //   Icons
                                                    //       .settings_input_composite,
                                                    //   color: Colors.white,
                                                    // ),
                                                    Translate
                                                        .TranslateAndSet_TextAutoSize(
                                                            'โน๊ตส่วนตัว',
                                                            HomeScreen_Color
                                                                .Colors_Text2_,
                                                            TextAlign.center,
                                                            FontWeight.bold,
                                                            FontWeight_.Fonts_T,
                                                            8,
                                                            20,
                                                            1)
                                                  ],
                                                ),
                                                const Icon(
                                                  Icons.menu_book,
                                                  // Icons.next_plan,
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                )
                                              ],
                                            )),
                                      ),
                                      Container(
                                          // width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: AppbackgroundColor
                                                .TiTile_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                          ),
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Translate
                                                      .TranslateAndSet_TextAutoSize(
                                                          'รายละเอียด',
                                                          HomeScreen_Color
                                                              .Colors_Text2_,
                                                          TextAlign.center,
                                                          FontWeight.bold,
                                                          FontWeight_.Fonts_T,
                                                          8,
                                                          20,
                                                          1)),
                                            ],
                                          )),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 300,
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                            ),
                                            // border: Border.all(
                                            //     color: Colors.grey, width: 1),
                                          ),
                                          child: TextFormField(
                                            // keyboardType: TextInputType.name,
                                            controller: Form_note,
                                            // onChanged: (value) =>
                                            //     _Form_nameshop = value.trim(),
                                            //initialValue: _Form_nameshop,
                                            onFieldSubmitted: (value) async {
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();

                                              var ren = preferences
                                                  .getString('renTalSer');
                                              var ser_user =
                                                  preferences.getString('ser');

                                              var note = Form_note.text;

                                              String url =
                                                  '${MyConstant().domain}/UDC_Note.php?isAdd=true&ren=$ren&ser_user=$ser_user&sernote=$sernote';

                                              try {
                                                var response = await http.post(
                                                    Uri.parse(url),
                                                    body: {
                                                      'note': value.toString(),
                                                    }).then((value) async {
                                                  print('$value');
                                                  // var result = json.decode(value.body);
                                                  // print('$result ');
                                                  var result =
                                                      json.decode(value.body);
                                                  print(result);
                                                  if (result.toString() ==
                                                      'true') {
                                                    setState(() {
                                                      read_GC_note();
                                                    });

                                                    print(
                                                        '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                                  } else {}
                                                });

                                                // var response = await http
                                                //     .get(Uri.parse(url));

                                                var result =
                                                    json.decode(response.body);
                                                print(result);
                                                if (result.toString() ==
                                                    'true') {
                                                  setState(() {
                                                    read_GC_note();
                                                  });

                                                  print(
                                                      '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                                } else {}
                                                // var response = await http
                                                //     .get(Uri.parse(url));

                                                // var result =
                                                //     json.decode(response.body);
                                                // print(result);
                                                // if (result.toString() ==
                                                //     'null') {
                                                //   setState(() {
                                                //     read_GC_note();
                                                //   });

                                                //   print(
                                                //       '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                                // } else {}
                                              } catch (e) {}
                                            },
                                            maxLines: 100,
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
                                                // labelText: 'ระบุชื่อร้านค้า',
                                                labelStyle: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                )),
                                          ),
                                          // ListView.builder(
                                          //   controller: _scrollController5,
                                          //   // itemExtent: 50,
                                          //   physics:
                                          //       const NeverScrollableScrollPhysics(),
                                          //   shrinkWrap: true,
                                          //   itemCount: noteModels.length,
                                          //   itemBuilder: (BuildContext context,
                                          //       int index) {
                                          //     return Container(
                                          //       color: tappedIndex_5 ==
                                          //               index.toString()
                                          //           ? tappedIndex_Color
                                          //               .tappedIndex_Colors
                                          //               .withOpacity(0.5)
                                          //           : null,
                                          //       child: ListTile(
                                          //         onTap: () {
                                          //           setState(() {
                                          //             tappedIndex_1 = '';
                                          //             tappedIndex_2 = '';
                                          //             tappedIndex_3 = '';
                                          //             tappedIndex_4 = '';
                                          //             tappedIndex_5 =
                                          //                 index.toString();
                                          //           });
                                          //         },
                                          //         title: Text(
                                          //           'Note ${index + 1}',
                                          //           maxLines: 1,
                                          //           overflow:
                                          //               TextOverflow.ellipsis,
                                          //           style: const TextStyle(
                                          //             color: HomeScreen_Color
                                          //                 .Colors_Text2_,

                                          //             fontFamily: Font_.Fonts_T,

                                          //             //fontSize: 10.0
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          // ),
                                        ),
                                      ),
                                      Container(
                                        // width: MediaQuery.of(context).size.width,
                                        // height: 40,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: InkWell(
                                                onTap: () async {
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  var ren = preferences
                                                      .getString('renTalSer');
                                                  var ser_user = preferences
                                                      .getString('ser');

                                                  var note = Form_note.text;

                                                  String url =
                                                      '${MyConstant().domain}/UDC_Note.php?isAdd=true&ren=$ren&ser_user=$ser_user&sernote=$sernote';

                                                  try {
                                                    var response = await http
                                                        .post(Uri.parse(url),
                                                            body: {
                                                          'note':
                                                              note.toString(),
                                                        }).then((value) async {
                                                      // print('$value');
                                                      // var result = json.decode(value.body);
                                                      // print('$result ');
                                                      var result = json
                                                          .decode(value.body);
                                                      print(result);
                                                      if (result.toString() ==
                                                          'true') {
                                                        setState(() {
                                                          read_GC_note();
                                                        });
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  'บันทึกสำเร็จ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T))),
                                                        );

                                                        print(
                                                            '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                                      }
                                                    });

                                                    // var response = await http
                                                    //     .get(Uri.parse(url));

                                                    var result = json
                                                        .decode(response.body);
                                                    print(result);
                                                    if (result.toString() ==
                                                        'null') {
                                                      setState(() {
                                                        read_GC_note();
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                'บันทึกสำเร็จ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T))),
                                                      );

                                                      print(
                                                          '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                                    } else {
                                                      print(
                                                          '00000000>>>>>>>>>>>>>>>>> no nost');
                                                    }
                                                  } catch (e) {}
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: AppbackgroundColor
                                                            //     .TiTile_Colors,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                topRight: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            6)),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: const Center(
                                                            child: Text(
                                                              'Save',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10.0,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
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
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 4, 0, 4),
                                                    child: Container(
                                                        // width: MediaQuery.of(context)
                                                        //     .size
                                                        //     .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                          borderRadius: const BorderRadius
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
                                                                          10)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Icon(
                                                                //   Icons
                                                                //       .settings_input_composite,
                                                                //   color: Colors.white,
                                                                // ),

                                                                Tooltip(
                                                                  richMessage:
                                                                      TextSpan(
                                                                    text:
                                                                        'ทั้งหมด : ${customerModels.length} รายการ',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: HomeScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: Colors
                                                                            .lightGreen[
                                                                        200],
                                                                  ),
                                                                  child:
                                                                      InkWell(
                                                                    child: Translate.TranslateAndSetText(
                                                                        'รายการรอทำสัญญา',
                                                                        HomeScreen_Color
                                                                            .Colors_Text2_,
                                                                        TextAlign
                                                                            .center,
                                                                        FontWeight
                                                                            .bold,
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                        16,
                                                                        1),
                                                                    onTap:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Icon(
                                                              // Icons.next_plan,
                                                              Icons.handshake,
                                                              color: HomeScreen_Color
                                                                  .Colors_Text1_,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'โซนพื้นที่',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                              // Text(
                                                              //   'โซนพื้นที่',
                                                              //   style: TextStyle(
                                                              //     color: Colors.black,
                                                              //     fontWeight:
                                                              //         FontWeight.bold,
                                                              //     //fontSize: 10.0
                                                              //   ),
                                                              // ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'รหัสพื้นที่',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),

                                                              // Text(
                                                              //   'รหัสพื้นที่',
                                                              //   style: TextStyle(
                                                              //     color: Colors.black,
                                                              //     fontWeight:
                                                              //         FontWeight.bold,
                                                              //     //fontSize: 10.0
                                                              //   ),
                                                              // ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'ร้านค้า',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),

                                                              //  Text(
                                                              //   'ร้านค้า',
                                                              //   style: TextStyle(
                                                              //     color: Colors.black,
                                                              //     fontWeight:
                                                              //         FontWeight.bold,
                                                              //     //fontSize: 10.0
                                                              //   ),
                                                              // ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'ขนาดพื้นที่(ตร.ม.)',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),

                                                              //  Text(
                                                              //   'ขนาดพื้นที่(ต.ร.ม.)',
                                                              //   style: TextStyle(
                                                              //     color: Colors.black,
                                                              //     fontWeight:
                                                              //         FontWeight.bold,
                                                              //     //fontSize: 10.0
                                                              //   ),
                                                              // ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'วันนัดหมาย',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),

                                                              // Text(
                                                              //   'วันนัดหมาย',
                                                              //   style: TextStyle(
                                                              //     color: Colors.black,
                                                              //     fontWeight:
                                                              //         FontWeight.bold,
                                                              //     //fontSize: 10.0
                                                              //   ),
                                                              // ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      height: 300,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
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
                                                      child: ListView.builder(
                                                        controller:
                                                            _scrollController1,
                                                        // itemExtent: 50,
                                                        physics:
                                                            const AlwaysScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            customerModels
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Material(
                                                            color: tappedIndex_1 ==
                                                                    index
                                                                        .toString()
                                                                ? tappedIndex_Color
                                                                    .tappedIndex_Colors
                                                                : AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                            child: Container(
                                                              // color: tappedIndex_1 ==
                                                              //         index
                                                              //             .toString()
                                                              //     ? tappedIndex_Color
                                                              //         .tappedIndex_Colors
                                                              //         .withOpacity(
                                                              //             0.5)
                                                              //     : null,
                                                              child: ListTile(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      tappedIndex_1 =
                                                                          index
                                                                              .toString();
                                                                      tappedIndex_2 =
                                                                          '';
                                                                      tappedIndex_3 =
                                                                          '';
                                                                      tappedIndex_4 =
                                                                          '';
                                                                      tappedIndex_5 =
                                                                          '';
                                                                    });
                                                                  },
                                                                  title:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.black12,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            '${customerModels[index].zn}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${customerModels[index].ln}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            child:
                                                                                AutoSizeText(
                                                                              minFontSize: 10,
                                                                              maxFontSize: 25,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              '${customerModels[index].ln}',
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${customerModels[index].scname}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            child:
                                                                                AutoSizeText(
                                                                              minFontSize: 10,
                                                                              maxFontSize: 25,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              '${customerModels[index].scname}',
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            '${nFormat.format(double.parse(customerModels[index].area!))}',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                          // Text(
                                                                          //   '${customerModels[index].area}',
                                                                          //   style: TextStyle(
                                                                          //     color: TextHome_Color
                                                                          //         .TextHome_Colors,

                                                                          //     //fontSize: 10.0
                                                                          //   ),
                                                                          // ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${customerModels[index].sdate} 00:00:00'))}',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      // width: MediaQuery.of(context).size.width,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      _scrollController1
                                                                          .animateTo(
                                                                        0,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                        curve: Curves
                                                                            .easeOut,
                                                                      );
                                                                    },
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                          // color: AppbackgroundColor
                                                                          //     .TiTile_Colors,
                                                                          borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(6),
                                                                              topRight: Radius.circular(6),
                                                                              bottomLeft: Radius.circular(6),
                                                                              bottomRight: Radius.circular(8)),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: const Text(
                                                                          'Top',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize:
                                                                                10.0,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (_scrollController1
                                                                        .hasClients) {
                                                                      final position = _scrollController1
                                                                          .position
                                                                          .maxScrollExtent;
                                                                      _scrollController1
                                                                          .animateTo(
                                                                        position,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                        curve: Curves
                                                                            .easeOut,
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        // color: AppbackgroundColor
                                                                        //     .TiTile_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(6),
                                                                            topRight: Radius.circular(6),
                                                                            bottomLeft: Radius.circular(6),
                                                                            bottomRight: Radius.circular(6)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(3.0),
                                                                      child: const Text(
                                                                        'Down',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              10.0,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      _moveUp1,
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_upward,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      )),
                                                                ),
                                                                Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // color: AppbackgroundColor
                                                                      //     .TiTile_Colors,
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              6),
                                                                          topRight: Radius.circular(
                                                                              6),
                                                                          bottomLeft: Radius.circular(
                                                                              6),
                                                                          bottomRight:
                                                                              Radius.circular(6)),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            3.0),
                                                                    child:
                                                                        const Text(
                                                                      'Scroll',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            10.0,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                InkWell(
                                                                  onTap:
                                                                      _moveDown1,
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_downward,
                                                                          color:
                                                                              Colors.grey,
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
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 4, 0, 4),
                                                    child: Container(
                                                        // width: MediaQuery.of(context)
                                                        //     .size
                                                        //     .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                          borderRadius: const BorderRadius
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
                                                                          10)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Icon(
                                                                //   Icons
                                                                //       .settings_input_composite,
                                                                //   color: Colors.white,
                                                                // ),

                                                                Tooltip(
                                                                  richMessage:
                                                                      TextSpan(
                                                                    text:
                                                                        'ทั้งหมด : ${maintenanceModels.length} รายการ',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: HomeScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: Colors
                                                                            .lightGreen[
                                                                        200],
                                                                  ),
                                                                  child:
                                                                      InkWell(
                                                                    child: Translate.TranslateAndSet_TextAutoSize(
                                                                        'รายการแจ้งซ่อม',
                                                                        HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        TextAlign
                                                                            .start,
                                                                        FontWeight
                                                                            .bold,
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                        8,
                                                                        20,
                                                                        1),
                                                                    onTap:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Icon(
                                                              // Icons.next_plan,
                                                              Icons
                                                                  .build_rounded,
                                                              color: HomeScreen_Color
                                                                  .Colors_Text1_,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'ร้านค้า',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'รหัสพื้นที่',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'รายละเอียด',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'วันแจ้งซ่อม',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'สถานะ',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign.end,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      height: 300,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
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
                                                      child: ListView.builder(
                                                        controller:
                                                            _scrollController2,
                                                        // itemExtent: 50,
                                                        // physics:
                                                        //     const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            maintenanceModels
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Material(
                                                            color: tappedIndex_2 ==
                                                                    index
                                                                        .toString()
                                                                ? tappedIndex_Color
                                                                    .tappedIndex_Colors
                                                                : AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                            child: Container(
                                                              // color: tappedIndex_2 ==
                                                              //         index
                                                              //             .toString()
                                                              //     ? tappedIndex_Color
                                                              //         .tappedIndex_Colors
                                                              //         .withOpacity(
                                                              //             0.5)
                                                              //     : null,
                                                              child: ListTile(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      tappedIndex_1 =
                                                                          '';
                                                                      tappedIndex_2 =
                                                                          index
                                                                              .toString();
                                                                      tappedIndex_3 =
                                                                          '';
                                                                      tappedIndex_4 =
                                                                          '';
                                                                      tappedIndex_5 =
                                                                          '';
                                                                    });
                                                                  },
                                                                  title:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.black12,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${maintenanceModels[index].sname}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              '${maintenanceModels[index].sname}',
                                                                              textAlign: TextAlign.start,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${maintenanceModels[index].aser}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              '${maintenanceModels[index].aser}',
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.start,
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Text(
                                                                            '${maintenanceModels[index].mdescr}',
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Text(
                                                                            '${DateFormat('dd-MM').format((DateTime.parse('${maintenanceModels[index].mdate} 00:00:00')))}-${DateTime.parse('${maintenanceModels[index].mdate} 00:00:00').year + 543}',
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.white10,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            child: Translate.TranslateAndSet_TextAutoSize(
                                                                                maintenanceModels[index].mst == '0'
                                                                                    ? ' '
                                                                                    : maintenanceModels[index].mst == '1'
                                                                                        ? 'รอดำเนินการ'
                                                                                        : 'เสร็จสิ้น',
                                                                                HomeScreen_Color.Colors_Text1_,
                                                                                TextAlign.end,
                                                                                FontWeight.bold,
                                                                                FontWeight_.Fonts_T,
                                                                                8,
                                                                                20,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      // width: MediaQuery.of(context).size.width,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      _scrollController2
                                                                          .animateTo(
                                                                        0,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                        curve: Curves
                                                                            .easeOut,
                                                                      );
                                                                    },
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                          // color: AppbackgroundColor
                                                                          //     .TiTile_Colors,
                                                                          borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(6),
                                                                              topRight: Radius.circular(6),
                                                                              bottomLeft: Radius.circular(6),
                                                                              bottomRight: Radius.circular(8)),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: const Text(
                                                                          'Top',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize:
                                                                                10.0,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (_scrollController2
                                                                        .hasClients) {
                                                                      final position = _scrollController2
                                                                          .position
                                                                          .maxScrollExtent;
                                                                      _scrollController2
                                                                          .animateTo(
                                                                        position,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                        curve: Curves
                                                                            .easeOut,
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        // color: AppbackgroundColor
                                                                        //     .TiTile_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(6),
                                                                            topRight: Radius.circular(6),
                                                                            bottomLeft: Radius.circular(6),
                                                                            bottomRight: Radius.circular(6)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(3.0),
                                                                      child: const Text(
                                                                        'Down',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              10.0,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      _moveUp2,
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_upward,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      )),
                                                                ),
                                                                Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // color: AppbackgroundColor
                                                                      //     .TiTile_Colors,
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              6),
                                                                          topRight: Radius.circular(
                                                                              6),
                                                                          bottomLeft: Radius.circular(
                                                                              6),
                                                                          bottomRight:
                                                                              Radius.circular(6)),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            3.0),
                                                                    child:
                                                                        const Text(
                                                                      'Scroll',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              10.0),
                                                                    )),
                                                                InkWell(
                                                                  onTap:
                                                                      _moveDown2,
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_downward,
                                                                          color:
                                                                              Colors.grey,
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
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 4, 0, 4),
                                                    child: Container(
                                                        // width: MediaQuery.of(context)
                                                        //     .size
                                                        //     .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                          borderRadius: const BorderRadius
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
                                                                          10)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Icon(
                                                                //   Icons
                                                                //       .settings_input_composite,
                                                                //   color: Colors.white,
                                                                // ),

                                                                Tooltip(
                                                                  richMessage:
                                                                      TextSpan(
                                                                    text:
                                                                        'ทั้งหมด : ${teNantModels.length} รายการ',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: HomeScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: Colors
                                                                            .lightGreen[
                                                                        200],
                                                                  ),
                                                                  child:
                                                                      InkWell(
                                                                    child: Translate.TranslateAndSet_TextAutoSize(
                                                                        'พื้นที่ใกล้หมดสัญญา',
                                                                        HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        TextAlign
                                                                            .start,
                                                                        FontWeight
                                                                            .bold,
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                        8,
                                                                        20,
                                                                        1),
                                                                    onTap:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Icon(
                                                              // Icons.next_plan,
                                                              Icons.map,
                                                              color: HomeScreen_Color
                                                                  .Colors_Text1_,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'โซนพื้นที่',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                child: Translate.TranslateAndSet_TextAutoSize(
                                                                    'รหัสพื้นที่',
                                                                    HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .center,
                                                                    FontWeight
                                                                        .bold,
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                    8,
                                                                    20,
                                                                    1),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'ร้านค้า',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'ขนาดพื้นที่(ตร.ม.)',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'วันสิ้นสุดสัญญา',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign.end,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      height: 300,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
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
                                                      child: ListView.builder(
                                                        controller:
                                                            _scrollController3,
                                                        // itemExtent: 50,
                                                        physics:
                                                            const AlwaysScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            teNantModels.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Material(
                                                            color: tappedIndex_3 ==
                                                                    index
                                                                        .toString()
                                                                ? tappedIndex_Color
                                                                    .tappedIndex_Colors
                                                                : AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                            child: Container(
                                                              // color: tappedIndex_3 ==
                                                              //         index
                                                              //             .toString()
                                                              //     ? tappedIndex_Color
                                                              //         .tappedIndex_Colors
                                                              //         .withOpacity(
                                                              //             0.5)
                                                              //     : null,
                                                              child: ListTile(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      tappedIndex_1 =
                                                                          '';
                                                                      tappedIndex_2 =
                                                                          '';
                                                                      tappedIndex_3 =
                                                                          index
                                                                              .toString();
                                                                      tappedIndex_4 =
                                                                          '';
                                                                      tappedIndex_5 =
                                                                          '';
                                                                    });
                                                                  },
                                                                  title:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.black12,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            '${teNantModels[index].zn}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: teNantModels[index].ln_c == null ? '${teNantModels[index].ln_q}' : '${teNantModels[index].ln_c}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            child:
                                                                                AutoSizeText(
                                                                              minFontSize: 10,
                                                                              maxFontSize: 25,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              teNantModels[index].ln_c == null ? '${teNantModels[index].ln_q}' : '${teNantModels[index].ln_c}',
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: teNantModels[index].sname == null ? '${teNantModels[index].sname_q}' : '${teNantModels[index].sname}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            child:
                                                                                AutoSizeText(
                                                                              minFontSize: 10,
                                                                              maxFontSize: 25,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              teNantModels[index].sname == null ? '${teNantModels[index].sname_q}' : '${teNantModels[index].sname}',
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            teNantModels[index].area_c == null
                                                                                ? '${nFormat.format(double.parse(teNantModels[index].area_q!))}'
                                                                                : '${nFormat.format(double.parse(teNantModels[index].area_c!))}',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            teNantModels[index].ldate == null
                                                                                ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].ldate_q} 00:00:00'))}'
                                                                                : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].ldate} 00:00:00'))}',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      // width: MediaQuery.of(context).size.width,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      _scrollController3
                                                                          .animateTo(
                                                                        0,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                        curve: Curves
                                                                            .easeOut,
                                                                      );
                                                                    },
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                          // color: AppbackgroundColor
                                                                          //     .TiTile_Colors,
                                                                          borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(6),
                                                                              topRight: Radius.circular(6),
                                                                              bottomLeft: Radius.circular(6),
                                                                              bottomRight: Radius.circular(8)),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: const Text(
                                                                          'Top',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize:
                                                                                10.0,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (_scrollController3
                                                                        .hasClients) {
                                                                      final position = _scrollController3
                                                                          .position
                                                                          .maxScrollExtent;
                                                                      _scrollController3
                                                                          .animateTo(
                                                                        position,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                        curve: Curves
                                                                            .easeOut,
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        // color: AppbackgroundColor
                                                                        //     .TiTile_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(6),
                                                                            topRight: Radius.circular(6),
                                                                            bottomLeft: Radius.circular(6),
                                                                            bottomRight: Radius.circular(6)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(3.0),
                                                                      child: const Text(
                                                                        'Down',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              10.0,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      _moveUp3,
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_upward,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      )),
                                                                ),
                                                                Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // color: AppbackgroundColor
                                                                      //     .TiTile_Colors,
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              6),
                                                                          topRight: Radius.circular(
                                                                              6),
                                                                          bottomLeft: Radius.circular(
                                                                              6),
                                                                          bottomRight:
                                                                              Radius.circular(6)),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            3.0),
                                                                    child:
                                                                        const Text(
                                                                      'Scroll',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            10.0,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                InkWell(
                                                                  onTap:
                                                                      _moveDown3,
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_downward,
                                                                          color:
                                                                              Colors.grey,
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
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 4, 0, 4),
                                                    child: Container(
                                                        // width: MediaQuery.of(context)
                                                        //     .size
                                                        //     .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                          borderRadius: const BorderRadius
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
                                                                          10)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Icon(
                                                                //   Icons
                                                                //       .settings_input_composite,
                                                                //   color: Colors.white,
                                                                // ),

                                                                Tooltip(
                                                                  richMessage:
                                                                      TextSpan(
                                                                    text:
                                                                        'ทั้งหมด : ${teNantTwoModels.length} รายการ',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: HomeScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: Colors
                                                                            .lightGreen[
                                                                        200],
                                                                  ),
                                                                  child:
                                                                      InkWell(
                                                                    child: Translate.TranslateAndSet_TextAutoSize(
                                                                        'รายการค้างชำระ',
                                                                        HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        TextAlign
                                                                            .start,
                                                                        FontWeight
                                                                            .bold,
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                        8,
                                                                        20,
                                                                        1),
                                                                    onTap:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .monetization_on_rounded,
                                                              // Icons.next_plan,
                                                              color: HomeScreen_Color
                                                                  .Colors_Text1_,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'ร้านค้า',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'รหัสพื้นที่',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'จำนวนเงิน',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'กำหนดชำระ',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Translate.TranslateAndSet_TextAutoSize(
                                                                  'ค้างชำระ',
                                                                  HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign.end,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  8,
                                                                  20,
                                                                  1),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      height: 300,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
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
                                                      child: ListView.builder(
                                                        controller:
                                                            _scrollController4,
                                                        // itemExtent: 50,
                                                        // physics:
                                                        //     const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            teNantTwoModels
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Material(
                                                            color: tappedIndex_4 ==
                                                                    index
                                                                        .toString()
                                                                ? tappedIndex_Color
                                                                    .tappedIndex_Colors
                                                                : AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                            child: Container(
                                                              // color: tappedIndex_4 ==
                                                              //         index
                                                              //             .toString()
                                                              //     ? tappedIndex_Color
                                                              //         .tappedIndex_Colors
                                                              //         .withOpacity(
                                                              //             0.5)
                                                              //     : null,
                                                              child: ListTile(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      tappedIndex_1 =
                                                                          '';
                                                                      tappedIndex_2 =
                                                                          '';
                                                                      tappedIndex_3 =
                                                                          '';
                                                                      tappedIndex_4 =
                                                                          index
                                                                              .toString();
                                                                      tappedIndex_5 =
                                                                          '';
                                                                    });
                                                                  },
                                                                  title:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.black12,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${teNantTwoModels[index].sname}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: AutoSizeText(
                                                                                minFontSize: 10,
                                                                                maxFontSize: 25,
                                                                                '${teNantTwoModels[index].sname}',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.start,
                                                                                style: const TextStyle(
                                                                                  color: HomeScreen_Color.Colors_Text2_,
                                                                                  // fontWeight:
                                                                                  //     FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${teNantTwoModels[index].ln_c}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                '${teNantTwoModels[index].ln_c}',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.center,
                                                                                style: const TextStyle(
                                                                                  color: HomeScreen_Color.Colors_Text2_,
                                                                                  // fontWeight:
                                                                                  //     FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Text(
                                                                            '${teNantTwoModels[index].count_total}',
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              '${DateFormat('dd-MM').format(DateTime.parse('${teNantTwoModels[index].sdate} 00:00:00'))}-${DateTime.parse('${teNantTwoModels[index].sdate} 00:00:00').year + 543}',
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.end,
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              '${teNantTwoModels[index].count_bill} รายการ',
                                                                              textAlign: TextAlign.end,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      // width: MediaQuery.of(context).size.width,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      _scrollController4
                                                                          .animateTo(
                                                                        0,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                        curve: Curves
                                                                            .easeOut,
                                                                      );
                                                                    },
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                          // color: AppbackgroundColor
                                                                          //     .TiTile_Colors,
                                                                          borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(6),
                                                                              topRight: Radius.circular(6),
                                                                              bottomLeft: Radius.circular(6),
                                                                              bottomRight: Radius.circular(8)),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: const Text(
                                                                          'Top',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize:
                                                                                10.0,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (_scrollController4
                                                                        .hasClients) {
                                                                      final position = _scrollController4
                                                                          .position
                                                                          .maxScrollExtent;
                                                                      _scrollController4
                                                                          .animateTo(
                                                                        position,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                        curve: Curves
                                                                            .easeOut,
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        // color: AppbackgroundColor
                                                                        //     .TiTile_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(6),
                                                                            topRight: Radius.circular(6),
                                                                            bottomLeft: Radius.circular(6),
                                                                            bottomRight: Radius.circular(6)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(3.0),
                                                                      child: const Text(
                                                                        'Down',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              10.0,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      _moveUp4,
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_upward,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      )),
                                                                ),
                                                                Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // color: AppbackgroundColor
                                                                      //     .TiTile_Colors,
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              6),
                                                                          topRight: Radius.circular(
                                                                              6),
                                                                          bottomLeft: Radius.circular(
                                                                              6),
                                                                          bottomRight:
                                                                              Radius.circular(6)),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            3.0),
                                                                    child:
                                                                        const Text(
                                                                      'Scroll',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            10.0,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                InkWell(
                                                                  onTap:
                                                                      _moveDown4,
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_downward,
                                                                          color:
                                                                              Colors.grey,
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
                      ),
                // if (Responsive.isDesktop(context))
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.all(8.0),
                //         child: Text(
                //           'เลือกสถานที่/Portfolio',
                //           style: TextStyle(
                //             color: HomeScreen_Color.Colors_Text1_,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: FontWeight_.Fonts_T,
                //           ),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: AppbackgroundColor.Sub_Abg_Colors,
                //             borderRadius: const BorderRadius.only(
                //                 topLeft: Radius.circular(10),
                //                 topRight: Radius.circular(10),
                //                 bottomLeft: Radius.circular(10),
                //                 bottomRight: Radius.circular(10)),
                //             border: Border.all(color: Colors.grey, width: 1),
                //           ),
                //           width: 200,
                //           child: DropdownButtonFormField2(
                //             decoration: InputDecoration(
                //               isDense: true,
                //               contentPadding: EdgeInsets.zero,
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //             ),
                //             isExpanded: true,
                //             hint: Text(
                //               renTal_name == null ? 'ค้นหา' : '$renTal_name',
                //               style: TextStyle(
                //                 fontSize: 14,
                //                 color: HomeScreen_Color.Colors_Text1_,
                //                 fontWeight: FontWeight.bold,
                //                 fontFamily: FontWeight_.Fonts_T,
                //               ),
                //             ),
                //             icon: const Icon(
                //               Icons.arrow_drop_down,
                //               color: Colors.white,
                //             ),
                //             style: const TextStyle(
                //               color: Colors.green,
                //               fontFamily: Font_.Fonts_T,
                //             ),
                //             iconSize: 30,
                //             buttonHeight: 40,
                //             // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                //             dropdownDecoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             items: renTalModels
                //                 .map((item) => DropdownMenuItem<String>(
                //                       value: '${item.ser},${item.pn}',
                //                       child: Text(
                //                         item.pn!,
                //                         style: const TextStyle(
                //                           fontSize: 14,
                //                           color: HomeScreen_Color.Colors_Text2_,
                //                           fontFamily: Font_.Fonts_T,
                //                         ),
                //                       ),
                //                     ))
                //                 .toList(),

                //             onChanged: (value) async {
                //               var renTals = value!.indexOf(',');
                //               var renTalSer = value.substring(0, renTals);
                //               var renTalName = value.substring(renTals + 1);
                //               print(
                //                   'mmmmm ${renTalSer.toString()} $renTalName');

                //               SharedPreferences preferences =
                //                   await SharedPreferences.getInstance();
                //               preferences.setString(
                //                   'renTalSer', renTalSer.toString());
                //               preferences.setString(
                //                   'renTalName', renTalName.toString());
                //               String? _route = preferences.getString('route');

                //               preferences.remove('zoneSer');
                //               preferences.remove('zonesName');
                //               preferences.remove('zonePSer');
                //               preferences.remove('zonesPName');

                //               MaterialPageRoute route = MaterialPageRoute(
                //                 builder: (context) =>
                //                     AdminScafScreen(route: _route),
                //               );
                //               Navigator.pushAndRemoveUntil(
                //                   context, route, (route) => false);
                //             },
                //             // onSaved: (value) {
                //             //   // selectedValue = value.toString();
                //             // },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // if (renTal_user == null)
                //   Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height * 0.3,
                //     child: Center(
                //       child: Text(
                //         'กรุณาเลือกสถานที่',
                //         style: TextStyle(
                //           color: HomeScreen_Color.Colors_Text2_,
                //           fontFamily: Font_.Fonts_T,
                //         ),
                //       ),
                //     ),
                //   ),
                // if (renTal_user != null) Text('data'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];

  List<ZoneAllModel> zoneAllModels = [];
  int SerBody_Step3_ = 0;
  String Value_lacotion_ = '';
  String Value_Area_ = '';
  int Value_AreaSer_ = 0; //ลักษณะพื้นที่เช่า
  String Value_Rent_ = '';
  int Value_RentSer_ = 0; //ชื่การคิดค่าเช่า
  String Value_Usage_ = '';
  int Value_UsageSer_ = 0; //การใช้งาน

  String Value_Zone_ = ''; //ชื่อโซนชั้น
  String Value_QTYROOM_ = ''; //จำนวนห้อง

  int activeStep = 0; // stepper
  int upperBound = 1; // stepper

  String? lncodeser, areaser, lnser, rentser, serUser, serzn, qtyzn;

  Widget Body4() {
    final Body3_formKey_1 = GlobalKey<FormState>();
    final Body3_formKey_2 = GlobalKey<FormState>();

    bool _isObscure = true;
    // bool _validate = false;
    final Body3Form1_text = TextEditingController();
    final Body3Form2_text = TextEditingController();
    final Body3Form3_text = TextEditingController();
    return Container(
      // color: Colors.grey[100],
      // height: MediaQuery.of(context).size.height,

      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Form(
              key: Body3_formKey_1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.add),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          'เพิ่มสถานที่',
                          minFontSize: 16,
                          maxFontSize: 25,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SingupScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          'ชื่อสถานที่',
                          minFontSize: 5,
                          maxFontSize: 15,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SingupScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: Body3Form1_text,
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
                                  errorStyle:
                                      TextStyle(fontFamily: Font_.Fonts_T),
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
                                  labelText: 'ชื่อสถานที่ (ภาษาอังกฤษเท่านั่น)',
                                  labelStyle:
                                      const TextStyle(color: Colors.black54)),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter(
                                    RegExp("[@.!#%&'*+/=?^`{|}~]"),
                                    allow: false),
                                // // for below version 2 use this
                                // FilteringTextInputFormatter.deny(
                                //     RegExp("[' ']")),

                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[A-Z a-z 1-9]')),
                                FilteringTextInputFormatter.deny(
                                    RegExp("[ก-ฮ ' ']")),
                                // for version 2 and greater youcan also use this
                                // FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              var Value_Email_ = preferences.getString('email');
                              if (Body3_formKey_1.currentState!.validate()) {
                                String dab = Body3Form1_text.text;
                                int txser = Value_AreaSer_ + 1;
                                int tser = Value_RentSer_ + 1;
                                int rtser = Value_UsageSer_ + 1;

                                String url =
                                    '${MyConstant().domain}/CR_resister.php?isAdd=true&txser=$txser&tser=$tser&rtser=$rtser&dab=$dab&email=$Value_Email_';

                                try {
                                  var response = await http.get(Uri.parse(url));

                                  var result = json.decode(response.body);
                                  print(result);
                                  if (result.toString() != 'Not data') {
                                    setState(() {
                                      Body3Form2_text.text = 'A';
                                      Body3Form3_text.text = '2';
                                    });
                                    for (var map in result) {
                                      RenTalModel userModel =
                                          RenTalModel.fromJson(map);
                                      setState(() {
                                        // SerBody_Step3_ = 1;
                                        Value_lacotion_ = Body3Form1_text.text;
                                        Value_Zone_ = Body3Form2_text.text;
                                        Value_QTYROOM_ = Body3Form3_text.text;
                                      });
                                    }
                                    upZoneTable();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'ชื่อสถานที่นี้มีผู้ใช้ท่านอื่นใช้แล้ว กรุณาใช้ชื่ออื่น')),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'ชื่อสถานที่นี้มีผู้ใช้ท่านอื่นใช้แล้ว กรุณาใช้ชื่ออื่น')),
                                  );
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 5,
                              decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: const Center(
                                child: AutoSizeText(
                                  'เพิ่ม',
                                  minFontSize: 5,
                                  maxFontSize: 15,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                app_port = 0;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: const Center(
                                child: AutoSizeText(
                                  'ยกเลิก',
                                  minFontSize: 5,
                                  maxFontSize: 15,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
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
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          '*** บันทึกพื้นที่เริ่มต้น 2 พื้นที่',
                          minFontSize: 5,
                          maxFontSize: 15,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              // color: SingupScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<Null> upZoneTable() async {
    if (zoneModels != 0) {
      setState(() {
        zoneModels.clear();
      });
    }
    print('ชื่อสถานที่ : $Value_lacotion_');
    print('โซนชั้น : $Value_Zone_');
    print('จำนวนห้อง : $Value_QTYROOM_');
    String location = Value_lacotion_;
    String zone = Value_Zone_;
    String qtyroom = Value_QTYROOM_;

    // String location = Value_lacotion_;
    // String zone = 'A';
    // String qtyroom = '2';
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var seruser = preferences.getString('ser');
    String? nameuser = seruser;

    String url =
        '${MyConstant().domain}/InC_Zone.php?isAdd=true&location=$location&zone=$zone&qtyroom=$qtyroom&nameuser=$nameuser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());

      if (result.toString() != 'Not data') {
        for (var map in result) {
          ZoneModel zoneModel = ZoneModel.fromJson(map);
          var serznx = zoneModel.ser;
          var qtyznx = zoneModel.qty;
          setState(() {
            serzn = serznx;
            qtyzn = qtyznx;
            zoneModels.add(zoneModel);
          });
        }
        upAreaTable();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('การเชื่อมต่อผิดพลาด',
                  style: TextStyle(
                      color: Colors.black, fontFamily: Font_.Fonts_T))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('การเชื่อมต่อผิดพลาด',
                style:
                    TextStyle(color: Colors.black, fontFamily: Font_.Fonts_T))),
      );
    }
  }

  Future<Null> upAreaTable() async {
    if (areaModels != 0) {
      setState(() {
        areaModels.clear();
      });
    }

    String? zone = serzn;
    String location = Value_lacotion_;
    String? nameuser = serUser;

    for (var iz = 0; iz < int.parse(qtyzn!); iz++) {
      String? zoneln = '$Value_Zone_ ${iz + 1}';
      String? codeln = '${iz + 1}';
      String url =
          '${MyConstant().domain}/InC_Area.php?isAdd=true&zoneln=$zoneln&zone=$zone&codeln=$codeln&location=$location&nameuser=$nameuser';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result.toString());

        if (result.toString() != 'Not data') {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);
            setState(() {
              areaModels.add(areaModel);
            });
          }

          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? _route = preferences.getString('route');
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) =>
                  AdminScafScreen(route: _route));
          Navigator.pushAndRemoveUntil(
              context, materialPageRoute, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('การเชื่อมต่อผิดพลาด',
                    style: TextStyle(
                        color: Colors.black, fontFamily: Font_.Fonts_T))),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('การเชื่อมต่อผิดพลาด',
                  style: TextStyle(
                      color: Colors.black, fontFamily: Font_.Fonts_T))),
        );
      }
    }
  }

/////////////---------------------------------------------------------->
  Widget BodyHome_mobile() {
    return (serBody_modile_wiget == 1)
        ? Datalist1_mobile_wiget()
        : (serBody_modile_wiget == 2)
            ? Datalist2_mobile_wiget()
            : (serBody_modile_wiget == 3)
                ? Datalist3_mobile_wiget()
                : (serBody_modile_wiget == 4)
                    ? Datalist4_mobile_wiget()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: renTal_user == null
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  padding: EdgeInsets.all(8),
                                  child: ListView(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'เลือกสถานที่/Portfolio',
                                              style: TextStyle(
                                                color: HomeScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              width: 200,
                                              child: DropdownButtonFormField2(
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                hint: Text(
                                                  renTal_name == null
                                                      ? 'ค้นหา'
                                                      : '$renTal_name',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: HomeScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontFamily: Font_.Fonts_T,
                                                ),
                                                iconSize: 30,
                                                buttonHeight: 40,
                                                // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                items: renTalModels
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value:
                                                              '${item.ser},${item.pn}',
                                                          child: Text(
                                                            item.pn!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color: HomeScreen_Color
                                                                  .Colors_Text2_,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),

                                                onChanged: (value) async {
                                                  var renTals =
                                                      value!.indexOf(',');
                                                  var renTalSer = value
                                                      .substring(0, renTals);
                                                  var renTalName = value
                                                      .substring(renTals + 1);
                                                  print(
                                                      'mmmmm ${renTalSer.toString()} $renTalName');

                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  preferences.setString(
                                                      'renTalSer',
                                                      renTalSer.toString());
                                                  preferences.setString(
                                                      'renTalName',
                                                      renTalName.toString());
                                                  String? _route = preferences
                                                      .getString('route');

                                                  preferences.remove('zoneSer');
                                                  preferences
                                                      .remove('zonesName');
                                                  preferences
                                                      .remove('zonePSer');
                                                  preferences
                                                      .remove('zonesPName');

                                                  MaterialPageRoute route =
                                                      MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdminScafScreen(
                                                            route: _route),
                                                  );
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      route,
                                                      (route) => false);
                                                },
                                                // onSaved: (value) {
                                                //   // selectedValue = value.toString();
                                                // },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.width,
                                        child: ListView(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'กรุณาเลือกสถานที่',
                                                        style: TextStyle(
                                                          color: HomeScreen_Color
                                                              .Colors_Text2_,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.transparent,
                                                    child: GridView.count(
                                                      crossAxisCount:
                                                          (Responsive.isDesktop(
                                                                  context))
                                                              ? 8
                                                              : 4,
                                                      children: [
                                                        Card(
                                                            color:
                                                                AppbackgroundColor
                                                                    .Abg_Colors,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                setState(() {
                                                                  app_port = 1;
                                                                });
                                                              },
                                                              child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppbackgroundColor
                                                                        .Sub_Abg_Colors,
                                                                    borderRadius: const BorderRadius
                                                                            .only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                50),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                50),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                50),
                                                                        bottomRight:
                                                                            Radius.circular(50)),
                                                                  ),
                                                                  // color: Colors.white,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.1,
                                                                  height: 50,
                                                                  child: Center(
                                                                      child:
                                                                          Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(Icons
                                                                              .add)
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          AutoSizeText(
                                                                            'เพิ่มสถานที่',
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                18,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              // fontSize: 20,
                                                                              fontFamily: Font_.Fonts_T,
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            ),
                                                                            maxLines:
                                                                                4,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ))),
                                                            )),
                                                        for (int i = 0;
                                                            i <
                                                                renTalModels
                                                                    .length;
                                                            i++)
                                                          Card(
                                                              color:
                                                                  AppbackgroundColor
                                                                      .Abg_Colors,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  var renTalSer =
                                                                      renTalModels[
                                                                              i]
                                                                          .ser;
                                                                  var renTalName =
                                                                      renTalModels[
                                                                              i]
                                                                          .pn;
                                                                  print(
                                                                      'mmmmm ${renTalSer.toString()} $renTalName');

                                                                  SharedPreferences
                                                                      preferences =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  preferences.setString(
                                                                      'renTalSer',
                                                                      renTalSer
                                                                          .toString());
                                                                  preferences.setString(
                                                                      'renTalName',
                                                                      renTalName
                                                                          .toString());
                                                                  String?
                                                                      _route =
                                                                      preferences
                                                                          .getString(
                                                                              'route');

                                                                  preferences
                                                                      .remove(
                                                                          'zoneSer');
                                                                  preferences
                                                                      .remove(
                                                                          'zonesName');
                                                                  preferences
                                                                      .remove(
                                                                          'zonePSer');
                                                                  preferences
                                                                      .remove(
                                                                          'zonesPName');

                                                                  MaterialPageRoute
                                                                      route =
                                                                      MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        AdminScafScreen(
                                                                            route:
                                                                                _route),
                                                                  );
                                                                  Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      route,
                                                                      (route) =>
                                                                          false);
                                                                },
                                                                child: Container(
                                                                    // color: Colors.green.shade200,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green
                                                                          .shade200,
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              50),
                                                                          topRight: Radius.circular(
                                                                              50),
                                                                          bottomLeft: Radius.circular(
                                                                              50),
                                                                          bottomRight:
                                                                              Radius.circular(50)),
                                                                    ),
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: 50,
                                                                    child: renTalModels[i].imglogo == null || renTalModels[i].imglogo == 'null'
                                                                        ? Center(
                                                                            child: AutoSizeText(
                                                                            '${renTalModels[i].pn}',
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                18,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              // fontSize: 20,
                                                                              fontFamily: Font_.Fonts_T,
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            ),
                                                                            maxLines:
                                                                                4,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ))
                                                                        : Center(
                                                                            child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              renTalModels[i].imglogo == null || renTalModels[i].imglogo == 'null'
                                                                                  ? SizedBox()
                                                                                  : Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        // Container(
                                                                                        //   width: 100,
                                                                                        //   height: 60,
                                                                                        //   decoration: BoxDecoration(
                                                                                        //     image: DecorationImage(
                                                                                        //       image: NetworkImage('${MyConstant().domain}/files/${renTalModels[i].dbn}/logo/${renTalModels[i].imglogo}'),
                                                                                        //     ),
                                                                                        //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                        //   ),
                                                                                        // ),
                                                                                        CircleAvatar(
                                                                                          radius: 25,
                                                                                          backgroundImage: NetworkImage('${MyConstant().domain}/files/${renTalModels[i].dbn}/logo/${renTalModels[i].imglogo}'),
                                                                                          backgroundColor: Colors.transparent,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  AutoSizeText(
                                                                                    '${renTalModels[i].pn}',
                                                                                    minFontSize: 10,
                                                                                    maxFontSize: 18,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      // fontSize: 20,
                                                                                      fontFamily: Font_.Fonts_T,
                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    ),
                                                                                    maxLines: 4,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ))),
                                                              )),
                                                      ],
                                                    )),
                                                (app_port == 1)
                                                    ? Row(
                                                        children: [
                                                          Expanded(
                                                            child: Body4(),
                                                          )
                                                        ],
                                                      )
                                                    : SizedBox()
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'เลือกสถานที่/Portfolio',
                                            style: TextStyle(
                                              color: HomeScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
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
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            width: 200,
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
                                                renTal_name == null
                                                    ? 'ค้นหา'
                                                    : '$renTal_name',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              ),
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                              iconSize: 30,
                                              buttonHeight: 40,
                                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                              dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              items: renTalModels
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value:
                                                            '${item.ser},${item.pn}',
                                                        child: Text(
                                                          item.pn!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color: HomeScreen_Color
                                                                .Colors_Text2_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),

                                              onChanged: (value) async {
                                                var renTals =
                                                    value!.indexOf(',');
                                                var renTalSer =
                                                    value.substring(0, renTals);
                                                var renTalName = value
                                                    .substring(renTals + 1);
                                                print(
                                                    'mmmmm ${renTalSer.toString()} $renTalName');

                                                SharedPreferences preferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                preferences.setString(
                                                    'renTalSer',
                                                    renTalSer.toString());
                                                preferences.setString(
                                                    'renTalName',
                                                    renTalName.toString());
                                                String? _route = preferences
                                                    .getString('route');

                                                preferences.remove('zoneSer');
                                                preferences.remove('zonesName');
                                                preferences.remove('zonePSer');
                                                preferences
                                                    .remove('zonesPName');

                                                MaterialPageRoute route =
                                                    MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminScafScreen(
                                                          route: _route),
                                                );
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    route,
                                                    (route) => false);
                                              },
                                              // onSaved: (value) {
                                              //   // selectedValue = value.toString();
                                              // },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width,
                                        // height: 500,
                                        // decoration: BoxDecoration(
                                        //   color: AppbackgroundColor.Sub_Abg_Colors,
                                        //   borderRadius: const BorderRadius.only(
                                        //       topLeft: Radius.circular(10),
                                        //       topRight: Radius.circular(10),
                                        //       bottomLeft: Radius.circular(10),
                                        //       bottomRight: Radius.circular(10)),
                                        //   border: Border.all(color: Colors.grey, width: 1),
                                        // ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          // width: MediaQuery.of(context).size.width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
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
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: const [
                                                                  // Icon(
                                                                  //   Icons
                                                                  //       .settings_input_composite,
                                                                  //   color: Colors.white,
                                                                  // ),
                                                                  Text(
                                                                    'รายการรอทำสัญญา',
                                                                    style:
                                                                        TextStyle(
                                                                      color: HomeScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // Icon(
                                                              //   Icons.next_plan,
                                                              //   color: HomeScreen_Color
                                                              //       .Colors_Text1_,

                                                              //   //fontSize: 10.0
                                                              // )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          // width: MediaQuery.of(context).size.width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
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
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: const [
                                                                  // Icon(
                                                                  //   Icons
                                                                  //       .settings_input_composite,
                                                                  //   color: Colors.white,
                                                                  // ),
                                                                  Text(
                                                                    'รายการแจ้งซ่อม',
                                                                    style:
                                                                        TextStyle(
                                                                      color: HomeScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // const Icon(
                                                              //   Icons.next_plan,
                                                              //   color: HomeScreen_Color
                                                              //       .Colors_Text1_,
                                                              // )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          // width: MediaQuery.of(context).size.width / 2.4,
                                                          height: 200,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                            borderRadius: BorderRadius.only(
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
                                                            // border:
                                                            //     Border.all(color: Colors.grey, width: 1),
                                                          ),
                                                          child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: const [
                                                                      Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: const [
                                                                      Text(
                                                                        'รายการรอทำสัญญา',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'ทั้งหมด ${customerModels.length} รายการ',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: const [
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'ดูทั้งหมด',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,

                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .drive_file_move,
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            serBody_modile_wiget =
                                                                1;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.4,
                                                          height: 200,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                            borderRadius: BorderRadius.only(
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
                                                            // border:
                                                            //     Border.all(color: Colors.grey, width: 1),
                                                          ),
                                                          child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: const [
                                                                      Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: const [
                                                                      Text(
                                                                        'รายการแจ้งซ่อม',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'ทั้งหมด ${maintenanceModels.length} รายการ',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: const [
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'ดูทั้งหมด',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .drive_file_move,
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            serBody_modile_wiget =
                                                                2;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          // width: MediaQuery.of(context).size.width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
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
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: const [
                                                                  // Icon(
                                                                  //   Icons
                                                                  //       .settings_input_composite,
                                                                  //   color: Colors.white,
                                                                  // ),
                                                                  Text(
                                                                    'พื้นที่ใกล้หมดสัญญา',
                                                                    style:
                                                                        TextStyle(
                                                                      color: HomeScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // Icon(
                                                              //   Icons.next_plan,
                                                              //   color: HomeScreen_Color
                                                              //       .Colors_Text1_,
                                                              // )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          // width: MediaQuery.of(context).size.width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
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
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: const [
                                                                  // Icon(
                                                                  //   Icons
                                                                  //       .settings_input_composite,
                                                                  //   color: Colors.white,
                                                                  // ),
                                                                  Text(
                                                                    'รายการค้างชำระ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: HomeScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // Icon(
                                                              //   Icons.next_plan,
                                                              //   color: HomeScreen_Color
                                                              //       .Colors_Text1_,
                                                              // )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          // width: MediaQuery.of(context).size.width / 2.4,
                                                          height: 200,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                            borderRadius: BorderRadius.only(
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
                                                            // border:
                                                            //     Border.all(color: Colors.grey, width: 1),
                                                          ),
                                                          child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: const [
                                                                      Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: const [
                                                                      Text(
                                                                        'พื้นที่ใกล้หมดสัญญา',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'ทั้งหมด ${teNantModels.length} รายการ',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: const [
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'ดูทั้งหมด',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .drive_file_move,
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,

                                                                        //fontSize: 10.0
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            serBody_modile_wiget =
                                                                3;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.4,
                                                          height: 200,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                            borderRadius: BorderRadius.only(
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
                                                            // border:
                                                            //     Border.all(color: Colors.grey, width: 1),
                                                          ),
                                                          child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: const [
                                                                      Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: const [
                                                                      Text(
                                                                        'รายการค้างชำระ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'ทั้งหมด ${teNantTwoModels.length} รายการ',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: const [
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'ดูทั้งหมด',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .drive_file_move,
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,

                                                                        //fontSize: 10.0
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            serBody_modile_wiget =
                                                                4;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                      child: Container(
                                        height: 200,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                          // border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10)),
                                                border: Border.all(
                                                    color: HomeScreen_Color
                                                        .Colors_Text1_,
                                                    width: 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'โน๊ตส่วนตัว',
                                                      style: TextStyle(
                                                        color: HomeScreen_Color
                                                            .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        //fontSize: 10.0
                                                      ),
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding:
                                                  //       EdgeInsets.all(8.0),
                                                  //   child: Icon(
                                                  //     Icons.next_plan,
                                                  //     color: HomeScreen_Color
                                                  //         .Colors_Text1_,
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 150,
                                              child: TextFormField(
                                                // keyboardType: TextInputType.name,
                                                controller: Form_note,
                                                // onChanged: (value) =>
                                                //     _Form_nameshop = value.trim(),
                                                //initialValue: _Form_nameshop,
                                                onFieldSubmitted:
                                                    (value) async {
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  var ren = preferences
                                                      .getString('renTalSer');
                                                  var ser_user = preferences
                                                      .getString('ser');

                                                  var note = Form_note.text;

                                                  print(sernote);

                                                  String url =
                                                      '${MyConstant().domain}/UDC_Note.php?isAdd=true&ren=$ren&ser_user=$ser_user&sernote=$sernote';

                                                  try {
                                                    var response = await http
                                                        .post(Uri.parse(url),
                                                            body: {
                                                          'note':
                                                              value.toString(),
                                                        }).then((value) async {
                                                      print('$value');
                                                      // var result = json.decode(value.body);
                                                      // print('$result ');
                                                      var result = json
                                                          .decode(value.body);
                                                      print(result);
                                                      if (result.toString() ==
                                                          'true') {
                                                        setState(() {
                                                          read_GC_note();
                                                        });

                                                        print(
                                                            '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                                      } else {}
                                                    });

                                                    // var response = await http
                                                    //     .get(Uri.parse(url));

                                                    var result = json
                                                        .decode(response.body);
                                                    print(result);
                                                    if (result.toString() ==
                                                        'true') {
                                                      setState(() {
                                                        read_GC_note();
                                                      });

                                                      print(
                                                          '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                                    } else {}
                                                  } catch (e) {}
                                                },
                                                maxLines: 100,
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
                                                    // labelText: 'ระบุชื่อร้านค้า',
                                                    labelStyle: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    )),
                                              ),
                                              // ListView.builder(
                                              //   itemCount: 20,
                                              //   itemBuilder:
                                              //       (BuildContext context,
                                              //           int index) {
                                              //     return ListTile(
                                              //       title: Text(
                                              //         'Note ${index + 1}',
                                              //         style: const TextStyle(
                                              //           color: HomeScreen_Color
                                              //               .Colors_Text1_,
                                              //           fontWeight:
                                              //               FontWeight.bold,
                                              //           fontFamily:
                                              //               FontWeight_.Fonts_T,
                                              //           //fontSize: 10.0
                                              //         ),
                                              //       ),
                                              //     );
                                              //   },
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();

                                            var ren = preferences
                                                .getString('renTalSer');
                                            var ser_user =
                                                preferences.getString('ser');

                                            var note = Form_note.text;

                                            String url =
                                                '${MyConstant().domain}/UDC_Note.php?isAdd=true&ren=$ren&ser_user=$ser_user&sernote=$sernote';

                                            try {
                                              var response = await http
                                                  .post(Uri.parse(url), body: {
                                                'note': note.toString(),
                                              }).then((value) async {
                                                print('$value');
                                                // var result = json.decode(value.body);
                                                // print('$result ');
                                                var result =
                                                    json.decode(value.body);
                                                print(result);
                                                if (result.toString() ==
                                                    'true') {
                                                  setState(() {
                                                    read_GC_note();
                                                  });

                                                  print(
                                                      '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                                } else {}
                                              });

                                              // var response = await http
                                              //     .get(Uri.parse(url));

                                              var result =
                                                  json.decode(response.body);
                                              print(result);
                                              if (result.toString() == 'true') {
                                                setState(() {
                                                  read_GC_note();
                                                });

                                                print(
                                                    '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                              } else {}
                                              // var response = await http
                                              //     .get(Uri.parse(url));

                                              // var result =
                                              //     json.decode(response.body);
                                              // print(result);
                                              // if (result.toString() == 'null') {
                                              //   setState(() {
                                              //     read_GC_note();
                                              //   });
                                              //   ScaffoldMessenger.of(context)
                                              //       .showSnackBar(
                                              //     const SnackBar(
                                              //         content: Text(
                                              //             'บันทึกสำเร็จ',
                                              //             style: TextStyle(
                                              //                 color:
                                              //                     Colors.black,
                                              //                 fontFamily: Font_
                                              //                     .Fonts_T))),
                                              //   );

                                              //   print(
                                              //       '00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
                                              // } else {}
                                            } catch (e) {}
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      // color: AppbackgroundColor
                                                      //     .TiTile_Colors,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(6),
                                                              topRight: Radius
                                                                  .circular(6),
                                                              bottomLeft: Radius
                                                                  .circular(6),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: const Center(
                                                      child: Text(
                                                        'Save',
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    )
                                  ],
                                ),
                        ),
                      );
  }

/////////////---------------------------------------------------------->
  Widget Datalist1_mobile_wiget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        serBody_modile_wiget = 0;
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppbackgroundColor.Sub_Abg_Colors,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'รายการรอทำสัญญา',
                        style: TextStyle(
                          color: HomeScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                          //fontSize: 10.0
                        ),
                      ),
                      // Icon(
                      //   Icons.next_plan,
                      //   color: HomeScreen_Color.Colors_Text1_,
                      // )
                    ],
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppbackgroundColor.Sub_Abg_Colors,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                children: [
                  ScrollConfiguration(
                    behavior:
                        ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        dragStartBehavior: DragStartBehavior.start,
                        child: Row(
                          children: [
                            Container(
                                width: 800,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 800,
                                      decoration: BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'โซนพื้นที่',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'รหัสพื้นที่',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ร้านค้า',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ขนาดพื้นที่(ต.ร.ม.)',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'วันนัดหมาย',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.55,
                                      width: 800,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: ListView.builder(
                                        controller: _scrollController1,
                                        // itemExtent: 50,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: customerModels.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            color: tappedIndex_1 ==
                                                    index.toString()
                                                ? tappedIndex_Color
                                                    .tappedIndex_Colors
                                                    .withOpacity(0.5)
                                                : null,
                                            child: ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    tappedIndex_1 =
                                                        index.toString();
                                                    tappedIndex_2 = '';
                                                    tappedIndex_3 = '';
                                                    tappedIndex_4 = '';
                                                    tappedIndex_5 = '';
                                                  });
                                                },
                                                title: Container(
                                                  decoration:
                                                      const BoxDecoration(
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
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 25,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            '${customerModels[index].zn}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: HomeScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),

                                                          //  Text(
                                                          //   '${customerModels[index].zn}',
                                                          //   style: const TextStyle(
                                                          //     color: TextHome_Color
                                                          //         .TextHome_Colors,

                                                          //     //fontSize: 10.0
                                                          //   ),
                                                          // ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              '${customerModels[index].ln}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          //  Text(
                                                          //   '${customerModels[index].ln}',
                                                          //   style: const TextStyle(
                                                          //     color: TextHome_Color
                                                          //         .TextHome_Colors,

                                                          //     //fontSize: 10.0
                                                          //   ),
                                                          // ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 25,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          '${customerModels[index].scname}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            color: HomeScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                        //  Text(
                                                        //   '${customerModels[index].scname}',
                                                        //   style: const TextStyle(
                                                        //     color: TextHome_Color
                                                        //         .TextHome_Colors,

                                                        //     //fontSize: 10.0
                                                        //   ),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 25,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          '${nFormat.format(double.parse(customerModels[index].area!))}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            color: HomeScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   '${customerModels[index].area}',
                                                        //   style: TextStyle(
                                                        //     color: TextHome_Color
                                                        //         .TextHome_Colors,

                                                        //     //fontSize: 10.0
                                                        //   ),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 25,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${customerModels[index].sdate} 00:00:00'))}',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                const TextStyle(
                                                              color: HomeScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),

                                                          //  Text(
                                                          //   '${customerModels[index].sdate}',
                                                          //   maxLines: 1,
                                                          //   overflow:
                                                          //       TextOverflow.ellipsis,
                                                          //   style: const TextStyle(
                                                          //     color: TextHome_Color
                                                          //         .TextHome_Colors,
                                                          //   ),
                                                          // ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
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
                                    onTap: () {
                                      _scrollController1.animateTo(
                                        0,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeOut,
                                      );
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          // color: AppbackgroundColor
                                          //     .TiTile_Colors,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(8)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(3.0),
                                        child: const Text(
                                          'Top',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_scrollController1.hasClients) {
                                      final position = _scrollController1
                                          .position.maxScrollExtent;
                                      _scrollController1.animateTo(
                                        position,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeOut,
                                      );
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        // color: AppbackgroundColor
                                        //     .TiTile_Colors,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(6)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Text(
                                        'Down',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
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
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(3.0),
                                    child: const Text(
                                      'Scroll',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
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
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

/////////////---------------------------------------------------------->
  Widget Datalist2_mobile_wiget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          serBody_modile_wiget = 0;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'รายการแจ้งซ่อม',
                          style: TextStyle(
                            color: HomeScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                            //fontSize: 10.0
                          ),
                        ),
                        // Icon(
                        //   Icons.next_plan,
                        //   color: HomeScreen_Color.Colors_Text1_,
                        // )
                      ],
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  children: [
                    ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          dragStartBehavior: DragStartBehavior.start,
                          child: Row(
                            children: [
                              Container(
                                  width: 800,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        decoration: BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'รหัสพื้นที่',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: HomeScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ร้านค้า',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: HomeScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'รายละเอียด',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: HomeScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'วันแจ้งซ่อม',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: HomeScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'สถานะ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: HomeScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView.builder(
                                            controller: _scrollController2,
                                            // itemExtent: 50,
                                            // physics:
                                            //     const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: maintenanceModels.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                color: tappedIndex_2 ==
                                                        index.toString()
                                                    ? tappedIndex_Color
                                                        .tappedIndex_Colors
                                                        .withOpacity(0.5)
                                                    : null,
                                                child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        tappedIndex_1 = '';
                                                        tappedIndex_2 =
                                                            index.toString();
                                                        tappedIndex_3 = '';
                                                        tappedIndex_4 = '';
                                                        tappedIndex_5 = '';
                                                      });
                                                    },
                                                    title: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color:
                                                                Colors.black12,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                '${maintenanceModels[index].aser}',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  color: HomeScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight:
                                                                  //     FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              '${maintenanceModels[index].sname}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              '${maintenanceModels[index].mdescr}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              '${DateFormat('dd-MM').format((DateTime.parse('${maintenanceModels[index].mdate} 00:00:00')))}-${DateTime.parse('${maintenanceModels[index].mdate} 00:00:00').year + 543}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .white10,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
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
                                                                      .all(4.0),
                                                              child: Center(
                                                                child: Text(
                                                                  maintenanceModels[index]
                                                                              .mst ==
                                                                          '0'
                                                                      ? ' '
                                                                      : maintenanceModels[index].mst ==
                                                                              '1'
                                                                          ? 'รอดำเนินการ'
                                                                          : 'เสร็จสิ้น',
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
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
                                      onTap: () {
                                        _scrollController2.animateTo(
                                          0,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeOut,
                                        );
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            // color: AppbackgroundColor
                                            //     .TiTile_Colors,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(8)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            'Top',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_scrollController2.hasClients) {
                                        final position = _scrollController2
                                            .position.maxScrollExtent;
                                        _scrollController2.animateTo(
                                          position,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeOut,
                                        );
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          // color: AppbackgroundColor
                                          //     .TiTile_Colors,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(3.0),
                                        child: const Text(
                                          'Down',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
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
                                    onTap: _moveUp2,
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
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Text(
                                        'Scroll',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      )),
                                  InkWell(
                                    onTap: _moveDown2,
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
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  /////////////---------------------------------------------------------->
  Widget Datalist3_mobile_wiget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          serBody_modile_wiget = 0;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'พื้นที่ใกล้หมดสัญญา',
                          style: TextStyle(
                            color: HomeScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        ),
                        // Icon(
                        //   Icons.next_plan,
                        //   color: HomeScreen_Color.Colors_Text1_,
                        // )
                      ],
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  children: [
                    ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        dragStartBehavior: DragStartBehavior.start,
                        child: Row(
                          children: [
                            Container(
                                width: 750,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 750,
                                      decoration: BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'โซนพื้นที่',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'รหัสพื้นที่',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ร้านค้า',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ขนาดพื้นที่(ต.ร.ม.)',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'วันสิ้นสุดสัญญา',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          controller: _scrollController3,
                                          // itemExtent: 50,
                                          // physics:
                                          //     const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: teNantModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              color: tappedIndex_3 ==
                                                      index.toString()
                                                  ? tappedIndex_Color
                                                      .tappedIndex_Colors
                                                      .withOpacity(0.5)
                                                  : null,
                                              child: ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      tappedIndex_1 = '';
                                                      tappedIndex_2 = '';
                                                      tappedIndex_3 =
                                                          index.toString();
                                                      tappedIndex_4 = '';
                                                      tappedIndex_5 = '';
                                                    });
                                                  },
                                                  title: Container(
                                                    decoration:
                                                        const BoxDecoration(
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
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              '${teNantModels[index].ln}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              teNantModels[index]
                                                                          .ln_c ==
                                                                      null
                                                                  ? '${teNantModels[index].ln_q}'
                                                                  : '${teNantModels[index].ln_c}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 25,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            teNantModels[index]
                                                                        .sname ==
                                                                    null
                                                                ? '${teNantModels[index].sname_q}'
                                                                : '${teNantModels[index].sname}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: HomeScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 25,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            teNantModels[index]
                                                                        .area_c ==
                                                                    null
                                                                ? '${nFormat.format(double.parse(teNantModels[index].area_q!))}'
                                                                : '${nFormat.format(double.parse(teNantModels[index].area_c!))}',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                const TextStyle(
                                                              color: HomeScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              teNantModels[index]
                                                                          .ldate ==
                                                                      null
                                                                  ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].ldate_q} 00:00:00'))}'
                                                                  : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].ldate} 00:00:00'))}',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                //fontSize: 10.0
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
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
                                      onTap: () {
                                        _scrollController3.animateTo(
                                          0,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeOut,
                                        );
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            // color: AppbackgroundColor
                                            //     .TiTile_Colors,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(8)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            'Top',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_scrollController3.hasClients) {
                                        final position = _scrollController3
                                            .position.maxScrollExtent;
                                        _scrollController3.animateTo(
                                          position,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeOut,
                                        );
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          // color: AppbackgroundColor
                                          //     .TiTile_Colors,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(3.0),
                                        child: const Text(
                                          'Down',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
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
                                    onTap: _moveUp3,
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
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Text(
                                        'Scroll',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      )),
                                  InkWell(
                                    onTap: _moveDown3,
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
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  /////////////---------------------------------------------------------->
  Widget Datalist4_mobile_wiget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          serBody_modile_wiget = 0;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'รายการค้างชำระ',
                          style: TextStyle(
                            color: HomeScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                            //fontSize: 10.0
                          ),
                        ),
                        // Icon(
                        //   Icons.next_plan,
                        //   color: HomeScreen_Color.Colors_Text1_,
                        // )
                      ],
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  children: [
                    ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        dragStartBehavior: DragStartBehavior.start,
                        child: Row(
                          children: [
                            Container(
                                width: 800,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 800,
                                      decoration: BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'รหัสพื้นที่',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ร้านค้า',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'รายการ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'จำนวนเงิน',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'กำหนดชำระ',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          controller: _scrollController4,
                                          // itemExtent: 50,
                                          // physics:
                                          //     const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: teNantTwoModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              color: tappedIndex_4 ==
                                                      index.toString()
                                                  ? tappedIndex_Color
                                                      .tappedIndex_Colors
                                                      .withOpacity(0.5)
                                                  : null,
                                              child: ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      tappedIndex_1 = '';
                                                      tappedIndex_2 = '';
                                                      tappedIndex_3 = '';
                                                      tappedIndex_4 =
                                                          index.toString();
                                                      tappedIndex_5 = '';
                                                    });
                                                  },
                                                  title: Container(
                                                    decoration:
                                                        const BoxDecoration(
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
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              '${teNantTwoModels[index].lncode}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              '${teNantTwoModels[index].sname}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            '${teNantTwoModels[index].total}',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.end,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              color: HomeScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              '${DateFormat('dd-MM').format(DateTime.parse('${teNantTwoModels[index].sdate} 00:00:00'))}-${DateTime.parse('${teNantTwoModels[index].sdate} 00:00:00').year + 543}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              '${teNantTwoModels[index].count_bill} รายการ',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color: HomeScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
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
                                      onTap: () {
                                        _scrollController4.animateTo(
                                          0,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeOut,
                                        );
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            // color: AppbackgroundColor
                                            //     .TiTile_Colors,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(8)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            'Top',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_scrollController4.hasClients) {
                                        final position = _scrollController4
                                            .position.maxScrollExtent;
                                        _scrollController4.animateTo(
                                          position,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeOut,
                                        );
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          // color: AppbackgroundColor
                                          //     .TiTile_Colors,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(3.0),
                                        child: const Text(
                                          'Down',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
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
                                    onTap: _moveUp4,
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
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Text(
                                        'Scroll',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      )),
                                  InkWell(
                                    onTap: _moveDown4,
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
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
