import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Constant/Myconstant.dart';
import '../Model/electricity_model.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';

class SetEle extends StatefulWidget {
  const SetEle({super.key});

  @override
  State<SetEle> createState() => _SetEleState();
}

class _SetEleState extends State<SetEle> {
  List<ElectricityModel> electricityModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_Electricity();
  }

  Future<Null> read_Electricity() async {
    if (electricityModels.isNotEmpty) {
      electricityModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_electricity.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ElectricityModel electricityModel = ElectricityModel.fromJson(map);
          setState(() {
            electricityModels.add(electricityModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppbackgroundColor.TiTile_Colors,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Translate.TranslateAndSetText(
                    'ปรับตั้งค่า การคำนวณอัตราค่าไฟ',
                    PeopleChaoScreen_Color.Colors_Text1_,
                    TextAlign.center,
                    FontWeight.bold,
                    Font_.Fonts_T,
                    14,
                    1),
                // Text(
                //   'ปรับตั้งค่า การคำนวณอัตราค่าไฟ',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: SettingScreen_Color.Colors_Text1_,
                //     fontFamily: FontWeight_.Fonts_T,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  String? ren = preferences.getString('renTalSer');
                  String? ser_user = preferences.getString('ser');

                  String url =
                      '${MyConstant().domain}/InC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user';

                  try {
                    var response = await http.get(Uri.parse(url));

                    var result = json.decode(response.body);
                    print(result);
                    if (result.toString() == 'Yes') {
                      setState(() {
                        read_Electricity();
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Translate.TranslateAndSetText(
                                    'ไม่สามารถเพิ่มได้',
                                    PeopleChaoScreen_Color.Colors_Text1_,
                                    TextAlign.center,
                                    null,
                                    Font_.Fonts_T,
                                    12,
                                    1),
                                //  Text(
                                //   'ไม่สามารถเพิ่มได้',
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     color: SettingScreen_Color.Colors_Text1_,
                                //     fontFamily: Font_.Fonts_T,
                                //   ),
                                // ),
                              ),
                            );
                          });
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  width: 150,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    // border: Border.all(
                    //     color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Translate.TranslateAndSetText(
                      '+ เพิ่มอัตราคำนวณ',
                      PeopleChaoScreen_Color.Colors_Text3_,
                      TextAlign.center,
                      null,
                      Font_.Fonts_T,
                      12,
                      1),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppbackgroundColor.TiTile_Colors,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Translate.TranslateAndSetText(
                      'ประเภท',
                      PeopleChaoScreen_Color.Colors_Text1_,
                      TextAlign.center,
                      FontWeight.bold,
                      FontWeight_.Fonts_T,
                      12,
                      1),
                  // Text(
                  //   'ประเภท',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: SettingScreen_Color.Colors_Text1_,
                  //     fontFamily: FontWeight_.Fonts_T,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Translate.TranslateAndSetText(
                      'ค่าบริการ',
                      PeopleChaoScreen_Color.Colors_Text1_,
                      TextAlign.center,
                      FontWeight.bold,
                      FontWeight_.Fonts_T,
                      12,
                      1),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Translate.TranslateAndSetText(
                      'ค่า Ft',
                      PeopleChaoScreen_Color.Colors_Text1_,
                      TextAlign.center,
                      FontWeight.bold,
                      FontWeight_.Fonts_T,
                      12,
                      1),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Vat %',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: SettingScreen_Color.Colors_Text1_,
                      fontFamily: FontWeight_.Fonts_T,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Translate.TranslateAndSetText(
                              'ขั้นที่ 1',
                              PeopleChaoScreen_Color.Colors_Text1_,
                              TextAlign.center,
                              FontWeight.bold,
                              FontWeight_.Fonts_T,
                              12,
                              1),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'ต่อหน่วย',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'เหมา',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Translate.TranslateAndSetText(
                              'ขั้นที่ 2',
                              PeopleChaoScreen_Color.Colors_Text1_,
                              TextAlign.center,
                              FontWeight.bold,
                              FontWeight_.Fonts_T,
                              12,
                              1),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'ต่อหน่วย',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'เหมา',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Translate.TranslateAndSetText(
                              'ขั้นที่ 3',
                              PeopleChaoScreen_Color.Colors_Text1_,
                              TextAlign.center,
                              FontWeight.bold,
                              FontWeight_.Fonts_T,
                              12,
                              1),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'ต่อหน่วย',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'เหมา',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Translate.TranslateAndSetText(
                              'ขั้นที่ 4',
                              PeopleChaoScreen_Color.Colors_Text1_,
                              TextAlign.center,
                              FontWeight.bold,
                              FontWeight_.Fonts_T,
                              12,
                              1),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'ต่อหน่วย',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'เหมา',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Translate.TranslateAndSetText(
                              'ขั้นที่ 5',
                              PeopleChaoScreen_Color.Colors_Text1_,
                              TextAlign.center,
                              FontWeight.bold,
                              FontWeight_.Fonts_T,
                              12,
                              1),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'ต่อหน่วย',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'เหมา',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Translate.TranslateAndSetText(
                              'ขั้นที่ 6',
                              PeopleChaoScreen_Color.Colors_Text1_,
                              TextAlign.center,
                              FontWeight.bold,
                              FontWeight_.Fonts_T,
                              12,
                              1),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'ต่อหน่วย',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                          Expanded(
                            child: Translate.TranslateAndSetText(
                                'เหมา',
                                PeopleChaoScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.bold,
                                FontWeight_.Fonts_T,
                                12,
                                1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Translate.TranslateAndSetText(
                      'ลบ',
                      PeopleChaoScreen_Color.Colors_Text1_,
                      TextAlign.center,
                      FontWeight.bold,
                      FontWeight_.Fonts_T,
                      12,
                      1),
                ),
              ),
            ],
          ),
        ),
        for (int index = 0; index < electricityModels.length; index++)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      // initialValue: electricityModels[index].nameEle,
                      onFieldSubmitted: (value) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        String? ren = preferences.getString('renTalSer');
                        String? ser_user = preferences.getString('ser');
                        var ele_colum = 'name_ele';
                        var ele_value = value;
                        var ele_ser = electricityModels[index].ser;

                        String url =
                            '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                        print(url);
                        try {
                          var response = await http.get(Uri.parse(url));

                          var result = json.decode(response.body);
                          print(result);
                          if (result.toString() == 'Yes') {
                            setState(() {
                              read_Electricity();
                            });
                          } else {
                            noAdd(context);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.05),
                          focusColor: Colors.grey.shade200,
                          filled: true,
                          // prefixIcon:
                          //     const Icon(Icons.key, color: Colors.black),
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
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          labelText: electricityModels[index].nameEle,
                          labelStyle: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              fontSize: 12,
                              fontFamily: Font_.Fonts_T)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      // initialValue: electricityModels[index].other,
                      onFieldSubmitted: (value) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        String? ren = preferences.getString('renTalSer');
                        String? ser_user = preferences.getString('ser');
                        var ele_colum = 'other';
                        var ele_value = value;
                        var ele_ser = electricityModels[index].ser;

                        String url =
                            '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                        print(url);
                        try {
                          var response = await http.get(Uri.parse(url));

                          var result = json.decode(response.body);
                          print(result);
                          if (result.toString() == 'Yes') {
                            setState(() {
                              read_Electricity();
                            });
                          } else {
                            noAdd(context);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.05),
                          focusColor: Colors.grey.shade200,
                          filled: true,
                          // prefixIcon:
                          //     const Icon(Icons.key, color: Colors.black),
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
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          labelText:
                              double.parse(electricityModels[index].other!)
                                  .toStringAsFixed(2),
                          labelStyle: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              fontSize: 12,
                              fontFamily: Font_.Fonts_T)),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                        // for version 2 and greater youcan also use this
                        // FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      // initialValue: electricityModels[index].eleTf,
                      onFieldSubmitted: (value) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        String? ren = preferences.getString('renTalSer');
                        String? ser_user = preferences.getString('ser');
                        var ele_colum = 'ele_tf';
                        var ele_value = value;
                        var ele_ser = electricityModels[index].ser;

                        String url =
                            '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                        print(url);
                        try {
                          var response = await http.get(Uri.parse(url));

                          var result = json.decode(response.body);
                          print(result);
                          if (result.toString() == 'Yes') {
                            setState(() {
                              read_Electricity();
                            });
                          } else {
                            noAdd(context);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.05),
                          focusColor: Colors.grey.shade200,
                          filled: true,
                          // prefixIcon:
                          //     const Icon(Icons.key, color: Colors.black),
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
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          labelText:
                              double.parse(electricityModels[index].eleTf!)
                                  .toStringAsFixed(4),
                          labelStyle: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              fontSize: 12,
                              fontFamily: Font_.Fonts_T)),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                        // for version 2 and greater youcan also use this
                        // FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      // initialValue: electricityModels[index].vat,
                      onFieldSubmitted: (value) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        String? ren = preferences.getString('renTalSer');
                        String? ser_user = preferences.getString('ser');
                        var ele_colum = 'vat';
                        var ele_value = value;
                        var ele_ser = electricityModels[index].ser;

                        String url =
                            '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                        print(url);
                        try {
                          var response = await http.get(Uri.parse(url));

                          var result = json.decode(response.body);
                          print(result);
                          if (result.toString() == 'Yes') {
                            setState(() {
                              read_Electricity();
                            });
                          } else {
                            noAdd(context);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.05),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          focusColor: Colors.grey.shade200,
                          focusedBorder: const OutlineInputBorder(
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
                          enabledBorder: const OutlineInputBorder(
                            // borderRadius: BorderRadius.only(
                            //   topRight: Radius.circular(15),
                            //   topLeft: Radius.circular(15),
                            //   bottomRight: Radius.circular(15),
                            //   bottomLeft: Radius.circular(15),
                            // ),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          labelText: double.parse(electricityModels[index].vat!)
                              .toStringAsFixed(2),
                          labelStyle: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              fontSize: 12,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T)),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                        // for version 2 and greater youcan also use this
                        // FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Translate.TranslateAndSetText(
                                      '0 ถึง ',
                                      PeopleChaoScreen_Color.Colors_Text1_,
                                      TextAlign.center,
                                      null,
                                      Font_.Fonts_T,
                                      12,
                                      1),
                                  // Text(
                                  //   '0 ถึง ',
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue: electricityModels[index].eleOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_one';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleOne,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    // for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            )
                            // Text(
                            //   '${electricityModels[index].eleOne}',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: SettingScreen_Color.Colors_Text1_,
                            //     fontFamily: Font_.Fonts_T,
                            //   ),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleMitOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_mit_one';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleMitOne,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleMitOne}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_gob_one';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleGobOne,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleGobOne}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Translate.TranslateAndSetText(
                                      '${int.parse(electricityModels[index].eleOne!) + 1} ถึง ',
                                      PeopleChaoScreen_Color.Colors_Text1_,
                                      TextAlign.center,
                                      null,
                                      Font_.Fonts_T,
                                      12,
                                      1),
                                  // Text(
                                  //   '${int.parse(electricityModels[index].eleOne!) + 1} ถึง ',
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_two';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleTwo,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    // for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleGobOne}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            // Text(
                            //   '${electricityModels[index].eleTwo}',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: SettingScreen_Color.Colors_Text1_,
                            //     fontFamily: Font_.Fonts_T,
                            //   ),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_mit_two';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleMitTwo,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleMitTwo}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_gob_two';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleGobTwo,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              //  Text(
                              //   '${electricityModels[index].eleGobTwo}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Translate.TranslateAndSetText(
                                      '${int.parse(electricityModels[index].eleTwo!) + 1} ถึง ',
                                      PeopleChaoScreen_Color.Colors_Text1_,
                                      TextAlign.center,
                                      null,
                                      Font_.Fonts_T,
                                      12,
                                      1),
                                  // Text(
                                  //   '${int.parse(electricityModels[index].eleTwo!) + 1} ถึง ',
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_three';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleThree,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    // for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleMitThree}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            // Text(
                            //   '${electricityModels[index].eleThree}',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: SettingScreen_Color.Colors_Text1_,
                            //     fontFamily: Font_.Fonts_T,
                            //   ),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_mit_three';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleMitThree,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleMitThree}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_gob_three';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleGobThree,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              //  Text(
                              //   '${electricityModels[index].eleGobThree}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Translate.TranslateAndSetText(
                                      '${int.parse(electricityModels[index].eleThree!) + 1} ถึง ',
                                      PeopleChaoScreen_Color.Colors_Text1_,
                                      TextAlign.center,
                                      null,
                                      Font_.Fonts_T,
                                      12,
                                      1),
                                  // Text(
                                  //   '${int.parse(electricityModels[index].eleThree!) + 1} ถึง ',
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_tour';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleTour,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    // for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              //  Text(
                              //   '${electricityModels[index].eleGobTwo}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            // Text(
                            //   '${electricityModels[index].eleTour}',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: SettingScreen_Color.Colors_Text1_,
                            //     fontFamily: Font_.Fonts_T,
                            //   ),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_mit_tour';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleMitTour,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              //  Text(
                              //   '${electricityModels[index].eleMitTour}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_gob_tour';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleGobTour,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              //  Text(
                              //   '${electricityModels[index].eleGobTour}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Translate.TranslateAndSetText(
                                      '${int.parse(electricityModels[index].eleTour!) + 1} ถึง ',
                                      PeopleChaoScreen_Color.Colors_Text1_,
                                      TextAlign.center,
                                      null,
                                      Font_.Fonts_T,
                                      12,
                                      1),
                                  // Text(
                                  //   '${int.parse(electricityModels[index].eleTour!) + 1} ถึง ',
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_five';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleFive,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    // for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              //  Text(
                              //   '${electricityModels[index].eleGobTour}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            // Text(
                            //   '${electricityModels[index].eleFive}',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: SettingScreen_Color.Colors_Text1_,
                            //     fontFamily: Font_.Fonts_T,
                            //   ),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_mit_five';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleMitFive,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              //  Text(
                              //   '${electricityModels[index].eleMitFive}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_gob_five';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleGobFive,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleGobFive}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_six';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleSix,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    // for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleGobFive}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Translate.TranslateAndSetText(
                                      'ขึ้นไป',
                                      PeopleChaoScreen_Color.Colors_Text1_,
                                      TextAlign.center,
                                      null,
                                      Font_.Fonts_T,
                                      12,
                                      1),
                                  // Text(
                                  //   'ขึ้นไป',
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ),
                              ),
                            ),
                            // Text(
                            //   '${electricityModels[index].eleSix}',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: SettingScreen_Color.Colors_Text1_,
                            //     fontFamily: Font_.Fonts_T,
                            //   ),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_mit_six';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleMitSix,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              // Text(
                              //   '${electricityModels[index].eleMitSix}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  // initialValue:
                                  //     electricityModels[index].eleGobOne,
                                  onFieldSubmitted: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    var ele_colum = 'ele_gob_six';
                                    var ele_value = value;
                                    var ele_ser = electricityModels[index].ser;

                                    String url =
                                        '${MyConstant().domain}/UPC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser&ele_colum=$ele_colum&ele_value=$ele_value';
                                    print(url);
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'Yes') {
                                        setState(() {
                                          read_Electricity();
                                        });
                                      } else {
                                        noAdd(context);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.05),
                                      focusColor: Colors.grey.shade200,
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      focusedBorder: const OutlineInputBorder(
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
                                      enabledBorder: const OutlineInputBorder(
                                        // borderRadius: BorderRadius.only(
                                        //   topRight: Radius.circular(15),
                                        //   topLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        //   bottomLeft: Radius.circular(15),
                                        // ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      labelText:
                                          electricityModels[index].eleGobSix,
                                      labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9 .]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              //  Text(
                              //   '${electricityModels[index].eleGobSix}',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: SettingScreen_Color.Colors_Text1_,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () async {
                      print('ลบ ${index}');

                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      String? ren = preferences.getString('renTalSer');
                      String? ser_user = preferences.getString('ser');

                      var ele_ser = electricityModels[index].ser;

                      String url =
                          '${MyConstant().domain}/DeC_electricity.php?isAdd=true&ren=$ren&ser_user=$ser_user&ele_ser=$ele_ser';

                      try {
                        var response = await http.get(Uri.parse(url));

                        var result = json.decode(response.body);
                        print(result);
                        if (result.toString() == 'Yes') {
                          setState(() {
                            read_Electricity();
                          });
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'ไม่สามารถลบรายการได้ เนื่องจากมีสัญญาใช้อัตราคำนวณนี้อยู่',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            SettingScreen_Color.Colors_Text1_,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                        child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 20,
                      child: Center(
                          child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      )),
                    )),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     print('ลบ ${index}');
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: Text(
                  //       'ลบ',
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         color: Colors.red,
                  //         fontFamily: Font_.Fonts_T,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Future<dynamic> noAdd(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'ไม่สามารถแก้ไขได้',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: SettingScreen_Color.Colors_Text1_,
                  fontFamily: Font_.Fonts_T,
                ),
              ),
            ),
          );
        });
  }
}
