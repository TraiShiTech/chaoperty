import 'dart:convert';
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
import '../Manage/Manage_Screen.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetNote_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/Get_maintenance_model.dart';
import '../Model/Get_tenant_tow_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Register/SignUp_Screen.dart';
import '../Report/Report_Screen.dart';
import 'package:http/http.dart' as http;
import '../Responsive/responsive.dart';

import '../Setting/SettingScreen.dart';
import '../Setting/ttt.dart';
import '../Style/colors.dart';

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
  String? renTal_user, renTal_name, sernote;
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
        '${MyConstant().domain}/GC_maintenance.php?isAdd=true&ren=$ren';
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
    var zone = preferences.getString('zonePSer');

    String url = zone == null
        ? '${MyConstant().domain}/GC_tenantAll_setring.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_tenantAll_setring.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_tenant_setring.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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

                print('difference == $difference');

                var daterx_now = DateTime.now();

                var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

                final now = DateTime.now();
                final earlier = daterx_ldate.subtract(const Duration(days: 0));
                var daterx_A = now.isAfter(earlier);
                print(now.isAfter(earlier)); // true
                print(now.isBefore(earlier)); // true

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

        print('result ${_TransReBillModels.length}');
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
      print(result);
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

            print('difference == $difference');

            var daterx_now = DateTime.now();

            var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

            final now = DateTime.now();
            final earlier = daterx_ldate.subtract(const Duration(days: 30));
            var daterx_A = now.isAfter(earlier);
            print(now.isAfter(earlier)); // true
            print(now.isBefore(earlier)); // true
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

        print('00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
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
      print(result);
      if (result != null) {
        for (var map in result) {
          NoteModel noteModel = NoteModel.fromJson(map);
          setState(() {
            noteModels.add(noteModel);
            Form_note.text = noteModel.descr.toString();
            sernote = noteModel.ser.toString();
          });
        }

        print('00000000>>>>>>>>>>>>>>>>> ${teNantModels.length}');
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
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>>>>>>>>>>>>>>>>>>>>>>>>> $serzone');
    String url =
        '${MyConstant().domain}/GC_custo_home.php?isAdd=true&ren=$ren&ser_zone$serzone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            customerModels.add(customerModel);
          });
        }
      }
      print(customerModels.map((e) => e.scname));
    } catch (e) {}
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
  }

  Future<Null> read_GC_rental() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var seruser = preferences.getString('ser');
    var utype = preferences.getString('utype');
    String url =
        '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      for (var map in result) {
        RenTalModel renTalModel = RenTalModel.fromJson(map);
        setState(() {
          renTalModels.add(renTalModel);
        });
      }
    } catch (e) {}
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
        ? BodyHome_mobile()
        : BodyHome_Web();
  }

/////////////---------------------------------------------------------->
  Widget BodyHome_Web() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
          // flex: 1,
          child: Container(
            child: Column(
              children: [
                if (Responsive.isDesktop(context))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'เลือกสถานที่/Portfolio',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: HomeScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        ),
                      ),
                      Padding(
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
                            hint: Text(
                              renTal_name == null ? 'ค้นหา' : '$renTal_name',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: HomeScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
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
                                          color: HomeScreen_Color.Colors_Text2_,
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
                    ],
                  ),
                renTal_user == null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: const Center(
                          child: Text(
                            'กรุณาเลือกสถานที่',
                            style: TextStyle(
                              color: HomeScreen_Color.Colors_Text2_,
                              fontFamily: Font_.Fonts_T,
                            ),
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
                                                  children: const [
                                                    // Icon(
                                                    //   Icons
                                                    //       .settings_input_composite,
                                                    //   color: Colors.white,
                                                    // ),
                                                    Text(
                                                      'โน๊ตส่วนตัว',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                          decoration: const BoxDecoration(
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
                                            children: const [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'รายละเอียด',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: HomeScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
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
                                                                    child:
                                                                        const Text(
                                                                      'รายการรอทำสัญญา',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
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
                                                      decoration:
                                                          const BoxDecoration(
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
                                                        children: const [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                'โซนพื้นที่',
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
                                                                ),
                                                              ),
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
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                'รหัสพื้นที่',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                                ),
                                                              ),
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
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                'ร้านค้า',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                                ),
                                                              ),
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
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                'ขนาดพื้นที่(ต.ร.ม.)',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                                ),
                                                              ),

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
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                'วันนัดหมาย',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
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
                                                                ),
                                                              ),
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
                                                                  title: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
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
                                                                        child:
                                                                            Tooltip(
                                                                          richMessage:
                                                                              TextSpan(
                                                                            text:
                                                                                '${customerModels[index].ln}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                SizedBox(
                                                                              child: AutoSizeText(
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
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Tooltip(
                                                                          richMessage:
                                                                              TextSpan(
                                                                            text:
                                                                                '${customerModels[index].scname}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                SizedBox(
                                                                              child: AutoSizeText(
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
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
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
                                                                            color:
                                                                                HomeScreen_Color.Colors_Text2_,
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
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
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
                                                                    child:
                                                                        const Text(
                                                                      'รายการแจ้งซ่อม',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
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
                                                      decoration:
                                                          const BoxDecoration(
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
                                                        children: const [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'ร้านค้า',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'รหัสพื้นที่',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'รายละเอียด',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'วันแจ้งซ่อม',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'สถานะ',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
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
                                                                  title: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Tooltip(
                                                                          richMessage:
                                                                              TextSpan(
                                                                            text:
                                                                                '${maintenanceModels[index].sname}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Tooltip(
                                                                          richMessage:
                                                                              TextSpan(
                                                                            text:
                                                                                '${maintenanceModels[index].aser}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              '${maintenanceModels[index].aser}',
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
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          '${maintenanceModels[index].mdescr}',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                HomeScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          '${DateFormat('dd-MM').format((DateTime.parse('${maintenanceModels[index].mdate} 00:00:00')))}-${DateTime.parse('${maintenanceModels[index].mdate} 00:00:00').year + 543}',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                HomeScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Colors.white10,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10)),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                AutoSizeText(
                                                                              minFontSize: 10,
                                                                              maxFontSize: 25,
                                                                              maintenanceModels[index].mst == '0'
                                                                                  ? ' '
                                                                                  : maintenanceModels[index].mst == '1'
                                                                                      ? 'รอดำเนินการ'
                                                                                      : 'เสร็จสิ้น',
                                                                              maxLines: 1,
                                                                              textAlign: TextAlign.end,
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
                                                                      ),
                                                                    ],
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
                                                                    child:
                                                                        const Text(
                                                                      'พื้นที่ใกล้หมดสัญญา',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
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
                                                      decoration:
                                                          const BoxDecoration(
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
                                                        children: const [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                'โซนพื้นที่',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
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
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  'รหัสพื้นที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                'ร้านค้า',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                'ขนาดพื้นที่(ต.ร.ม.)',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                'วันสิ้นสุดสัญญา',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
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
                                                                  title: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
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
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Tooltip(
                                                                          richMessage:
                                                                              TextSpan(
                                                                            text: teNantModels[index].ln_c == null
                                                                                ? '${teNantModels[index].ln_q}'
                                                                                : '${teNantModels[index].ln_c}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Tooltip(
                                                                          richMessage:
                                                                              TextSpan(
                                                                            text: teNantModels[index].sname == null
                                                                                ? '${teNantModels[index].sname_q}'
                                                                                : '${teNantModels[index].sname}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
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
                                                                            color:
                                                                                HomeScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
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
                                                                      ),
                                                                    ],
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
                                                                    child:
                                                                        const Text(
                                                                      'รายการค้างชำระ',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
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
                                                      decoration:
                                                          const BoxDecoration(
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
                                                        children: const [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'ร้านค้า',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'รหัสพื้นที่',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'จำนวนเงิน',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'กำหนดชำระ',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'ค้างชำระ',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
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
                                                                  title: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Tooltip(
                                                                          richMessage:
                                                                              TextSpan(
                                                                            text:
                                                                                '${teNantTwoModels[index].sname}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                AutoSizeText(
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
                                                                        flex: 1,
                                                                        child:
                                                                            Tooltip(
                                                                          richMessage:
                                                                              TextSpan(
                                                                            text:
                                                                                '${teNantTwoModels[index].lncode}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              '${teNantTwoModels[index].lncode}',
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
                                                                        flex: 2,
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
                                                                            color:
                                                                                HomeScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${DateFormat('dd-MM').format(DateTime.parse('${teNantTwoModels[index].sdate} 00:00:00'))}-${DateTime.parse('${teNantTwoModels[index].sdate} 00:00:00').year + 543}',
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
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${teNantTwoModels[index].count_bill} รายการ',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
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
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Column(
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
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: const Center(
                                          child: Text(
                                            'กรุณาเลือกสถานที่',
                                            style: TextStyle(
                                              color: HomeScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T,
                                            ),
                                          ),
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
                                      decoration: const BoxDecoration(
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
                                                title: Row(
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
                                                          overflow: TextOverflow
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
                                                        style: const TextStyle(
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
                                                        style: const TextStyle(
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
                                                          overflow: TextOverflow
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
                                        decoration: const BoxDecoration(
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
                                                    title: Row(
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
                                                            textAlign: TextAlign
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
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            '${maintenanceModels[index].mdescr}',
                                                            maxLines: 1,
                                                            textAlign: TextAlign
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
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            '${DateFormat('dd-MM').format((DateTime.parse('${maintenanceModels[index].mdate} 00:00:00')))}-${DateTime.parse('${maintenanceModels[index].mdate} 00:00:00').year + 543}',
                                                            maxLines: 1,
                                                            textAlign: TextAlign
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
                                                              fontFamily:
                                                                  Font_.Fonts_T,
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
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
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
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                                      decoration: const BoxDecoration(
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
                                                  title: Row(
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
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 25,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          teNantModels[index]
                                                                      .sname ==
                                                                  null
                                                              ? '${teNantModels[index].sname_q}'
                                                              : '${teNantModels[index].sname}',
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
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 25,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
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
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
                                      decoration: const BoxDecoration(
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
                                                  title: Row(
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
                                                                TextAlign.left,
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
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '${teNantTwoModels[index].total}',
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.end,
                                                          overflow: TextOverflow
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
                                                            textAlign: TextAlign
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
                                                              fontFamily:
                                                                  Font_.Fonts_T,
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
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
