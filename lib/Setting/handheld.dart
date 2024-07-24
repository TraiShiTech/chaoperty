import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/Get_C_print.dart';
import '../Style/ThaiBaht.dart';
import '../Style/colors.dart';

class HandHeld extends StatefulWidget {
  const HandHeld({super.key});

  @override
  State<HandHeld> createState() => _HandHeldState();
}

class _HandHeldState extends State<HandHeld> {
  List<RenTalModel> renTalModels = [];
  List<PrintModel> printModels = [];
  List<ExpModel> expModels = [];
  List<PayMentModel> _PayMentModels = [];
  DateTime dateTime = DateTime.now();
  var nFormat = NumberFormat("#,##0.00", "en_US");
  final Form1_text = TextEditingController();
  final Form2_text = TextEditingController();
  final Form_texthead = TextEditingController();
  GlobalKey qrImageKey = GlobalKey();
  int index_b = 0, _openprint = 0;
  int? _p_logo,
      _p_bill_name,
      _p_bill_addr,
      _p_timex,
      _p_datex,
      _p_invoice,
      _p_name,
      _p_name_shop,
      _p_area,
      _p_zone,
      _p_foot,
      _p_head,
      _p_number,
      _p_textfoot,
      _texthead,
      _p_name_custno,
      _p_cash;
  String? ser_user,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      renTal_Email,
      rtname,
      type,
      typex,
      renname,
      pkname,
      ser_Zonex,
      bill_name,
      bill_addr;
  String? base64_Imgmap, foder;
  String? tel_user, img_, img_logo;
  String? _p_text, _p_foot_text, _fname, _p_texthead;
  String? renTal_user,
      renTal_name,
      zone_ser,
      zone_name,
      Value_cid,
      fname_,
      lname_,
      px_ser,
      _Date,
      _Time;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_GC_rental();
    read_GC_print();
    read_GC_Exp();
    red_payMent();
    _Date = DateFormat('dd-MM-yyyy').format(dateTime);
    _Time = DateFormat('HH:mm:ss').format(dateTime);
  }

  Future<Null> red_payMent() async {
    if (_PayMentModels.length != 0) {
      setState(() {
        _PayMentModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      for (var map in result) {
        PayMentModel _PayMentModel = PayMentModel.fromJson(map);

        setState(() {
          _PayMentModels.add(_PayMentModel);
        });
      }
    } catch (e) {}
  }

  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      expModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_exp_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ExpModel expModel = ExpModel.fromJson(map);

          setState(() {
            expModels.add(expModel);
          });
        }
      } else {}
    } catch (e) {}
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
          var billname = renTalModel.bill_name;
          var billaddr = renTalModel.bill_addr;
          var print = int.parse(renTalModel.open_print!);

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
            pkname = pkx;
            img_ = img;
            img_logo = imglogo;
            bill_name = billname;
            bill_addr = billaddr;
            _openprint = print;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  Future<Null> read_GC_print() async {
    if (printModels.isNotEmpty) {
      printModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var fname = preferences.getString('fname');
    String url = '${MyConstant().domain}/GC_Print.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          PrintModel printModel = PrintModel.fromJson(map);
          var p_logo = int.parse(printModel.logo!);
          var p_bill_name = int.parse(printModel.bill_name!);
          var p_bill_addr = int.parse(printModel.bill_addr!);
          var p_text = printModel.text!.trim();
          var p_timex = int.parse(printModel.timex!);
          var p_datex = int.parse(printModel.datex!);
          var foot_text = printModel.foot_text!.trim();
          var p_foot = int.parse(printModel.foot!);
          var p_invoice = int.parse(printModel.invoice!);
          var p_name = int.parse(printModel.name!);
          var p_name_shop = int.parse(printModel.name_shop!);
          var p_area = int.parse(printModel.area!);
          var p_zone = int.parse(printModel.zone!);
          var p_head = int.parse(printModel.head!);
          var p_number = int.parse(printModel.number!);
          var p_textfoot = int.parse(printModel.textfoot!);
          var p_texthead = printModel.texthead!.trim();
          var p_name_custno = int.parse(printModel.name_custno!);
          var p_cash = int.parse(printModel.cash!);

          setState(() {
            _p_logo = p_logo;
            _p_bill_name = p_bill_name;
            _p_bill_addr = p_bill_addr;
            _p_text = p_text;
            _p_timex = p_timex;
            _p_datex = p_datex;
            _p_foot = p_foot;
            _p_foot_text = foot_text;
            _p_invoice = p_invoice;
            _p_name = p_name;
            _p_name_shop = p_name_shop;
            _p_area = p_area;
            _p_zone = p_zone;
            _fname = fname;
            _p_head = p_head;
            _p_texthead = p_texthead;
            _p_number = p_number;
            _p_textfoot = p_textfoot;
            _p_name_custno = p_name_custno;
            _p_cash = p_cash;
            Form_texthead.text = p_texthead;
            Form1_text.text = foot_text;
            Form2_text.text = p_text;
            printModels.add(printModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    minFontSize: 20,
                    maxFontSize: 30,
                    'ตั้งค่า Handheld',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: index_b == 1
                                      ? Colors.blue.shade900
                                      : Colors.white,
                                  child: Container(
                                    height: 50,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          index_b = 1;
                                        });
                                      },
                                      child: Center(
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 20,
                                          'ตั้งค่าหน้ากระดาษ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: index_b == 1
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: index_b == 2
                                      ? Colors.blue.shade900
                                      : Colors.white,
                                  child: Container(
                                    height: 50,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          index_b = 2;
                                        });
                                      },
                                      child: Center(
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 20,
                                          'ตั้งค่าแสดงรายการ เพิ่มค่าบริการ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: index_b == 2
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: index_b == 3
                                      ? Colors.blue.shade900
                                      : Colors.white,
                                  child: Container(
                                    height: 50,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          index_b = 3;
                                        });
                                      },
                                      child: Center(
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 20,
                                          'ตั้งค่าแสดงรายการ ช่องทางชำระ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: index_b == 3
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Expanded(
                  flex: 8,
                  child: index_b == 0
                      ? SizedBox()
                      : index_b == 1
                          ? setA()
                          : index_b == 2
                              ? setB()
                              : setC(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column setB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  'Preview >>> ',
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 10,
                  maxFontSize: 25,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'เพิ่มรายการชำระ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T
                                      //fontSize: 10.0
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'รายการชำระ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text1_,
                                          fontFamily: Font_.Fonts_T
                                          //fontSize: 10.0
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'ยอดชำระ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text1_,
                                          fontFamily: Font_.Fonts_T
                                          //fontSize: 10.0
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                StreamBuilder(
                                    stream: Stream.periodic(
                                        const Duration(seconds: 0)),
                                    builder: (context, snapshot) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                        child: GridView.count(
                                          crossAxisCount: 2,
                                          children: [
                                            for (int i = 0;
                                                i < expModels.length;
                                                i++)
                                              if (expModels[i].show_han == '1')
                                                Card(
                                                  color: Colors.white,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      // setState(() {
                                                      //   text_add.text =
                                                      //       expModels[i]
                                                      //           .expname
                                                      //           .toString();
                                                      //   price_add.text =
                                                      //       expModels[i]
                                                      //           .pri_han
                                                      //           .toString();
                                                      // });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            maxLines: 1,
                                                            '${expModels[i].expname}',
                                                            textAlign: TextAlign
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
                                                          AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            maxLines: 1,
                                                            '${nFormat.format(double.parse(expModels[i].pri_han!))}',
                                                            textAlign: TextAlign
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  for (int i = 0; i < expModels.length; i++)
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: AutoSizeText(
                              '${expModels[i].expname}',
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 6,
                              maxFontSize: 16,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      String? ren =
                                          preferences.getString('renTalSer');

                                      var nametable = 'show_han';
                                      var set = expModels[i].show_han == '1'
                                          ? '0'
                                          : '1';
                                      var serh = expModels[i].ser;
                                      String url =
                                          '${MyConstant().domain}/U_han.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set&serh=$serh';
                                      try {
                                        var response =
                                            await http.get(Uri.parse(url));

                                        var result = json.decode(response.body);
                                        print(result);
                                        if (result.toString() == 'true') {
                                          read_GC_Exp();
                                        }
                                      } catch (e) {}
                                    },
                                    icon: expModels[i].show_han == '1'
                                        ? Icon(
                                            Icons.toggle_on_outlined,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.toggle_off_outlined,
                                          ),
                                  ),
                                  Center(
                                    child: AutoSizeText(
                                      minFontSize: 5,
                                      maxFontSize: 12,
                                      expModels[i].show_han == '1'
                                          ? 'เปิดอยู่'
                                          : 'ปิดอยู่',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: expModels[i].show_han == '1'
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        onChanged: (value) async {},
                                        onFieldSubmitted: (value) async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? ren = preferences
                                              .getString('renTalSer');

                                          var nametable = 'pri_han';
                                          var set = value;
                                          var serh = expModels[i].ser;
                                          String url =
                                              '${MyConstant().domain}/U_han.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set&serh=$serh';
                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            print(result);
                                            if (result.toString() == 'true') {
                                              read_GC_Exp();
                                            }
                                          } catch (e) {}
                                        },
                                        decoration: InputDecoration(
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            filled: true,

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
                                            errorStyle: TextStyle(
                                                fontFamily: Font_.Fonts_T),
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
                                                color: Colors.black,
                                              ),
                                            ),
                                            labelText: nFormat.format(
                                                double.parse(
                                                    expModels[i].pri_han!)),
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily: Font_.Fonts_T)),
                                        inputFormatters: <TextInputFormatter>[
                                          // for below version 2 use this
                                          // FilteringTextInputFormatter(RegExp("[a-zA-Z1-9@.]"),
                                          //     allow: true),
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9 .]')),
                                          // for version 2 and greater youcan also use this
                                          // FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    )
                                  : SizedBox()),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column setC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  'Preview >>> ',
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 10,
                  maxFontSize: 25,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'ช่องทางการชำระ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T
                                      //fontSize: 10.0
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // _PayMentModels
                        for (int i = 0; i < _PayMentModels.length; i++)
                          if (_PayMentModels[i].ser_han == '1')
                            Card(
                              child: InkWell(
                                onTap: () {
                                  if (_PayMentModels[i].img.toString().trim() !=
                                      '') {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Center(
                                                  child: RepaintBoundary(
                                                    key: qrImageKey,
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(4, 8, 4, 2),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Center(
                                                            child: Container(
                                                              width: 220,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green[300],
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Center(
                                                                child: Text(
                                                                  '$renTal_name',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 300,
                                                            height: 300,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(
                                                                    '${MyConstant().domain}/files/$foder/payment/${_PayMentModels[i].img.toString().trim()}'),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
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
                                                                  .all(8.0),
                                                          child: TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    'OK'),
                                                            child: const Text(
                                                              'ปิด',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          '${_PayMentModels[i].ptname!}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          '${_PayMentModels[i].bno!}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: Font_.Fonts_T,
                                          ),
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
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  for (int i = 0; i < _PayMentModels.length; i++)
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AutoSizeText(
                                      '${_PayMentModels[i].ptname}',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      '${_PayMentModels[i].bno}',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: Font_.Fonts_T,
                                      ),
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
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      String? ren =
                                          preferences.getString('renTalSer');

                                      var nametable = 'ser_han';
                                      var set = _PayMentModels[i].ser_han == '1'
                                          ? '0'
                                          : '1';
                                      var serh = _PayMentModels[i].ser;
                                      String url =
                                          '${MyConstant().domain}/U_Phan.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set&serh=$serh';
                                      try {
                                        var response =
                                            await http.get(Uri.parse(url));

                                        var result = json.decode(response.body);
                                        print(result);
                                        if (result.toString() == 'true') {
                                          red_payMent();
                                        }
                                      } catch (e) {}
                                    },
                                    icon: _PayMentModels[i].ser_han == '1'
                                        ? Icon(
                                            Icons.toggle_on_outlined,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.toggle_off_outlined,
                                          ),
                                  ),
                                  Center(
                                    child: AutoSizeText(
                                      minFontSize: 5,
                                      maxFontSize: 12,
                                      _PayMentModels[i].ser_han == '1'
                                          ? 'เปิดอยู่'
                                          : 'ปิดอยู่',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: SizedBox(),
                        // ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column setA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  'Preview >>> ',
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 10,
                  maxFontSize: 25,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        _p_logo == 1
                            ? Container(
                                child: (img_logo == null ||
                                        img_logo.toString() == '')
                                    ? const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.black,
                                        ),
                                      )
                                    : Image.network(
                                        '${MyConstant().domain}/files/$foder/logo/$img_logo',
                                        width: 50,
                                        height: 50,
                                      ),
                              )
                            : SizedBox(),
                        _p_bill_name == 1
                            ? Container(
                                child: AutoSizeText(
                                '$bill_name',
                                overflow: TextOverflow.ellipsis,
                                minFontSize: 6,
                                maxFontSize: 12,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ))
                            : SizedBox(),
                        _p_bill_name == 2
                            ? Container(
                                child: AutoSizeText(
                                '$_p_text',
                                overflow: TextOverflow.ellipsis,
                                minFontSize: 6,
                                maxFontSize: 12,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ))
                            : SizedBox(),
                        SizedBox(
                          height: 5,
                        ),
                        _p_head == 1
                            ? Container(
                                child: AutoSizeText(
                                '$_p_texthead',
                                overflow: TextOverflow.ellipsis,
                                minFontSize: 6,
                                maxFontSize: 12,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ))
                            : SizedBox(),
                        SizedBox(
                          height: 5,
                        ),
                        _p_bill_addr == 1
                            ? Container(
                                child: Text(
                                  '$bill_addr',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 5,
                        ),
                        _p_name == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    'ทดสอบ',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        _p_name_shop == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'ร้านค้า',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    'ร้านขนมจีน',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        _p_name_custno == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        ' ',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                  Expanded(
                                      flex: 6,
                                      child: Text(
                                        'แม่เพอร์ตี้ เช่าเพอร์ตี้',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                ],
                              )
                            : SizedBox(),
                        _p_invoice == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'เลขที่ใบเสร็จ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    'RE66-05-000059',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 9),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        _p_datex == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'วันที่',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    '$_Date',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        _p_timex == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'เวลา',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    '$_Time',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        _p_zone == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'โซน',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    'A',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        _p_area == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'พื้นที่',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    'A01',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'รายการ',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 12),
                            )),
                            Expanded(
                                child: Text(
                              'รวม',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 12),
                            )),
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'ค่าเช่า',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 10),
                            )),
                            Expanded(
                                child: Text(
                              '200.00',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 10),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'รวม',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 16),
                            )),
                            Expanded(
                                child: Text(
                              '200.00',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 16),
                            )),
                          ],
                        ),
                        _p_number == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '(${convertToThaiBaht(200.00)})',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        _p_cash == 1
                            ? Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    'ชำระเงินสด',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 1,
                        ),
                        Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _p_foot == 1
                            ? Container(
                                child: Text(
                                  '$_p_foot_text',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: _openprint != 0
                  ? Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String? ren =
                                      preferences.getString('renTalSer');

                                  var op = '0';
                                  String url =
                                      '${MyConstant().domain}/U_open_print.php?isAdd=true&ren=$ren&op=$op';
                                  try {
                                    var response =
                                        await http.get(Uri.parse(url));

                                    var result = json.decode(response.body);
                                    print(result);
                                    if (result.toString() == 'true') {
                                      read_GC_rental();
                                      read_GC_print();
                                    }
                                  } catch (e) {}
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _openprint != 0
                                        ? Colors.red.shade400
                                        : Colors.grey.shade400,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: AutoSizeText(
                                    'เปิดการพิมพ์ใบเสร็จ',
                                    overflow: TextOverflow.ellipsis,
                                    minFontSize: 6,
                                    maxFontSize: 16,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ])
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var op = '1';
                                    String url =
                                        '${MyConstant().domain}/U_open_print.php?isAdd=true&ren=$ren&op=$op';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_rental();
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _openprint != 0
                                          ? Colors.red.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'ปิดการพิมพ์ใบเสร็จ',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'logo';
                                    var set = _p_logo == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_logo == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'โลโก้',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'bill_name';
                                    var set = _p_bill_name == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_bill_name == 1
                                          ? Colors.green.shade400
                                          : _p_bill_name == 2
                                              ? Colors.green.shade400
                                              : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'หัวบิล',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'bill_name';
                                    var set = _p_bill_name == 2 ? 0 : 2;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_bill_name == 2
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'กำหนด',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        _p_bill_name == 2
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        // maxLines: 3,
                                        //keyboardType: TextInputType.none,
                                        controller: Form2_text,
                                        onChanged: (value) async {},
                                        onFieldSubmitted: (value) async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? ren = preferences
                                              .getString('renTalSer');

                                          var nametable = 'text';
                                          var set = value;
                                          String url =
                                              '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            print(result);
                                            if (result.toString() == 'true') {
                                              read_GC_print();
                                            }
                                          } catch (e) {}
                                        },

                                        decoration: InputDecoration(
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            filled: true,

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
                                            errorStyle: TextStyle(
                                                fontFamily: Font_.Fonts_T),
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
                                                color: Colors.black,
                                              ),
                                            ),
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily: Font_.Fonts_T)),
                                        // inputFormatters: <TextInputFormatter>[
                                        //   // for below version 2 use this
                                        //   FilteringTextInputFormatter(RegExp("[a-zA-Z1-9@.]"),
                                        //       allow: true),
                                        //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                        //   // for version 2 and greater youcan also use this
                                        //   // FilteringTextInputFormatter.digitsOnly
                                        // ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String? ren =
                                            preferences.getString('renTalSer');

                                        var nametable = 'head';
                                        var set = _p_head == 1 ? 0 : 1;
                                        String url =
                                            '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                        try {
                                          var response =
                                              await http.get(Uri.parse(url));

                                          var result =
                                              json.decode(response.body);
                                          print(result);
                                          if (result.toString() == 'true') {
                                            read_GC_print();
                                          }
                                        } catch (e) {}
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _p_head == 1
                                              ? Colors.green.shade400
                                              : Colors.grey.shade400,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          'หัวบิลรอง',
                                          overflow: TextOverflow.ellipsis,
                                          minFontSize: 6,
                                          maxFontSize: 16,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            _p_head == 1
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextFormField(
                                            // maxLines: 3,
                                            //keyboardType: TextInputType.none,
                                            controller: Form_texthead,
                                            onChanged: (value) async {},
                                            onFieldSubmitted: (value) async {
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String? ren = preferences
                                                  .getString('renTalSer');

                                              var nametable = 'texthead';
                                              var set = value;
                                              String url =
                                                  '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                              try {
                                                var response = await http
                                                    .get(Uri.parse(url));

                                                var result =
                                                    json.decode(response.body);
                                                print(result);
                                                if (result.toString() ==
                                                    'true') {
                                                  read_GC_print();
                                                }
                                              } catch (e) {}
                                            },

                                            decoration: InputDecoration(
                                                fillColor: Colors.white
                                                    .withOpacity(0.3),
                                                filled: true,

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
                                                errorStyle: TextStyle(
                                                    fontFamily: Font_.Fonts_T),
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
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                    fontFamily: Font_.Fonts_T)),
                                            // inputFormatters: <TextInputFormatter>[
                                            //   // for below version 2 use this
                                            //   FilteringTextInputFormatter(RegExp("[a-zA-Z1-9@.]"),
                                            //       allow: true),
                                            //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            //   // for version 2 and greater youcan also use this
                                            //   // FilteringTextInputFormatter.digitsOnly
                                            // ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'bill_addr';
                                    var set = _p_bill_addr == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_bill_addr == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'ที่อยู่',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'name';
                                    var set = _p_name == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_name == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'ผู้ทำรายการ',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'name_shop';
                                    var set = _p_name_shop == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_name_shop == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'ชื่อร้าน',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'name_custno';
                                    var set = _p_name_custno == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_name_custno == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'ชื่อลูกค้า',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'invoice';
                                    var set = _p_invoice == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_invoice == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'เลขที่ใบเสร็จ',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'datex';
                                    var set = _p_datex == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_datex == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'วันที่',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'timex';
                                    var set = _p_timex == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_timex == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'เวลา',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'zone';
                                    var set = _p_zone == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_zone == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'โซนพื้นที่',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'area';
                                    var set = _p_area == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_area == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'รหัสพื้นที่',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'number';
                                    var set = _p_number == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_number == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'ตัวเลขยอดรวม',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'foot';
                                    var set = _p_foot == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_foot == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'ท้ายบิล',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');

                                    var nametable = 'cash';
                                    var set = _p_cash == 1 ? 0 : 1;
                                    String url =
                                        '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result = json.decode(response.body);
                                      print(result);
                                      if (result.toString() == 'true') {
                                        read_GC_print();
                                      }
                                    } catch (e) {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _p_cash == 1
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'ช่องทางชำระ',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 6,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        _p_foot == 1
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        // maxLines: 3,
                                        //keyboardType: TextInputType.none,
                                        controller: Form1_text,
                                        onChanged: (value) async {},
                                        onFieldSubmitted: (value) async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? ren = preferences
                                              .getString('renTalSer');

                                          var nametable = 'foot_text';
                                          var set = value;
                                          String url =
                                              '${MyConstant().domain}/U_print.php?isAdd=true&ren=$ren&nametable=$nametable&set=$set';
                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            print(result);
                                            if (result.toString() == 'true') {
                                              read_GC_print();
                                            }
                                          } catch (e) {}
                                        },

                                        decoration: InputDecoration(
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            filled: true,

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
                                            errorStyle: TextStyle(
                                                fontFamily: Font_.Fonts_T),
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
                                                color: Colors.black,
                                              ),
                                            ),
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily: Font_.Fonts_T)),
                                        // inputFormatters: <TextInputFormatter>[
                                        //   // for below version 2 use this
                                        //   FilteringTextInputFormatter(RegExp("[a-zA-Z1-9@.]"),
                                        //       allow: true),
                                        //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                        //   // for version 2 and greater youcan also use this
                                        //   // FilteringTextInputFormatter.digitsOnly
                                        // ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ],
    );
  }
}
