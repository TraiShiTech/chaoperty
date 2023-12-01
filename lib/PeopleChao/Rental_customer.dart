import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetC_regis_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetZone_Model.dart';
import 'package:http/http.dart' as http;

import '../PeopleChao/PeopleChao_Screen2.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Details_Rental_customer.dart';

class Rental_customers extends StatefulWidget {
  final updateMessage;
  final updatesearch;

  const Rental_customers({super.key, this.updateMessage, this.updatesearch});

  @override
  State<Rental_customers> createState() => _Rental_customersState();
}

class _Rental_customersState extends State<Rental_customers> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  String tappedIndex_ = '';
  ScrollController _scrollController2 = ScrollController();
  List<TransBillModel> _TransBillModels = [];
  List<ZoneModel> zoneModels = [];
  int Count_OFF_SET = 0;
  List<TeNantModel> teNantModels = [];
  List<TeNantModel> teNantModels_Sum = [];
  // List<List<TeNantModel>> teNantModels_Save = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<AreaModel> areaModels = [];

  List<c_regis_Model> regisModels = [];
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
  String text_data = '';
  @override
  void initState() {
    checkPreferance();
    read_GC_rental();

    read_GC_tenant();
    read_GC_Regis();
    super.initState();
  }

  @override
  void didUpdateWidget(Rental_customers oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.updatesearch != oldWidget.updatesearch) {
      // Call _searchBar when widget.updatesearch changes
      _searchBar();
    }
  }

  void _searchBar() {
    text_data = widget.updatesearch.toString();
    var text = text_data.toLowerCase();
    setState(() {
      teNantModels = _teNantModels.where((teNantModels) {
        var notTitle = teNantModels.cid.toString().toLowerCase();
        var notTitle2 = teNantModels.docno.toString().toLowerCase();
        var notTitle3 = teNantModels.invoice.toString().toLowerCase();
        var notTitle4 = teNantModels.ln_c.toString().toLowerCase();
        var notTitle5 = teNantModels.sname.toString().toLowerCase();
        var notTitle6 = teNantModels.cname.toString().toLowerCase();
        var notTitle7 = teNantModels.expname.toString().toLowerCase();
        var notTitle8 = teNantModels.custno.toString().toLowerCase();
        return notTitle.contains(text) ||
            notTitle2.contains(text) ||
            notTitle3.contains(text) ||
            notTitle4.contains(text) ||
            notTitle5.contains(text) ||
            notTitle6.contains(text) ||
            notTitle7.contains(text) ||
            notTitle8.contains(text);
      }).toList();
    });
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
    var zone = preferences.getString('zonePSer');
    String url =
        '${MyConstant().domain}/peploe_chaoAll_GrupBy.php?isAdd=true&ren=$ren&zone=$zone&count_OFFSET=$Count_OFF_SET';
    // zone == null
    //     ? '${MyConstant().domain}/peploe_chaoAll_GrupBy.php?isAdd=true&ren=$ren&zone=$zone'
    //     : zone == '0'
    //         ? '${MyConstant().domain}/peploe_chaoAll_GrupBy.php?isAdd=true&ren=$ren&zone=$zone'
    //         : '${MyConstant().domain}/peploe_chao_GrupBy.php.php?isAdd=true&ren=$ren&zone=$zone';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
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
      } else {}

      setState(() {
        _teNantModels = teNantModels;
      });
      read_GC_tenant_SUM();
    } catch (e) {}
  }

  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

///////////-----regisModels------GC_regis.php
  int Status_cuspang = 0;
  String? cust_no;
  String? ser_ren;

  Future<Null> read_GC_Regis() async {
    if (regisModels.isNotEmpty) {
      regisModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_regis.php?isAdd=true&ren=$ren';
    setState(() {
      ser_ren = ren;
    });
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          c_regis_Model regisModel = c_regis_Model.fromJson(map);
          setState(() {
            regisModels.add(regisModel);
          });
        }
      } else {}
      // red_Trans_bill();
    } catch (e) {}
  }

  Future<Null> read_GC_tenant_SUM() async {
    if (teNantModels_Sum.isNotEmpty) {
      teNantModels_Sum.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_tenantAll_Sumcust.php?isAdd=true&ren=$ren';

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
            teNantModels_Sum.add(teNantModel);
            // sum_teNantModel++;
          }
        }
      } else {}
      // red_Trans_bill();
    } catch (e) {}
  }

  Future<int> read_GC_tenant_where(index) async {
    String targetCustNo = teNantModels[index].custno!; // Get the target custno
    ///print(" custno: $targetCustNo");

    int sum_teNantModel = teNantModels_Sum
        .where((element) => element.custno == targetCustNo)
        .length;

    //print("Total $targetCustNo: $sum_teNantModel");
    return sum_teNantModel;
  }

  Future<String> read_GC_tenant_wherecids(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    double total = 0.00;
    String targetCustNo = teNantModels[index].custno!;

    await Future.forEach(
        teNantModels_Sum.where((element) => element.custno == targetCustNo),
        (element) async {
      try {
        String url =
            '${MyConstant().domain}/GC_tran_paysCustomer.php?isAdd=true&ren=$ren&ciddoc=${element.cid}';

        var response = await http.get(Uri.parse(url));
        var result = json.decode(response.body);

        if (result != null) {
          for (var map in result) {
            TransBillModel _TransBillModel = TransBillModel.fromJson(map);
            total += (_TransBillModel.total == null)
                ? 0.00
                : double.parse(_TransBillModel.total!);
            // if (_TransBillModel.invoice == null) {
            //   if (_TransBillModel.total != null) {
            //     total += (_TransBillModel.total == null)
            //         ? 0.00
            //         : double.parse(_TransBillModel.total!);
            //   }
            // }
          }
        }
      } catch (e) {
        // Handle or log the error here
      }
      // await Future.delayed(Duration(milliseconds: 600));
    });
    //print(" custno: $targetCustNo");
    return '${nFormat.format(double.parse(total.toString()))}';
  }

  String? _message, Valuecid;

  void updateMessage1(PeopleChaoScreen2, ValueNameShop_index, Valuecid) {
    setState(() {
      // _message = newMessage;
      widget.updateMessage(PeopleChaoScreen2, ValueNameShop_index, Valuecid);
      // Status_cuspang = int.parse(newMessage);
      Valuecid = Value_cid;
    });
  }

  // _searchBar() {
  //   return TextField(
  //     autofocus: false,
  //     keyboardType: TextInputType.text,
  //     style: const TextStyle(
  //         color: PeopleChaoScreen_Color.Colors_Text2_,
  //         fontFamily: Font_.Fonts_T),
  //     decoration: InputDecoration(
  //       filled: true,
  //       // fillColor: Colors.white,
  //       hintText: ' Search...',
  //       hintStyle: const TextStyle(
  //           color: PeopleChaoScreen_Color.Colors_Text2_,
  //           fontFamily: Font_.Fonts_T),
  //       contentPadding:
  //           const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
  //       // focusedBorder: OutlineInputBorder(
  //       //   borderSide: const BorderSide(color: Colors.white),
  //       //   borderRadius: BorderRadius.circular(10),
  //       // ),
  //       enabledBorder: UnderlineInputBorder(
  //         borderSide: const BorderSide(color: Colors.white),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //     onChanged: (text) {
  //       print(text);
  //       // search_ = text;
  //       text = text.toLowerCase();
  //       setState(() {
  //         teNantModels = _teNantModels.where((teNantModels) {
  //           var notTitle = teNantModels.lncode.toString().toLowerCase();
  //           var notTitle2 = teNantModels.cid.toString().toLowerCase();
  //           var notTitle3 = teNantModels.docno.toString().toLowerCase();
  //           var notTitle4 = teNantModels.sname.toString().toLowerCase();
  //           var notTitle5 = teNantModels.cname.toString().toLowerCase();
  //           var notTitle6 = teNantModels.zn.toString().toLowerCase();
  //           var notTitle7 = teNantModels.zser.toString().toLowerCase();
  //           return notTitle.contains(text) ||
  //               notTitle2.contains(text) ||
  //               notTitle3.contains(text) ||
  //               notTitle4.contains(text) ||
  //               notTitle5.contains(text) ||
  //               notTitle6.contains(text) ||
  //               notTitle7.contains(text);
  //         }).toList();
  //       });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return (Status_cuspang == 1)
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          // widget.updateMessage('6');
                          Status_cuspang = 0;
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
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'ย้อนกลับ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AccountScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                  //fontSize: 10.0
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
              Details_Rental_customer(
                  updateMessage2: updateMessage1, name_custno: cust_no)
              // PeopleChaoScreen2(
              //   Get_Value_cid: resultqr,
              //   Get_Value_NameShop_index: '1',
              //   Get_Value_status: '1',
              //   Get_Value_indexpage: '3',
              //   updateMessage: updateMessage,
              // ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width,
                  width: (Responsive.isDesktop(context))
                      ? MediaQuery.of(context).size.width * 0.85
                      : 1200,
                  decoration: const BoxDecoration(
                    color: AppbackgroundColor.Sub_Abg_Colors,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    // border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                          // width: MediaQuery.of(context).size.width,
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.85
                              : 1200,
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
                                      SizedBox(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: (Responsive.isDesktop(
                                                      context))
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85
                                                  : 1200,
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(0)),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(child: Text('')),
                                                      StreamBuilder(
                                                          stream: Stream.periodic(
                                                              const Duration(
                                                                  milliseconds:
                                                                      300)),
                                                          builder: (context,
                                                              snapshot) {
                                                            return Container(
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
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .menu_book,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 20,
                                                                  ),
                                                                  InkWell(
                                                                      onTap: (Count_OFF_SET ==
                                                                              0)
                                                                          ? null
                                                                          : () async {
                                                                              if (Count_OFF_SET == 0) {
                                                                              } else {
                                                                                Count_OFF_SET = Count_OFF_SET - 50;
                                                                                setState(() {
                                                                                  checkPreferance();
                                                                                  read_GC_rental();

                                                                                  read_GC_tenant();
                                                                                  read_GC_Regis();
                                                                                });
                                                                              }
                                                                            },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_left,
                                                                        color: (Count_OFF_SET ==
                                                                                0)
                                                                            ? Colors.grey[200]
                                                                            : Colors.black,
                                                                        size:
                                                                            25,
                                                                      )),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            4,
                                                                            0,
                                                                            4,
                                                                            0),
                                                                    child: Text(
                                                                      // '$Count_OFF_SET',
                                                                      (Count_OFF_SET ==
                                                                              0)
                                                                          ? '${Count_OFF_SET + 1}'
                                                                          : '${(Count_OFF_SET / 50) + 1}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .green,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                      onTap: (teNantModels.length ==
                                                                              0)
                                                                          ? null
                                                                          : () async {
                                                                              Count_OFF_SET = Count_OFF_SET + 50;
                                                                              setState(() {
                                                                                checkPreferance();
                                                                                read_GC_rental();

                                                                                read_GC_tenant();
                                                                                read_GC_Regis();
                                                                              });
                                                                            },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_right,
                                                                        color: (teNantModels.length ==
                                                                                0)
                                                                            ? Colors.grey[200]
                                                                            : Colors.black,
                                                                        size:
                                                                            25,
                                                                      )),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'รหัสลูกค้า ${widget.updatesearch.toString()}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
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
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'ชื่อผู้เช่า',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
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
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'ชื่อร้านค้า',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
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
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'User name',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
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
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'passw',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
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
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'สัญญาที่พบ',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
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
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'จำนวนเงิน',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
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
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            '...',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
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
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.7,
                                                width: Responsive.isDesktop(
                                                        context)
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.85
                                                    : 1200,
                                                decoration: const BoxDecoration(
                                                  color: AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0)),
                                                  // border: Border.all(color: Colors.grey, width: 1),
                                                ),
                                                child: teNantModels.isEmpty
                                                    ? SizedBox(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const CircularProgressIndicator(),
                                                            StreamBuilder(
                                                              stream: Stream.periodic(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          25),
                                                                  (i) => i),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (!snapshot
                                                                    .hasData)
                                                                  return const Text(
                                                                      '');
                                                                double elapsed =
                                                                    double.parse(snapshot
                                                                            .data
                                                                            .toString()) *
                                                                        0.05;
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: (elapsed >
                                                                          8.00)
                                                                      ? const Text(
                                                                          'ไม่พบข้อมูล',
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              fontFamily: Font_.Fonts_T
                                                                              //fontSize: 10.0
                                                                              ),
                                                                        )
                                                                      : Text(
                                                                          'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                          // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                          style: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
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
                                                        controller:
                                                            _scrollController2,
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
                                                            color: tappedIndex_ ==
                                                                    index
                                                                        .toString()
                                                                ? tappedIndex_Color
                                                                    .tappedIndex_Colors
                                                                : AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                            child: Container(
                                                              // color: tappedIndex_ ==
                                                              //         index.toString()
                                                              //     ? tappedIndex_Color
                                                              //         .tappedIndex_Colors
                                                              //         .withOpacity(0.5)
                                                              //     : null,
                                                              child: Column(
                                                                children: [
                                                                  ListTile(
                                                                      onTap:
                                                                          () async {
                                                                        // generateRandomString();
                                                                        // setState(() {
                                                                        //   red_Trans_select(
                                                                        //       index);
                                                                        //   red_Invoice(
                                                                        //       index);
                                                                        // });
                                                                        // Future.delayed(
                                                                        //     const Duration(
                                                                        //         milliseconds:
                                                                        //             300),
                                                                        //     () async {
                                                                        //   checkshowDialog(
                                                                        //     index,
                                                                        //   );
                                                                        // });
                                                                      },
                                                                      title:
                                                                          Container(
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          // color: Colors.green[100]!
                                                                          //     .withOpacity(0.5),
                                                                          border:
                                                                              Border(
                                                                            bottom:
                                                                                BorderSide(
                                                                              color: Colors.black12,
                                                                              width: 1,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: AutoSizeText(
                                                                                minFontSize: 10,
                                                                                maxFontSize: 25,
                                                                                maxLines: 1,
                                                                                '${teNantModels[index].custno}',
                                                                                textAlign: TextAlign.start,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Tooltip(
                                                                                richMessage: TextSpan(
                                                                                  text: '${teNantModels[index].cname}',
                                                                                  style: const TextStyle(
                                                                                    color: HomeScreen_Color.Colors_Text1_,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                    //fontSize: 10.0
                                                                                  ),
                                                                                ),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                  color: Colors.grey[200],
                                                                                ),
                                                                                child: AutoSizeText(
                                                                                  minFontSize: 10,
                                                                                  maxFontSize: 25,
                                                                                  maxLines: 1,
                                                                                  '${teNantModels[index].cname}',
                                                                                  textAlign: TextAlign.start,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Tooltip(
                                                                                richMessage: TextSpan(
                                                                                  text: '${teNantModels[index].sname}',
                                                                                  style: const TextStyle(
                                                                                    color: HomeScreen_Color.Colors_Text1_,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                    //fontSize: 10.0
                                                                                  ),
                                                                                ),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                  color: Colors.grey[200],
                                                                                ),
                                                                                child: AutoSizeText(
                                                                                  minFontSize: 10,
                                                                                  maxFontSize: 25,
                                                                                  maxLines: 1,
                                                                                  '${teNantModels[index].sname}',
                                                                                  textAlign: TextAlign.start,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(2.0),
                                                                                  child: (regisModels.where((model) => model.rser == '$ser_ren' && model.custno == '${teNantModels[index].custno}').map((model) => model.username).join(', ').toString() != '')
                                                                                      ? Container(
                                                                                          height: 40,
                                                                                          child: TextFormField(
                                                                                            readOnly: true,
                                                                                            style: TextStyle(fontFamily: Font_.Fonts_T, fontSize: 12),
                                                                                            textAlign: TextAlign.start,
                                                                                            // controller:
                                                                                            //     Add_Number_area_,
                                                                                            validator: (value) {
                                                                                              if (value == null || value.isEmpty) {
                                                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                                              }
                                                                                              // if (int.parse(value.toString()) < 13) {
                                                                                              //   return '< 13';
                                                                                              // }
                                                                                              return null;
                                                                                            },
                                                                                            initialValue: regisModels.where((model) => model.rser == '$ser_ren' && model.custno == '${teNantModels[index].custno}').map((model) => model.username).join(', ').toString(),
                                                                                            cursorColor: Colors.green,
                                                                                            decoration: InputDecoration(
                                                                                                fillColor: Colors.grey[300]!.withOpacity(0.4),
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
                                                                                                // labelText:
                                                                                                //     'เลขเรื่มต้น 1-xxx',
                                                                                                labelStyle: const TextStyle(
                                                                                                  fontSize: 12,
                                                                                                  color: Colors.black54,
                                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                                )),
                                                                                          ),
                                                                                        )
                                                                                      : Container(
                                                                                          height: 40,
                                                                                          child: TextFormField(
                                                                                            style: TextStyle(fontFamily: Font_.Fonts_T, fontSize: 12),
                                                                                            textAlign: TextAlign.start,
                                                                                            // controller:
                                                                                            //     Add_Number_area_,
                                                                                            validator: (value) {
                                                                                              if (value == null || value.isEmpty) {
                                                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                                              }
                                                                                              // if (int.parse(value.toString()) < 13) {
                                                                                              //   return '< 13';
                                                                                              // }
                                                                                              return null;
                                                                                            },
                                                                                            // initialValue: teNantModels[index].user_name,
                                                                                            onFieldSubmitted: (value) async {
                                                                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                              String? ren = preferences.getString('renTalSer');
                                                                                              String? renTalname_s = preferences.getString('renTalName');

                                                                                              var Cust_n = '${teNantModels[index].custno}';
                                                                                              var Cid = '';
                                                                                              var User_U = '$value';
                                                                                              var Pass_U = '';
                                                                                              var Accesstoken = '';
                                                                                              var Idtoken = '';
                                                                                              var Userid = '';
                                                                                              var Displayname = '';
                                                                                              var C_name = '${teNantModels[index].cname}';
                                                                                              var Type = '${teNantModels[index].stype}';

                                                                                              String url = '${MyConstant().domain}/UpC_custno_cid_Informa.php?isAdd=true&ren=$ren&Pn=$renTalname_s&cust_no=$Cust_n&Cid=$Cid&user_U=$User_U&pass_U=$Pass_U&Accesstoken=$Accesstoken&Idtoken=$Idtoken&Userid=$Userid&Displayname=$Displayname&c_name=$C_name';

                                                                                              try {
                                                                                                var response = await http.get(Uri.parse(url));

                                                                                                var result = json.decode(response.body);
                                                                                                print('result');
                                                                                                print(result);
                                                                                                print(result);
                                                                                                if (result.toString() == 'true' && regisModels.where((model) => model.rser == '$ser_ren' && model.custno == '${teNantModels[index].custno}').map((model) => model.username.toString()).first.toString() != '$value') {
                                                                                                  Insert_log.Insert_logs('บัญชี', 'บัญชี>>บัญชีผู้เช่า>>User>>$value(${teNantModels[index].custno})');

                                                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('แก้ไขข้อมูลเสร็จสิ้น !!', style: TextStyle(color: Colors.black, fontFamily: Font_.Fonts_T))));
                                                                                                } else {
                                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                                    const SnackBar(content: Text('เกิดข้อผิดพลาด', style: TextStyle(color: Colors.red, fontFamily: Font_.Fonts_T))),
                                                                                                  );
                                                                                                }
                                                                                              } catch (e) {
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  const SnackBar(content: Text('เกิดข้อผิดพลาด', style: TextStyle(color: Colors.red, fontFamily: Font_.Fonts_T))),
                                                                                                );
                                                                                              }
                                                                                              setState(() {
                                                                                                checkPreferance();
                                                                                                read_GC_rental();

                                                                                                read_GC_tenant();
                                                                                                read_GC_Regis();
                                                                                              });
                                                                                            },

                                                                                            // maxLength: 4,
                                                                                            cursorColor: Colors.green,
                                                                                            decoration: InputDecoration(
                                                                                                hintStyle: TextStyle(
                                                                                                  fontSize: 10.5,
                                                                                                  fontFamily: Font_.Fonts_T,
                                                                                                ),
                                                                                                labelText: 'กำหนด Username',
                                                                                                hintText: 'ใส่ได้เฉพาะ A-Z a-z 0-9 _ @ .',
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
                                                                                                // labelText:
                                                                                                //     'เลขเรื่มต้น 1-xxx',
                                                                                                labelStyle: TextStyle(
                                                                                                  fontSize: 11,
                                                                                                  color: Colors.red[700],
                                                                                                  fontFamily: Font_.Fonts_T,
                                                                                                )),
                                                                                            inputFormatters: <TextInputFormatter>[
                                                                                              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9_.@]')),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(2.0),
                                                                                  child: (regisModels.where((model) => model.rser == '$ser_ren' && model.custno == '${teNantModels[index].custno}').map((model) => model.username).join(', ').toString() == '')
                                                                                      ? Text('')
                                                                                      : Container(
                                                                                          height: 40,
                                                                                          child: TextFormField(
                                                                                            style: TextStyle(fontFamily: Font_.Fonts_T, fontSize: 12),
                                                                                            textAlign: TextAlign.start,
                                                                                            // controller:
                                                                                            //     Add_Number_area_,
                                                                                            validator: (value) {
                                                                                              if (value == null || value.isEmpty) {
                                                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                                              }
                                                                                              // if (int.parse(value.toString()) < 13) {
                                                                                              //   return '< 13';
                                                                                              // }
                                                                                              return null;
                                                                                            },

                                                                                            initialValue: (regisModels.where((model) => model.rser == '$ser_ren' && model.custno == '${teNantModels[index].custno}').map((model) => model.passwd).join(', ').toString() != '') ? 'XXXXXX' : '',
                                                                                            onFieldSubmitted: (value) async {
                                                                                              String password = md5.convert(utf8.encode(value)).toString();

                                                                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                              String? ren = preferences.getString('renTalSer');
                                                                                              String? renTalname_s = preferences.getString('renTalName');

                                                                                              var Cust_n = '${teNantModels[index].custno}';
                                                                                              var Cid = '';
                                                                                              var User_U = '${regisModels.where((model) => model.rser == '$ser_ren' && model.custno == '${teNantModels[index].custno}').map((model) => model.username.toString()).first}';

                                                                                              var Pass_U = '$password';
                                                                                              var Accesstoken = '';
                                                                                              var Idtoken = '';
                                                                                              var Userid = '';
                                                                                              var Displayname = '';
                                                                                              var C_name = '${teNantModels[index].cname}';

                                                                                              String url = '${MyConstant().domain}/UpC_custno_cid_Informa.php?isAdd=true&ren=$ren&Pn=$renTalname_s&cust_no=$Cust_n&Cid=$Cid&user_U=$User_U&pass_U=$Pass_U&Accesstoken=$Accesstoken&Idtoken=$Idtoken&Userid=$Userid&Displayname=$Displayname&c_name=$C_name';

                                                                                              try {
                                                                                                var response = await http.get(Uri.parse(url));

                                                                                                var result = json.decode(response.body);
                                                                                                print(result);
                                                                                                print(result);
                                                                                                if (result.toString() == 'true') {
                                                                                                  Insert_log.Insert_logs('บัญชี', 'บัญชี>>บัญชีผู้เช่า>>Passwd>>$value(${teNantModels[index].custno})');

                                                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('แก้ไขข้อมูลเสร็จสิ้น !!', style: TextStyle(color: Colors.black, fontFamily: Font_.Fonts_T))));
                                                                                                } else {
                                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                                    const SnackBar(content: Text('เกิดข้อผิดพลาด', style: TextStyle(color: Colors.red, fontFamily: Font_.Fonts_T))),
                                                                                                  );
                                                                                                }
                                                                                              } catch (e) {
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  const SnackBar(content: Text('เกิดข้อผิดพลาด', style: TextStyle(color: Colors.red, fontFamily: Font_.Fonts_T))),
                                                                                                );
                                                                                              }
                                                                                              setState(() {
                                                                                                checkPreferance();
                                                                                                read_GC_rental();

                                                                                                read_GC_tenant();
                                                                                                read_GC_Regis();
                                                                                              });
                                                                                            },
                                                                                            // maxLength: 4,
                                                                                            cursorColor: Colors.green,
                                                                                            decoration: InputDecoration(
                                                                                                labelText: 'ใส่ได้เฉพาะ A-Z a-z 0-9 _ @ .',
                                                                                                // hintText: 'ใส่ได้เฉพาะ A-Z a-z 0-9 _ @ .',
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
                                                                                                // labelText:
                                                                                                //     'เลขเรื่มต้น 1-xxx',
                                                                                                labelStyle: TextStyle(
                                                                                                  fontSize: 11,
                                                                                                  color: Colors.red[700],
                                                                                                  fontFamily: Font_.Fonts_T,
                                                                                                )),
                                                                                            inputFormatters: <TextInputFormatter>[
                                                                                              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9_.@]')),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              ),
                                                                              //     AutoSizeText(
                                                                              //   minFontSize:
                                                                              //       10,
                                                                              //   maxFontSize:
                                                                              //       25,
                                                                              //   maxLines:
                                                                              //       1,
                                                                              //   (teNantModels[index].passw == null)
                                                                              //       ? ''
                                                                              //       : '******',
                                                                              //   textAlign:
                                                                              //       TextAlign.start,
                                                                              //   style: const TextStyle(
                                                                              //       color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              //       fontFamily: Font_.Fonts_T),
                                                                              // ),
                                                                            ),
                                                                            Expanded(
                                                                                flex: 1,
                                                                                child: StreamBuilder(
                                                                                    stream: Stream<void>.periodic(const Duration(seconds: 1), (i) => i).take(1),
                                                                                    // stream: Stream<void>.periodic(const Duration(seconds: 0)).take(1),
                                                                                    builder: (context, snapshot) {
                                                                                      return FutureBuilder<int>(
                                                                                        future: read_GC_tenant_where(index),
                                                                                        initialData: 0, // Set an initial value
                                                                                        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                            return Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                SizedBox(height: 50, child: CircularProgressIndicator()),
                                                                                              ],
                                                                                            );
                                                                                          } else if (snapshot.hasError) {
                                                                                            return Text('Error: ${snapshot.error}');
                                                                                          } else {
                                                                                            return Text(
                                                                                              snapshot.data.toString(),
                                                                                              maxLines: 1,
                                                                                              textAlign: TextAlign.end,
                                                                                              style: const TextStyle(
                                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                fontFamily: Font_.Fonts_T,
                                                                                              ),
                                                                                            );
                                                                                          }
                                                                                        },
                                                                                      );
                                                                                    })),
                                                                            Expanded(
                                                                                flex: 1,
                                                                                child: StreamBuilder(
                                                                                    stream: Stream<void>.periodic(const Duration(seconds: 1), (i) => i).take(1),
                                                                                    builder: (context, snapshot) {
                                                                                      return FutureBuilder<String>(
                                                                                        future: read_GC_tenant_wherecids(index),
                                                                                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                            return Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                SizedBox(height: 50, child: CircularProgressIndicator()),
                                                                                              ],
                                                                                            );
                                                                                          } else if (snapshot.hasError) {
                                                                                            return Text('Error: ${snapshot.error}');
                                                                                          } else {
                                                                                            return Text(
                                                                                              snapshot.data.toString(),
                                                                                              maxLines: 1,
                                                                                              textAlign: TextAlign.end,
                                                                                              style: const TextStyle(
                                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                fontFamily: Font_.Fonts_T,
                                                                                              ),
                                                                                            );
                                                                                          }
                                                                                        },
                                                                                      );
                                                                                    })),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(0.0),
                                                                                    child: InkWell(
                                                                                      onTap: () {
                                                                                        print(teNantModels[index].custno);
                                                                                        setState(() {
                                                                                          // widget.updateMessage('0');
                                                                                          Status_cuspang = 1;

                                                                                          cust_no = teNantModels[index].custno!;
                                                                                        });
                                                                                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                                                                        //   return Details_Rental_customer(
                                                                                        //     name_custno: cust_no,
                                                                                        //   );
                                                                                        // }));
                                                                                      },
                                                                                      child: Container(
                                                                                        width: 130,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.deepPurple.shade100,
                                                                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          border: Border.all(color: Colors.white, width: 1),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                        child: const AutoSizeText(
                                                                                          minFontSize: 10,
                                                                                          maxFontSize: 25,
                                                                                          maxLines: 1,
                                                                                          'เรียกดู',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  // if (index +
                                                                  //         1 ==
                                                                  //     teNantModels
                                                                  //         .length)
                                                                  //   ListTile(
                                                                  //       title: Row(
                                                                  //           mainAxisAlignment:
                                                                  //               MainAxisAlignment.center,
                                                                  //           children: [
                                                                  //         Padding(
                                                                  //           padding:
                                                                  //               const EdgeInsets.all(4.0),
                                                                  //           child:
                                                                  //               Container(
                                                                  //             width: 100,
                                                                  //             decoration: BoxDecoration(
                                                                  //               color: Colors.red[100]!.withOpacity(0.5),
                                                                  //               borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                  //             ),
                                                                  //             padding: const EdgeInsets.all(2.0),
                                                                  //             child: AutoSizeText(
                                                                  //               minFontSize: 10,
                                                                  //               maxFontSize: 25,
                                                                  //               maxLines: 1,
                                                                  //               'สิ้นสุด',
                                                                  //               textAlign: TextAlign.center,
                                                                  //               overflow: TextOverflow.ellipsis,
                                                                  //               style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                  //             ),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ])),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        })),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width * 0.85
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  _scrollController2.animateTo(
                                                    0,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    curve: Curves.easeOut,
                                                  );
                                                },
                                                child: Container(
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
                                                                          8)),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: const Text(
                                                      'Top',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (_scrollController2
                                                    .hasClients) {
                                                  final position =
                                                      _scrollController2
                                                          .position
                                                          .maxScrollExtent;
                                                  _scrollController2.animateTo(
                                                    position,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    curve: Curves.easeOut,
                                                  );
                                                }
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    // color: AppbackgroundColor
                                                    //     .TiTile_Colors,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    6),
                                                            topRight:
                                                                Radius.circular(
                                                                    6),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    6),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    6)),
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: const Text(
                                                    'Down',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    alignment:
                                                        Alignment.centerLeft,
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
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  6),
                                                          topRight:
                                                              Radius.circular(
                                                                  6),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  6),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  6)),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: const Text(
                                                  'Scroll',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            InkWell(
                                              onTap: _moveDown2,
                                              child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
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

  Future<void> updated_Customer(scname, stype, typeser, type, cname, attn,
      addr_1, tel, tax, email, indexToEdit) async {}
}
