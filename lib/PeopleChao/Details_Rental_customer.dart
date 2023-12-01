import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetZone_Model.dart';
import '../PeopleChao/PeopleChao_Screen2.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'package:http/http.dart' as http;

class Details_Rental_customer extends StatefulWidget {
  final name_custno;
  final updateMessage2;

  const Details_Rental_customer(
      {super.key, this.name_custno, this.updateMessage2});

  @override
  State<Details_Rental_customer> createState() =>
      _Details_Rental_customerState();
}

class _Details_Rental_customerState extends State<Details_Rental_customer> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  String tappedIndex_ = '';
  ScrollController _scrollController2 = ScrollController();
  List<TransBillModel> _TransBillModels = [];
  List<ZoneModel> zoneModels = [];

  List<TeNantModel> teNantModels = [];
  // List<List<TeNantModel>> teNantModels_Save = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<AreaModel> areaModels = [];
  String? renTal_user, renTal_name, Value_cid, custno_;

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
      bills_name_,
      imglogo_,
      imgl;
  List<RenTalModel> renTalModels = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();

    read_GC_rental();
    read_GC_tenant();
    // read_GC_areaSelect();
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';
    renTal_name = preferences.getString('renTalName');
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);
          var rtnamex = renTalModel.rtname!.trim();
          var typexs = renTalModel.type!.trim();
          var typexx = renTalModel.typex!.trim();
          var billNamex = renTalModel.bill_name!.trim();
          var billAddrx = renTalModel.bill_addr!.trim();
          var billTaxx = renTalModel.bill_tax!.trim();
          var billTelx = renTalModel.bill_tel!.trim();
          var billEmailx = renTalModel.bill_email!.trim();
          var billDefaultx = renTalModel.bill_default;
          var billTserx = renTalModel.tser;
          var name = renTalModel.pn!.trim();
          var foderx = renTalModel.dbn;
          setState(() {
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            bill_name = billNamex;
            bill_addr = billAddrx;
            bill_tax = billTaxx;
            bill_tel = billTelx;
            bill_email = billEmailx;
            bill_default = billDefaultx;
            bill_tser = billTserx;
            // tem_page_ser = renTalModel.tem_page!.trim();
            renTalModels.add(renTalModel);
            if (billDefaultx == 'P') {
              bills_name_ = 'บิลธรรมดา';
            } else {
              bills_name_ = 'ใบกำกับภาษี';
            }
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  Future<Null> read_GC_tenant() async {
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var custno_s = widget.name_custno.toString();

    String url =
        '${MyConstant().domain}/GC_tenantAll_cust.php?isAdd=true&ren=$ren&custno=${custno_s}';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          if (teNantModel.cid == null ||
              teNantModel.cid.toString() == '' ||
              teNantModel.cid.toString() == 'null') {
          } else {
            setState(() {
              teNantModels.add(teNantModel);
            });
          }
        }
      } else {}
      red_Trans_bill();
    } catch (e) {}
  }

  /////////////////////////////////////////////////////////////////////
  List<String> total_list = [];
  double All_total = 0.00;
  Future<Null> red_Trans_bill() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String to_tal = '';
    double total = 0.00;
    // var ciddoc = preferences.getString('usercid');
    for (int index = 0; index < teNantModels.length; index++) {
      String url =
          '${MyConstant().domain}/GC_tran_paysCustomer.php?isAdd=true&ren=$ren&ciddoc=${teNantModels[index].cid}';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        //  print('${teNantModels[index].cid}');
        if (result.toString() != 'null') {
          for (var map in result) {
            TransBillModel _TransBillModel = TransBillModel.fromJson(map);
            var menu = double.parse(_TransBillModel.total.toString())
                .toStringAsFixed(2);
            // print('${_TransBillModel.date}');
            // print(_TransBillModel.total!);

            setState(() {
              // _TransBillModels.add(_TransBillModel);

              total = (_TransBillModel.total == null)
                  ? total + 0.00
                  : total + double.parse(_TransBillModel.total!);
              All_total = (_TransBillModel.total == null)
                  ? All_total + 0.00
                  : All_total + double.parse(_TransBillModel.total!);
              // if (_TransBillModel.invoice == null) {
              //   if (menu != '0.00') {
              //     total = (_TransBillModel.total == null)
              //         ? total + 0.00
              //         : total + double.parse(_TransBillModel.total!);
              //     All_total = (_TransBillModel.total == null)
              //         ? All_total + 0.00
              //         : All_total + double.parse(_TransBillModel.total!);
              //   }
              // }
              // _TransBillModels.add(_TransBillModel);
            });
          }
        }
        setState(() {
          total_list.add(total.toString());
          total = 0.00;
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            color: AppbackgroundColor.Sub_Abg_Colors,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            // border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Column(children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: AppbackgroundColor.TiTile_Colors,

                // color: green,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "สัญญา ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            // border: Border.all(color: Colors.orange, width: 2),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "สัญญาทั้งหมด : ${teNantModels.length}",
                            style: TextStyle(
                              // decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "ยอดรวม : ${nFormat.format(double.parse(All_total.toString()))} บาท  ",
                            style: TextStyle(
                              // decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Data_Widget()),
          ]),
        ));
  }

  Data_Widget() {
    //////////////////////////////////////////////////////////////////////
    // List<Widget> data = [];
    // for (int index = 0; index < teNantModels.length; index++) {

    // }

    return Column(
      children: [
        for (int index = 0; index < teNantModels.length; index++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                // setState(() {
                //   ReturnBodyPeople = 'PeopleChaoScreen2';
                // });
                setState(() {
                  var ser_teNant = teNantModels[index].quantity;
                  Value_cid = teNantModels[index].cid.toString();
                  widget.updateMessage2(
                      'PeopleChaoScreen2', ser_teNant, Value_cid);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(0, 1))
                    ]),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    Container(
                      color:
                          Color.fromARGB(255, 201, 196, 186)!.withOpacity(0.5),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${index + 1}. ชื่อร้านค้า  : ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  )),
                              Text(
                                teNantModels[index].sname == null
                                    ? teNantModels[index].sname_q == null
                                        ? ''
                                        : '${teNantModels[index].sname_q}'
                                    : '${teNantModels[index].sname}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: teNantModels[index].quantity == '1'
                                    ? datex.isAfter(DateTime.parse(
                                                    '${teNantModels[index].ldate} 00:00:00.000')
                                                .subtract(
                                                    const Duration(days: 0))) ==
                                            true
                                        ? Color.fromARGB(255, 254, 0, 0)
                                        : datex.isAfter(DateTime.parse(
                                                        '${teNantModels[index].ldate} 00:00:00.000')
                                                    .subtract(const Duration(
                                                        days: 30))) ==
                                                true
                                            ? Colors.amber
                                            : Colors.green
                                    : teNantModels[index].quantity == '2'
                                        ? Colors.blue
                                        : teNantModels[index].quantity == '3'
                                            ? Colors.blue.shade100
                                            : Colors.blueGrey.shade50,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                // border: Border.all(
                                //     color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                teNantModels[index].quantity == '1'
                                    ? datex.isAfter(DateTime.parse(
                                                    '${teNantModels[index].ldate} 00:00:00.000')
                                                .subtract(
                                                    const Duration(days: 0))) ==
                                            true
                                        ? 'สถานะ : หมดสัญญา'
                                        : datex.isAfter(DateTime.parse(
                                                        '${teNantModels[index].ldate} 00:00:00.000')
                                                    .subtract(const Duration(
                                                        days: 30))) ==
                                                true
                                            ? 'สถานะ : ใกล้หมดสัญญา'
                                            : 'สถานะ : เช่าอยู่'
                                    : teNantModels[index].quantity == '2'
                                        ? 'สถานะ : เสนอราคา'
                                        : teNantModels[index].quantity == '3'
                                            ? 'สถานะ : เสนอราคา(มัดจำ)'
                                            : 'สถานะ : ว่าง',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("ชื่อผู้ติดต่อ : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  )),
                              Text(
                                teNantModels[index].cname == null
                                    ? teNantModels[index].cname_q == null
                                        ? ''
                                        : '${teNantModels[index].cname_q}'
                                    : '${teNantModels[index].cname}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("รหัสพื้นที่ : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  )),
                              Text(
                                teNantModels[index].ln_c == null
                                    ? teNantModels[index].ln_q == null
                                        ? ''
                                        : '${teNantModels[index].ln_q}'
                                    : '${teNantModels[index].ln_c}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8.0),
                                child: Row(
                                  children: [
                                    Text("เลขสัญญา : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        )),
                                    Text(
                                      teNantModels[index].docno == null
                                          ? teNantModels[index].cid == null
                                              ? ''
                                              : '${teNantModels[index].cid}'
                                          : '${teNantModels[index].docno}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text("โซน : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      )),
                                  Text(
                                    '${teNantModels[index].zn}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                (total_list.length != teNantModels.length)
                                    ? 'ยอด :'
                                    : "ยอด : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                              Text(
                                (total_list.length != teNantModels.length)
                                    ? '0.00 บาท'
                                    : "${nFormat.format(double.parse(total_list[index].toString()))} บาท",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
