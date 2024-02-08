import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Man_PDF/Man_Reduce_debt.dart';
import '../Model/GetInvoice_Model.dart';
import '../Model/GetInvoice_dis_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/GetTrans_hisdisinv_Model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class DiscountBill extends StatefulWidget {
  final Get_Value_cid;
  const DiscountBill({
    super.key,
    this.Get_Value_cid,
  });

  @override
  State<DiscountBill> createState() => _DiscountBillState();
}

class _DiscountBillState extends State<DiscountBill> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  List<InvoiceModel> _InvoiceModels = [];
  List<TransModel> _TransModels = [];
  List<TransHisDisInvModel> _TransHisDisInvModels = [];

  List<RenTalModel> renTalModels = [];
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0,
      sum_Pakan = 0,
      sum_Pakan_KF = 0,
      dis_Pakan = 0,
      dis_matjum = 0,
      dis_sum_Pakan = 0.00,
      dis_sum_Matjum = 0.00,
      sum_Matjum_KF = 0,
      sum_tran_dis = 0,
      sum_matjum = 0.00,
      sum_tran_fine = 0,
      fine_total = 0,
      fine_total2 = 0;
  String? docno_inv,
      ser_inv,
      amt_inv,
      vat_inv,
      nvat_inv,
      pvat_inv,
      wht_inv,
      nwht_inv,
      vat_ser,
      inv_num;

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
      renTal_name;

////////------------------------------------>
  int Default_Receipt_type = 0;
  int TitleType_Default_Receipt = 0;
  List Default_Receipt_ = [
    'ออกใบเสร็จ',
    'ไม่ออกใบเสร็จ',
  ];

  List TitleType_Default_Receipt_ = [
    'ไม่ระบุ',
    'ต้นฉบับ',
    'สำเนา',
  ];
  ////////------------------------------------>
  int padeindex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    red_Invoice();
    read_GC_rental();
  }

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

            Default_Receipt_type =
                (renTalModel.printbill_default.toString() == 'N') ? 1 : 0;
            TitleType_Default_Receipt = int.parse(renTalModel.receipt_title!);
            renTalModels.add(renTalModel);
            // if (bill_defaultx == 'P') {
            //   bills_name_ = 'บิลธรรมดา';
            // } else {
            //   bills_name_ = 'ใบกำกับภาษี';
            // }
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  Future<Null> red_Invoice() async {
    if (_InvoiceModels.length != 0) {
      setState(() {
        _InvoiceModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_bill_invoice.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          InvoiceModel _InvoiceModel = InvoiceModel.fromJson(map);
          setState(() {
            _InvoiceModels.add(_InvoiceModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Invoice_dis() async {
    if (_InvoiceModels.length != 0) {
      setState(() {
        _InvoiceModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_bill_invoice_hisdis.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          InvoiceModel _InvoiceModel = InvoiceModel.fromJson(map);
          setState(() {
            _InvoiceModels.add(_InvoiceModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Invoice_HisDis(int index) async {
    if (_TransHisDisInvModels.length != 0) {
      setState(() {
        _TransHisDisInvModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        sum_tran_dis = 0;
        sum_matjum = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = _InvoiceModels[index].docno;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_bill_invoice_hislist.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        setState(() {
          _TransHisDisInvModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          sum_tran_dis = 0;
        });
        for (var map in result) {
          TransHisDisInvModel _TransHisDisInvModel =
              TransHisDisInvModel.fromJson(map);

          var sum_pvatx = double.parse(_TransHisDisInvModel.pvat!);
          var sum_vatx = double.parse(_TransHisDisInvModel.vat!);
          var sum_whtx = double.parse(_TransHisDisInvModel.wht!);
          var sum_amtx = double.parse(_TransHisDisInvModel.total!);
          var sum_disx = double.parse(_TransHisDisInvModel.dis!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_tran_dis = sum_tran_dis + sum_disx;
            _TransHisDisInvModels.add(_TransHisDisInvModel);
          });
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          dragStartBehavior: DragStartBehavior.start,
          child: Row(
            children: [
              Container(
                  width: (!Responsive.isDesktop(context))
                      ? 800
                      : MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.82,
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    // border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.deepOrange[200],
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    red_Invoice();
                                                    padeindex = 0;
                                                    docno_inv = null;
                                                    amt_inv = null;
                                                    ser_inv = null;
                                                    vat_inv = null;
                                                    nvat_inv = null;
                                                    pvat_inv = null;
                                                    wht_inv = null;
                                                    nwht_inv = null;
                                                    inv_num = null;
                                                  });
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: (padeindex != 1)
                                                          ? Colors.white
                                                              .withOpacity(0.4)
                                                          : null,
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      10)),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1)),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Center(
                                                    child: Text(
                                                      'ใบวางบิล',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple[200],
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(0)),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    red_Invoice_dis();
                                                    padeindex = 1;
                                                    docno_inv = null;
                                                    amt_inv = null;
                                                    ser_inv = null;
                                                    vat_inv = null;
                                                    nvat_inv = null;
                                                    pvat_inv = null;
                                                    wht_inv = null;
                                                    nwht_inv = null;
                                                    inv_num = null;
                                                  });
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: (padeindex != 1)
                                                          ? null
                                                          : Colors.white
                                                              .withOpacity(0.4),
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      10)),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1)),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Center(
                                                    child: Text(
                                                      'ใบลดหนี้',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.grey[200],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: padeindex == 1 ? 2 : 1,
                                          child: Text(
                                            padeindex == 1
                                                ? 'วันที่ทำรายการ'
                                                : 'กำหนดชำระ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        padeindex == 1
                                            ? Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'เลขที่ใบวางบิล',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : SizedBox(),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            padeindex == 1
                                                ? 'เลขที่ใบลดหนี้'
                                                : 'เลขที่ใบวางบิล',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            padeindex == 1
                                                ? 'ยอดรวม'
                                                : 'ยอดชำระ',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        for (int index = 0;
                                            index < _InvoiceModels.length;
                                            index++)
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    ser_inv =
                                                        _InvoiceModels[index]
                                                            .ser;
                                                    docno_inv =
                                                        _InvoiceModels[index]
                                                            .docno;

                                                    amt_inv = (double.parse(
                                                                _InvoiceModels[
                                                                        index]
                                                                    .amtall!) +
                                                            double.parse(
                                                                _InvoiceModels[
                                                                        index]
                                                                    .vatall!) -
                                                            double.parse(
                                                                _InvoiceModels[
                                                                        index]
                                                                    .whtall!))
                                                        .toString();
                                                    vat_inv =
                                                        _InvoiceModels[index]
                                                            .vatall;
                                                    vat_ser =
                                                        _InvoiceModels[index]
                                                            .vser;
                                                    nvat_inv =
                                                        _InvoiceModels[index]
                                                            .nvat;
                                                    pvat_inv =
                                                        _InvoiceModels[index]
                                                            .pvat;
                                                    wht_inv =
                                                        _InvoiceModels[index]
                                                            .whtall;
                                                    nwht_inv =
                                                        _InvoiceModels[index]
                                                            .nwht;
                                                    inv_num =
                                                        _InvoiceModels[index]
                                                            .inv;
                                                    red_Trans_select2();
                                                    if (padeindex == 1) {
                                                      red_Invoice_HisDis(index);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.lightGreen,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      10)),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1)),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: padeindex == 1
                                                            ? 2
                                                            : 1,
                                                        child: Text(
                                                          '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_InvoiceModels[index].date} 00:00:00'))}',
                                                          style: TextStyle(
                                                              color: ser_inv ==
                                                                      _InvoiceModels[
                                                                              index]
                                                                          .ser
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      padeindex == 1
                                                          ? Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                '${_InvoiceModels[index].inv}',
                                                                style: TextStyle(
                                                                    color: ser_inv ==
                                                                            _InvoiceModels[index]
                                                                                .ser
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '${_InvoiceModels[index].docno}',
                                                          style: TextStyle(
                                                              color: ser_inv ==
                                                                      _InvoiceModels[
                                                                              index]
                                                                          .ser
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${nFormat.format(double.parse(_InvoiceModels[index].amtall!))} ',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              color: ser_inv ==
                                                                      _InvoiceModels[
                                                                              index]
                                                                          .ser
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff3f3ee),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // color: Colors.brown[100],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  child: Column(
                                    children: [
                                      padeindex == 1 && inv_num != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'เลขที่ใบวางบิล : $inv_num',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        padeindex == 1
                                                            ? 'เลขที่ใบลดหนี้'
                                                            : 'เลขที่ใบวางบิล',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        amt_inv == null
                                                            ? ''
                                                            : ' : $docno_inv',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 2,
                                            //   child: Text(
                                            //     amt_inv == null
                                            //         ? ''
                                            //         : '$docno_inv',
                                            //     textAlign: TextAlign.center,
                                            //     style: const TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 20,
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                amt_inv == null
                                                    ? ''
                                                    : '${nFormat.format(double.parse(amt_inv!))}',
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ser_inv == null
                                          ? const SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 6,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              padeindex == 1
                                                                  ? 'ยอดรวม'
                                                                  : 'ยอดชำระ',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'vat %',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'หัก ณ ที่จ่าย %',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'ยอดสุทธิ',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              '${nFormat.format(double.parse(amt_inv!) - double.parse(vat_inv!) - double.parse(wht_inv!))}',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              '$nvat_inv % (${nFormat.format(double.parse(vat_inv!))})',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              '$nwht_inv % (${nFormat.format(double.parse(wht_inv!))})',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              '${nFormat.format(double.parse(amt_inv!))}',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                // const Divider(),
                                Container(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  // color: Colors.grey.shade300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          child: Text(
                                            'ลับดับ',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 3,
                                          child: Text(
                                            'รายการ',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Text(
                                            'ยอด',
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Vat',
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Wht',
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Text(
                                            'ยอดรวม',
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        padeindex == 1
                                            ? SizedBox()
                                            : Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      if (ser_inv != null) {
                                                        in_Trans_add();
                                                      }
                                                    },
                                                    child: Container(
                                                      // width: MediaQuery.of(context)
                                                      //     .size
                                                      //     .width,
                                                      // height: 50,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      10)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1)),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Text(
                                                        'Add +',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ), //_InvoiceHisDisModels
                                padeindex == 1 && inv_num != null
                                    ? Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: Column(
                                            children: [
                                              for (int index = 0;
                                                  index <
                                                      _TransHisDisInvModels
                                                          .length;
                                                  index++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
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
                                                        Container(
                                                          width: 40,
                                                          child: Text(
                                                            '${index + 1}',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            '${_TransHisDisInvModels[index].name}',
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${_TransHisDisInvModels[index].amt}',
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${_TransHisDisInvModels[index].vat}',
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${_TransHisDisInvModels[index].wht}',
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${_TransHisDisInvModels[index].total}',
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: Column(
                                            children: [
                                              for (int index = 0;
                                                  index < _TransModels.length;
                                                  index++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
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
                                                        Container(
                                                          width: 40,
                                                          child: Text(
                                                            '${index + 1}',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                // keyboardType: TextInputType.number,
                                                                initialValue:
                                                                    _TransModels[
                                                                            index]
                                                                        .name,
                                                                onFieldSubmitted:
                                                                    (value) async {
                                                                  SharedPreferences
                                                                      preferences =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  var ren = preferences
                                                                      .getString(
                                                                          'renTalSer');
                                                                  var user = preferences
                                                                      .getString(
                                                                          'ser');

                                                                  var ser_tran =
                                                                      _TransModels[
                                                                              index]
                                                                          .ser;
                                                                  var c_value =
                                                                      'name';
                                                                  var valuex =
                                                                      value;

                                                                  String url =
                                                                      '${MyConstant().domain}/U_tran_select_ser_dis.php?isAdd=true&ren=$ren&ser_tran=$ser_tran&c_value=$c_value&valuex=$valuex&user=$user&vat_ser=$vat_ser&nwht_inv=$nwht_inv';
                                                                  try {
                                                                    var response =
                                                                        await http
                                                                            .get(Uri.parse(url));

                                                                    var result =
                                                                        json.decode(
                                                                            response.body);
                                                                    // print(result);
                                                                    if (result
                                                                            .toString() ==
                                                                        'true') {
                                                                      setState(
                                                                          () {
                                                                        red_Trans_select2();
                                                                      });
                                                                      print(
                                                                          'rrrrrrrrrrrrrr');
                                                                    }
                                                                  } catch (e) {
                                                                    print(
                                                                        'rrrrrrrrrrrrrr $e');
                                                                  }
                                                                },
                                                                // maxLength: 13,
                                                                cursorColor:
                                                                    Colors
                                                                        .green,
                                                                decoration: InputDecoration(
                                                                    fillColor: Colors.white.withOpacity(0.5),
                                                                    filled: true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder: const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder: const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    labelStyle: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                                // inputFormatters: <TextInputFormatter>[
                                                                //   // for below version 2 use this
                                                                //   FilteringTextInputFormatter
                                                                //       .allow(RegExp(r'[0-9]')),
                                                                //   // for version 2 and greater youcan also use this
                                                                //   // FilteringTextInputFormatter.digitsOnly
                                                                // ],
                                                              ),
                                                            ),
                                                          ),
                                                          // Text(
                                                          //   '${_TransModels[index].name}',
                                                          //   textAlign: TextAlign.start,
                                                          // ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,

                                                                // keyboardType: TextInputType.number,
                                                                initialValue:
                                                                    _TransModels[
                                                                            index]
                                                                        .amt,
                                                                onFieldSubmitted:
                                                                    (value) async {
                                                                  SharedPreferences
                                                                      preferences =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  var ren = preferences
                                                                      .getString(
                                                                          'renTalSer');
                                                                  var user = preferences
                                                                      .getString(
                                                                          'ser');

                                                                  var ser_tran =
                                                                      _TransModels[
                                                                              index]
                                                                          .ser;
                                                                  var c_value =
                                                                      'amt';
                                                                  var valuex =
                                                                      value;

                                                                  String url =
                                                                      '${MyConstant().domain}/U_tran_select_ser_dis.php?isAdd=true&ren=$ren&ser_tran=$ser_tran&c_value=$c_value&valuex=$valuex&user=$user&vat_ser=$vat_ser&nwht_inv=$nwht_inv';
                                                                  try {
                                                                    var response =
                                                                        await http
                                                                            .get(Uri.parse(url));

                                                                    var result =
                                                                        json.decode(
                                                                            response.body);
                                                                    // print(result);
                                                                    if (result
                                                                            .toString() ==
                                                                        'true') {
                                                                      setState(
                                                                          () {
                                                                        red_Trans_select2();
                                                                      });
                                                                      print(
                                                                          'rrrrrrrrrrrrrr');
                                                                    }
                                                                  } catch (e) {
                                                                    print(
                                                                        'rrrrrrrrrrrrrr $e');
                                                                  }
                                                                },
                                                                // maxLength: 13,
                                                                cursorColor:
                                                                    Colors
                                                                        .green,
                                                                decoration: InputDecoration(
                                                                    fillColor: Colors.white.withOpacity(0.5),
                                                                    filled: true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder: const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder: const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    labelStyle: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                                inputFormatters: <TextInputFormatter>[
                                                                  // for below version 2 use this
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          r'[0-9]')),
                                                                  // for version 2 and greater youcan also use this
                                                                  // FilteringTextInputFormatter.digitsOnly
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${_TransModels[index].vat}',
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${_TransModels[index].wht}',
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${_TransModels[index].total}',
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              deall_Trans_select(
                                                                  index);
                                                            },
                                                            icon: const Icon(
                                                                Icons
                                                                    .delete_outlined,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  // height: 40,
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          'ยอดรวม : ',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.red[600],
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            '$sum_pvat',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            '$sum_vat',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            '$sum_wht',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            '$sum_amt',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                      padeindex == 1
                                          ? SizedBox()
                                          : Expanded(
                                              flex: 1,
                                              child: Container(
                                                color: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  '',
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
                                            )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green[200],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      child: Row(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child:
                                                              const AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            textAlign:
                                                                TextAlign.start,
                                                            'ใบเสร็จ :',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            // height: 50,

                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                              borderRadius:
                                                                  const BorderRadius
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
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              // border: Border.all(
                                                              //     color: Colors.grey, width: 1),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.5),
                                                            child:
                                                                DropdownButtonFormField2(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              focusColor:
                                                                  Colors.white,
                                                              autofocus: false,
                                                              decoration:
                                                                  InputDecoration(
                                                                enabled: true,
                                                                hoverColor:
                                                                    Colors
                                                                        .brown,
                                                                prefixIconColor:
                                                                    Colors.blue,
                                                                fillColor: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.05),
                                                                filled: false,
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.red),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                focusedBorder:
                                                                    const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            231,
                                                                            227,
                                                                            227),
                                                                  ),
                                                                ),
                                                              ),
                                                              hint: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                child: Text(
                                                                  '${Default_Receipt_[Default_Receipt_type]}',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),

                                                              isExpanded: false,
                                                              // value: Default_Receipt_type == 0 ?''
                                                              // :'',
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              iconSize: 25,
                                                              buttonHeight: 42,
                                                              buttonPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              dropdownDecoration:
                                                                  BoxDecoration(
                                                                // color: Colors
                                                                //     .amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 1),
                                                              ),
                                                              items: Default_Receipt_
                                                                  .map((item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            '${item}',
                                                                        child:
                                                                            Text(
                                                                          '${item}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      )).toList(),

                                                              onChanged:
                                                                  (value) async {
                                                                int selectedIndex =
                                                                    Default_Receipt_.indexWhere(
                                                                        (item) =>
                                                                            item ==
                                                                            value);

                                                                setState(() {
                                                                  Default_Receipt_type =
                                                                      selectedIndex;
                                                                  TitleType_Default_Receipt =
                                                                      0;
                                                                });

                                                                print(
                                                                    '${selectedIndex}////$value  ////----> $Default_Receipt_type');
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      child: Row(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child:
                                                              const AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            textAlign:
                                                                TextAlign.start,
                                                            'หัวบิล :',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            // height: 50,

                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                              borderRadius:
                                                                  const BorderRadius
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
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              // border: Border.all(
                                                              //     color: Colors.grey, width: 1),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.5),
                                                            child:
                                                                DropdownButtonFormField2(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              focusColor:
                                                                  Colors.white,
                                                              autofocus: false,
                                                              decoration:
                                                                  InputDecoration(
                                                                enabled: true,
                                                                hoverColor:
                                                                    Colors
                                                                        .brown,
                                                                prefixIconColor:
                                                                    Colors.blue,
                                                                fillColor: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.05),
                                                                filled: false,
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.red),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                focusedBorder:
                                                                    const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            231,
                                                                            227,
                                                                            227),
                                                                  ),
                                                                ),
                                                              ),
                                                              hint: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                child: Text(
                                                                  '${TitleType_Default_Receipt_[TitleType_Default_Receipt]}',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),

                                                              isExpanded: false,
                                                              // value: Default_Receipt_type == 0 ?''
                                                              // :'',
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              iconSize: 25,
                                                              buttonHeight: 42,
                                                              buttonPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              dropdownDecoration:
                                                                  BoxDecoration(
                                                                // color: Colors
                                                                //     .amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 1),
                                                              ),
                                                              items: TitleType_Default_Receipt_
                                                                  .map((item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            '${item}',
                                                                        child:
                                                                            Text(
                                                                          '${item}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      )).toList(),

                                                              onChanged:
                                                                  (value) async {
                                                                int selectedIndex =
                                                                    TitleType_Default_Receipt_.indexWhere(
                                                                        (item) =>
                                                                            item ==
                                                                            value);

                                                                setState(() {
                                                                  TitleType_Default_Receipt =
                                                                      selectedIndex;
                                                                });

                                                                print(
                                                                    '${selectedIndex}////$value  ////----> $TitleType_Default_Receipt');
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: const BorderRadius
                                                    .only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(0),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  // inv_num         amt_inv == null
                                                  //         ? ''
                                                  //         : ' : $docno_inv',
                                                  List newValuePDFimg = [];
                                                  String?
                                                      TitleType_Default_Receipt_Name;
                                                  /////////-------------->
                                                  if (TitleType_Default_Receipt ==
                                                      0) {
                                                  } else {
                                                    setState(() {
                                                      TitleType_Default_Receipt_Name =
                                                          '${TitleType_Default_Receipt_[TitleType_Default_Receipt]}';
                                                    });
                                                  }
                                                  /////////------------------------------------>
                                                  for (int index = 0;
                                                      index < 1;
                                                      index++) {
                                                    if (renTalModels[0]
                                                            .imglogo!
                                                            .trim() ==
                                                        '') {
                                                      // newValuePDFimg.add(
                                                      //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                                    } else {
                                                      newValuePDFimg.add(
                                                          '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                                    }
                                                  }

                                                  if (padeindex == 0) {
                                                    if (ser_inv != null) {
                                                      in_Trans_invoice(
                                                          newValuePDFimg,
                                                          TitleType_Default_Receipt_Name);
                                                    }
                                                  } else {
                                                    if (Default_Receipt_type !=
                                                        1) {
                                                      Man_Reducedebt_PDF
                                                          .man_Reducedebt_PDF(
                                                              TitleType_Default_Receipt_Name,
                                                              foder,
                                                              '1',
                                                              tem_page_ser,
                                                              context,
                                                              '${widget.Get_Value_cid}',
                                                              '1',
                                                              bill_addr,
                                                              bill_email,
                                                              bill_tel,
                                                              bill_tax,
                                                              bill_name,
                                                              newValuePDFimg,
                                                              inv_num,
                                                              docno_inv);
                                                    }
                                                  }
                                                  print(padeindex);
                                                  print(docno_inv);
                                                  // if (padeindex != 1) {
                                                  //   if (ser_inv != null) {
                                                  //     in_Trans_invoice();
                                                  //   }
                                                  // }
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: (padeindex == 0)
                                                          ? Colors.orange
                                                          : Colors.green,
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      10)),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1)),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          (padeindex == 0)
                                                              ? 'บันทึกใบลดหนี้'
                                                              : 'พิมพ์ซ้ำใบลดหนี้',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> in_Trans_add() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = '1';

    var textadd = 'ลดหนี้';
    var priceadd = '0';
    var dtypeadd = '';

    String url =
        '${MyConstant().domain}/In_tran_select_dis.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&textadd=$textadd&priceadd=$priceadd&user=$user&dtypeadd=$dtypeadd&docno_inv=$docno_inv';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2();
        });
      }
    } catch (e) {
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> red_Trans_select2() async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        sum_tran_dis = 0;
        sum_matjum = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_tran_select_dis.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docno_inv=$docno_inv';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        setState(() {
          _TransModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          sum_tran_dis = 0;
        });
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);

          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          var sum_disx = double.parse(_TransModel.dis!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_tran_dis = sum_tran_dis + sum_disx;
            _TransModels.add(_TransModel);
          });
        }
      } else {
        setState(() {
          dis_matjum = 0;
          dis_sum_Matjum = 0.00;
        });
      }
    } catch (e) {}

    setState(() {});
  }

  Future<Null> deall_Trans_select(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = '1';
    var ser_tran = _TransModels[index].ser;

    String url =
        '${MyConstant().domain}/D_tran_select_ser.php?isAdd=true&ren=$ren&ser_tren=$ser_tran&qutser=$qutser&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {
      print('rrrrrrrrrrrrrr $e');
    }
  }
/////////------------------------>

/////////------------------------>
  Future<Null> in_Trans_invoice(
      newValuePDFimg, TitleType_Default_Receipt_Name) async {
    /////////------------------------------------>
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var ren = preferences.getString('renTalSer');
    // var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;
    // var sumdis = sum_disamt.text;
    // var sumdisp = sum_disp.text;
    // String? cFinn;
    // String url =
    //     '${MyConstant().domain}/In_tran_invoice.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp';
    /////////------------------------------------>
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var renTal_name = preferences.getString('renTalName');
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = '1';
    var sumdis = '0';
    var sumdisp = '0';
    var c_payment_Ser = '0';
    String? inv_num_, docno_inv_;
    String url =
        '${MyConstant().domain}/In_tran_invoice_dis.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&pay_Ser1=$c_payment_Ser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('result>In_tran_invoice_dis>>> $result');
      if (result.toString() != 'No') {
        for (var map in result) {
          InvoiceModel InvoiceModels = InvoiceModel.fromJson(map);
          setState(() {
            inv_num_ = InvoiceModels.inv;
            docno_inv_ = InvoiceModels.docno;
          });
          print('zzzzasaaa123454>>>>  $inv_num_ ');
          print('docnodocnodocnodocnodocno123456>>>>  ${docno_inv_}');
        }
        /////////------------------------------------>
        Insert_log.Insert_logs(
            'ผู้เช่า', 'ใบลดหนี้>>บันทึก(${docno_inv_.toString()})');
        /////////------------------------------------>
        if (Default_Receipt_type != 1) {
          Man_Reducedebt_PDF.man_Reducedebt_PDF(
              TitleType_Default_Receipt_Name,
              foder,
              qutser,
              tem_page_ser,
              context,
              '${widget.Get_Value_cid}',
              '1',
              bill_addr,
              bill_email,
              bill_tel,
              bill_tax,
              bill_name,
              newValuePDFimg,
              inv_num_,
              docno_inv_);
        }

        /////////------------------------------------>
        setState(() {
          red_Trans_select2();
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;
          sum_Pakan = 0;
          sum_Pakan_KF = 0;
          dis_Pakan = 0;
          dis_matjum = 0;
          dis_sum_Pakan = 0.00;
          dis_sum_Matjum = 0.00;
          sum_Matjum_KF = 0;
          sum_tran_dis = 0;
          sum_matjum = 0.00;
          sum_tran_fine = 0;
          fine_total = 0;
          fine_total2 = 0;
          docno_inv = null;
          ser_inv = null;
          amt_inv = null;
          vat_inv = null;
          nvat_inv = null;
          pvat_inv = null;
          wht_inv = null;
          nwht_inv = null;
          vat_ser = null;
          inv_num = null;
        });
        /////////------------------------------------>
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('บันทึกรายการใบลดหนี้สำเร็จ',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
        // print('rrrrrrrrrrrrrr');
        /////////------------------------------------>
      }
    } catch (e) {}
    /////////------------------------------------>
    Future.delayed(const Duration(milliseconds: 200), () async {
      setState(() {
        red_Trans_select2();
        sum_pvat = 0.00;
        sum_vat = 0.00;
        sum_wht = 0.00;
        sum_amt = 0.00;
        sum_dis = 0.00;
        sum_disamt = 0.00;
        sum_disp = 0;
        sum_Pakan = 0;
        sum_Pakan_KF = 0;
        dis_Pakan = 0;
        dis_matjum = 0;
        dis_sum_Pakan = 0.00;
        dis_sum_Matjum = 0.00;
        sum_Matjum_KF = 0;
        sum_tran_dis = 0;
        sum_matjum = 0.00;
        sum_tran_fine = 0;
        fine_total = 0;
        fine_total2 = 0;
        docno_inv = null;
        ser_inv = null;
        amt_inv = null;
        vat_inv = null;
        nvat_inv = null;
        pvat_inv = null;
        wht_inv = null;
        nwht_inv = null;
        vat_ser = null;
        inv_num = null;
      });
    });
    /////////------------------------------------>
  }
}
