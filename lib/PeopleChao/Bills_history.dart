// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Man_PDF/Man_BillingNoteInvlice_PDF.dart';
import '../Model/GetInvoice_Model.dart';
import '../Model/GetInvoice_history_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetTrans_Model.dart';
import '../PDF/PDF_Billing/pdf_BillingNote_IV.dart';
import '../PDF_TP2/PDF_Billing_TP2/pdf_BillingNote_IV_TP2.dart';
import '../PDF_TP3/PDF_Billing_TP3/pdf_BillingNote_IV_TP3.dart';
import '../PDF_TP4/PDF_Billing_TP4/pdf_BillingNote_IV_TP4.dart';
import '../PDF_TP5/PDF_Billing_TP5/pdf_BillingNote_IV_TP5.dart';

import '../Style/colors.dart';

class BillsHistory extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  final namenew;

  const BillsHistory({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
    this.namenew,
  });

  @override
  State<BillsHistory> createState() => _BillsHistoryState();
}

class _BillsHistoryState extends State<BillsHistory> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  @override
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  List<InvoiceModel> _InvoiceModels = [];
  List<InvoiceHistoryModel> _InvoiceHistoryModels = [];
  List<TeNantModel> teNantModels = [];
  List<RenTalModel> renTalModels = [];
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;

  String? numinvoice;
  String? Form_nameshop;
  String? Form_typeshop;
  String? Form_bussshop;
  String? Form_bussscontact;
  String? Form_address;
  String? Form_tel;
  String? Form_email;
  String? Form_tax;
  String? rental_count_text;
  String? Form_area;
  String? Form_ln;
  String? Form_sdate;
  String? Form_ldate;
  String? Form_period;
  String? Form_rtname;
  String? Form_docno;
  String? Form_zn;
  String? Form_aser;
  String? Form_qty;
  String? ADDR;
  String? base64_Imgmap, foder, tem_page_ser;
  String? Datex_invoice;
  String? payment_Ptser1, payment_Ptname1, payment_Bno1;
  String? payment_Ptser2, payment_Ptname2, payment_Bno2;
  int TitleType_Default_Receipt = 0;
  List TitleType_Default_Receipt_ = [
    'ไม่ระบุ',
    'ต้นฉบับ',
    'สำเนา',
  ];
  @override
  void initState() {
    super.initState();
    red_Invoice();
    read_data();
    read_GC_rental();
  }

  Future<Null> read_GC_rental() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // var seruser = preferences.getString('ser');
    // var utype = preferences.getString('utype');
    // String url =
    //     '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('read_GC_rental///// $result');
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
          tem_page_ser = renTalModel.tem_page!.trim();
          renTalModels.add(renTalModel);
        });
      }
    } catch (e) {}
  }

  ///------------------------------------------------------>
  Future<Null> read_data() async {
    if (teNantModels.length != 0) {
      setState(() {
        teNantModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_tenantlookAS.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            teNantModels.add(teNantModel);

            Form_nameshop = teNantModel.sname.toString();
            Form_typeshop = teNantModel.stype.toString();
            Form_bussshop = teNantModel.cname.toString();
            Form_bussscontact = teNantModel.attn.toString();
            Form_address = teNantModel.addr.toString();
            Form_tel = teNantModel.tel.toString();
            Form_email = teNantModel.email.toString();
            Form_tax =
                teNantModel.tax == null ? "-" : teNantModel.tax.toString();
            Form_area = teNantModel.area.toString();
            Form_ln = teNantModel.area_c.toString();

            Form_sdate = DateFormat('dd-MM-yyyy')
                .format(DateTime.parse('${teNantModel.sdate} 00:00:00'))
                .toString();
            Form_ldate = DateFormat('dd-MM-yyyy')
                .format(DateTime.parse('${teNantModel.ldate} 00:00:00'))
                .toString();
            Form_period = teNantModel.period.toString();
            Form_rtname = teNantModel.rtname.toString();
            Form_docno = teNantModel.docno.toString();
            Form_zn = teNantModel.zn.toString();
            Form_aser = teNantModel.aser.toString();
            Form_qty = teNantModel.qty.toString();
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_select(index) async {
    if (_InvoiceHistoryModels.length != 0) {
      setState(() {
        _InvoiceHistoryModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        sum_disamt = 0;
        sum_disp = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var docnoin = _InvoiceModels[index].docno;

    String url =
        '${MyConstant().domain}/GC_bill_invoice_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          InvoiceHistoryModel _InvoiceHistoryModel =
              InvoiceHistoryModel.fromJson(map);

          var sum_pvatx = double.parse(_InvoiceHistoryModel.pvat_t!);
          var sum_vatx = double.parse(_InvoiceHistoryModel.vat_t!);
          var sum_whtx = double.parse(_InvoiceHistoryModel.wht!);
          var sum_amtx = double.parse(_InvoiceHistoryModel.total_t!);
          var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
          var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_disamt = sum_disamtx;
            sum_disp = sum_dispx;
            numinvoice = _InvoiceHistoryModel.docno;
            _InvoiceHistoryModels.add(_InvoiceHistoryModel);
          });
        }
      }
    } catch (e) {}
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
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_bill_invoice.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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

  // Future<Null> red_Trans_bill_meter() async {
  //   if (_TransBillModels.length != 0) {
  //     setState(() {
  //       _TransBillModels.clear();
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;

  //   String url =
  //       '${MyConstant().domain}/GC_tran_bill_miter.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result.toString() != 'null') {
  //       for (var map in result) {
  //         TransBillModel _TransBillModel = TransBillModel.fromJson(map);
  //         setState(() {
  //           _TransBillModels.add(_TransBillModel);
  //         });
  //       }
  //     }
  //   } catch (e) {}
  // }

  // Future<Null> in_Trans_select(index) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;

  //   var tser = _TransBillModels[index].ser;
  //   var tdocno = _TransBillModels[index].docno;

  //   print('object $tdocno');
  //   String url =
  //       '${MyConstant().domain}/In_tran_select.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result.toString() == 'true') {
  //       setState(() {
  //         red_Trans_select();
  //       });
  //       print('rrrrrrrrrrrrrr');
  //     }
  //   } catch (e) {}
  // }

  // Future<Null> de_Trans_select(index) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;

  //   var tser = _TransModels[index].ser;
  //   var tdocno = _TransModels[index].docno;

  //   print('tser >>.> $tser');

  //   String url =
  //       '${MyConstant().domain}/De_tran_select.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result.toString() == 'true') {
  //       setState(() {
  //         red_Trans_select();
  //       });
  //       print('rrrrrrrrrrrrrr');
  //     }
  //   } catch (e) {}
  // }

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  final Set<int> _pressedIndices = Set();

  ///----------------->
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                red_Invoice();
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.yellow[200],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                                // border: Border.all(
                                //     color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: const Center(
                                child: Text(
                                  'รายการวางบิล',
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
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                'ประเภท',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                'วันที่วางบิล',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                'เลขที่ใบเสร็จ',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 450,
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        // border: Border.all(
                        //     color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        controller: _scrollController1,
                        // itemExtent: 50,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _InvoiceModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            color: (numinvoice.toString() ==
                                    _InvoiceModels[index].docno.toString())
                                ? tappedIndex_Color.tappedIndex_Colors
                                : AppbackgroundColor.Sub_Abg_Colors,
                            child: ListTile(
                              onTap: () {
                                print(
                                    '${_InvoiceModels[index].ser} ${_InvoiceModels[index].docno}');

                                setState(() {
                                  payment_Ptser1 = _InvoiceModels[index].ptser;
                                  payment_Ptname1 =
                                      _InvoiceModels[index].ptname;
                                  payment_Bno1 = _InvoiceModels[index].bno;

                                  Datex_invoice = _InvoiceModels[index].daterec;
                                });

                                red_Trans_select(index);
                              },
                              title: Container(
                                // color: (numinvoice.toString() ==
                                //         _InvoiceModels[index]
                                //             .docno
                                //             .toString())
                                //     ? tappedIndex_Color.tappedIndex_Colors
                                //     : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Tooltip(
                                        richMessage: TextSpan(
                                          text:
                                              '${_InvoiceModels[index].descr}',
                                          style: const TextStyle(
                                            color: PeopleChaoScreen_Color
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
                                          '${_InvoiceModels[index].descr}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
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
                                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_InvoiceModels[index].daterec} 00:00:00'))}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Tooltip(
                                        richMessage: TextSpan(
                                          text:
                                              '${_InvoiceModels[index].docno}',
                                          style: const TextStyle(
                                            color: PeopleChaoScreen_Color
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
                                          '${_InvoiceModels[index].docno}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.52,
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            // padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'รายละเอียดบิล',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        numinvoice == null
                            ? SizedBox()
                            : Expanded(
                                flex: 2,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.orange[100],

                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      // border: Border.all(
                                      //     color: Colors.grey, width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$numinvoice',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            // padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'ลำดับ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'กำหนดชำระ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'รายการ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'จำนวน',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'หน่วย',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'Vat',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'ราคารวม',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'ราคารวม Vat',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 290,
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.Sub_Abg_Colors,
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
                        controller: _scrollController2,
                        // itemExtent: 50,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _InvoiceHistoryModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            child: ListTile(
                              onTap: () {},
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      maxLines: 1,
                                      '${index + 1}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          //fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      maxLines: 1,
                                      '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_InvoiceHistoryModels[index].date} 00:00:00'))}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          //fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      maxLines: 1,
                                      '${_InvoiceHistoryModels[index].descr}',
                                      textAlign: TextAlign.center,
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
                                      maxFontSize: 15,
                                      maxLines: 1,
                                      '${_InvoiceHistoryModels[index].qty}',
                                      textAlign: TextAlign.end,
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
                                      maxFontSize: 15,
                                      maxLines: 1,
                                      _InvoiceHistoryModels[index].nvalue != '0'
                                          ? '${nFormat.format(double.parse(_InvoiceHistoryModels[index].pri!))}'
                                          : '${_InvoiceHistoryModels[index].nvat}',
                                      textAlign: TextAlign.end,
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
                                      maxFontSize: 15,
                                      maxLines: 1,
                                      '${_InvoiceHistoryModels[index].vat}',
                                      textAlign: TextAlign.end,
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
                                      maxFontSize: 15,
                                      maxLines: 1,
                                      '${_InvoiceHistoryModels[index].pvat}',
                                      textAlign: TextAlign.end,
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
                                      maxFontSize: 15,
                                      maxLines: 1,
                                      '${_InvoiceHistoryModels[index].amt}',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          //fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                  ),
                                ],
                              ),
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
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                color: Colors.grey.shade300,
                                // height: 100,
                                width: 300,
                                padding: EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'รวม(บาท)',
                                          style: TextStyle(
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
                                          maxFontSize: 15,
                                          textAlign: TextAlign.end,
                                          '${nFormat.format(sum_pvat)}',
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'ภาษีมูลค่าเพิ่ม(vat)',
                                          style: TextStyle(
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
                                          maxFontSize: 15,
                                          textAlign: TextAlign.end,
                                          '${nFormat.format(sum_vat)}',
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'หัก ณ ที่จ่าย',
                                          style: TextStyle(
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
                                          maxFontSize: 15,
                                          textAlign: TextAlign.end,
                                          '${nFormat.format(sum_wht)}',
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'ยอดรวม',
                                          style: TextStyle(
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
                                          maxFontSize: 15,
                                          textAlign: TextAlign.end,
                                          '${nFormat.format(sum_amt)}',
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              'ส่วนลด',
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 60,
                                              height: 20,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                '$sum_disp  %',
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          '${nFormat.format(sum_disamt)}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                        // AutoSizeText(
                                        //   minFontSize: 10,
                                        //   maxFontSize: 15,
                                        //   textAlign: TextAlign.end,
                                        //   '${nFormat.format(0.00)}',
                                        //   style: TextStyle(
                                        //       color: PeopleChaoScreen_Color
                                        //           .Colors_Text2_,
                                        //       //fontWeight: FontWeight.bold,
                                        //       fontFamily: Font_.Fonts_T),
                                        // ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'ยอดชำระ',
                                          style: TextStyle(
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
                                          maxFontSize: 15,
                                          textAlign: TextAlign.end,
                                          '${nFormat.format(sum_amt - sum_disamt)}',
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ))
                  ])),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        // border: Border.all(
                        //     color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                        child: Text(
                          'ยอดชำระทั้งหมด',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T
                              //fontSize: 10.0
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
                    flex: 6,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 15,
                            textAlign: TextAlign.start,
                            'ยอดชำระรวม : ',
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red[50]!.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              width: 120,
                              child: Center(
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.end,
                                  '${nFormat.format(sum_amt - sum_disamt)}',
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 15,
                            textAlign: TextAlign.start,
                            'หัวบิล : ',
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              width: 120,
                              child: DropdownButtonFormField2(
                                alignment: Alignment.center,
                                focusColor: Colors.white,
                                autofocus: false,
                                decoration: InputDecoration(
                                  enabled: true,
                                  hoverColor: Colors.brown,
                                  prefixIconColor: Colors.blue,
                                  fillColor: Colors.white.withOpacity(0.05),
                                  filled: false,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 231, 227, 227),
                                    ),
                                  ),
                                ),
                                hint: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    '${TitleType_Default_Receipt_[TitleType_Default_Receipt]}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),

                                isExpanded: false,
                                // value: Default_Receipt_type == 0 ?''
                                // :'',
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                                iconSize: 25,
                                buttonHeight: 42,
                                buttonPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  // color: Colors
                                  //     .amber,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                items: TitleType_Default_Receipt_.map(
                                    (item) => DropdownMenuItem<String>(
                                          value: '${item}',
                                          child: Text(
                                            '${item}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        )).toList(),

                                onChanged: (value) async {
                                  int selectedIndex =
                                      TitleType_Default_Receipt_.indexWhere(
                                          (item) => item == value);

                                  setState(() {
                                    TitleType_Default_Receipt = selectedIndex;
                                  });

                                  print(
                                      '${selectedIndex}////$value  ////----> $TitleType_Default_Receipt');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 15,
                            textAlign: TextAlign.start,
                            'รูปแบบชำระ : ',
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              width: 120,
                              child: Center(
                                child: AutoSizeText(
                                  minFontSize: 8,
                                  maxFontSize: 12,
                                  textAlign: TextAlign.end,
                                  (payment_Ptname1 == null)
                                      ? 'รูปแบบ'
                                      : (payment_Bno1 == null)
                                          ? '${payment_Ptname1}  '
                                          : '${payment_Ptname1} : ${payment_Bno1}',
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 6,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          List newValuePDFimg = [];
                          for (int index = 0; index < 1; index++) {
                            if (renTalModels[0].imglogo!.trim() == '') {
                              // newValuePDFimg.add(
                              //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                            } else {
                              newValuePDFimg.add(
                                  '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                            }
                          }
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          var renTal_name = preferences.getString('renTalName');

                          final tableData003 = [
                            for (int index = 0;
                                index < _InvoiceHistoryModels.length;
                                index++)
                              [
                                '${index + 1}',
                                '${_InvoiceHistoryModels[index].date}',
                                '${_InvoiceHistoryModels[index].descr}',
                                // '${nFormat.format(double.parse(_InvoiceHistoryModels[index].qty!))}',
                                '${nFormat.format(double.parse(_InvoiceHistoryModels[index].nvat!))}',
                                '${nFormat.format(double.parse(_InvoiceHistoryModels[index].vat!))}',
                                '${nFormat.format(double.parse(_InvoiceHistoryModels[index].pvat!))}',
                                '${nFormat.format(double.parse(_InvoiceHistoryModels[index].amt!))}',
                              ],
                          ];
                          BillingNoteInvlice_History_Tempage(
                              tableData003, newValuePDFimg, renTal_name);
                          // BillingNoteInvlice_History_Tempage(
                          //     tableData003, newValuePDFimg, renTal_name);
                          //       Pdfgen_BillingNoteInvlice
                          //           .exportPDF_BillingNoteInvlice(
                          //               '2',
                          //               tableData003,
                          //               context,
                          //               _InvoiceHistoryModels,
                          //               '${widget.Get_Value_cid}',
                          //               '${widget.namenew}',
                          //               '${sum_pvat}',
                          //               '${sum_vat}',
                          //               '${sum_wht}',
                          //               '${sum_amt}',
                          //               ' $sum_dis',
                          //  '${sum_amt - sum_disamt}',
                          //               '$renTal_name',
                          //               '${Form_bussshop}',
                          //               '${Form_address}',
                          //               '${Form_tel}',
                          //               '${Form_email}',
                          //               '${Form_tax}',
                          //               ' ${Form_nameshop}',
                          //               ' ${renTalModels[0].bill_addr}',
                          //               ' ${renTalModels[0].bill_email}',
                          //               ' ${renTalModels[0].bill_tel}',
                          //               ' ${renTalModels[0].bill_tax}',
                          //               ' ${renTalModels[0].bill_name}',
                          //               newValuePDFimg,
                          //               numinvoice,
                          //               '${_InvoiceHistoryModels[0].daterec}');
                        },
                        child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              // border: Border.all(color: Colors.white, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                                child: Text(
                              'พิมพ์',
                              style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text3_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                            ))),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (numinvoice != null) {
                            showDialog<String>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                title: const Center(
                                    child: Text(
                                  'ยืนยันการยกเลิกวางบิล',
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                content: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'เลขที่ใบเสร็จ',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '$numinvoice',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (numinvoice != null) {
                                                      Insert_log.Insert_logs(
                                                          'ผู้เช่า',
                                                          'วางบิล>>ประวัติวางบิล>>ยกเลิกการวางบิล(${numinvoice.toString()})');
                                                      print(numinvoice);
                                                      de_invoice();
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .green.shade500,
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(6),
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
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Center(
                                                        child: const Text(
                                                          'ตกลง',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              // fontSize: 10.0,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(6),
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
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Center(
                                                        child: const Text(
                                                          'ยกเลิก',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              // fontSize: 10.0,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              // border: Border.all(color: Colors.white, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                                child: Text(
                              'ยกเลิกการวางบิล',
                              style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text3_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                            ))),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }

  Future<Null> de_invoice() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    print('numinvoice 1 $numinvoice');
    String url =
        '${MyConstant().domain}/UPC_Invoice_history.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&numinvoice=$numinvoice';
    try {
      print('numinvoice 2 $numinvoice');
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('result>>>>>>> $result');
      print('numinvoice 3 $numinvoice');

      if (result.toString() == 'true') {
        setState(() async {
          print('numinvoice 4 $numinvoice');
          red_Invoice();
          _InvoiceHistoryModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          sum_disamt = 0;
          sum_disp = 0;
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }
  //////////////////////////------------------------------>
  Future<Null> BillingNoteInvlice_History_Tempage(
      tableData003, newValuePDFimg, renTal_name) async {
    String? TitleType_Default_Receipt_Name;
    if (TitleType_Default_Receipt == 0) {
    } else {
      setState(() {
        TitleType_Default_Receipt_Name =
            '${TitleType_Default_Receipt_[TitleType_Default_Receipt]}';
      });
    }
    Man_BillingNoteInvlice_PDF.ManBillingNoteInvlice_PDF(
      TitleType_Default_Receipt_Name,
      foder,
      '${widget.Get_Value_NameShop_index}',
      tem_page_ser,
      context,
      '${widget.Get_Value_cid}',
      '${widget.namenew}',
      '${renTalModels[0].bill_addr}',
      '${renTalModels[0].bill_email}',
      '${renTalModels[0].bill_tel}',
      '${renTalModels[0].bill_tax}',
      '${renTalModels[0].bill_name}',
      newValuePDFimg,
      numinvoice,'0'
    );
  }
}
