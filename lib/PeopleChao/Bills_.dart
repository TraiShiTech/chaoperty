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
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Man_PDF/Man_BillingNoteInvlice_PDF.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetTrans_Model.dart';
import '../PDF/PDF_Billing/pdf_BillingNote_IV.dart';
import '../PDF_TP2/PDF_Billing_TP2/pdf_BillingNote_IV_TP2.dart';
import '../PDF_TP3/PDF_Billing_TP3/pdf_BillingNote_IV_TP3.dart';
import '../PDF_TP4/PDF_Billing_TP4/pdf_BillingNote_IV_TP4.dart';
import '../PDF_TP5/PDF_Billing_TP5/pdf_BillingNote_IV_TP5.dart';

import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Bills_history.dart';
import 'package:pdf/widgets.dart' as pw;

class Bills extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  final namenew;
  final sname_;
  final addr_;
  final tel_;
  final email_;
  final tax_;
  final cname_;
  const Bills({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
    this.namenew,
    this.sname_,
    this.addr_,
    this.tel_,
    this.email_,
    this.tax_,
    this.cname_,
  });

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  var nFormat = NumberFormat("#,##0.00", "en_US");

  @override
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  List<TransBillModel> _TransBillModels = [];
  List<TransModel> _TransModels = [];
  List<TeNantModel> teNantModels = [];
  List<RenTalModel> renTalModels = [];
  List<PayMentModel> _PayMentModels = [];
  List<ExpModel> expModels = [];
  final sum_disamt = TextEditingController();
  final sum_disp = TextEditingController();
  final text_add = TextEditingController();
  final price_add = TextEditingController();
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00;
  int indexbill = 0;
  String? numinvoice;
  String? Form_nameshop,
      Form_typeshop,
      Form_bussshop,
      Form_bussscontact,
      Form_address,
      Form_tel,
      Form_email,
      Form_tax,
      rental_count_text,
      Form_area,
      Form_ln,
      Form_sdate,
      Form_ldate,
      Form_period,
      Form_rtname,
      Form_docno,
      Form_zn,
      Form_aser,
      Form_qty;
  String? rtname, type, typex, renname, pkname, ser_Zonex;
  int? pkqty, pkuser, countarae;
  String? base64_Imgmap, foder;
  String? tel_user, img_, img_logo, tem_page_ser;
  String? selectedValue;
  String? paymentSer1, paymentName1, paymentSer2, paymentName2;
  int TitleType_Default_Receipt = 0;
  List TitleType_Default_Receipt_ = [
    'ไม่ระบุ',
    'ต้นฉบับ',
    'สำเนา',
  ];
  @override
  void initState() {
    super.initState();
    red_Trans_bill();
    red_Trans_select();
    sum_disamt.text = '0.00';
    read_data();
    read_GC_rental();
    red_payMent();
    read_GC_Exp();
  }

  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      setState(() {
        expModels.clear();
      });
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

  Future<Null> red_payMent() async {
    if (_PayMentModels.length != 0) {
      setState(() {
        _PayMentModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren}';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        Map<String, dynamic> map = Map();
        map['ser'] = '0';
        map['datex'] = '';
        map['timex'] = '';
        map['ptser'] = '';
        map['ptname'] = 'เลือก';
        map['bser'] = '';
        map['bank'] = '';
        map['bno'] = '';
        map['bname'] = '';
        map['bsaka'] = '';
        map['btser'] = '';
        map['btype'] = '';
        map['st'] = '1';
        map['rser'] = '';
        map['accode'] = '';
        map['co'] = '';
        map['data_update'] = '';
        map['auto'] = '0';

        PayMentModel _PayMentModel = PayMentModel.fromJson(map);
        setState(() {
          _PayMentModels.add(_PayMentModel);
        });

        for (var map in result) {
          PayMentModel _PayMentModel = PayMentModel.fromJson(map);
          var autox = _PayMentModel.auto;
          var serx = _PayMentModel.ser;
          var ptnamex = _PayMentModel.ptname;
          setState(() {
            _PayMentModels.add(_PayMentModel);
            if (autox == '1') {
              paymentSer1 = serx.toString();
              paymentName1 = ptnamex.toString();
            }
          });
          if (_PayMentModel.btser.toString() == '1') {
          } else {}
        }

        if (paymentName1 == null) {
          paymentSer1 = 0.toString();
          paymentName1 = 'เลือก'.toString();
        }
      }
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
    // var seruser = preferences.getString('ser');
    // var utype = preferences.getString('utype');
    // String url =
    //     '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

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
            tem_page_ser = renTalModel.tem_page!.trim();
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
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

  Future<Null> red_Trans_select() async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_tran_select.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        setState(() {
          _TransModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
        });
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);

          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            _TransModels.add(_TransModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_bill() async {
    if (_TransBillModels.length != 0) {
      setState(() {
        _TransBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_tran_bill.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransBillModel _TransBillModel = TransBillModel.fromJson(map);
          setState(() {
            _TransBillModels.add(_TransBillModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_billAll() async {
    if (_TransBillModels.length != 0) {
      setState(() {
        _TransBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_tran_bill_All.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransBillModel _TransBillModel = TransBillModel.fromJson(map);
          setState(() {
            _TransBillModels.add(_TransBillModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_bill_meter() async {
    if (_TransBillModels.length != 0) {
      setState(() {
        _TransBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_tran_bill_miter.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransBillModel _TransBillModel = TransBillModel.fromJson(map);
          setState(() {
            _TransBillModels.add(_TransBillModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> in_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    var tser = _TransBillModels[index].ser;
    var tdocno = _TransBillModels[index].docno;

    print('object $tdocno');
    String url =
        '${MyConstant().domain}/In_tran_select.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select();
        });
        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        setState(() {
          red_Trans_select();
        });
        print('rrrrrrrrrrrrrr');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('ผู้ใช้อื่นกำลังเลือกทำรายการอยู่....',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                style:
                    TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      );
    }
  }

  Future<Null> de_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    var tser = _TransModels[index].ser;
    var tdocno = _TransModels[index].docno;

    print('tser >>.> $tser');

    String url =
        '${MyConstant().domain}/De_tran_select.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select();
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

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
  @override
  Widget build(BuildContext context) {
    return indexbill == 1
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      // color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            // color: Colors.grey,
                            // height: 80,
                            // width: 300,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              indexbill = 0;
                                              red_Trans_bill();
                                              red_Trans_select();
                                              sum_disamt.text = '0.00';
                                              sum_disp.clear();
                                            });
                                          },
                                          child: Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.yellow.shade700,
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
                                              // border: Border.all(color: Colors.white, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                      Icons.chevron_left),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    'วางบิล',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ],
                    )),
              ),
              BillsHistory(
                Get_Value_cid: widget.Get_Value_cid,
                Get_Value_NameShop_index: widget.Get_Value_NameShop_index,
                namenew: widget.namenew,
              ),
            ],
          )
        : Column(
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
                                      red_Trans_bill();
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
                                        'ค่าบริการ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Container(
                              //     height: 50,
                              //     decoration: BoxDecoration(
                              //       color: Colors.brown[200],
                              //       borderRadius: const BorderRadius.only(
                              //         topLeft: Radius.circular(0),
                              //         topRight: Radius.circular(0),
                              //         bottomLeft: Radius.circular(0),
                              //         bottomRight: Radius.circular(0),
                              //       ),
                              //       // border: Border.all(
                              //       //     color: Colors.grey, width: 1),
                              //     ),
                              //     padding: const EdgeInsets.all(8.0),
                              //   ),
                              // ),
                              Expanded(
                                flex: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      red_Trans_bill_meter();
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(0),
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
                                        'ค่าน้ำ - ค่าไฟ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
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
                                  child: const Center(
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      'ประเภท',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
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
                                  child: const Center(
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      'กำหนดชำระ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.086,
                                      color: Colors.brown[200],
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Center(
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          'เลขตั้งหนี้',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        for (var i = 0;
                                            i < _TransBillModels.length;
                                            i++) {
                                          in_Trans_select(i);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.027,
                                        color: Colors.brown[200],
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                            child: Icon(Icons.chevron_right)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 360,
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
                              // controller: _scrollController1,
                              // itemExtent: 50,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _TransBillModels.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Material(
                                  color: (_TransModels.any((A) =>
                                              A.docno ==
                                              _TransBillModels[index].docno) &&
                                          _TransModels.any((A) =>
                                              A.date ==
                                              _TransBillModels[index].date))
                                      ? tappedIndex_Color.tappedIndex_Colors
                                      : AppbackgroundColor.Sub_Abg_Colors,
                                  child: ListTile(
                                    onTap: () {
                                      print(
                                          '${_TransBillModels[index].ser} ${_TransBillModels[index].docno}');

                                      in_Trans_select(index);
                                    },
                                    title: Container(
                                      // color: (_TransModels.any((A) =>
                                      //             A.docno ==
                                      //             _TransBillModels[index]
                                      //                 .docno) &&
                                      //         _TransModels.any((A) =>
                                      //             A.date ==
                                      //             _TransBillModels[index].date))
                                      //     ? tappedIndex_Color.tappedIndex_Colors
                                      //     : null,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text:
                                                    '${_TransBillModels[index].expname} ${_TransBillModels[index].meter}',
                                                style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                _TransBillModels[index].dtype ==
                                                        'KU'
                                                    ? '${_TransBillModels[index].expname} ${DateFormat.MMM('th_TH').format((DateTime.parse('${_TransBillModels[index].date} 00:00:00')))}(${_TransBillModels[index].meter})'
                                                    : '${_TransBillModels[index].expname}',
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                              _TransBillModels[index].dtype ==
                                                      'KU'
                                                  ? '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index].duedate} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index].duedate} 00:00:00').year + 543}'
                                                  : '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index].date} 00:00:00').year + 543}',
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
                                            flex: 2,
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text:
                                                    '${_TransBillModels[index].docno}',
                                                style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                                                overflow: TextOverflow.ellipsis,
                                                '${_TransBillModels[index].docno}',
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      // color: Colors.grey,
                                      // height: 80,
                                      // width: 300,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      addPlaySelect();
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius.only(
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
                                                        // border: Border.all(color: Colors.white, width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: const Center(
                                                        child: AutoSizeText(
                                                          minFontSize: 8,
                                                          maxFontSize: 12,
                                                          '+ เพิ่มใหม่',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: Padding(
                                            //     padding:
                                            //         const EdgeInsets.all(8.0),
                                            //   ),
                                            // ),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        red_Trans_billAll();
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
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
                                                        // border: Border.all(color: Colors.white, width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: const Center(
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ค่าบริการทั้งหมด',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        indexbill = 1;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .yellow.shade700,
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
                                                        // border: Border.all(color: Colors.white, width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: const Center(
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ประวัติวางบิล',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                                      overflow: TextOverflow.ellipsis,
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
                                      overflow: TextOverflow.ellipsis,
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
                                      overflow: TextOverflow.ellipsis,
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
                                      overflow: TextOverflow.ellipsis,
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
                                      overflow: TextOverflow.ellipsis,
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
                                      overflow: TextOverflow.ellipsis,
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
                                      'ราคาต่อหน่วย',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
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
                                      overflow: TextOverflow.ellipsis,
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
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    deall_Trans_select();
                                  },
                                  child: Container(
                                    height: 50,
                                    color: Colors.brown[200],
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Center(
                                      child: AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 15,
                                        maxLines: 1,
                                        'X',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
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
                              // controller: _scrollController2,
                              // itemExtent: 50,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _TransModels.length,
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
                                            overflow: TextOverflow.ellipsis,
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
                                            _TransModels[index].dtype == 'KU'
                                                ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransModels[index].duedate} 00:00:00'))}'
                                                : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransModels[index].date} 00:00:00'))}',
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
                                          flex: 2,
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            '${_TransModels[index].name}',
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
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            '${nFormat.format(double.parse(_TransModels[index].tqty!))}',
                                            //'${_TransModels[index].tqty}',
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
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            '${_TransModels[index].unit_con}',
                                            overflow: TextOverflow.ellipsis,
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
                                            _TransModels[index].qty_con ==
                                                    '0.00'
                                                ? '${nFormat.format(double.parse(_TransModels[index].amt_con!))}'
                                                //'${_TransModels[index].amt_con}'
                                                : '${nFormat.format(double.parse(_TransModels[index].qty_con!))}',
                                            //'${_TransModels[index].qty_con}',
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
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
                                            // '${_TransModels[index].pvat}',
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
                                            child: Center(
                                              child: IconButton(
                                                  onPressed: () {
                                                    de_Trans_select(index);
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.red,
                                                  )),
                                            )),
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                'รวม(บาท)',
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                'ภาษีมูลค่าเพิ่ม(vat)',
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                'หัก ณ ที่จ่าย',
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                'ยอดรวม',
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  const AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    'ส่วนลด',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 60,
                                                    height: 20,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: sum_disp,
                                                      onFieldSubmitted:
                                                          (value) async {
                                                        var valuenum =
                                                            double.parse(value);
                                                        var sum = ((sum_amt *
                                                                valuenum) /
                                                            100);

                                                        setState(() {
                                                          sum_dis = sum;
                                                          sum_disamt.text =
                                                              sum.toString();
                                                        });

                                                        print(
                                                            'sum_dis $sum_dis');
                                                      },
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.3),
                                                              filled: true,
                                                              // prefixIcon:
                                                              //     const Icon(Icons.person, color: Colors.black),
                                                              // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              // labelText: 'ระบุชื่อร้านค้า',
                                                              labelStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          8,

                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T)),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9 .]')),
                                                        // FilteringTextInputFormatter.digitsOnly
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    '%',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  showCursor: true,
                                                  //add this line
                                                  readOnly: false,

                                                  // initialValue: sum_disamt.text,
                                                  textAlign: TextAlign.end,
                                                  controller: sum_disamt,
                                                  onFieldSubmitted:
                                                      (value) async {
                                                    var valuenum =
                                                        double.parse(value);

                                                    setState(() {
                                                      sum_dis = valuenum;
                                                      // sum_disamt.text =
                                                      //     nFormat.format(sum_disamt);
                                                      sum_disp.clear();
                                                    });

                                                    print('sum_dis $sum_dis');
                                                  },
                                                  cursorColor: Colors.black,
                                                  decoration: InputDecoration(
                                                      fillColor: Colors.white
                                                          .withOpacity(0.3),
                                                      filled: true,
                                                      // prefixIcon:
                                                      //     const Icon(Icons.person, color: Colors.black),
                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        borderSide: BorderSide(
                                                          // width: 1,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      // labelText: 'ระบุชื่อร้านค้า',
                                                      labelStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 8,

                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T)),
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9 .]')),
                                                    // FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                ),
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
                                            const Expanded(
                                              flex: 1,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                'ยอดชำระ',
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                                '${nFormat.format(sum_amt - double.parse(sum_disamt.text))}',
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
                        const Expanded(
                          flex: 6,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green[200],
                              borderRadius: const BorderRadius.only(
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
                        const Expanded(
                          flex: 6,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      textAlign: TextAlign.start,
                                      'ยอดชำระรวม : ',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          //fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.red[50]!.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        // width: 120,
                                        child: Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            textAlign: TextAlign.end,
                                            '${nFormat.format(sum_amt - double.parse(sum_disamt.text))}',
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  const AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    textAlign: TextAlign.start,
                                    'หัวบิล :',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButtonFormField2(
                                        alignment: Alignment.center,
                                        focusColor: Colors.white,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          enabled: true,
                                          hoverColor: Colors.brown,
                                          prefixIconColor: Colors.blue,
                                          fillColor:
                                              Colors.white.withOpacity(0.05),
                                          filled: false,
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 231, 227, 227),
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          // color: Colors
                                          //     .amber,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                        ),
                                        items: TitleType_Default_Receipt_.map(
                                            (item) => DropdownMenuItem<String>(
                                                  value: '${item}',
                                                  child: Text(
                                                    '${item}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                )).toList(),

                                        onChanged: (value) async {
                                          int selectedIndex =
                                              TitleType_Default_Receipt_
                                                  .indexWhere(
                                                      (item) => item == value);

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
                                Row(
                                  children: [
                                    AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      textAlign: TextAlign.start,
                                      'รูปแบบชำระ :',
                                      style: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          //fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        padding: const EdgeInsets.all(8.0),
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
                                            // border: Border.all(
                                            //     color: Colors.grey, width: 1),
                                          ),
                                          width: 120,
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                              //Add isDense true and zero Padding.
                                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              //Add more decoration as you want here
                                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                            ),
                                            isExpanded: true,
                                            // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                            hint: Row(
                                              children: [
                                                Text(
                                                  '$paymentName1',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ],
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black45,
                                            ),
                                            iconSize: 25,
                                            buttonHeight: 42,
                                            buttonPadding:
                                                const EdgeInsets.only(
                                                    left: 10, right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            items: _PayMentModels.map((item) =>
                                                DropdownMenuItem<String>(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedValue = item.bno!;
                                                    });
                                                    print(
                                                        '**/*/*   --- ${selectedValue}');
                                                  },
                                                  value:
                                                      '${item.ser}:${item.ptname}',
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${item.ptname!}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${item.bno!}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )).toList(),
                                            onChanged: (value) async {
                                              print(value);
                                              // Do something when changing the item if you want.

                                              var zones = value!.indexOf(':');
                                              var rtnameSer =
                                                  value.substring(0, zones);
                                              var rtnameName =
                                                  value.substring(zones + 1);
                                              // print(
                                              //     'mmmmm ${rtnameSer.toString()} $rtnameName');
                                              setState(() {
                                                paymentSer1 =
                                                    rtnameSer.toString();

                                                if (rtnameSer.toString() ==
                                                    '0') {
                                                  paymentName1 = null;
                                                } else {
                                                  paymentName1 =
                                                      rtnameName.toString();
                                                }
                                                paymentSer1 = rtnameSer;
                                              });
                                              print(
                                                  'mmmmm ${rtnameSer.toString()} $rtnameName');
                                              // print(
                                              //     'pppppp $paymentSer1 $paymentName1');
                                              // print('Form_payment1.text');
                                              // print(Form_payment1.text);
                                              // print(Form_payment2.text);
                                              // print('Form_payment1.text');
                                            },
                                            // onSaved: (value) {

                                            // },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                              onTap: (paymentName1 == null ||
                                      paymentName1.toString() == 'เลือก')
                                  ? null
                                  : () async {
                                      List newValuePDFimg = [];
                                      for (int index = 0; index < 1; index++) {
                                        if (renTalModels[0].imglogo!.trim() ==
                                            '') {
                                          // newValuePDFimg.add(
                                          //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                        } else {
                                          newValuePDFimg.add(
                                              '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                        }
                                      }

                                      final tableData003 = [
                                        for (int index = 0;
                                            index < _TransModels.length;
                                            index++)
                                          [
                                            '${index + 1}',
                                            '${_TransModels[index].date}',
                                            '${_TransModels[index].expname}',
                                            // '${nFormat.format(double.parse(_InvoiceHistoryModels[index].qty!))}',
                                            '${nFormat.format(double.parse(_TransModels[index].nvat!))}',
                                            '${nFormat.format(double.parse(_TransModels[index].vat!))}',
                                            '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
                                            '${nFormat.format(double.parse(_TransModels[index].amt!))}',
                                            // '${index + 1}',
                                            // '${_TransModels[index].name}',
                                            // '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransModels[index].date} 00:00:00'))}',
                                            // "${nFormat.format(double.parse('${_TransModels[index].tqty}'))}",

                                            // '${_TransModels[index].unit_con}',
                                            // "${nFormat.format(double.parse('${_TransModels[index].vat}'))}",
                                            // _TransModels[index].qty_con == '0.00'
                                            //     ? "${nFormat.format(double.parse('${_TransModels[index].amt_con}'))}"

                                            //     : "${nFormat.format(double.parse('${_TransModels[index].qty_con}'))}",

                                            // "${nFormat.format(double.parse('${_TransModels[index].pvat}'))}",
                                          ],
                                      ];

                                      if (paymentName1 == null ||
                                          paymentName1.toString() == 'เลือก') {
                                      } else {
                                        in_Trans_invoice2(
                                            tableData003, newValuePDFimg);
                                      }
                                    },
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: (paymentName1 == null ||
                                            paymentName1.toString() == 'เลือก')
                                        ? Colors.orange[300]
                                        : Colors.orange,
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
                                    'พิมพ์/บันทึก',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text3_,
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
                                in_Trans_invoice();
                              },
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade900,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    // border: Border.all(color: Colors.white, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Center(
                                      child: Text(
                                    'บันทึก',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text3_,
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

  Future<void> addPlaySelect() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ListBody(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'เพิ่มรายการชำระ',
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
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            StreamBuilder(
                                stream:
                                    Stream.periodic(const Duration(seconds: 0)),
                                builder: (context, snapshot) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 350,
                                    child: GridView.count(
                                      crossAxisCount:
                                          Responsive.isDesktop(context) ? 5 : 2,
                                      children: [
                                        // Card(
                                        //   child: InkWell(
                                        //     onTap: () async {
                                        //       Navigator.of(context).pop();
                                        //       addPlay();
                                        //     },
                                        //     child:
                                        //         Icon(Icons.add_circle_outline),
                                        //   ),
                                        // ),
                                        for (int i = 0;
                                            i < expModels.length;
                                            i++)
                                          Card(
                                            color: text_add.text ==
                                                    expModels[i].expname
                                                ? Colors.lime
                                                : Colors.white,
                                            child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  text_add.text = expModels[i]
                                                      .expname
                                                      .toString();
                                                  price_add.text = expModels[i]
                                                      .pri_auto
                                                      .toString();
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      maxLines: 1,
                                                      '${expModels[i].expname}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      maxLines: 1,
                                                      '${nFormat.format(double.parse(expModels[i].pri_auto!))}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                          height: 350,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.6 /
                                        2.5,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        // keyboardType: TextInputType.name,
                                        controller: text_add,

                                        maxLines: 1,
                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
                                          // prefixIcon:
                                          //     const Icon(Icons.person, color: Colors.black),
                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                          labelText: 'รายการชำระ',
                                          labelStyle: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.6 /
                                        2.5,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: price_add,

                                        maxLines: 1,
                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
                                          // prefixIcon:
                                          //     const Icon(Icons.person, color: Colors.black),
                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                          labelText: 'ยอดชำระ',
                                          labelStyle: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                            width: 150,
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
                              'ตกลง',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
                                  //fontSize: 10.0
                                  ),
                            ))),
                        onTap: () {
                          if (text_add.text != '' && price_add.text != '') {
                            if (price_add.text != '0') {
                              in_Trans_add();
                              Navigator.of(context).pop();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.black,
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
                              'ปิด',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
                                  //fontSize: 10.0
                                  ),
                            ))),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future<Null> in_Trans_add() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    var textadd = text_add.text;
    var priceadd = price_add.text;
    var dtypeadd = '';

    String url =
        '${MyConstant().domain}/In_tran_select_add.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&textadd=$textadd&priceadd=$priceadd&user=$user&dtypeadd=$dtypeadd';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_bill();
          red_Trans_select();
          text_add.clear();
          price_add.clear();
        });
        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        setState(() {
          red_Trans_bill();
          red_Trans_select();
          text_add.clear();
          price_add.clear();
        });
        print('rrrrrrrrrrrrrrfalse');
      } else {
        setState(() {
          red_Trans_bill();
          red_Trans_select();
          text_add.clear();
          price_add.clear();
        });
      }
    } catch (e) {
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> deall_Trans_select() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/D_tran_select.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_bill();
          red_Trans_select();
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> in_Trans_invoice() async {
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

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var renTal_name = preferences.getString('renTalName');
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var sumdis = sum_disamt.text;
    var sumdisp = sum_disp.text;
    var c_payment_Ser = paymentSer1;
    String? cFinn;
    String url =
        '${MyConstant().domain}/In_tran_invoice.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&pay_Ser1=$c_payment_Ser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'No') {
        for (var map in result) {
          TransBillModel transBillModel = TransBillModel.fromJson(map);
          setState(() {
            cFinn = transBillModel.docno;
          });
          print('zzzzasaaa123454>>>>  $cFinn');
          print('docnodocnodocnodocnodocno123456>>>>  ${transBillModel.docno}');
        }

        Insert_log.Insert_logs(
            'ผู้เช่า', 'วางบิล>>บันทึก(${ciddoc.toString()})');
        setState(() {
          red_Trans_bill();
          red_Trans_select();
          sum_disamt.text = '0.00';
          sum_disp.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('บันทึกรายการวางบิลสำเร็จ',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
    Future.delayed(const Duration(milliseconds: 200), () async {
      setState(() {
        red_Trans_bill();
        red_Trans_select();
        sum_disamt.text = '0.00';
        sum_disp.clear();
      });
    });
  }

  Future<Null> in_Trans_invoice2(tableData003, newValuePDFimg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var renTal_name = preferences.getString('renTalName');
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var sumdis = sum_disamt.text;
    var sumdisp = sum_disp.text;
    var c_payment_Ser = paymentSer1;
    String? cFinn;
    String url =
        '${MyConstant().domain}/In_tran_invoice.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&pay_Ser1=$c_payment_Ser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'No') {
        for (var map in result) {
          TransBillModel transBillModel = TransBillModel.fromJson(map);
          setState(() {
            cFinn = transBillModel.docno;
          });
          print('zzzzasaaa123454>>>>  $cFinn');
          print('docnodocnodocnodocnodocno123456>>>>  ${transBillModel.docno}');
        }
        Insert_log.Insert_logs(
            'ผู้เช่า', 'วางบิล>>บันทึก(${ciddoc.toString()})');
        //////////----------------------->
        BillingNoteInvlice_Tempage(
            tableData003, newValuePDFimg, cFinn, renTal_name);
        //////////*////////////----------------------->
        // Pdfgen_BillingNoteInvlice.exportPDF_BillingNoteInvlice(
        //     tableData003,
        //     context,
        //     _TransModels,
        //     '${widget.Get_Value_cid}',
        //     '${widget.namenew}',
        //     '${sum_pvat}',
        //     '${sum_vat}',
        //     '${sum_wht}',
        //     '${sum_amt}',
        //     ' $sum_dis',
        //     '${sum_amt - double.parse(sum_disamt.text)}',
        //     '$renTal_name',
        //     '${Form_bussshop}',
        //     '${Form_address}',
        //     '${Form_tel}',
        //     '${Form_email}',
        //     '${Form_tax}',
        //     ' ${Form_nameshop}',
        //     ' ${renTalModels[0].bill_addr}',
        //     ' ${renTalModels[0].bill_email}',
        //     ' ${renTalModels[0].bill_tel}',
        //     ' ${renTalModels[0].bill_tax}',
        //     ' ${renTalModels[0].bill_name}',
        //     newValuePDFimg,
        //     cFinn);

        setState(() async {
          await red_Trans_bill();
          red_Trans_select();
          sum_disamt.text = '0.00';
          sum_disp.clear();
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

//////////////////////////------------------------------>
  Future<Null> BillingNoteInvlice_Tempage(
      tableData003, newValuePDFimg, cFinn, renTal_name) async {
    String? TitleType_Default_Receipt_Name;
    if (TitleType_Default_Receipt == 0) {
    } else {
      setState(() {
        TitleType_Default_Receipt_Name =
            '${TitleType_Default_Receipt_[TitleType_Default_Receipt]}';
      });
    }
    var selectedValue_bank_bno = selectedValue;
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
      cFinn,'0'
    );
  }
}

class PreviewPdfgen_Bills extends StatelessWidget {
  final pw.Document doc;
  final renTal_name;
  final nameBills;
  const PreviewPdfgen_Bills(
      {Key? key, required this.doc, this.renTal_name, this.nameBills})
      : super(key: key);

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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "$nameBills",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: Font_.Fonts_T,
            ),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: true,
          allowPrinting: true, canDebug: false,
          canChangeOrientation: false, canChangePageFormat: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "$nameBills.pdf",
        ),
      ),
    );
  }
}
