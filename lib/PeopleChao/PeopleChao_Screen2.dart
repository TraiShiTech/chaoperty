// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/Account_Screen.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../ChaoArea/ChaoRe_contact.dart';
import '../ChaoArea/ChaoRe_contact_add.dart';
import '../ChaoArea/Chao_Return.dart';
import '../ChaoArea/Chao_Return_madjum.dart';
import '../Constant/Myconstant.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Manage/Manage_Screen.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Report/Report_Screen.dart';
import '../Setting/SettingScreen.dart';
import '../Style/colors.dart';
import 'Bills_.dart';
import 'Bills_history.dart';
import 'History_Bills.dart';
import 'Meter_WaterElectric.dart';
import 'Pays_.dart';
import 'Pays_history.dart';
import 'PeopleChao_Screen.dart';
import 'Rental_Information.dart';
import 'package:http/http.dart' as http;

import 'Seteing_listmenu.dart';
import 'discount_bill.dart';

class PeopleChaoScreen2 extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  final Get_Value_status;
  final updateMessage;
  final Get_Value_indexpage;
  const PeopleChaoScreen2({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
    this.Get_Value_status,
    this.updateMessage,
    this.Get_Value_indexpage,
  });

  @override
  State<PeopleChaoScreen2> createState() => _PeopleChaoScreen2State();
}

class _PeopleChaoScreen2State extends State<PeopleChaoScreen2> {
  /////------------------------------------------------>()
  int ser_tabbarview_1 = 0, _Pakan = 0, renTal_lavel = 0, _Madjum = 0;
  List<TeNantModel> teNantModels = [];
  List<RenTalModel> renTalModels = [];
  String? areanew, namenew, Sercid, cc_datecid, s_datecid, l_datecid;
  final Formbecause_ = TextEditingController();
  List tabbarview_1 = [
    'เงินประกัน',
    'ยกเลิกสัญญา',
    'ซ่อมบำรุง',
  ];
  List tabbarview_color_1 = [
    Colors.orange, //เงินประกัน
    Colors.red, //ยกเลิกสัญญา
    Colors.green, //ซ่อมบำรุง
  ];
  /////------------------------------------------------>()
  int ser_tabbarview_2 = 0, contact_new = 0, contact_add = 0;

  List tabbarview_2 = [
    'ข้อมูลการเช่า',
    'มิเตอร์น้ำไฟฟ้า',
    'วางบิล',
    'ลดหนี้',
    'รับชำระ',
    'ประวัติบิล',
  ];
  List tabbarview_color_2 = [
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.pink,
    Colors.deepPurple,
    Colors.orange,
  ];

  String? rtname,
      type,
      typex,
      renname,
      bill_name,
      bill_addr,
      bill_tax,
      bill_tel,
      bill_email,
      expbill,
      expbill_name,
      bill_default,
      bill_tser,
      foder,
      tem_page_ser,
      newValuePDFimg_QR,
      renTal_name,
      open_disinv;

  @override
  void initState() {
    super.initState();
    read_GC_teNant();
    read_GC_pkan();
    read_GC_Madjum();
    read_GC_rental();
    // print(tabbarview_2.length);
    ser_tabbarview_2 = int.parse(widget.Get_Value_indexpage);
  }

  String Value_DateTime_Step2 = '';
  String Value_rental_type_ = '';
  String Value_rental_type_2 = '';
  String Value_rental_type_3 = '';
  String Value_DateTime_end = '';
  String Value_D_start = '';
  String Value_D_end = '';

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      setState(() {
        renTalModels.clear();
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';
    renTal_name = preferences.getString('renTalName');
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);
          var rtnamex = renTalModel.rtname!.trim();
          var typexs = renTalModel.type!.trim();
          var typexx = renTalModel.typex!.trim();
          var bill_namex = renTalModel.bill_name!.trim();
          var bill_addrx = renTalModel.bill_addr!.trim();
          var bill_taxx = renTalModel.bill_tax!.trim();
          var bill_telx = renTalModel.bill_tel!.trim();
          var bill_emailx = renTalModel.bill_email!.trim();
          var bill_defaultx = renTalModel.bill_default;
          var bill_tserx = renTalModel.tser;
          var name = renTalModel.pn!.trim();
          var foderx = renTalModel.dbn;
          var open_disinvx = renTalModel.open_disinv;
          setState(() {
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            bill_name = bill_namex;
            bill_addr = bill_addrx;
            bill_tax = bill_taxx;
            bill_tel = bill_telx;
            bill_email = bill_emailx;
            bill_default = bill_defaultx;
            bill_tser = bill_tserx;
            tem_page_ser = renTalModel.tem_page!.trim();
            open_disinv = open_disinvx;

            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_pkan() async {
    setState(() {
      _Pakan = 0;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_Pakan.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------  $result');

      if (result.toString() == 'true') {
        setState(() {
          _Pakan = 1;
        });
      }
    } catch (e) {}
    setState(() {
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
    });
  }

  Future<Null> read_GC_Madjum() async {
    setState(() {
      _Madjum = 0;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_Madjum.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------  $result');

      if (result.toString() == 'true') {
        setState(() {
          _Madjum = 1;
        });
      }
    } catch (e) {}
    setState(() {
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
    });
  }

  Future<Null> read_GC_teNant() async {
    if (teNantModels.length != 0) {
      setState(() {
        teNantModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_tenantlook.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);

          setState(() {
            areanew = teNantModel.area_c;
            namenew = teNantModel.cname;
            Sercid = teNantModel.ser;
            cc_datecid = teNantModel.cc_date;
            s_datecid = teNantModel.sdate;
            l_datecid = teNantModel.ldate;
            teNantModels.add(teNantModel);
          });
        }
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        String? _route = preferences.getString('route');
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => AdminScafScreen(route: _route));
        Navigator.pushAndRemoveUntil(
            context, materialPageRoute, (route) => false);
      }
    } catch (e) {}
  }

  ///--------------------------------------------------->
  void updateMessage2(index_s) async {
    setState(() {
      ser_tabbarview_2 = 3;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        ser_tabbarview_2 = 4;
      });
    });
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? _route = preferences.getString('route');
    // MaterialPageRoute materialPageRoute = MaterialPageRoute(
    //     builder: (BuildContext context) => AdminScafScreen(route: _route));
    // Navigator.pushAndRemoveUntil(context, materialPageRoute, (route) => false);
  }

  ///--------------------------------------------------->
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.TiTile_Box,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.white, width: 1),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'สถานะ : ',
                                style: TextStyle(
                                    color: AdminScafScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              calcen_LE(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange[600],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ยกเลิกสัญญา ( กำหนด )',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (widget.Get_Value_NameShop_index.toString() ==
                                  '1') {
                                setState(() {
                                  if (contact_new == 2) {
                                    contact_new = 0;
                                  } else {
                                    contact_new = 2;
                                  }
                                });
                              } else {
                                if (_Madjum == 1) {
                                  setState(() {
                                    if (contact_new == 4) {
                                      contact_new = 0;
                                    } else {
                                      contact_new = 4;
                                    }
                                  });
                                  print('ยกเลิกมัดจำ');
                                } else {
                                  cancel(context);
                                }
                              }

                              // cancel(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red[600],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.Get_Value_NameShop_index.toString() ==
                                        '1'
                                    ? 'ยกเลิกสัญญา'
                                    : 'ยกเลิกใบเสนอราคา',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // widget.Get_Value_NameShop_index.toString() == '1'
                        //     ? _Pakan == 0
                        //         ? SizedBox()
                        //         : Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: InkWell(
                        //               onTap: () {
                        //                 setState(() {
                        //                   if (contact_new == 2) {
                        //                     contact_new = 0;
                        //                   } else {
                        //                     contact_new = 2;
                        //                   }
                        //                 });
                        //               },
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.blue,
                        //                   borderRadius: const BorderRadius.only(
                        //                       topLeft: Radius.circular(10),
                        //                       topRight: Radius.circular(10),
                        //                       bottomLeft: Radius.circular(10),
                        //                       bottomRight: Radius.circular(10)),
                        //                 ),
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: Text(
                        //                   'คืนเงินประกัน',
                        //                   style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontWeight: FontWeight.bold,
                        //                     // fontSize: 15.0,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           )
                        //     : SizedBox(),
                        widget.Get_Value_status == 'ใกล้หมดสัญญา' ||
                                widget.Get_Value_status == 'หมดสัญญา'
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (contact_new == 1) {
                                        contact_new = 0;
                                      } else {
                                        contact_new = 1;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[600],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      contact_new == 1
                                          ? 'ยกเลิกต่อสัญญา'
                                          : 'ต่อสัญญา',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        // fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),

                        // renTal_lavel <= 1
                        //     ? SizedBox()
                        //     : Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: InkWell(
                        //           onTap: () async {
                        //             setState(() {
                        //               if (contact_new == 3) {
                        //                 contact_new = 0;
                        //               } else {
                        //                 contact_new = 3;
                        //               }
                        //             });

                        //             SharedPreferences preferences =
                        //                 await SharedPreferences.getInstance();
                        //             String? ren =
                        //                 preferences.getString('renTalSer');
                        //             String? ser_user = preferences.getString('ser');
                        //             String url2 =
                        //                 '${MyConstant().domain}/D_quotx.php?isAdd=true&ren=$ren&ser_user=$ser_user';

                        //             try {
                        //               var response2 =
                        //                   await http.get(Uri.parse(url2));

                        //               var result2 = json.decode(response2.body);
                        //               print(result2);
                        //               if (result2.toString() == 'true') {}
                        //             } catch (e) {}
                        //           },
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //               color: Colors.blue[600],
                        //               borderRadius: const BorderRadius.only(
                        //                   topLeft: Radius.circular(10),
                        //                   topRight: Radius.circular(10),
                        //                   bottomLeft: Radius.circular(10),
                        //                   bottomRight: Radius.circular(10)),
                        //             ),
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Text(
                        //               contact_new == 3
                        //                   ? 'ยกเลิกเพิ่มค่าบริการ'
                        //                   : 'เพิ่มค่าบริการ',
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //                 // fontSize: 15.0,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       )
                      ],
                    ),
                  ),
                ),
              ),
              cc_datecid == '0000-00-00' ||
                      cc_datecid == null ||
                      cc_datecid == ''
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'วันที่หมดสัญญา : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('$l_datecid 00:00:00'))}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<Object>(
                            stream: Stream.periodic(
                                const Duration(seconds: 1), (i) => i),
                            builder: (context, snapshot) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      // '$l_datecid' ,//
                                      cc_datecid == '0000-00-00' ||
                                              cc_datecid == null ||
                                              cc_datecid == ''
                                          ? ''
                                          : 'กำหนดยกเลิกสัญญา วันที่ : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('$cc_datecid 00:00:00'))}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
            ],
          ),
        ),
        contact_new == 1
            ? ChaoReContact(
                Value_cid: widget.Get_Value_cid,
              )
            : contact_new == 2
                ? ChaoReturn(
                    Get_Value_NameShop_index: widget.Get_Value_NameShop_index,
                    Value_cid: widget.Get_Value_cid,
                  )
                : contact_new == 3
                    ? ChaoReContactAdd(
                        Value_cid: widget.Get_Value_cid,
                      )
                    : contact_new == 4
                        ? ChaoReturnMadjum(
                            Value_cid: widget.Get_Value_cid,
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
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
                                              child: Column(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'รหัสพื้นที่ : ',
                                                      style: TextStyle(
                                                        color: TextHome_Color
                                                            .TextHome_Colors,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: const BorderRadius
                                                                .only(
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
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        '$areanew',
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
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
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    child: Column(
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            'ชื่อผู้เช่า : ',
                                                            style: TextStyle(
                                                              color: TextHome_Color
                                                                  .TextHome_Colors,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft:
                                                                      Radius.circular(
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
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 15,
                                                              '$namenew',
                                                              maxLines: 2,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 15,
                                                              widget.Get_Value_NameShop_index
                                                                          .toString() ==
                                                                      '1'
                                                                  ? 'เลขที่ใบสัญญา : '
                                                                  : 'เลขที่ใบเสนอราคา : ',
                                                              style:
                                                                  const TextStyle(
                                                                color: TextHome_Color
                                                                    .TextHome_Colors,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
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
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 15,
                                                                '${widget.Get_Value_cid}',
                                                                maxLines: 2,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  //0953873075
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.845,
                                          decoration: const BoxDecoration(
                                            // color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          child: Center(
                                            child: ScrollConfiguration(
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    for (var index = 0;
                                                        index <
                                                            tabbarview_2.length;
                                                        index++)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              ser_tabbarview_2 =
                                                                  index;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 200,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: (ser_tabbarview_2 ==
                                                                      index)
                                                                  ? tabbarview_color_2[
                                                                          index]
                                                                      [700]
                                                                  : tabbarview_color_2[
                                                                          index]
                                                                      [200],
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft:
                                                                      Radius.circular(
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
                                                              border: (ser_tabbarview_2 ==
                                                                      index)
                                                                  ? Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 1)
                                                                  : null,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              '${tabbarview_2[index]}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: (ser_tabbarview_2 ==
                                                                          index)
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      15.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    // renTal_lavel <= 1
                                                    //     ? SizedBox()
                                                    //     : Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .all(8.0),
                                                    //         child: InkWell(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               ser_tabbarview_2 =
                                                    //                   5;
                                                    //             });
                                                    //           },
                                                    //           child: Container(
                                                    //             width: 200,
                                                    //             decoration:
                                                    //                 BoxDecoration(
                                                    //               color: Colors
                                                    //                   .orange
                                                    //                   .shade700,
                                                    //               borderRadius: const BorderRadius
                                                    //                   .only(
                                                    //                   topLeft:
                                                    //                       Radius.circular(
                                                    //                           10),
                                                    //                   topRight: Radius
                                                    //                       .circular(
                                                    //                           10),
                                                    //                   bottomLeft: Radius
                                                    //                       .circular(
                                                    //                           10),
                                                    //                   bottomRight: Radius
                                                    //                       .circular(
                                                    //                           10)),
                                                    //               border: (ser_tabbarview_2 ==
                                                    //                       5)
                                                    //                   ? Border.all(
                                                    //                       color: Colors
                                                    //                           .white,
                                                    //                       width: 1)
                                                    //                   : null,
                                                    //             ),
                                                    //             padding:
                                                    //                 const EdgeInsets
                                                    //                     .all(8.0),
                                                    //             child: Text(
                                                    //               'ปรับตั้งหนี้',
                                                    //               textAlign:
                                                    //                   TextAlign
                                                    //                       .center,
                                                    //               style: TextStyle(
                                                    //                   color: (ser_tabbarview_2 ==
                                                    //                           5)
                                                    //                       ? Colors
                                                    //                           .white
                                                    //                       : Colors
                                                    //                           .black,
                                                    //                   fontWeight:
                                                    //                       FontWeight
                                                    //                           .bold,
                                                    //                   fontSize:
                                                    //                       15.0),
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              (ser_tabbarview_2 == 0)
                                  ? RentalInformation(
                                      Get_Value_cid: widget.Get_Value_cid,
                                      Get_Value_NameShop_index:
                                          widget.Get_Value_NameShop_index,
                                      Get_Value_statu: widget.Get_Value_status,
                                    )
                                  : (ser_tabbarview_2 == 1)
                                      ? MeterWaterElectric(
                                          Get_Value_cid: widget.Get_Value_cid,
                                          Get_Value_NameShop_index:
                                              widget.Get_Value_NameShop_index)
                                      : (ser_tabbarview_2 == 2)
                                          ? Bills(
                                              Get_Value_cid:
                                                  widget.Get_Value_cid,
                                              Get_Value_NameShop_index: widget
                                                  .Get_Value_NameShop_index,
                                              namenew: namenew)
                                          : (ser_tabbarview_2 == 3)
                                              ? open_disinv == '0'
                                                  ? Center(
                                                      child: Text(
                                                          'Coming soon...'),
                                                    )
                                                  : DiscountBill(
                                                      Get_Value_cid:
                                                          widget.Get_Value_cid,
                                                    )
                                              : (ser_tabbarview_2 == 4)
                                                  ? Pays(
                                                      updateMessage2:
                                                          updateMessage2,
                                                      Get_Value_cid:
                                                          widget.Get_Value_cid,
                                                      Get_Value_NameShop_index:
                                                          widget
                                                              .Get_Value_NameShop_index,
                                                      namenew: namenew,
                                                      Screen_name: 'PeopleChao',
                                                    )
                                                  // : (ser_tabbarview_2 == 5)
                                                  //     ? PaysHistory(
                                                  //         Get_Value_cid: widget.Get_Value_cid,
                                                  //         Get_Value_NameShop_index:
                                                  //             widget.Get_Value_NameShop_index)
                                                  : (ser_tabbarview_2 == 5)
                                                      ? HistoryBills(
                                                          Get_Value_cid: widget
                                                              .Get_Value_cid,
                                                          Get_Value_NameShop_index:
                                                              widget
                                                                  .Get_Value_NameShop_index)
                                                      : SettringListMenu(
                                                          Get_Value_cid: widget
                                                              .Get_Value_cid,
                                                          Get_Value_NameShop_index:
                                                              widget
                                                                  .Get_Value_NameShop_index),
                            ],
                          ),
      ],
    );
  }

  Future<dynamic> calcen_LE(BuildContext context) {
    final data_text = TextEditingController();
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
        builder: (context, snapshot) {
          return AlertDialog(
              backgroundColor: AppbackgroundColor.Sub_Abg_Colors,
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(10.0),
              actionsPadding: const EdgeInsets.all(6.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'กำหนดวันยกเลิกสัญญา',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              content: SingleChildScrollView(
                  child: ListBody(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: InkWell(
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          locale: const Locale('th', 'TH'),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.parse('$s_datecid 00:00:00'),
                          lastDate: DateTime.parse('$l_datecid 00:00:00')
                              .add(const Duration(days: 50)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppBarColors
                                      .ABar_Colors, // header background color
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

                        if (newDate == null) {
                          return;
                        } else {
                          print('$newDate');

                          String start =
                              DateFormat('yyyy-MM-dd').format(newDate);

                          String end_StratTime =
                              DateFormat('dd-MM-yyy').format(newDate);

                          print('$start ');
                          setState(() {
                            Value_D_start = start;

                            Value_DateTime_Step2 = end_StratTime;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        child: AutoSizeText(
                          Value_DateTime_Step2 == ''
                              ? 'เลือกวันที่'
                              : '$Value_DateTime_Step2',
                          minFontSize: 9,
                          maxFontSize: 16,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: data_text,
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      // validator: (String? value) {
                      //   return (value != null && value.contains('@'))
                      //       ? 'Do not use the @ char.'
                      //       : null;
                      // },
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
              ])),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              read_ED_tenant(data_text.text.toString());
                            },
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
                              child: Text(
                                'ยืนยัน',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ยกเลิก',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]);
        },
      ),
    );
  }

  Future<Null> read_ED_tenant(data_text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');
    var zone_Sub = preferences.getString('zoneSubSer');

    print('zone>>>>>>zone>>>>>$zone');
    var ciddoc = widget.Get_Value_cid;
    var ccdate = Value_D_start;
    var datatext = (data_text == null) ? '' : data_text.toString();

    String url =
        '${MyConstant().domain}/UP_cc_contract.php?isAdd=true&ren=$ren&cid=$ciddoc&ccdate=$ccdate&remark=$datatext';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          Value_D_start = '';

          Value_DateTime_Step2 = '';
          read_GC_teNant();
        });
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  Future<String?> cancel(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
            child: Text(
          widget.Get_Value_NameShop_index.toString() == '1'
              ? 'ยกเลิกสัญญา'
              : 'ยกใบเสนอราคา',
          style: TextStyle(
              color: AdminScafScreen_Color.Colors_Text1_,
              fontWeight: FontWeight.bold,
              fontFamily: FontWeight_.Fonts_T),
        )),
        actions: <Widget>[
          Column(
            children: [
              // const Divider(
              //   color: Colors.grey,
              //   height: 4.0,
              // ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                '${widget.Get_Value_cid}',
                style: const TextStyle(
                    color: AdminScafScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: Formbecause_,
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
                      // prefixIcon: const Icon(Icons.water,
                      //     color: Colors.blue),
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
                      labelText: 'หมายเหตุ',
                      labelStyle: const TextStyle(
                        color: ManageScreen_Color.Colors_Text2_,
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
                            print('Ser: ${Sercid}');
                            print('Cid: ${widget.Get_Value_cid}');
                            print(' เหตุผล :${Formbecause_.text.toString()}');
                            String because_ = '${Formbecause_.text.toString()}';

                            if (because_ == '') {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: const Center(
                                      child: Text(
                                    'กรุณากรอกเหตุผล !!',
                                    style: TextStyle(
                                        color:
                                            AdminScafScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  )),
                                  actions: <Widget>[
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
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text(
                                                'ปิด',
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
                              );
                            } else {
                              if (widget.Get_Value_NameShop_index.toString() ==
                                  '1') {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                var ren = preferences.getString('renTalSer');
                                String url =
                                    '${MyConstant().domain}/DC_Area_ciddoc.php?isAdd=true&ren=$ren&ciddoc=${widget.Get_Value_cid}&because=$because_';
                                try {
                                  var response = await http.get(Uri.parse(url));
                                  var result = json.decode(response.body);
                                  print('BBBBBBBBBBBBBBBB>>>> $result');
                                  Insert_log.Insert_logs('ผู้เช่า',
                                      'เรียกดู>>ยกเลิกสัญญา(${widget.Get_Value_cid} : $because_');
                                  if (result.toString() == 'true') {
                                    Navigator.pop(context, 'OK');
                                    widget.updateMessage('PeopleChaoScreen');
                                    setState(() {
                                      Formbecause_.clear();
                                    });
                                  }
                                } catch (e) {}
                              } else {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                var ren = preferences.getString('renTalSer');
                                String url =
                                    '${MyConstant().domain}/DC_Area_quot.php?isAdd=true&ren=$ren&ciddoc=${widget.Get_Value_cid}&because=$because_';
                                try {
                                  var response = await http.get(Uri.parse(url));
                                  var result = json.decode(response.body);
                                  print('BBBBBBBBBBBBBBBB>>>> $result');
                                  if (result.toString() == 'true') {
                                    Navigator.pop(context, 'OK');
                                    widget.updateMessage('PeopleChaoScreen');
                                    setState(() {
                                      Formbecause_.clear();
                                    });
                                  }
                                } catch (e) {}
                              }
                            }

                            // Navigator.pop(context, 'OK');
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  Formbecause_.clear();
                                });
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text(
                                'ปิด',
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
