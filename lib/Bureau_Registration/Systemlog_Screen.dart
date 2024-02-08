// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetC_Syslog.dart';
import '../Model/GetRenTal_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class SystemlogScreen extends StatefulWidget {
  final Status_3_;
  const SystemlogScreen({super.key, this.Status_3_});

  @override
  State<SystemlogScreen> createState() => _SystemlogScreenState();
}

class _SystemlogScreenState extends State<SystemlogScreen> {
  int Count_OFF_SET = 0;
  List<RenTalModel> renTalModels = [];
  List<SyslogModel> syslogModel = [];
  List<SyslogModel> _syslogModel = <SyslogModel>[];
  List<SyslogModel> syslogModel_User = [];
  List<SyslogModel> _syslogModel_User = <SyslogModel>[];
  String tappedIndex_ = '';
  String? renTal_user, renTal_name, zone_ser, zone_name;
  String? ser_user,
      foder,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      tel_user,
      img_,
      img_logo;
  var Value_selectDate;
  int Status_3_ = 0;
  List Status_3 = [
    'ทั้งหมด',
    'พื้นที่เช่า',
    'ผู้เช่า',
    'บัญชี',
    'จัดการ',
    'รายงาน',
    'ทะเบียน',
    'ตั้งค่า'
  ];
  List Status_User = ['ทั้งหมด', 'ชำระ', 'ประวัติชำระ', 'ข้อมูลส่วนตัว'];
  int ser_type_TapMan = 0;
  @override
  void initState() {
    checkPreferance();
    red_Syslog();
    read_GC_rental();
    super.initState();
  }

  Future<Null> checkPreferance() async {
    DateTime currentDate = DateTime.now();

    // Format the date as 'YYYY-MM-DD'
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      Value_selectDate = formattedDate;
    });
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var utype = preferences.getString('utype');
    var seruser = preferences.getString('ser');
    String url =
        '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

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

            img_ = img;
            img_logo = imglogo;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> red_Syslog() async {
    print('red_Syslogred_Syslogred_Syslogred_Syslogred_Syslog');
    if (syslogModel.length != 0) {
      syslogModel.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ser_user = preferences.getString('ser');

    String Status_ = (ser_type_TapMan == 0)
        ? '${Status_3[Status_3_]}'
        : '${Status_User[Status_3_]}';

    String url = (Value_selectDate == null)
        ? '${MyConstant().domain}/GC_Syslog.php?isAdd=true&ren=$ren&datex_=null&status=$Status_&count_OFFSET=$Count_OFF_SET'
        : '${MyConstant().domain}/GC_Syslog.php?isAdd=true&ren=$ren&datex_=$Value_selectDate&status=$Status_&count_OFFSET=$Count_OFF_SET';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          SyslogModel syslogModels = SyslogModel.fromJson(map);
          if (syslogModels.uid.toString() == '0' && ser_type_TapMan == 0) {
            setState(() {
              syslogModel.add(syslogModels);
              _syslogModel = syslogModel;
            });
          } else if (syslogModels.uid.toString() == '1' &&
              ser_type_TapMan == 1) {
            if (syslogModels.frm.toString() != 'ล็อคอิน') {
              setState(() {
                syslogModel.add(syslogModels);
                _syslogModel = syslogModel;
              });
            } else {}
          } else {}
        }

        print('00000000>>>>>>>>>>>>>>>>> ${syslogModel.length}');
      } else {}
    } catch (e) {}
  }

  ///////////////------------------------------------------------->c_syslog
  ScrollController _scrollController1 = ScrollController();
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  Future<Null> _select_Date(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่เริ่มต้น', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      // selectableDayPredicate: _decideWhichDayToEnable,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppBarColors.ABar_Colors, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    picked.then((result) {
      if (picked != null) {
        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_selectDate = "${formatter.format(result)}";
        });
      }
      red_Syslog();
    });
  }

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        // fontSize: 22.0,
        color: TextHome_Color.TextHome_Colors,
      ),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(
          // fontSize: 20.0,
          color: TextHome_Color.TextHome_Colors,
        ),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (text) {
        text = text.toLowerCase();
        // setState(() {
        //   syslogModel = _syslogModel.where((syslogModelss) {
        //     var notTitle = syslogModelss.username!.toLowerCase();
        //     return notTitle.contains(text);
        //   }).toList();
        // });
        setState(() {
          syslogModel = _syslogModel.where((syslogModelss) {
            var notTitle = syslogModelss.username.toString().toLowerCase();
            var notTitle2 = syslogModelss.ip.toString().toLowerCase();
            var notTitle3 = syslogModelss.timex.toString().toLowerCase();
            var notTitle4 = syslogModelss.frm.toString().toLowerCase();
            var notTitle5 = syslogModelss.datex.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text);
          }).toList();
        });
      },
    );
  }

  ///----------------------->
  Widget Next_page() {
    return Row(
      children: [
        Expanded(child: Text('')),
        StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 300)),
            builder: (context, snapshot) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: Colors.grey,
                      size: 20,
                    ),
                    InkWell(
                        onTap: (Count_OFF_SET == 0)
                            ? null
                            : () async {
                                if (Count_OFF_SET == 0) {
                                } else {
                                  Count_OFF_SET = Count_OFF_SET - 100;
                                  setState(() {
                                    checkPreferance();
                                    red_Syslog();
                                    read_GC_rental();
                                  });
                                }
                              },
                        child: Icon(
                          Icons.arrow_left,
                          color: (Count_OFF_SET == 0)
                              ? Colors.grey[200]
                              : Colors.black,
                          size: 25,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        // '$Count_OFF_SET',
                        (Count_OFF_SET == 0)
                            ? '${Count_OFF_SET + 1}'
                            : '${(Count_OFF_SET / 100) + 1}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                          //fontSize: 10.0
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (syslogModel.length == 0)
                            ? null
                            : () async {
                                Count_OFF_SET = Count_OFF_SET + 100;
                                setState(() {
                                  checkPreferance();
                                  red_Syslog();
                                  read_GC_rental();
                                });
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: (syslogModel.length == 0)
                              ? Colors.grey[200]
                              : Colors.black,
                          size: 25,
                        )),
                  ],
                ),
              );
            }),
      ],
    );
  }

///////////--------------------------------->
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.white, width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              ser_type_TapMan = 0;
                              Status_3_ = 0;
                              Count_OFF_SET = 0;
                            });
                            red_Syslog();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: (ser_type_TapMan == 0)
                                    ? Colors.black
                                    : Colors.grey,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: const Center(
                                child: Text(
                                  'ระบบแอดมิน',
                                  style: TextStyle(
                                      color: Colors.white,
                                      // fontSize: 10.0,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              ser_type_TapMan = 1;
                              Status_3_ = 0;
                              Count_OFF_SET = 0;
                            });
                            red_Syslog();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: (ser_type_TapMan == 1)
                                    ? Colors.black
                                    : Colors.grey,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: const Center(
                                child: Text(
                                  'ระบบผู้ใช้ทั่วไป',
                                  style: TextStyle(
                                      color: Colors.white,
                                      // fontSize: 10.0,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              }),
                              child: (ser_type_TapMan == 0)
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(children: [
                                        for (int i = 0;
                                            i < Status_3.length;
                                            i++)
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    tappedIndex_ = '';
                                                    Status_3_ = i;
                                                    Count_OFF_SET = 0;
                                                  });
                                                  red_Syslog();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: (i + 1 == 1)
                                                        ? (Status_3_ == i)
                                                            ? Colors.blue[700]
                                                            : Colors.blue[200]
                                                        : (i + 1 == 2)
                                                            ? (Status_3_ == i)
                                                                ? Colors.grey[
                                                                    700]
                                                                : Colors
                                                                    .grey[300]
                                                            : (i + 1 == 3)
                                                                ? (Status_3_ ==
                                                                        i)
                                                                    ? Colors.purple[
                                                                        700]
                                                                    : Colors.purple[
                                                                        200]
                                                                : (i + 1 == 4)
                                                                    ? (Status_3_ ==
                                                                            i)
                                                                        ? Colors.amber[
                                                                            700]
                                                                        : Colors.amber[
                                                                            200]
                                                                    : (i + 1 ==
                                                                            5)
                                                                        ? (Status_3_ ==
                                                                                i)
                                                                            ? Colors.lime[
                                                                                700]
                                                                            : Colors.lime[
                                                                                200]
                                                                        : (i + 1 ==
                                                                                6)
                                                                            ? (Status_3_ == i)
                                                                                ? Colors.blueGrey[700]
                                                                                : Colors.blueGrey[200]
                                                                            : (i + 1 == 7)
                                                                                ? (Status_3_ == i)
                                                                                    ? Colors.brown[700]
                                                                                    : Colors.brown[200]
                                                                                : (Status_3_ == i)
                                                                                    ? Colors.red[700]
                                                                                    : Colors.red[200],
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
                                                    border: (Status_3_ == i)
                                                        ? Border.all(
                                                            color: Colors.white,
                                                            width: 1)
                                                        : null,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      Status_3[i],
                                                      style: TextStyle(
                                                          color: (Status_3_ ==
                                                                  i)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                      ]))
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(children: [
                                        for (int i = 0;
                                            i < Status_User.length;
                                            i++)
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    tappedIndex_ = '';
                                                    Status_3_ = i;
                                                  });
                                                  red_Syslog();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: (i + 1 == 1)
                                                        ? Colors.blue[300]
                                                        : (i + 1 == 2)
                                                            ? Colors.grey[300]
                                                            : (i + 1 == 3)
                                                                ? Colors
                                                                    .purple[300]
                                                                : (i + 1 == 4)
                                                                    ? Colors.amber[
                                                                        300]
                                                                    : (i + 1 ==
                                                                            5)
                                                                        ? Colors.lime[
                                                                            300]
                                                                        : (i + 1 ==
                                                                                6)
                                                                            ? Colors.blueGrey[300]
                                                                            : (i + 1 == 7)
                                                                                ? Colors.brown[300]
                                                                                : Colors.red[300],
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
                                                    border: (Status_3_ == i)
                                                        ? Border.all(
                                                            color: Colors.white,
                                                            width: 1)
                                                        : null,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      Status_User[i],
                                                      style: TextStyle(
                                                          color: (Status_3_ ==
                                                                  i)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                      ])),
                            ),
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     if (Value_selectDate != null) {
                      //       _displayPdf();
                      //     } else {
                      //       showDialog<String>(
                      //         barrierDismissible: false,
                      //         context: context,
                      //         builder: (BuildContext context) => AlertDialog(
                      //           shape: const RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(20.0))),
                      //           title: const Center(
                      //               child: Text(
                      //             'กรุณาเลือกวันที่ !!',
                      //             style: TextStyle(
                      //               color: Colors.red,
                      //               // fontWeight: FontWeight.bold,
                      //               fontFamily: FontWeight_.Fonts_T,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           )),
                      //           content: const Padding(
                      //             padding: EdgeInsets.all(8.0),
                      //             child: Text(
                      //               'กรุณาเลือกวันที่ แบบระบุวันที่',
                      //               textAlign: TextAlign.center,
                      //               style: TextStyle(
                      //                   color:
                      //                       CustomerScreen_Color.Colors_Text1_,
                      //                   // fontWeight: FontWeight.bold,
                      //                   fontFamily: Font_.Fonts_T),
                      //             ),
                      //           ),
                      //           actions: [
                      //             Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: InkWell(
                      //                 onTap: () {
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: Container(
                      //                     height: 50,
                      //                     decoration: BoxDecoration(
                      //                       color: Colors.black,
                      //                       borderRadius: const BorderRadius
                      //                               .only(
                      //                           topLeft: Radius.circular(10),
                      //                           topRight: Radius.circular(10),
                      //                           bottomLeft: Radius.circular(10),
                      //                           bottomRight:
                      //                               Radius.circular(10)),
                      //                       border: Border.all(
                      //                           color: Colors.grey, width: 1),
                      //                     ),
                      //                     padding: const EdgeInsets.all(3.0),
                      //                     child: const Center(
                      //                       child: Text(
                      //                         'ปิด',
                      //                         style: TextStyle(
                      //                             color: Colors.white,
                      //                             // fontSize: 10.0,
                      //                             fontFamily:
                      //                                 FontWeight_.Fonts_T),
                      //                       ),
                      //                     )),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     // height: 50,
                      //     width: 100,
                      //     decoration: BoxDecoration(
                      //       color: Colors.green[600],
                      //       borderRadius: const BorderRadius.only(
                      //           topLeft: Radius.circular(10),
                      //           topRight: Radius.circular(10),
                      //           bottomLeft: Radius.circular(10),
                      //           bottomRight: Radius.circular(10)),
                      //       border: Border.all(color: Colors.grey, width: 1),
                      //     ),
                      //     padding: const EdgeInsets.all(4.0),
                      //     child: Center(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.all(4.0),
                      //             child: Icon(
                      //               Icons.print,
                      //               color: (Status_3_ + 1 == 1)
                      //                   ? Colors.blue[100]
                      //                   : (Status_3_ + 1 == 2)
                      //                       ? Colors.grey[100]
                      //                       : (Status_3_ + 1 == 3)
                      //                           ? Colors.purple[100]
                      //                           : (Status_3_ + 1 == 4)
                      //                               ? Colors.amber[100]
                      //                               : (Status_3_ + 1 == 5)
                      //                                   ? Colors.lime[100]
                      //                                   : (Status_3_ + 1 == 6)
                      //                                       ? Colors
                      //                                           .blueGrey[100]
                      //                                       : (Status_3_ + 1 ==
                      //                                               7)
                      //                                           ? Colors
                      //                                               .brown[100]
                      //                                           : Colors
                      //                                               .red[100],
                      //             ),
                      //           ),
                      //           const Padding(
                      //             padding: EdgeInsets.all(4.0),
                      //             child: Text(
                      //               'พิมพ์',
                      //               style: TextStyle(
                      //                 color:
                      //                     PeopleChaoScreen_Color.Colors_Text1_,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontFamily: FontWeight_.Fonts_T,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: (Responsive.isDesktop(context))
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'ค้นหา:',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        width: 120,
                                        height: 35,
                                        child: _searchBar(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'ประวัติการใช้งาน',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ReportScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'วันที่ :',
                                        style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          width: 120,
                                          padding: const EdgeInsets.all(8.0),
                                          child: PopupMenuButton(
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      (Value_selectDate == null)
                                                          ? 'ทั้งหมด'
                                                          : '$Value_selectDate',
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            itemBuilder:
                                                (BuildContext context) => [
                                              PopupMenuItem(
                                                child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        Value_selectDate = null;
                                                        Count_OFF_SET = 0;
                                                      });
                                                      red_Syslog();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Row(
                                                          children: const [
                                                            Expanded(
                                                              child: Text(
                                                                'เลือกทั้งหมด',
                                                                style: TextStyle(
                                                                    color: ReportScreen_Color.Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            )
                                                          ],
                                                        ))),
                                              ),
                                              PopupMenuItem(
                                                child: InkWell(
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      Count_OFF_SET = 0;
                                                      _select_Date(context);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Row(
                                                          children: const [
                                                            Expanded(
                                                              child: Text(
                                                                'เลือกวันที่',
                                                                style: TextStyle(
                                                                    color: ReportScreen_Color.Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            )
                                                          ],
                                                        ))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            }),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'ค้นหา:',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
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
                                            width: 120,
                                            height: 35,
                                            child: _searchBar(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ประวัติการใช้งาน',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'วันที่ :',
                                            style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {},
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
                                              width: 120,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: PopupMenuButton(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          (Value_selectDate ==
                                                                  null)
                                                              ? 'ทั้งหมด'
                                                              : '$Value_selectDate',
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                        onTap: () async {
                                                          setState(() {
                                                            Value_selectDate =
                                                                null;
                                                          });
                                                          red_Syslog();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Row(
                                                              children: const [
                                                                Expanded(
                                                                  child: Text(
                                                                    'เลือกทั้งหมด',
                                                                    style: TextStyle(
                                                                        color: ReportScreen_Color.Colors_Text2_,
                                                                        // fontWeight:
                                                                        //     FontWeight
                                                                        //         .bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                )
                                                              ],
                                                            ))),
                                                  ),
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              context);
                                                          _select_Date(context);
                                                        },
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Row(
                                                              children: const [
                                                                Expanded(
                                                                  child: Text(
                                                                    'เลือกวันที่',
                                                                    style: TextStyle(
                                                                        color: ReportScreen_Color.Colors_Text2_,
                                                                        // fontWeight:
                                                                        //     FontWeight
                                                                        //         .bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                )
                                                              ],
                                                            ))),
                                                  ),
                                                ],
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
                          ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                // border: Border.all(color: Colors.grey, width: 1),
              ),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                }),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: (Responsive.isDesktop(context))
                            ? MediaQuery.of(context).size.width / 1.165
                            : 800,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.TiTile_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Next_page(),
                                      Row(
                                        children: [
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     child: const Center(
                                          //       child: Text(
                                          //         'atype',
                                          //         style: TextStyle(
                                          //             color: CustomerScreen_Color
                                          //                 .Colors_Text1_,
                                          //             fontWeight: FontWeight.bold,
                                          //             fontFamily:
                                          //                 FontWeight_.Fonts_T),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  'วันที่',
                                                  style: TextStyle(
                                                      color:
                                                          CustomerScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  'เวลา',
                                                  style: TextStyle(
                                                      color:
                                                          CustomerScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  'ไอพี(ip)',
                                                  style: TextStyle(
                                                      color:
                                                          CustomerScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     child: const Center(
                                          //       child: Text(
                                          //         'uid',
                                          //         style: TextStyle(
                                          //             color: CustomerScreen_Color
                                          //                 .Colors_Text1_,
                                          //             fontWeight: FontWeight.bold,
                                          //             fontFamily:
                                          //                 FontWeight_.Fonts_T),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  'ผู้ใช้',
                                                  style: TextStyle(
                                                      color:
                                                          CustomerScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  'เมนู',
                                                  style: TextStyle(
                                                      color:
                                                          CustomerScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  'รายละเอียด',
                                                  style: TextStyle(
                                                      color:
                                                          CustomerScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // color: Colors.black,
                                child: ListView.builder(
                                    controller: _scrollController1,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: syslogModel.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Material(
                                        color: tappedIndex_ == index.toString()
                                            ? tappedIndex_Color
                                                .tappedIndex_Colors
                                            : AppbackgroundColor.Sub_Abg_Colors,
                                        child: Container(
                                          // color:
                                          //     tappedIndex_ == index.toString()
                                          //         ? Colors.grey.shade300
                                          //         : null,
                                          padding: const EdgeInsets.all(0),
                                          child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                tappedIndex_ = index.toString();
                                              });
                                            },
                                            title: Container(
                                              decoration: BoxDecoration(
                                                // color: Colors.green[100]!
                                                //     .withOpacity(0.5),
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black12,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  // Expanded(
                                                  //   flex: 1,
                                                  //   child: Container(
                                                  //     child: Center(
                                                  //       child: Text(
                                                  //         '${syslogModel[index].atype}',
                                                  //         style: const TextStyle(
                                                  //             color:
                                                  //                 CustomerScreen_Color
                                                  //                     .Colors_Text2_,
                                                  //             // fontWeight: FontWeight.bold,
                                                  //             fontFamily:
                                                  //                 Font_.Fonts_T),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${syslogModel[index].datex}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              CustomerScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${syslogModel[index].timex}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              CustomerScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${syslogModel[index].ip}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              CustomerScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   flex: 1,
                                                  //   child: Container(
                                                  //     child: Center(
                                                  //       child: Text(
                                                  //         '${syslogModel[index].uid}',
                                                  //         style: const TextStyle(
                                                  //             color:
                                                  //                 CustomerScreen_Color
                                                  //                     .Colors_Text2_,
                                                  //             // fontWeight: FontWeight.bold,
                                                  //             fontFamily:
                                                  //                 Font_.Fonts_T),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${syslogModel[index].username}',
                                                      maxLines: 2,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color:
                                                              CustomerScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${syslogModel[index].frm}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              CustomerScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '${syslogModel[index].fdo}',
                                                      maxLines: 2,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color:
                                                              CustomerScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
              width: (Responsive.isDesktop(context))
                  ? MediaQuery.of(context).size.width / 1.165
                  : MediaQuery.of(context).size.width,
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
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(3.0),
                                child: const Text(
                                  'Top',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: FontWeight_.Fonts_T),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_scrollController1.hasClients) {
                              final position =
                                  _scrollController1.position.maxScrollExtent;
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(3.0),
                              child: const Text(
                                'Down',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                    fontFamily: FontWeight_.Fonts_T),
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
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(3.0),
                            child: const Text(
                              'Scroll',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                  fontFamily: FontWeight_.Fonts_T),
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
    ));
  }
  //////////----------------------------------------------------------------->

  void _displayPdf() async {
    List newValuePDFimg = [];
    for (int index = 0; index < 1; index++) {
      if (renTalModels[0].img!.trim() == '') {
        // newValuePDFimg.add(
        //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
      } else {
        newValuePDFimg.add(
            '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
      }
    }
    String bill_addr = ' ${renTalModels[0].bill_addr}';
    String bill_email = ' ${renTalModels[0].bill_email}';
    String bill_tel = ' ${renTalModels[0].bill_tel}';
    String bill_tax = ' ${renTalModels[0].bill_tax}';
    String bill_name = ' ${renTalModels[0].bill_name}';

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var renTal_name = preferences.getString('renTalName');
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();

    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    doc.addPage(
      pw.MultiPage(
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(
                // PdfPageFormat.a4.width, PdfPageFormat.a4.height,
                //   marginAll: 20
                PdfPageFormat.a4.height,
                PdfPageFormat.a4.width,
                marginAll: 20),
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    (netImage.isEmpty)
                        ? pw.Container(
                            height: 72,
                            width: 70,
                            color: PdfColors.grey200,
                            child: pw.Center(
                              child: pw.Text(
                                '$renTal_name ',
                                maxLines: 1,
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  font: ttf,
                                  color: PdfColors.grey300,
                                ),
                              ),
                            ))

                        // pw.Image(
                        //     pw.MemoryImage(iconImage),
                        //     height: 72,
                        //     width: 70,
                        //   )
                        : pw.Image(
                            (netImage[0]),
                            height: 72,
                            width: 70,
                          ),
                    pw.SizedBox(width: 1 * PdfPageFormat.mm),
                    pw.Container(
                      width: 200,
                      child: pw.Column(
                        mainAxisSize: pw.MainAxisSize.min,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '$renTal_name',
                            maxLines: 2,
                            style: pw.TextStyle(
                              fontSize: 14.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                            ),
                          ),
                          pw.Text(
                            '$bill_addr',
                            maxLines: 3,
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              color: PdfColors.grey800,
                              font: ttf,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      width: 180,
                      child: pw.Column(
                        mainAxisSize: pw.MainAxisSize.min,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          // pw.Text(
                          //   'ใบเสนอราคา',
                          //   style: pw.TextStyle(
                          //     fontSize: 12.00,
                          //     fontWeight: pw.FontWeight.bold,
                          //     font: ttf,
                          //   ),
                          // ),
                          // pw.Text(
                          //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                          //   textAlign: pw.TextAlign.right,
                          //   style: pw.TextStyle(
                          //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                          // ),
                          pw.Text(
                            'โทรศัพท์: $bill_tel',
                            textAlign: pw.TextAlign.right,
                            maxLines: 1,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                          pw.Text(
                            'อีเมล: $bill_email',
                            maxLines: 1,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                          pw.Text(
                            'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                            maxLines: 2,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                          pw.Text(
                            'ณ วันที่:  $thaiDate ${DateTime.now().year + 543}',
                            maxLines: 2,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                pw.Divider(),
                pw.SizedBox(height: 4 * PdfPageFormat.mm),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'ประวัติการใช้งาน',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12.0,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black),
                    )
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'วันที่ : $Value_selectDate',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              // fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        )
                        // style: pw.TextStyle(fontSize: 30),
                        ),
                    pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'เมนู : ${Status_3[Status_3_]}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              // fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        )
                        // style: pw.TextStyle(fontSize: 30),
                        ),
                  ],
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Container(
                  decoration: const pw.BoxDecoration(
                      color: PdfColors.green100,
                      border: pw.Border(
                          bottom: pw.BorderSide(
                        color: PdfColors.green900,
                        width: 1.0, // Underline thickness
                      ))),
                  height: 50,
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text('วันที่',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text('เวลา',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text('ไอพี(ip)',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text('ผู้ใช้',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text('เมนู',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text('รายละเอียด',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < syslogModel.length; i++)
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          height: 25,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.white,
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Center(
                              child: pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text('${syslogModel[i].datex}',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 8.0,
                                    font: ttf,
                                    color: PdfColors.black)
                                // style: pw.TextStyle(fontSize: 30),
                                ),
                          )),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          height: 25,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.grey100,
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Center(
                            child: pw.Text('${syslogModel[i].timex}',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: 8.0,
                                    font: ttf,
                                    color: PdfColors.black)
                                // style: pw.TextStyle(fontSize: 30),
                                ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          height: 25,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.white,
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Center(
                            child: pw.Text('${syslogModel[i].ip}',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: 8.0,
                                    font: ttf,
                                    color: PdfColors.black)
                                // style: pw.TextStyle(fontSize: 30),
                                ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          height: 25,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.grey100,
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Center(
                            child: pw.Text('${syslogModel[i].username}',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: 8.0,
                                    font: ttf,
                                    color: PdfColors.black)
                                // style: pw.TextStyle(fontSize: 30),
                                ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          height: 25,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.white,
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Center(
                            child: pw.Text('${syslogModel[i].frm}',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: 8.0,
                                    font: ttf,
                                    color: PdfColors.black)
                                // style: pw.TextStyle(fontSize: 30),
                                ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          height: 25,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.grey100,
                            border: pw.Border(
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Center(
                            child: pw.Text('${syslogModel[i].fdo}',
                                textAlign: pw.TextAlign.center,
                                softWrap: true,
                                maxLines: 2,
                                style: pw.TextStyle(
                                    fontSize: 8.0,
                                    font: ttf,
                                    color: PdfColors.black)
                                // style: pw.TextStyle(fontSize: 30),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ];
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              // pw.Text(
              //   '${fname_}',
              //   textAlign: pw.TextAlign.right,
              //   style: pw.TextStyle(
              //     fontSize: 10,
              //     font: ttf,
              //     color: PdfColors.grey800,
              //     // fontWeight: pw.FontWeight.bold
              //   ),
              // ),
              pw.Text(
                'หน้า ${context.pageNumber} / ${context.pagesCount} ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 10,
                  font: ttf,
                  color: PdfColors.grey800,
                  // fontWeight: pw.FontWeight.bold
                ),
              ),
            ],
          );
        },
      ),
    );

    ////////////---------------------------------------------->
    // final List<int> bytes = await doc.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    ////////////---------------------------------------------->
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewSytemlogScreen(doc: doc),
        ));
  }
}

class PreviewSytemlogScreen extends StatelessWidget {
  final pw.Document doc;

  PreviewSytemlogScreen({super.key, required this.doc});

  static const customSwatch = MaterialColor(
    0xFF8DB95A,
    <int, Color>{
      50: Color(0xFFC2FD7F),
      100: Color(0xFFB6EE77),
      200: Color(0xFFB2E875),
      300: Color(0xFFACDF71),
      400: Color(0xFFA7DA6E),
      500: Color(0xFFA1D16A),
      600: Color(0xFF94BF62),
      700: Color(0xFF90B961),
      800: Color(0xFF85AB5A),
      900: Color(0xFF7A9B54),
    },
  );
  String day_ =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

  String Tim_ =
      '${DateTime.now().hour}.${DateTime.now().minute}.${DateTime.now().second}';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 141, 185, 90),
          leading: IconButton(
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();

              String? _route = preferences.getString('route');
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AdminScafScreen(route: _route));
              Navigator.pushAndRemoveUntil(
                  context, materialPageRoute, (route) => false);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "ประวัติการใช้งาน",
            style:
                TextStyle(color: Colors.white, fontFamily: FontWeight_.Fonts_T),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: true,
          allowPrinting: true, canChangePageFormat: false,
          canChangeOrientation: false, canDebug: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "ประวัติการใช้งาน.pdf",
        ),
      ),
    );
  }
}
