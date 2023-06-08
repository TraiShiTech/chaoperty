import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/Account_Screen.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../ChaoArea/ChaoRe_contact.dart';
import '../Constant/Myconstant.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Manage/Manage_Screen.dart';
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
  int ser_tabbarview_1 = 0;
  List<TeNantModel> teNantModels = [];
  String? areanew, namenew, Sercid;
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
  int ser_tabbarview_2 = 0, contact_new = 0;

  List tabbarview_2 = [
    'ข้อมูลการเช่า',
    'มิเตอร์น้ำไฟฟ้า',
    'วางบิล',
    'รับชำระ',
    'ประวัติบิล',
  ];
  List tabbarview_color_2 = [
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.deepPurple,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    read_GC_teNant();
    print(tabbarview_2.length);
    ser_tabbarview_2 = int.parse(widget.Get_Value_indexpage);
  }

  Future<Null> read_GC_teNant() async {
    if (teNantModels.length != 0) {
      teNantModels.clear();
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
      print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);

          setState(() {
            areanew = teNantModel.area_c;
            namenew = teNantModel.cname;
            Sercid = teNantModel.ser;
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.TiTile_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
              // border: Border.all(color: Colors.white, width: 1),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: AlwaysScrollableScrollPhysics(),
                child: Row(
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
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              title: const Center(
                                  child: Text(
                                'ยกเลิกสัญญา',
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
                                          color: AdminScafScreen_Color
                                              .Colors_Text1_,
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
                                            labelText: 'หมายเหตุ',
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
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextButton(
                                                onPressed: () async {
                                                  print('Ser: ${Sercid}');
                                                  print(
                                                      'Cid: ${widget.Get_Value_cid}');
                                                  print(
                                                      ' เหตุผล :${Formbecause_.text.toString()}');
                                                  String because_ =
                                                      '${Formbecause_.text.toString()}';

                                                  if (because_ == '') {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        title: const Center(
                                                            child: Text(
                                                          'กรุณากรอกเหตุผล !!',
                                                          style: TextStyle(
                                                              color: AdminScafScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        )),
                                                        actions: <Widget>[
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
                                                                        .redAccent,
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
                                                                            Radius.circular(10)),
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
                                                                          fontWeight: FontWeight
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
                                                    );
                                                  } else {
                                                    if (widget.Get_Value_NameShop_index
                                                            .toString() ==
                                                        '1') {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      var ren =
                                                          preferences.getString(
                                                              'renTalSer');
                                                      String url =
                                                          '${MyConstant().domain}/DC_Area_ciddoc.php?isAdd=true&ren=$ren&ciddoc=${widget.Get_Value_cid}&because=$because_';
                                                      try {
                                                        var response =
                                                            await http.get(
                                                                Uri.parse(url));
                                                        var result =
                                                            json.decode(
                                                                response.body);
                                                        print(
                                                            'BBBBBBBBBBBBBBBB>>>> $result');
                                                        Insert_log.Insert_logs(
                                                            'ผู้เช่า',
                                                            'เรียกดู>>ยกเลิกสัญญา(${widget.Get_Value_cid} : $because_');
                                                        if (result.toString() ==
                                                            'true') {
                                                          Navigator.pop(
                                                              context, 'OK');
                                                          widget.updateMessage(
                                                              'PeopleChaoScreen');
                                                          setState(() {
                                                            Formbecause_
                                                                .clear();
                                                          });
                                                        }
                                                      } catch (e) {}
                                                    } else {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      var ren =
                                                          preferences.getString(
                                                              'renTalSer');
                                                      String url =
                                                          '${MyConstant().domain}/DC_Area_quot.php?isAdd=true&ren=$ren&ciddoc=${widget.Get_Value_cid}&because=$because_';
                                                      try {
                                                        var response =
                                                            await http.get(
                                                                Uri.parse(url));
                                                        var result =
                                                            json.decode(
                                                                response.body);
                                                        print(
                                                            'BBBBBBBBBBBBBBBB>>>> $result');
                                                        if (result.toString() ==
                                                            'true') {
                                                          Navigator.pop(
                                                              context, 'OK');
                                                          widget.updateMessage(
                                                              'PeopleChaoScreen');
                                                          setState(() {
                                                            Formbecause_
                                                                .clear();
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.redAccent,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                      const EdgeInsets.all(8.0),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        Formbecause_.clear();
                                                      });
                                                      Navigator.pop(
                                                          context, 'OK');
                                                    },
                                                    child: const Text(
                                                      'ปิด',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
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
                          child: const Text(
                            'ยกเลิกสัญญา',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              // fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                  ],
                ),
              ),
            ),
          ),
        ),
        contact_new == 1
            ? ChaoReContact(
                Value_cid: widget.Get_Value_cid,
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'รหัสพื้นที่ : ',
                                          style: TextStyle(
                                            color:
                                                TextHome_Color.TextHome_Colors,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            '$areanew',
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
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
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                'ชื่อผู้เช่า : ',
                                                style: TextStyle(
                                                  color: TextHome_Color
                                                      .TextHome_Colors,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  '$namenew',
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
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
                                                    const EdgeInsets.all(4.0),
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  widget.Get_Value_NameShop_index
                                                              .toString() ==
                                                          '1'
                                                      ? 'เลขที่ใบสัญญา : '
                                                      : 'เลขที่ใบเสนอราคา : ',
                                                  style: const TextStyle(
                                                    color: TextHome_Color
                                                        .TextHome_Colors,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
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
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    '${widget.Get_Value_cid}',
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                              width: MediaQuery.of(context).size.width * 0.845,
                              decoration: const BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Center(
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  }),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    dragStartBehavior: DragStartBehavior.start,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        for (var index = 0;
                                            index < tabbarview_2.length;
                                            index++)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  ser_tabbarview_2 = index;
                                                });
                                              },
                                              child: Container(
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color: (ser_tabbarview_2 ==
                                                          index)
                                                      ? tabbarview_color_2[
                                                          index][600]
                                                      : tabbarview_color_2[
                                                          index][200],
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
                                                  border: (ser_tabbarview_2 ==
                                                          index)
                                                      ? Border.all(
                                                          color: Colors.white,
                                                          width: 1)
                                                      : null,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '${tabbarview_2[index]}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          (ser_tabbarview_2 ==
                                                                  index)
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                            ),
                                          )
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
                              widget.Get_Value_NameShop_index)
                      : (ser_tabbarview_2 == 1)
                          ? MeterWaterElectric(
                              Get_Value_cid: widget.Get_Value_cid,
                              Get_Value_NameShop_index:
                                  widget.Get_Value_NameShop_index)
                          : (ser_tabbarview_2 == 2)
                              ? Bills(
                                  Get_Value_cid: widget.Get_Value_cid,
                                  Get_Value_NameShop_index:
                                      widget.Get_Value_NameShop_index,
                                  namenew: namenew)
                              // : (ser_tabbarview_2 == 3)
                              //     ? BillsHistory(
                              //         Get_Value_cid: widget.Get_Value_cid,
                              //         Get_Value_NameShop_index:
                              //             widget.Get_Value_NameShop_index)
                              : (ser_tabbarview_2 == 3)
                                  ? Pays(
                                      Get_Value_cid: widget.Get_Value_cid,
                                      Get_Value_NameShop_index:
                                          widget.Get_Value_NameShop_index,
                                      namenew: namenew)
                                  // : (ser_tabbarview_2 == 5)
                                  //     ? PaysHistory(
                                  //         Get_Value_cid: widget.Get_Value_cid,
                                  //         Get_Value_NameShop_index:
                                  //             widget.Get_Value_NameShop_index)
                                  : HistoryBills(
                                      Get_Value_cid: widget.Get_Value_cid,
                                      Get_Value_NameShop_index:
                                          widget.Get_Value_NameShop_index),
                ],
              ),
      ],
    );
  }
}
