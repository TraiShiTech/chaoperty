import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_saver/file_saver.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import 'package:http/http.dart' as http;

import '../Style/colors.dart';
import 'PeopleChao_Screen2.dart';
import 'package:pdf/widgets.dart' as pw;
import 'PeopleChao_Screen3.dart';
import 'PeopleChao_Screen4.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;

class PeopleChaoScreen extends StatefulWidget {
  const PeopleChaoScreen({super.key});

  @override
  State<PeopleChaoScreen> createState() => _PeopleChaoScreenState();
}

class _PeopleChaoScreenState extends State<PeopleChaoScreen> {
  DateTime datex = DateTime.now();
  // String rotation = 'vertical';

  ///------------------------------------------------->
  String ReturnBodyPeople = 'PeopleChao_Screen';
  String Ser_PeopleChao_index = ''; //indexรายการหน้าPeopleChao_Screen
  String Value_NameShop_index = ''; //ชื่อร้านค้าหน้าPeopleChao_Screen
  List<ZoneModel> zoneModels = [];

  List<TeNantModel> teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  String? renTal_user, renTal_name, zone_ser, zone_name, Value_cid, fname_;
  String? rtname, type, typex, renname, pkname, ser_Zonex, Value_stasus;
  int? pkqty, pkuser, countarae;
  List<RenTalModel> renTalModels = [];
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
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  int Status_ = 1;
  int index_listviwe = 0;
  ///////---------------------------------------------------->showMyDialog_SAVE
  String _verticalGroupValue_File = "EXCEL";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();
  ///////---------------------------------------------------->
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
    read_GC_zone();
    read_GC_tenant();
    read_GC_rental();
  }

  // Future<Null> read_GC_rental() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var seruser = preferences.getString('ser');
  //   var utype = preferences.getString('utype');
  //   String url =
  //       '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print('read_GC_rental///// $result');
  //     for (var map in result) {
  //       RenTalModel renTalModel = RenTalModel.fromJson(map);
  //       setState(() {
  //         renTalModels.add(renTalModel);
  //       });
  //     }
  //   } catch (e) {}
  // }
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

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');
    });
  }

  Future<Null> read_GC_zone() async {
    if (zoneModels.length != 0) {
      zoneModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['rser'] = '0';
      map['zn'] = 'ทั้งหมด';
      map['qty'] = '0';
      map['img'] = '0';
      map['data_update'] = '0';

      ZoneModel zoneModelx = ZoneModel.fromJson(map);

      setState(() {
        zoneModels.add(zoneModelx);
      });

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
    } catch (e) {}
  }

  Future<Null> read_GC_tenant() async {
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');

    String url = zone == null
        ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            teNantModels.add(teNantModel);
          });
        }
      } else {
        setState(() {
          if (teNantModels.isEmpty) {
            preferences.remove('zonePSer');
            preferences.remove('zonesPName');
            zone_ser = null;
            zone_name = null;
          }
        });
      }

      setState(() {
        _teNantModels = teNantModels;

        zone_ser = preferences.getString('zonePSer');
        zone_name = preferences.getString('zonesPName');
      });
    } catch (e) {}
  }

  Future<Null> read_GC_areaSelect(int select) async {
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');

    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $select');

    if (select == 1) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            TeNantModel teNantModel = TeNantModel.fromJson(map);
            if (teNantModel.quantity == '1') {
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
                final earlier = daterx_ldate.subtract(const Duration(days: 0));
                var daterx_A = now.isAfter(earlier);
                print(now.isAfter(earlier)); // true
                print(now.isBefore(earlier)); // true

                if (daterx_A != true) {
                  setState(() {
                    teNantModels.add(teNantModel);
                  });
                }
              }
              // setState(() {
              //   teNantModels.add(teNantModel);
              // });
            }
            // setState(() {
            //   teNantModels.add(teNantModel);
            // });
          }
        } else {
          setState(() {
            if (teNantModels.isEmpty) {
              preferences.remove('zonePSer');
              preferences.remove('zonesPName');
              zone_ser = null;
              zone_name = null;
            }
          });
        }

        setState(() {
          _teNantModels = teNantModels;

          zone_ser = preferences.getString('zonePSer');
          zone_name = preferences.getString('zonesPName');
        });
      } catch (e) {}
    } else if (select == 2) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

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
              final earlier = daterx_ldate.subtract(const Duration(days: 0));
              var daterx_A = now.isAfter(earlier);
              print(now.isAfter(earlier)); // true
              print(now.isBefore(earlier)); // true

              if (daterx_A == true) {
                setState(() {
                  if (teNantModel.quantity == '1') {
                    teNantModels.add(teNantModel);
                  }
                });
              }
            }
          }
        } else {
          setState(() {
            if (teNantModels.isEmpty) {
              preferences.remove('zonePSer');
              preferences.remove('zonesPName');
              zone_ser = null;
              zone_name = null;
            }
          });
        }
        setState(() {
          _teNantModels = teNantModels;

          zone_ser = preferences.getString('zonePSer');
          zone_name = preferences.getString('zonesPName');
        });
      } catch (e) {}
    } else if (select == 3) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            TeNantModel teNantModel = TeNantModel.fromJson(map);
            if (teNantModel.quantity == '2' || teNantModel.quantity == '3') {
              setState(() {
                teNantModels.add(teNantModel);
              });
            }
          }
        } else {
          setState(() {
            if (teNantModels.isEmpty) {
              preferences.remove('zonePSer');
              preferences.remove('zonesPName');
              zone_ser = null;
              zone_name = null;
            }
          });
        }
        setState(() {
          _teNantModels = teNantModels;

          zone_ser = preferences.getString('zonePSer');
          zone_name = preferences.getString('zonesPName');
        });
      } catch (e) {}
    }
  }

  List Status = [
    'ปัจจุบัน',
    'หมดสัญญา',
    'ผู้สนใจ',
  ];

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: PeopleChaoScreen_Color.Colors_Text2_,
          fontFamily: Font_.Fonts_T),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(
            color: PeopleChaoScreen_Color.Colors_Text2_,
            fontFamily: Font_.Fonts_T),
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
        print(text);
        text = text.toLowerCase();
        setState(() {
          teNantModels = _teNantModels.where((teNantModels) {
            var notTitle = teNantModels.lncode.toString().toLowerCase();
            var notTitle2 = teNantModels.cid.toString().toLowerCase();
            var notTitle3 = teNantModels.docno.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text);
          }).toList();
        });
      },
    );
  }

  ScrollController _scrollController1 = ScrollController();

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
  ////////////------------------------------------------------------>
  Future<void> _showMyDialog_SAVE() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 0)),
            builder: (context, snapshot) {
              return Form(
                key: _formKey,
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  title: Container(
                    width: 300,
                    height: 50,
                    child: Stack(
                      children: [
                        Container(
                          width: 200,
                          child: Center(
                            child: Text(
                              '$Value_Report',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                              // width: 100,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => Navigator.pop(context, 'OK'),
                                child: const Text(
                                  'ปิด',
                                  style: TextStyle(
                                    color: Colors.white,
                                    //fontWeight: FontWeight.bold, color:

                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        // if (_verticalGroupValue_NameFile == 'กำหนดเอง')
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: TextFormField(
                        //       //keyboardType: TextInputType.none,
                        //       controller: FormNameFile_text,
                        //       validator: (value) {
                        //         if (value == null ||
                        //             value.isEmpty ||
                        //             value.length < 13) {
                        //           return 'กรุณาใส่ข้อมูล ';
                        //         }
                        //         return null;
                        //       },
                        //       // maxLength: 13,
                        //       cursorColor: Colors.green,
                        //       decoration: InputDecoration(
                        //           fillColor:
                        //               const Color.fromARGB(255, 209, 255, 205)
                        //                   .withOpacity(0.3),
                        //           filled: true,
                        //           labelText: 'ชื่อไฟล์',
                        //           labelStyle: const TextStyle(
                        //             color: ReportScreen_Color.Colors_Text2_,
                        //             // fontWeight: FontWeight.bold,
                        //             fontFamily: Font_.Fonts_T,
                        //           )),
                        //       inputFormatters: <TextInputFormatter>[
                        //         FilteringTextInputFormatter(
                        //             RegExp("[@.!#%&'*+=?^`{|}~-]"),
                        //             allow: false),
                        //         FilteringTextInputFormatter.deny(
                        //             RegExp("[' ']")),
                        //       ],
                        //     ),
                        //   ),
                        // if (FormNameFile_text.text.isEmpty &&
                        //     _verticalGroupValue_NameFile == 'กำหนดเอง')
                        //   const Text(
                        //     'กรุณาใส่ข้อมูล',
                        //     style: TextStyle(
                        //       color: Colors.red, fontSize: 10,
                        //       // fontWeight: FontWeight.bold,
                        //       fontFamily: Font_.Fonts_T,
                        //       // fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // const Text(
                        //   'ชื่อไฟล์ :',
                        //   style: TextStyle(
                        //     color: ReportScreen_Color.Colors_Text2_,
                        //     // fontWeight: FontWeight.bold,
                        //     fontFamily: Font_.Fonts_T,

                        //     // fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.3),
                        //     borderRadius: const BorderRadius.only(
                        //       topLeft: Radius.circular(15),
                        //       topRight: Radius.circular(15),
                        //       bottomLeft: Radius.circular(15),
                        //       bottomRight: Radius.circular(15),
                        //     ),
                        //     border: Border.all(color: Colors.grey, width: 1),
                        //   ),
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: RadioGroup<String>.builder(
                        //     direction: Axis.horizontal,
                        //     groupValue: _verticalGroupValue_NameFile,
                        //     horizontalAlignment: MainAxisAlignment.spaceAround,
                        //     onChanged: (value) async {
                        //       setState(() {
                        //         _verticalGroupValue_NameFile = 'กำหนดเอง';

                        //         FormNameFile_text.clear();
                        //       });
                        //       setState(() {
                        //         _verticalGroupValue_NameFile = value ?? '';
                        //       });
                        //     },
                        //     items: const <String>[
                        //       "จากระบบ",
                        //       "กำหนดเอง",
                        //     ],
                        //     textStyle: const TextStyle(
                        //       fontSize: 15,
                        //       color: ReportScreen_Color.Colors_Text2_,
                        //       // fontWeight: FontWeight.bold,
                        //       fontFamily: Font_.Fonts_T,
                        //     ),
                        //     itemBuilder: (item) => RadioButtonBuilder(
                        //       item,
                        //     ),
                        //   ),
                        // ),
                        const Text(
                          'สกุลไฟล์ :',
                          style: TextStyle(
                            color: ReportScreen_Color.Colors_Text2_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue_File,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) {
                              setState(() {
                                FormNameFile_text.clear();
                              });
                              setState(() {
                                _verticalGroupValue_File = value ?? '';
                              });
                            },
                            items: const <String>[
                              // "PDF",
                              "EXCEL",
                            ],
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: ReportScreen_Color.Colors_Text2_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T,
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 180,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () async {
                              InkWell_onTap(context);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 25,
                                  backgroundImage: (_verticalGroupValue_File ==
                                          'PDF')
                                      ? const AssetImage('images/IconPDF.gif')
                                      : const AssetImage(
                                          'images/excel_icon.gif'),
                                ),
                                Container(
                                  width: 80,
                                  child: const Text(
                                    'Download',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                  // decoration: const BoxDecoration(
                                  //   border: Border(
                                  //     bottom: BorderSide(
                                  //         color: Colors.white),
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  void InkWell_onTap(context) async {
    setState(() {
      NameFile_ = '';
      NameFile_ = FormNameFile_text.text;
    });

    if (_verticalGroupValue_NameFile == 'กำหนดเอง') {
      if (FormNameFile_text.text.isNotEmpty) {
        if (_verticalGroupValue_File == 'PDF') {
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
          SharedPreferences preferences = await SharedPreferences.getInstance();
          var renTal_name = preferences.getString('renTalName');
          _displayPdf(
            '$renTal_name',
            ' ${renTalModels[0].bill_addr}',
            ' ${renTalModels[0].bill_email}',
            ' ${renTalModels[0].bill_tel}',
            ' ${renTalModels[0].bill_tax}',
            ' ${renTalModels[0].bill_name}',
            newValuePDFimg,
          );
          Navigator.of(context).pop();
        } else {
          _exportExcel_(NameFile_, _verticalGroupValue_NameFile, Value_Report);
          Navigator.of(context).pop();
        }
      }
    } else {
      if (_verticalGroupValue_File == 'PDF') {
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
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var renTal_name = preferences.getString('renTalName');
        _displayPdf(
          '$renTal_name',
          ' ${renTalModels[0].bill_addr}',
          ' ${renTalModels[0].bill_email}',
          ' ${renTalModels[0].bill_tel}',
          ' ${renTalModels[0].bill_tax}',
          ' ${renTalModels[0].bill_name}',
          newValuePDFimg,
        );
        Navigator.of(context).pop();
      } else {
        _exportExcel_(NameFile_, _verticalGroupValue_NameFile, Value_Report);
        Navigator.of(context).pop();
      }
    }
  }

  String? _message;
  void updateMessage(String newMessage) {
    setState(() {
      _message = newMessage;
      ReturnBodyPeople = newMessage;
    });
    checkPreferance();
    read_GC_zone();
    read_GC_tenant();
    read_GC_rental();
  }

  ////////////////-------------------------------------->
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (ReturnBodyPeople == 'PeopleChaoScreen2')
          ? Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            ReturnBodyPeople = 'PeopleChaoScreen';
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
                    ),
                  ],
                ),
                PeopleChaoScreen2(
                  Get_Value_cid: Value_cid,
                  Get_Value_NameShop_index: Value_NameShop_index,
                  Get_Value_status: Value_stasus,
                  updateMessage: updateMessage,
                ),
              ],
            )
          : (ReturnBodyPeople == 'PeopleChaoScreen3')
              ? Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                ReturnBodyPeople = 'PeopleChaoScreen';
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
                        ),
                      ],
                    ),
                    /////////////----------->คุมเงินประกัน
                    const PeopleChaoScreen3(),
                    /////////////----------->คุมเงินประกัน
                  ],
                )
              : (ReturnBodyPeople == 'PeopleChaoScreen4')
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    ReturnBodyPeople = 'PeopleChaoScreen';
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
                            ),
                          ],
                        ), /////////////----------->ยกเลิกสัญญา
                        const PeopleChaoScreen4(),
                        /////////////----------->ยกเลิกสัญญา
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 2, 0),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    AutoSizeText(
                                      'ผู้เช่า ',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 8,
                                      maxFontSize: 20,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                    AutoSizeText(
                                      ' > >',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 8,
                                      maxFontSize: 20,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppbackgroundColor.TiTile_Colors,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              // border: Border.all(color: Colors.white, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'โซนพื้นที่เช่า:',
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppbackgroundColor
                                                        .Sub_Abg_Colors,
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
                                                  width: 150,
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    isExpanded: true,
                                                    hint: Text(
                                                      zone_name == null
                                                          ? 'ทั้งหมด'
                                                          : '$zone_name',
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black,
                                                    ),
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                    iconSize: 30,
                                                    buttonHeight: 40,
                                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    items: zoneModels
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  '${item.ser},${item.zn}',
                                                              child: Text(
                                                                item.zn!,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                              ),
                                                            ))
                                                        .toList(),

                                                    onChanged: (value) async {
                                                      var zones =
                                                          value!.indexOf(',');
                                                      var zoneSer = value
                                                          .substring(0, zones);
                                                      var zonesName = value
                                                          .substring(zones + 1);
                                                      print(
                                                          'mmmmm ${zoneSer.toString()} $zonesName');

                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      preferences.setString(
                                                          'zonePSer',
                                                          zoneSer.toString());
                                                      preferences.setString(
                                                          'zonesPName',
                                                          zonesName.toString());

                                                      setState(() {
                                                        read_GC_tenant();
                                                      });
                                                    },
                                                    // onSaved: (value) {
                                                    //   // selectedValue = value.toString();
                                                    // },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ค้นหา:',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppbackgroundColor
                                                        .Sub_Abg_Colors,
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
                                                  width: 120,
                                                  height: 35,
                                                  child: _searchBar(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.fromLTRB(8, 8, 15, 8),
                                // child: InkWell(
                                //   child: Container(
                                //       // padding: EdgeInsets.all(8.0),
                                //       child: CircleAvatar(
                                //     backgroundColor: Colors.yellow[700],
                                //     radius: 20,
                                //     child: PopupMenuButton(
                                //       child: const Text(
                                //         '...',
                                //         style: TextStyle(
                                //             fontSize: 25,
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.bold,
                                //             fontFamily: FontWeight_.Fonts_T),
                                //       ),
                                //       itemBuilder: (BuildContext context) => [
                                //         PopupMenuItem(
                                //           child: InkWell(
                                //               onTap: () async {
                                //                 Navigator.pop(context);
                                //                 setState(() {
                                //                   ReturnBodyPeople =
                                //                       'PeopleChaoScreen3';
                                //                 });
                                //               },
                                //               child: Container(
                                //                   padding:
                                //                       const EdgeInsets.all(
                                //                           10),
                                //                   width:
                                //                       MediaQuery.of(context)
                                //                           .size
                                //                           .width,
                                //                   child: Row(
                                //                     children: const [
                                //                       Expanded(
                                //                         child: Text(
                                //                           'คุมเงินประกัน',
                                //                           style: TextStyle(
                                //                               color: PeopleChaoScreen_Color
                                //                                   .Colors_Text1_,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .bold,
                                //                               fontFamily:
                                //                                   FontWeight_
                                //                                       .Fonts_T),
                                //                         ),
                                //                       )
                                //                     ],
                                //                   ))),
                                //         ),
                                //         PopupMenuItem(
                                //           child: InkWell(
                                //               onTap: () async {
                                //                 Navigator.pop(context);
                                //                 setState(() {
                                //                   ReturnBodyPeople =
                                //                       'PeopleChaoScreen4';
                                //                 });
                                //               },
                                //               child: Container(
                                //                   padding:
                                //                       const EdgeInsets.all(
                                //                           10),
                                //                   width:
                                //                       MediaQuery.of(context)
                                //                           .size
                                //                           .width,
                                //                   child: Row(
                                //                     children: const [
                                //                       Expanded(
                                //                         child: Text(
                                //                           'ยกเลิกสัญญา',
                                //                           style: TextStyle(
                                //                               color: PeopleChaoScreen_Color
                                //                                   .Colors_Text1_,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .bold,
                                //                               fontFamily:
                                //                                   FontWeight_
                                //                                       .Fonts_T),
                                //                         ),
                                //                       )
                                //                     ],
                                //                   ))),
                                //         ),
                                //       ],
                                //     ),
                                //   )),
                                // ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        //   child: Container(
                        //       width: MediaQuery.of(context).size.width,
                        //       decoration: const BoxDecoration(
                        //         color: AppbackgroundColor.TiTile_Colors,
                        //         borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(10),
                        //             topRight: Radius.circular(10),
                        //             bottomLeft: Radius.circular(0),
                        //             bottomRight: Radius.circular(0)),
                        //         // border: Border.all(color: Colors.white, width: 1),
                        //       ),
                        //       // padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           Expanded(
                        //               flex: 1,
                        //               child: Row(
                        //                 children: [
                        //                   const Expanded(
                        //                     flex: 2,
                        //                     child:
                        // Padding(
                        //                       padding: EdgeInsets.all(8.0),
                        //                       child: Text(
                        //                         'โซนพื้นที่เช่า:',
                        //                         style: TextStyle(
                        //                             color:
                        //                                 PeopleChaoScreen_Color
                        //                                     .Colors_Text1_,
                        //                             fontWeight: FontWeight.bold,
                        //                             fontFamily:
                        //                                 FontWeight_.Fonts_T),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     flex: 3,
                        //                     child:
                        // Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                         decoration: BoxDecoration(
                        //                           color: AppbackgroundColor
                        //                               .Sub_Abg_Colors,
                        //                           borderRadius:
                        //                               const BorderRadius.only(
                        //                                   topLeft:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   topRight:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   bottomLeft:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   bottomRight:
                        //                                       Radius.circular(
                        //                                           10)),
                        //                           border: Border.all(
                        //                               color: Colors.grey,
                        //                               width: 1),
                        //                         ),
                        //                         width: 150,
                        //                         child: DropdownButtonFormField2(
                        //                           decoration: InputDecoration(
                        //                             isDense: true,
                        //                             contentPadding:
                        //                                 EdgeInsets.zero,
                        //                             border: OutlineInputBorder(
                        //                               borderRadius:
                        //                                   BorderRadius.circular(
                        //                                       10),
                        //                             ),
                        //                           ),
                        //                           isExpanded: true,
                        //                           hint: Text(
                        //                             zone_name == null
                        //                                 ? 'ทั้งหมด'
                        //                                 : '$zone_name',
                        //                             maxLines: 1,
                        //                             style: const TextStyle(
                        //                                 fontSize: 14,
                        //                                 color:
                        //                                     PeopleChaoScreen_Color
                        //                                         .Colors_Text2_,
                        //                                 fontFamily:
                        //                                     Font_.Fonts_T),
                        //                           ),
                        //                           icon: const Icon(
                        //                             Icons.arrow_drop_down,
                        //                             color: Colors.black,
                        //                           ),
                        //                           style: const TextStyle(
                        //                               color:
                        //                                   PeopleChaoScreen_Color
                        //                                       .Colors_Text2_,
                        //                               fontFamily:
                        //                                   Font_.Fonts_T),
                        //                           iconSize: 30,
                        //                           buttonHeight: 40,
                        //                           // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        //                           dropdownDecoration:
                        //                               BoxDecoration(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     10),
                        //                           ),
                        //                           items: zoneModels
                        //                               .map((item) =>
                        //                                   DropdownMenuItem<
                        //                                       String>(
                        //                                     value:
                        //                                         '${item.ser},${item.zn}',
                        //                                     child: Text(
                        //                                       item.zn!,
                        //                                       style: const TextStyle(
                        //                                           fontSize: 14,
                        //                                           color: PeopleChaoScreen_Color
                        //                                               .Colors_Text2_,
                        //                                           fontFamily: Font_
                        //                                               .Fonts_T),
                        //                                     ),
                        //                                   ))
                        //                               .toList(),

                        //                           onChanged: (value) async {
                        //                             var zones =
                        //                                 value!.indexOf(',');
                        //                             var zoneSer = value
                        //                                 .substring(0, zones);
                        //                             var zonesName = value
                        //                                 .substring(zones + 1);
                        //                             print(
                        //                                 'mmmmm ${zoneSer.toString()} $zonesName');

                        //                             SharedPreferences
                        //                                 preferences =
                        //                                 await SharedPreferences
                        //                                     .getInstance();
                        //                             preferences.setString(
                        //                                 'zonePSer',
                        //                                 zoneSer.toString());
                        //                             preferences.setString(
                        //                                 'zonesPName',
                        //                                 zonesName.toString());

                        //                             setState(() {
                        //                               read_GC_tenant();
                        //                             });
                        //                           },
                        //                           // onSaved: (value) {
                        //                           //   // selectedValue = value.toString();
                        //                           // },
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               )),
                        //           Expanded(
                        //               flex: 2,
                        //               child: Row(
                        //                 children: [
                        //                   const Expanded(
                        //                     flex: 1,
                        //                     child:
                        // Padding(
                        //                       padding: EdgeInsets.all(8.0),
                        //                       child: Text(
                        //                         'ค้นหา:',
                        //                         textAlign: TextAlign.end,
                        //                         style: TextStyle(
                        //                             color:
                        //                                 PeopleChaoScreen_Color
                        //                                     .Colors_Text1_,
                        //                             fontWeight: FontWeight.bold,
                        //                             fontFamily:
                        //                                 FontWeight_.Fonts_T),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     flex: 4,
                        //                     child:
                        // Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                         decoration: BoxDecoration(
                        //                           color: AppbackgroundColor
                        //                               .Sub_Abg_Colors,
                        //                           borderRadius:
                        //                               const BorderRadius.only(
                        //                                   topLeft:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   topRight:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   bottomLeft:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   bottomRight:
                        //                                       Radius.circular(
                        //                                           10)),
                        //                           border: Border.all(
                        //                               color: Colors.grey,
                        //                               width: 1),
                        //                         ),
                        //                         width: 120,
                        //                         height: 35,
                        //                         child: _searchBar(),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               )),
                        //           Expanded(
                        //               flex: 2,
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.end,
                        //                 children: [
                        //                   Padding(
                        //                     padding: const EdgeInsets.all(8.0),
                        //                     child: InkWell(
                        //                       child: Container(
                        //                           // padding: EdgeInsets.all(8.0),
                        //                           child: CircleAvatar(
                        //                         backgroundColor:
                        //                             Colors.yellow[700],
                        //                         radius: 20,
                        //                         child: PopupMenuButton(
                        //                           child: const Text(
                        //                             '...',
                        //                             style: TextStyle(
                        //                                 fontSize: 25,
                        //                                 color: Colors.white,
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                                 fontFamily: FontWeight_
                        //                                     .Fonts_T),
                        //                           ),
                        //                           itemBuilder:
                        //                               (BuildContext context) =>
                        //                                   [
                        //                             PopupMenuItem(
                        //                               child: InkWell(
                        //                                   onTap: () async {
                        //                                     Navigator.pop(
                        //                                         context);
                        //                                     setState(() {
                        //                                       ReturnBodyPeople =
                        //                                           'PeopleChaoScreen3';
                        //                                     });
                        //                                   },
                        //                                   child: Container(
                        //                                       padding:
                        //                                           const EdgeInsets
                        //                                               .all(10),
                        //                                       width:
                        //                                           MediaQuery.of(
                        //                                                   context)
                        //                                               .size
                        //                                               .width,
                        //                                       child: Row(
                        //                                         children: [
                        //                                           const Expanded(
                        //                                             child: Text(
                        //                                               'คุมเงินประกัน',
                        //                                               style: TextStyle(
                        //                                                   color: PeopleChaoScreen_Color
                        //                                                       .Colors_Text1_,
                        //                                                   fontWeight: FontWeight
                        //                                                       .bold,
                        //                                                   fontFamily:
                        //                                                       FontWeight_.Fonts_T),
                        //                                             ),
                        //                                           )
                        //                                         ],
                        //                                       ))),
                        //                             ),
                        //                             PopupMenuItem(
                        //                               child: InkWell(
                        //                                   onTap: () async {
                        //                                     Navigator.pop(
                        //                                         context);
                        //                                     setState(() {
                        //                                       ReturnBodyPeople =
                        //                                           'PeopleChaoScreen4';
                        //                                     });
                        //                                   },
                        //                                   child: Container(
                        //                                       padding:
                        //                                           const EdgeInsets
                        //                                               .all(10),
                        //                                       width:
                        //                                           MediaQuery.of(
                        //                                                   context)
                        //                                               .size
                        //                                               .width,
                        //                                       child: Row(
                        //                                         children: [
                        //                                           const Expanded(
                        //                                             child: Text(
                        //                                               'ยกเลิกสัญญา',
                        //                                               style: TextStyle(
                        //                                                   color: PeopleChaoScreen_Color
                        //                                                       .Colors_Text1_,
                        //                                                   fontWeight: FontWeight
                        //                                                       .bold,
                        //                                                   fontFamily:
                        //                                                       FontWeight_.Fonts_T),
                        //                                             ),
                        //                                           )
                        //                                         ],
                        //                                       ))),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       )),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               )),
                        //           const SizedBox(
                        //             width: 20,
                        //           ),
                        //         ],
                        //       )),
                        // ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ผู้เช่า :',
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                              for (int i = 0;
                                                  i < Status.length;
                                                  i++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        tappedIndex_ = '';
                                                      });
                                                      setState(() {
                                                        Status_ = i + 1;
                                                      });
                                                      read_GC_areaSelect(
                                                          Status_);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: (i + 1 == 1)
                                                            ? Colors
                                                                .grey.shade400
                                                            : (i + 1 == 2)
                                                                ? Colors.red
                                                                    .shade300
                                                                : Colors.blue
                                                                    .shade400,
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
                                                        border: (Status_ ==
                                                                i + 1)
                                                            ? Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 1)
                                                            : null,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          Status[i],
                                                          style: TextStyle(
                                                              color: (Status_ ==
                                                                      i + 1)
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
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
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green[600],
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: PopupMenuButton(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Icon(
                                                          Icons.print,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'พิมพ์',
                                                          style: TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  // PopupMenuItem(
                                                  //   child: InkWell(
                                                  //       onTap: () async {
                                                  //         List newValuePDFimg =
                                                  //             [];
                                                  //         for (int index = 0;
                                                  //             index < 1;
                                                  //             index++) {
                                                  //           if (renTalModels[0]
                                                  //                   .imglogo!
                                                  //                   .trim() ==
                                                  //               '') {
                                                  //             // newValuePDFimg.add(
                                                  //             //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                                  //           } else {
                                                  //             newValuePDFimg.add(
                                                  //                 '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                                  //           }
                                                  //         }
                                                  //         SharedPreferences
                                                  //             preferences =
                                                  //             await SharedPreferences
                                                  //                 .getInstance();
                                                  //         var renTal_name =
                                                  //             preferences.getString(
                                                  //                 'renTalName');
                                                  //         setState(() {
                                                  //           Pre_and_Dow =
                                                  //               'Preview';
                                                  //         });
                                                  //         Navigator.pop(
                                                  //             context);
                                                  //         _displayPdf(
                                                  //           '$renTal_name',
                                                  //           ' ${renTalModels[0].bill_addr}',
                                                  //           ' ${renTalModels[0].bill_email}',
                                                  //           ' ${renTalModels[0].bill_tel}',
                                                  //           ' ${renTalModels[0].bill_tax}',
                                                  //           ' ${renTalModels[0].bill_name}',
                                                  //           newValuePDFimg,
                                                  //         );
                                                  //       },
                                                  //       child: Container(
                                                  //           padding:
                                                  //               const EdgeInsets
                                                  //                   .all(10),
                                                  //           width:
                                                  //               MediaQuery.of(
                                                  //                       context)
                                                  //                   .size
                                                  //                   .width,
                                                  //           child: Row(
                                                  //             children: const [
                                                  //               Expanded(
                                                  //                 child: Text(
                                                  //                   'Preview & Print',
                                                  //                   style: TextStyle(
                                                  //                       color: PeopleChaoScreen_Color
                                                  //                           .Colors_Text1_,
                                                  //                       fontWeight:
                                                  //                           FontWeight
                                                  //                               .bold,
                                                  //                       fontFamily:
                                                  //                           FontWeight_.Fonts_T),
                                                  //                 ),
                                                  //               )
                                                  //             ],
                                                  //           ))),
                                                  // ),
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {
                                                            Pre_and_Dow =
                                                                'Download';
                                                          });
                                                          _showMyDialog_SAVE();
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
                                                                    'Exprt file',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T),
                                                                  ),
                                                                )
                                                              ],
                                                            ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        (!Responsive.isDesktop(context))
                            ? BodyHome_mobile()
                            : BodyHome_Web()
                      ],
                    ),
    );
  }

  Widget BodyHome_Web() {
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
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'เลขที่สัญญา/เสนอราคา',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'ชื่อผู้ติดต่อ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'ชื่อร้านค้า',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'โซนพื้นที่',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'รหัสพื้นที่',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'ขนาดพื้นที่(ต.ร.ม.)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'ระยะเวลาการเช่า',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'วันเริ่มสัญญา',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'วันสิ้นสุดสัญญา',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 25,
                      maxLines: 2,
                      'สถานะ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                child: teNantModels.isEmpty
                    ? SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            StreamBuilder(
                              stream: Stream.periodic(
                                  const Duration(milliseconds: 25), (i) => i),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return const Text('');
                                double elapsed =
                                    double.parse(snapshot.data.toString()) *
                                        0.05;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: (elapsed > 8.00)
                                      ? const Text(
                                          'ไม่พบข้อมูล',
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T
                                              //fontSize: 10.0
                                              ),
                                        )
                                      : Text(
                                          'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                          // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                          style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T
                                              //fontSize: 10.0
                                              ),
                                        ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController1,
                        // itemExtent: 50,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: teNantModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            color: tappedIndex_ == index.toString()
                                ? tappedIndex_Color.tappedIndex_Colors
                                    .withOpacity(0.5)
                                : AppbackgroundColor.Sub_Abg_Colors,
                            child: Container(
                              // color: Colors.white,
                              // color: tappedIndex_ == index.toString()
                              //     ? tappedIndex_Color.tappedIndex_Colors
                              //         .withOpacity(0.5)
                              //     : null,
                              child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      tappedIndex_ = index.toString();
                                    });
                                  },
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
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
                                                // border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: PopupMenuButton(
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    InkWell(
                                                      // onTap: () {
                                                      //   setState(() {
                                                      //     tappedIndex_ =
                                                      //         index.toString();
                                                      //   });
                                                      // },
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        'เรียกดู',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.navigate_next,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                )),
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                        onTap: () {
                                                          var ser_teNant =
                                                              teNantModels[
                                                                      index]
                                                                  .quantity;
                                                          var ser_ciddoc =
                                                              teNantModels[index]
                                                                          .docno ==
                                                                      null
                                                                  ? teNantModels[
                                                                          index]
                                                                      .cid
                                                                  : teNantModels[
                                                                          index]
                                                                      .docno;
                                                          setState(() {
                                                            Value_NameShop_index =
                                                                '$ser_teNant';
                                                            Value_cid =
                                                                '$ser_ciddoc';
                                                            Value_stasus = teNantModels[
                                                                            index]
                                                                        .quantity ==
                                                                    '1'
                                                                ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(
                                                                            days:
                                                                                0))) ==
                                                                        true
                                                                    ? 'หมดสัญญา'
                                                                    : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                            true
                                                                        ? 'ใกล้หมดสัญญา'
                                                                        : 'เช่าอยู่'
                                                                : teNantModels[index]
                                                                            .quantity ==
                                                                        '2'
                                                                    ? 'เสนอราคา'
                                                                    : teNantModels[index].quantity ==
                                                                            '3'
                                                                        ? 'เสนอราคา(มัดจำ)'
                                                                        : 'ว่าง';
                                                          });

                                                          setState(() {
                                                            ReturnBodyPeople =
                                                                'PeopleChaoScreen2';
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (context) =>
                                                          //             const PeopleChaoScreen2()));
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
                                                              children: [
                                                                Expanded(
                                                                    child: Text(
                                                                  teNantModels[index]
                                                                              .docno ==
                                                                          null
                                                                      ? teNantModels[index].cid ==
                                                                              null
                                                                          ? ''
                                                                          : '${teNantModels[index].cid}'
                                                                      : '${teNantModels[index].docno}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ))
                                                              ],
                                                            ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text: teNantModels[index].docno ==
                                                      null
                                                  ? teNantModels[index].cid ==
                                                          null
                                                      ? ''
                                                      : '${teNantModels[index].cid}'
                                                  : '${teNantModels[index].docno}',
                                              style: const TextStyle(
                                                color: HomeScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                                //fontSize: 10.0
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey[200],
                                            ),
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              teNantModels[index].docno == null
                                                  ? teNantModels[index].cid ==
                                                          null
                                                      ? ''
                                                      : '${teNantModels[index].cid}'
                                                  : '${teNantModels[index].docno}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 25,
                                            maxLines: 1,
                                            teNantModels[index].cname == null
                                                ? teNantModels[index].cname_q ==
                                                        null
                                                    ? ''
                                                    : '${teNantModels[index].cname_q}'
                                                : '${teNantModels[index].cname}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text: teNantModels[index].sname ==
                                                      null
                                                  ? teNantModels[index]
                                                              .sname_q ==
                                                          null
                                                      ? ''
                                                      : '${teNantModels[index].sname_q}'
                                                  : '${teNantModels[index].sname}',
                                              style: const TextStyle(
                                                color: HomeScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                                //fontSize: 10.0
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey[200],
                                            ),
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              teNantModels[index].sname == null
                                                  ? teNantModels[index]
                                                              .sname_q ==
                                                          null
                                                      ? ''
                                                      : '${teNantModels[index].sname_q}'
                                                  : '${teNantModels[index].sname}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          '${teNantModels[index].zn}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Tooltip(
                                          richMessage: TextSpan(
                                            text: teNantModels[index].ln_c ==
                                                    null
                                                ? teNantModels[index].ln_q ==
                                                        null
                                                    ? ''
                                                    : '${teNantModels[index].ln_q}'
                                                : '${teNantModels[index].ln_c}',
                                            style: const TextStyle(
                                              color: HomeScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                              //fontSize: 10.0
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey[200],
                                          ),
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 25,
                                            maxLines: 1,
                                            teNantModels[index].ln_c == null
                                                ? teNantModels[index].ln_q ==
                                                        null
                                                    ? ''
                                                    : '${teNantModels[index].ln_q}'
                                                : '${teNantModels[index].ln_c}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          teNantModels[index].area_c == null
                                              ? teNantModels[index].area_q ==
                                                      null
                                                  ? ''
                                                  : '${teNantModels[index].area_q}'
                                              : '${teNantModels[index].area_c}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          teNantModels[index].period == null
                                              ? teNantModels[index].period_q ==
                                                      null
                                                  ? ''
                                                  : '${teNantModels[index].period_q}  ${teNantModels[index].rtname_q!.substring(3)}'
                                              : '${teNantModels[index].period}  ${teNantModels[index].rtname!.substring(3)}',
                                          textAlign: TextAlign.end,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 25,
                                            maxLines: 1,
                                            teNantModels[index].sdate_q == null
                                                ? teNantModels[index].sdate ==
                                                        null
                                                    ? ''
                                                    : DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.parse(
                                                            '${teNantModels[index].sdate} 00:00:00'))
                                                        .toString()
                                                : DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.parse(
                                                        '${teNantModels[index].sdate_q} 00:00:00'))
                                                    .toString(),
                                            textAlign: TextAlign.end,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 25,
                                            maxLines: 1,
                                            teNantModels[index].ldate_q == null
                                                ? teNantModels[index].ldate ==
                                                        null
                                                    ? ''
                                                    : DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.parse(
                                                            '${teNantModels[index].ldate} 00:00:00'))
                                                        .toString()
                                                : DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.parse(
                                                        '${teNantModels[index].ldate_q} 00:00:00'))
                                                    .toString(),
                                            textAlign: TextAlign.end,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          teNantModels[index].quantity == '1'
                                              ? datex.isAfter(DateTime.parse(
                                                              '${teNantModels[index].ldate} 00:00:00.000')
                                                          .subtract(
                                                              const Duration(
                                                                  days: 0))) ==
                                                      true
                                                  ? 'หมดสัญญา'
                                                  : datex.isAfter(DateTime.parse(
                                                                  '${teNantModels[index].ldate} 00:00:00.000')
                                                              .subtract(
                                                                  const Duration(
                                                                      days:
                                                                          30))) ==
                                                          true
                                                      ? 'ใกล้หมดสัญญา'
                                                      : 'เช่าอยู่'
                                              : teNantModels[index].quantity ==
                                                      '2'
                                                  ? 'เสนอราคา'
                                                  : teNantModels[index]
                                                              .quantity ==
                                                          '3'
                                                      ? 'เสนอราคา(มัดจำ)'
                                                      : 'ว่าง',
                                          textAlign: TextAlign.end,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: teNantModels[index].quantity ==
                                                      '1'
                                                  ? datex.isAfter(DateTime.parse(
                                                                  '${teNantModels[index].ldate} 00:00:00.000')
                                                              .subtract(
                                                                  const Duration(
                                                                      days:
                                                                          0))) ==
                                                          true
                                                      ? Colors.red
                                                      : datex.isAfter(DateTime.parse(
                                                                      '${teNantModels[index].ldate} 00:00:00.000')
                                                                  .subtract(
                                                                      const Duration(days: 30))) ==
                                                              true
                                                          ? Colors.orange.shade900
                                                          : Colors.black
                                                  : teNantModels[index].quantity == '2'
                                                      ? Colors.blue
                                                      : teNantModels[index].quantity == '3'
                                                          ? Colors.blue
                                                          : Colors.green,
                                              fontFamily: Font_.Fonts_T
                                              //fontSize: 10.0
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
                                          fontFamily: FontWeight_.Fonts_T),
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
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
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
        ),
      ],
    );
  }

  Widget BodyHome_mobile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Container(
                      width: 1000,
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
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 1050,
                                      decoration: const BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              '...',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ชื่อผู้ติดต่อ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ชื่อร้านค้า',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'โซนพื้นที่',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'รหัสพื้นที่',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ขนาดพื้นที่(ต.ร.ม.)',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ระยะเวลาการเช่า',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'วันเริ่มสัญญา',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'วันสิ้นสุดสัญญา',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'สถานะ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.6,
                                      width: 1050,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                        // border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: teNantModels.isEmpty
                                          ? SizedBox(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const CircularProgressIndicator(),
                                                  StreamBuilder(
                                                    stream: Stream.periodic(
                                                        const Duration(
                                                            milliseconds: 50),
                                                        (i) => i),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData)
                                                        return const Text('');
                                                      double elapsed =
                                                          double.parse(snapshot
                                                                  .data
                                                                  .toString()) *
                                                              0.05;
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: (elapsed > 40.00)
                                                            ? const Text(
                                                                'ไม่พบข้อมูล',
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    ),
                                                              )
                                                            : Text(
                                                                'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          : ListView.builder(
                                              controller: _scrollController1,
                                              // itemExtent: 50,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: teNantModels.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  color: tappedIndex_ ==
                                                          index.toString()
                                                      ? tappedIndex_Color
                                                          .tappedIndex_Colors
                                                          .withOpacity(0.5)
                                                      : null,
                                                  child: ListTile(
                                                      onTap: () {
                                                        setState(() {
                                                          tappedIndex_ =
                                                              index.toString();
                                                        });
                                                      },
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
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
                                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      PopupMenuButton(
                                                                    child: Center(
                                                                        child: Row(
                                                                      children: const [
                                                                        AutoSizeText(
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              25,
                                                                          maxLines:
                                                                              1,
                                                                          'เรียกดู',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              //fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .navigate_next,
                                                                          color:
                                                                              Colors.black,
                                                                        )
                                                                      ],
                                                                    )),
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context) =>
                                                                            [
                                                                      PopupMenuItem(
                                                                        child: InkWell(
                                                                            onTap: () {
                                                                              var ser_teNant = teNantModels[index].quantity;
                                                                              var ser_ciddoc = teNantModels[index].docno == null ? teNantModels[index].cid : teNantModels[index].docno;
                                                                              setState(() {
                                                                                Value_NameShop_index = '$ser_teNant';
                                                                                Value_cid = '$ser_ciddoc';
                                                                                Value_stasus = teNantModels[index].quantity == '1'
                                                                                    ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) == true
                                                                                        ? 'หมดสัญญา'
                                                                                        : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) == true
                                                                                            ? 'ใกล้หมดสัญญา'
                                                                                            : 'เช่าอยู่'
                                                                                    : teNantModels[index].quantity == '2'
                                                                                        ? 'เสนอราคา'
                                                                                        : teNantModels[index].quantity == '3'
                                                                                            ? 'เสนอราคา(มัดจำ)'
                                                                                            : 'ว่าง';
                                                                              });

                                                                              setState(() {
                                                                                index_listviwe = index;
                                                                                ReturnBodyPeople = 'PeopleChaoScreen2';
                                                                              });
                                                                              Navigator.pop(context);
                                                                              // Navigator.push(
                                                                              //     context,
                                                                              //     MaterialPageRoute(
                                                                              //         builder: (context) =>
                                                                              //             const PeopleChaoScreen2()));
                                                                            },
                                                                            child: Container(
                                                                                padding: const EdgeInsets.all(10),
                                                                                width: MediaQuery.of(context).size.width,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Text(
                                                                                      teNantModels[index].docno == null
                                                                                          ? teNantModels[index].cid == null
                                                                                              ? ''
                                                                                              : '${teNantModels[index].cid}'
                                                                                          : '${teNantModels[index].docno}',
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          //fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ))
                                                                                  ],
                                                                                ))),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .docno ==
                                                                        null
                                                                    ? teNantModels[index].cid ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].cid}'
                                                                    : '${teNantModels[index].docno}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .cname ==
                                                                        null
                                                                    ? teNantModels[index].cname_q ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].cname_q}'
                                                                    : '${teNantModels[index].cname}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .sname ==
                                                                        null
                                                                    ? teNantModels[index].sname_q ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].sname_q}'
                                                                    : '${teNantModels[index].sname}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              '${teNantModels[index].ln}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              teNantModels[index]
                                                                          .ln_c ==
                                                                      null
                                                                  ? teNantModels[index]
                                                                              .ln_q ==
                                                                          null
                                                                      ? ''
                                                                      : '${teNantModels[index].ln_q}'
                                                                  : '${teNantModels[index].ln_c}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              teNantModels[index]
                                                                          .area_c ==
                                                                      null
                                                                  ? teNantModels[index]
                                                                              .area_q ==
                                                                          null
                                                                      ? ''
                                                                      : '${teNantModels[index].area_q}'
                                                                  : '${teNantModels[index].area_c}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              teNantModels[index]
                                                                          .period ==
                                                                      null
                                                                  ? teNantModels[index]
                                                                              .period_q ==
                                                                          null
                                                                      ? ''
                                                                      : '${teNantModels[index].period_q}  ${teNantModels[index].rtname_q!.substring(3)}'
                                                                  : '${teNantModels[index].period}  ${teNantModels[index].rtname!.substring(3)}',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style:
                                                                  const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .sdate_q ==
                                                                        null
                                                                    ? teNantModels[index].sdate ==
                                                                            null
                                                                        ? ''
                                                                        : DateFormat('dd-MM-yyyy')
                                                                            .format(DateTime.parse(
                                                                                '${teNantModels[index].sdate} 00:00:00'))
                                                                            .toString()
                                                                    : DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            DateTime.parse('${teNantModels[index].sdate_q} 00:00:00'))
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .ldate_q ==
                                                                        null
                                                                    ? teNantModels[index].ldate ==
                                                                            null
                                                                        ? ''
                                                                        : DateFormat('dd-MM-yyyy')
                                                                            .format(DateTime.parse(
                                                                                '${teNantModels[index].ldate} 00:00:00'))
                                                                            .toString()
                                                                    : DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            DateTime.parse('${teNantModels[index].ldate_q} 00:00:00'))
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              teNantModels[index]
                                                                          .quantity ==
                                                                      '1'
                                                                  ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(
                                                                              days:
                                                                                  0))) ==
                                                                          true
                                                                      ? 'หมดสัญญา'
                                                                      : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                              true
                                                                          ? 'ใกล้หมดสัญญา'
                                                                          : 'เช่าอยู่'
                                                                  : teNantModels[index]
                                                                              .quantity ==
                                                                          '2'
                                                                      ? 'เสนอราคา'
                                                                      : teNantModels[index].quantity ==
                                                                              '3'
                                                                          ? 'เสนอราคา(มัดจำ)'
                                                                          : 'ว่าง',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                  color: teNantModels[index]
                                                                              .quantity ==
                                                                          '1'
                                                                      ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
                                                                              true
                                                                          ? Colors
                                                                              .red
                                                                          : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                                  true
                                                                              ? Colors
                                                                                  .orange.shade900
                                                                              : Colors
                                                                                  .black
                                                                      : teNantModels[index].quantity ==
                                                                              '2'
                                                                          ? Colors
                                                                              .blue
                                                                          : teNantModels[index].quantity ==
                                                                                  '3'
                                                                              ? Colors
                                                                                  .blue
                                                                              : Colors
                                                                                  .green,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
                Container(
                    width: 1050,
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
                                            fontFamily: FontWeight_.Fonts_T),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
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
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  //////////////////////////////////------------------------->(รายงานผู้เช่า)
  void _exportExcel_(
      NameFile_, _verticalGroupValue_NameFile, Value_Report) async {
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;

    //Adding a picture
    final ByteData bytes_image = await rootBundle.load('images/LOGO.png');
    final Uint8List image = bytes_image.buffer
        .asUint8List(bytes_image.offsetInBytes, bytes_image.lengthInBytes);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
// Adding an image.
    // sheet.pictures.addStream(1, 1, image);
    // final x.Picture picture = sheet.pictures[0];

// Re-size an image
    // picture.height = 30;
    // picture.width = 50;

// // rotate an image.
//     picture.rotation = 100;

// // Flip an image.
//     picture.horizontalFlip = true;
//  _displayPdf(
//             '$renTal_name',
//             ' ${renTalModels[0].bill_addr}',
//             ' ${renTalModels[0].bill_email}',
//             ' ${renTalModels[0].bill_tel}',
//             ' ${renTalModels[0].bill_tax}',
//             ' ${renTalModels[0].bill_name}',
//             newValuePDFimg,
//           );
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.backColorRgb = const Color.fromARGB(255, 252, 255, 251);
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 14;
    globalStyle.hAlign = x.HAlignType.center;
///////////////////////////////----------------------->

    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 141, 185, 90);
    globalStyle2.fontName = 'Angsana New';
    globalStyle2.fontSize = 14;

///////////////////////////////----------------------->
    x.Style globalStyle3 = workbook.styles.add('style3');
    globalStyle3.backColorRgb =
        const Color.fromRGBO(232, 232, 232, 1.000); //    Color(0xFFD9D9B7);

    globalStyle3.fontName = 'Angsana New';
    globalStyle3.fontSize = 14;
    globalStyle3.hAlign = x.HAlignType.center;

///////////////////////////////----------------------->
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    sheet.getRangeByName('A1').setText('${renTal_name}');
    sheet
        .getRangeByName('J1')
        .setText('โทรศัพท์ : ${renTalModels[0].bill_tel}');

// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle;
    sheet.getRangeByName('B2').cellStyle = globalStyle;
    sheet.getRangeByName('C2').cellStyle = globalStyle;
    sheet.getRangeByName('D2').cellStyle = globalStyle;
    sheet.getRangeByName('E2').cellStyle = globalStyle;
    sheet.getRangeByName('F2').cellStyle = globalStyle;
    sheet.getRangeByName('G2').cellStyle = globalStyle;
    sheet.getRangeByName('H2').cellStyle = globalStyle;
    sheet.getRangeByName('I2').cellStyle = globalStyle;
    sheet.getRangeByName('J2').cellStyle = globalStyle;
    sheet.getRangeByName('A2').setText('${renTalModels[0].bill_addr}');
    sheet.getRangeByName('J2').setText('อีเมล : ${renTalModels[0].bill_email}');

    sheet.getRangeByName('A3').cellStyle = globalStyle;
    sheet.getRangeByName('B3').cellStyle = globalStyle;
    sheet.getRangeByName('C3').cellStyle = globalStyle;
    sheet.getRangeByName('D3').cellStyle = globalStyle;
    sheet.getRangeByName('E3').cellStyle = globalStyle;
    sheet.getRangeByName('F3').cellStyle = globalStyle;
    sheet.getRangeByName('G3').cellStyle = globalStyle;
    sheet.getRangeByName('H3').cellStyle = globalStyle;
    sheet.getRangeByName('I3').cellStyle = globalStyle;
    sheet.getRangeByName('J3').cellStyle = globalStyle;
    sheet
        .getRangeByName('J3')
        .setText('เลขประจำตัวผู้เสียภาษี : ${renTalModels[0].bill_tax}');

    sheet.getRangeByName('A4').cellStyle = globalStyle;
    sheet.getRangeByName('B4').cellStyle = globalStyle;
    sheet.getRangeByName('C4').cellStyle = globalStyle;
    sheet.getRangeByName('D4').cellStyle = globalStyle;
    sheet.getRangeByName('E4').cellStyle = globalStyle;
    sheet.getRangeByName('F4').cellStyle = globalStyle;
    sheet.getRangeByName('G4').cellStyle = globalStyle;
    sheet.getRangeByName('H4').cellStyle = globalStyle;
    sheet.getRangeByName('I4').cellStyle = globalStyle;
    sheet.getRangeByName('J4').cellStyle = globalStyle;
    sheet
        .getRangeByName('J4')
        .setText('ณ วันที่ : $thaiDate ${DateTime.now().year + 543}');

    sheet.getRangeByName('A5').cellStyle = globalStyle;
    sheet.getRangeByName('B5').cellStyle = globalStyle;
    sheet.getRangeByName('C5').cellStyle = globalStyle;
    sheet.getRangeByName('D5').cellStyle = globalStyle;
    sheet.getRangeByName('E5').cellStyle = globalStyle;
    sheet.getRangeByName('F5').cellStyle = globalStyle;
    sheet.getRangeByName('G5').cellStyle = globalStyle;
    sheet.getRangeByName('H5').cellStyle = globalStyle;
    sheet.getRangeByName('I5').cellStyle = globalStyle;
    sheet.getRangeByName('J5').cellStyle = globalStyle;

    sheet.getRangeByName('A6').cellStyle = globalStyle;
    sheet.getRangeByName('B6').cellStyle = globalStyle;
    sheet.getRangeByName('C6').cellStyle = globalStyle;
    sheet.getRangeByName('D6').cellStyle = globalStyle;
    sheet.getRangeByName('E6').cellStyle = globalStyle;
    sheet.getRangeByName('F6').cellStyle = globalStyle;
    sheet.getRangeByName('G6').cellStyle = globalStyle;
    sheet.getRangeByName('H6').cellStyle = globalStyle;
    sheet.getRangeByName('I6').cellStyle = globalStyle;
    sheet.getRangeByName('J6').cellStyle = globalStyle;
    sheet.getRangeByName('A6').setText('ผู้เช่า : ${Status[Status_ - 1]}');
    sheet.getRangeByName('E6').setText('ข้อมูลผู้เช่า');
    sheet
        .getRangeByName('J6')
        .setText((zone_name == null) ? 'โซน : ทั้งหมด' : 'โซน : $zone_name');

    sheet.getRangeByName('A7').cellStyle = globalStyle;
    sheet.getRangeByName('B7').cellStyle = globalStyle;
    sheet.getRangeByName('C7').cellStyle = globalStyle;
    sheet.getRangeByName('D7').cellStyle = globalStyle;
    sheet.getRangeByName('E7').cellStyle = globalStyle;
    sheet.getRangeByName('F7').cellStyle = globalStyle;
    sheet.getRangeByName('G7').cellStyle = globalStyle;
    sheet.getRangeByName('H7').cellStyle = globalStyle;
    sheet.getRangeByName('I7').cellStyle = globalStyle;
    sheet.getRangeByName('J7').cellStyle = globalStyle;

    // sheet.getRangeByName('J2').setText('เวลา: ${Tim_}');
    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A8').cellStyle = globalStyle2;
    sheet.getRangeByName('B8').cellStyle = globalStyle2;
    sheet.getRangeByName('C8').cellStyle = globalStyle2;
    sheet.getRangeByName('D8').cellStyle = globalStyle2;
    sheet.getRangeByName('E8').cellStyle = globalStyle2;
    sheet.getRangeByName('F8').cellStyle = globalStyle2;
    sheet.getRangeByName('G8').cellStyle = globalStyle2;
    sheet.getRangeByName('H8').cellStyle = globalStyle2;
    sheet.getRangeByName('I8').cellStyle = globalStyle2;
    sheet.getRangeByName('J8').cellStyle = globalStyle2;
    sheet.getRangeByName('A8').columnWidth = 18;
    sheet.getRangeByName('B8').columnWidth = 18;
    sheet.getRangeByName('C8').columnWidth = 18;
    sheet.getRangeByName('D8').columnWidth = 18;
    sheet.getRangeByName('E8').columnWidth = 18;
    sheet.getRangeByName('F8').columnWidth = 18;
    sheet.getRangeByName('G8').columnWidth = 18;
    sheet.getRangeByName('H8').columnWidth = 18;
    sheet.getRangeByName('I8').columnWidth = 18;
    sheet.getRangeByName('J8').columnWidth = 28;

    sheet.getRangeByName('A8').setText('เลขที่สัญญา/เสนอราคา');
    sheet.getRangeByName('B8').setText('ชื่อผู้ติดต่อ');
    sheet.getRangeByName('C8').setText('ชื่อร้านค้า');
    sheet.getRangeByName('D8').setText('โซนพื้นที่');
    sheet.getRangeByName('E8').setText('รหัสพื้นที่');
    sheet.getRangeByName('F8').setText('ขนาดพื้นที่(ต.ร.ม.)');
    sheet.getRangeByName('G8').setText('ระยะเวลาการเช่า');
    sheet.getRangeByName('H8').setText('วันเริ่มสัญญา');
    sheet.getRangeByName('I8').setText('วันสิ้นสุดสัญญา');
    sheet.getRangeByName('J8').setText('สถานะ');

    for (int i = 0; i < teNantModels.length; i++) {
      sheet.getRangeByName('A${i + 9}').cellStyle = globalStyle;
      sheet.getRangeByName('B${i + 9}').cellStyle = globalStyle3;
      sheet.getRangeByName('C${i + 9}').cellStyle = globalStyle;
      sheet.getRangeByName('D${i + 9}').cellStyle = globalStyle3;
      sheet.getRangeByName('E${i + 9}').cellStyle = globalStyle;
      sheet.getRangeByName('F${i + 9}').cellStyle = globalStyle3;
      sheet.getRangeByName('G${i + 9}').cellStyle = globalStyle;
      sheet.getRangeByName('H${i + 9}').cellStyle = globalStyle3;
      sheet.getRangeByName('I${i + 9}').cellStyle = globalStyle;
      sheet.getRangeByName('J${i + 9}').cellStyle = globalStyle3;

      if (i == (teNantModels.length - 1)) {
        sheet.getRangeByName('A${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('B${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('C${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('D${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('E${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('F${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('G${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('H${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('I${i + 9 + 1}').cellStyle = globalStyle;
        sheet.getRangeByName('J${i + 9 + 1}').cellStyle = globalStyle;

        sheet.getRangeByName('A${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('B${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('C${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('D${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('E${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('F${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('G${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('H${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('I${i + 9 + 2}').cellStyle = globalStyle;
        sheet.getRangeByName('J${i + 9 + 2}').cellStyle = globalStyle;
      } else {}

      sheet.getRangeByName('A${i + 9}').setText(
            teNantModels[i].docno == null
                ? teNantModels[i].cid == null
                    ? ''
                    : '${teNantModels[i].cid}'
                : '${teNantModels[i].docno}',
          );
      sheet.getRangeByName('B${i + 9}').setText(
            teNantModels[i].cname == null
                ? teNantModels[i].cname_q == null
                    ? ''
                    : '${teNantModels[i].cname_q}'
                : '${teNantModels[i].cname}',
          );
      sheet.getRangeByName('C${i + 9}').setText(
            teNantModels[i].sname == null
                ? teNantModels[i].sname_q == null
                    ? ''
                    : '${teNantModels[i].sname_q}'
                : '${teNantModels[i].sname}',
          );
      sheet.getRangeByName('D${i + 9}').setText(
            '${teNantModels[i].ln}',
          );
      sheet.getRangeByName('E${i + 9}').setText(
            teNantModels[i].ln_c == null
                ? teNantModels[i].ln_q == null
                    ? ''
                    : '${teNantModels[i].ln_q}'
                : '${teNantModels[i].ln_c}',
          );
      sheet.getRangeByName('F${i + 9}').setText(
            teNantModels[i].area_c == null
                ? teNantModels[i].area_q == null
                    ? ''
                    : '${teNantModels[i].area_q}'
                : '${teNantModels[i].area_c}',
          );
      sheet.getRangeByName('G${i + 9}').setText(
            teNantModels[i].period == null
                ? teNantModels[i].period_q == null
                    ? ''
                    : '${teNantModels[i].period_q}  ${teNantModels[i].rtname_q!.substring(3)}'
                : '${teNantModels[i].period}  ${teNantModels[i].rtname!.substring(3)}',
          );
      sheet.getRangeByName('H${i + 9}').setText(
            teNantModels[i].sdate_q == null
                ? teNantModels[i].sdate == null
                    ? ''
                    : DateFormat('dd-MM-yyyy')
                        .format(
                            DateTime.parse('${teNantModels[i].sdate} 00:00:00'))
                        .toString()
                : DateFormat('dd-MM-yyyy')
                    .format(
                        DateTime.parse('${teNantModels[i].sdate_q} 00:00:00'))
                    .toString(),
          );
      sheet.getRangeByName('I${i + 9}').setText(
            teNantModels[i].ldate_q == null
                ? teNantModels[i].ldate == null
                    ? ''
                    : DateFormat('dd-MM-yyyy')
                        .format(
                            DateTime.parse('${teNantModels[i].ldate} 00:00:00'))
                        .toString()
                : DateFormat('dd-MM-yyyy')
                    .format(
                        DateTime.parse('${teNantModels[i].ldate_q} 00:00:00'))
                    .toString(),
          );
      sheet.getRangeByName('J${i + 9}').setText(
            teNantModels[i].quantity == '1'
                ? datex.isAfter(DateTime.parse(
                                '${teNantModels[i].ldate} 00:00:00.000')
                            .subtract(const Duration(days: 0))) ==
                        true
                    ? 'หมดสัญญา'
                    : datex.isAfter(DateTime.parse(
                                    '${teNantModels[i].ldate} 00:00:00.000')
                                .subtract(const Duration(days: 30))) ==
                            true
                        ? 'ใกล้หมดสัญญา'
                        : 'เช่าอยู่'
                : teNantModels[i].quantity == '2'
                    ? 'เสนอราคา'
                    : teNantModels[i].quantity == '3'
                        ? 'เสนอราคา(มัดจำ)'
                        : 'ว่าง',
          );
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "ผู้เช่า(${Status[Status_ - 1]})(ณ วันที่${day_})", data, "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }
//////////----------------------------------------------------------------->

  void _displayPdf(renTal_name, bill_addr, bill_email, bill_tel, bill_tax,
      bill_name, newValuePDFimg) async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();

    final tableHeaders = [
      'เลขที่สัญญา/เสนอราคา',
      'ชื่อผู้ติดต่อ',
      'ชื่อร้านค้า',
      'โซนพื้นที่',
      'รหัสพื้นที่',
      'ขนาดพื้นที่(ต.ร.ม.)',
      'ระยะเวลาการเช่า',
      'วันเริ่มสัญญา',
      'วันสิ้นสุดสัญญา',
      'สถานะ',
    ];
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

    final tableData1 = [
      for (int i = 0; i < teNantModels.length; i++)
        [
          /////////////////////////////////////-------------------1
          teNantModels[i].docno == null
              ? teNantModels[i].cid == null
                  ? ''
                  : '${teNantModels[i].cid}'
              : '${teNantModels[i].docno}',
          /////////////////////////////////////-------------------2
          teNantModels[i].cname == null
              ? teNantModels[i].cname_q == null
                  ? ''
                  : '${teNantModels[i].cname_q}'
              : '${teNantModels[i].cname}',
          /////////////////////////////////////-------------------3
          teNantModels[i].sname == null
              ? teNantModels[i].sname_q == null
                  ? ''
                  : '${teNantModels[i].sname_q}'
              : '${teNantModels[i].sname}',
          /////////////////////////////////////-------------------4
          '${teNantModels[i].ln}',
          /////////////////////////////////////-------------------5
          teNantModels[i].ln_c == null
              ? teNantModels[i].ln_q == null
                  ? ''
                  : '${teNantModels[i].ln_q}'
              : '${teNantModels[i].ln_c}',
          /////////////////////////////////////-------------------6
          teNantModels[i].area_c == null
              ? teNantModels[i].area_q == null
                  ? ''
                  : '${teNantModels[i].area_q}'
              : '${teNantModels[i].area_c}',
          /////////////////////////////////////-------------------7
          teNantModels[i].period == null
              ? teNantModels[i].period_q == null
                  ? ''
                  : '${teNantModels[i].period_q}  ${teNantModels[i].rtname_q!.substring(3)}'
              : '${teNantModels[i].period}  ${teNantModels[i].rtname!.substring(3)}',
          /////////////////////////////////////-------------------8
          teNantModels[i].sdate_q == null
              ? teNantModels[i].sdate == null
                  ? ''
                  : DateFormat('dd-MM-yyyy')
                      .format(
                          DateTime.parse('${teNantModels[i].sdate} 00:00:00'))
                      .toString()
              : DateFormat('dd-MM-yyyy')
                  .format(DateTime.parse('${teNantModels[i].sdate_q} 00:00:00'))
                  .toString(),
          /////////////////////////////////////-------------------9
          teNantModels[i].ldate_q == null
              ? teNantModels[i].ldate == null
                  ? ''
                  : DateFormat('dd-MM-yyyy')
                      .format(
                          DateTime.parse('${teNantModels[i].ldate} 00:00:00'))
                      .toString()
              : DateFormat('dd-MM-yyyy')
                  .format(DateTime.parse('${teNantModels[i].ldate_q} 00:00:00'))
                  .toString(),
          /////////////////////////////////////-------------------10
          teNantModels[i].quantity == '1'
              ? datex.isAfter(DateTime.parse(
                              '${teNantModels[i].ldate} 00:00:00.000')
                          .subtract(const Duration(days: 0))) ==
                      true
                  ? 'หมดสัญญา'
                  : datex.isAfter(DateTime.parse(
                                  '${teNantModels[i].ldate} 00:00:00.000')
                              .subtract(const Duration(days: 30))) ==
                          true
                      ? 'ใกล้หมดสัญญา'
                      : 'เช่าอยู่'
              : teNantModels[i].quantity == '2'
                  ? 'เสนอราคา'
                  : teNantModels[i].quantity == '3'
                      ? 'เสนอราคา(มัดจำ)'
                      : 'ว่าง',
        ],
    ];

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
                      'ข้อมูลผู้เช่า',
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
                          'ผู้เช่า : ${Status[Status_ - 1]}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              // fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        )
                        // style: pw.TextStyle(fontSize: 30),
                        ),
                    if (zone_name.toString() == 'null')
                      pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            'โซน : ทั้งหมด',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                // fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black),
                          )
                          // style: pw.TextStyle(fontSize: 30),
                          ),
                    if (zone_name.toString() != 'null')
                      pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            'โซน : ${zone_name}',
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
                        child: pw.Text('เลขที่สัญญา/เสนอราคา',
                            textAlign: pw.TextAlign.left,
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
                        child: pw.Text('ชื่อผู้ติดต่อ',
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
                        child: pw.Text('ชื่อร้านค้า',
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
                        child: pw.Text('โซนพื้นที่',
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
                        child: pw.Text('รหัสพื้นที่',
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
                        child: pw.Text('ขนาดพื้นที่(ต.ร.ม.)',
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
                        child: pw.Text('ระยะเวลาการเช่า',
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
                        child: pw.Text('วันเริ่มสัญญา',
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
                        child: pw.Text('วันสิ้นสุดสัญญา',
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
                        child: pw.Text('สถานะ',
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
                for (int i = 0; i < teNantModels.length; i++)
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
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                                teNantModels[i].docno == null
                                    ? teNantModels[i].cid == null
                                        ? ''
                                        : '${teNantModels[i].cid}'
                                    : '${teNantModels[i].docno}',
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
                            child: pw.Text(
                                teNantModels[i].cname == null
                                    ? teNantModels[i].cname_q == null
                                        ? ''
                                        : '${teNantModels[i].cname_q}'
                                    : '${teNantModels[i].cname}',
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
                            child: pw.Text(
                                teNantModels[i].sname == null
                                    ? teNantModels[i].sname_q == null
                                        ? ''
                                        : '${teNantModels[i].sname_q}'
                                    : '${teNantModels[i].sname}',
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
                            child: pw.Text('${teNantModels[i].ln}',
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
                            child: pw.Text(
                                teNantModels[i].ln_c == null
                                    ? teNantModels[i].ln_q == null
                                        ? ''
                                        : '${teNantModels[i].ln_q}'
                                    : '${teNantModels[i].ln_c}',
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
                            child: pw.Text(
                                teNantModels[i].area_c == null
                                    ? teNantModels[i].area_q == null
                                        ? ''
                                        : '${teNantModels[i].area_q}'
                                    : '${teNantModels[i].area_c}',
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
                            child: pw.Text(
                                teNantModels[i].period == null
                                    ? teNantModels[i].period_q == null
                                        ? ''
                                        : '${teNantModels[i].period_q}  ${teNantModels[i].rtname_q!.substring(3)}'
                                    : '${teNantModels[i].period}  ${teNantModels[i].rtname!.substring(3)}',
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
                            child: pw.Text(
                                teNantModels[i].sdate_q == null
                                    ? teNantModels[i].sdate == null
                                        ? ''
                                        : DateFormat('dd-MM-yyyy')
                                            .format(DateTime.parse(
                                                '${teNantModels[i].sdate} 00:00:00'))
                                            .toString()
                                    : DateFormat('dd-MM-yyyy')
                                        .format(DateTime.parse(
                                            '${teNantModels[i].sdate_q} 00:00:00'))
                                        .toString(),
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
                            child: pw.Text(
                                teNantModels[i].ldate_q == null
                                    ? teNantModels[i].ldate == null
                                        ? ''
                                        : DateFormat('dd-MM-yyyy')
                                            .format(DateTime.parse(
                                                '${teNantModels[i].ldate} 00:00:00'))
                                            .toString()
                                    : DateFormat('dd-MM-yyyy')
                                        .format(DateTime.parse(
                                            '${teNantModels[i].ldate_q} 00:00:00'))
                                        .toString(),
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
                            child: pw.Text(
                                teNantModels[i].quantity == '1'
                                    ? datex.isAfter(DateTime.parse(
                                                    '${teNantModels[i].ldate} 00:00:00.000')
                                                .subtract(
                                                    const Duration(days: 0))) ==
                                            true
                                        ? 'หมดสัญญา'
                                        : datex.isAfter(DateTime.parse(
                                                        '${teNantModels[i].ldate} 00:00:00.000')
                                                    .subtract(const Duration(
                                                        days: 30))) ==
                                                true
                                            ? 'ใกล้หมดสัญญา'
                                            : 'เช่าอยู่'
                                    : teNantModels[i].quantity == '2'
                                        ? 'เสนอราคา'
                                        : teNantModels[i].quantity == '3'
                                            ? 'เสนอราคา(มัดจำ)'
                                            : 'ว่าง',
                                textAlign: pw.TextAlign.right,
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
                // pw.Table.fromTextArray(
                //   headers: tableHeaders,
                //   data: tableData1,
                //   border: null,
                //   headerStyle: pw.TextStyle(
                //       fontSize: 10.0,
                //       fontWeight: pw.FontWeight.bold,
                //       font: ttf,
                //       color: PdfColors.green900),
                //   headerDecoration: const pw.BoxDecoration(
                //     color: PdfColors.green100,
                //     border: pw.Border(
                //       bottom: pw.BorderSide(color: PdfColors.green900),
                //     ),
                //   ),
                //   cellStyle: pw.TextStyle(
                //       fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                //   cellHeight: 25.0,
                //   cellAlignments: {
                //     0: pw.Alignment.centerLeft,
                //     1: pw.Alignment.centerRight,
                //     2: pw.Alignment.centerRight,
                //     3: pw.Alignment.centerRight,
                //     4: pw.Alignment.centerRight,
                //     5: pw.Alignment.centerRight,
                //     6: pw.Alignment.centerRight,
                //     7: pw.Alignment.centerRight,
                //     8: pw.Alignment.centerRight,
                //     9: pw.Alignment.centerRight,
                //     10: pw.Alignment.centerRight,
                //     11: pw.Alignment.centerRight,
                //   },
                // ),
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
    final List<int> bytes = await doc.save();
    final Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.PDF;
    ////////////---------------------------------------------->
    if (Pre_and_Dow == 'Download') {
      ////////////---------------------------------------------->
      if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
        final dir = await FileSaver.instance.saveFile(
            "ผู้เช่า(${Status[Status_ - 1]})(ณ วันที่${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year})",
            data,
            "pdf",
            mimeType: type);
      } else {
        final dir = await FileSaver.instance
            .saveFile("${NameFile_}", data, "pdf", mimeType: type);
        setState(() {
          _formKey.currentState!.reset();
          FormNameFile_text.clear();
          FormNameFile_text.text = '';
          _verticalGroupValue_NameFile = 'จากระบบ';
        });
      }
      ////////////---------------------------------------------->
    } else {
      // open Preview Screen
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewChaoAreaScreen(
                doc: doc, Status_: 'ผู้เช่า(${Status[Status_ - 1]})'),
          ));
    }
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => PreviewChaoAreaScreen(
    //           doc: doc, Status_: 'ผู้เช่า(${Status[Status_ - 1]})'),
    //     ));
  }
}

class PreviewChaoAreaScreen extends StatelessWidget {
  final pw.Document doc;
  final Status_;
  PreviewChaoAreaScreen({super.key, required this.doc, this.Status_});

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
          title: Text(
            "${Status_}",
            style: const TextStyle(
                color: Colors.white, fontFamily: FontWeight_.Fonts_T),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: false,
          allowPrinting: true, canChangePageFormat: false,
          canChangeOrientation: false, canDebug: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "${Status_}[$day_]-[$Tim_].pdf",
        ),
      ),
    );
  }
}
