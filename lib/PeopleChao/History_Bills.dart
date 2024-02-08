// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Man_PDF/Man_Pay_Receipt_PDF.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetInvoice_Model.dart';
import '../Model/GetInvoice_history_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../PDF/PDF_Receipt/pdf_AC_his_statusbill.dart';
import '../PDF_TP2/PDF_Receipt_TP2/pdf_AC_his_statusbill_TP2.dart';
import '../PDF_TP3/PDF_Receipt_TP3/pdf_AC_his_statusbill_TP3.dart';
import '../PDF_TP4/PDF_Receipt_TP4/pdf_AC_his_statusbill_TP4.dart';
import '../PDF_TP5/PDF_Receipt_TP5/pdf_AC_his_statusbill_TP5.dart';
import '../PDF_TP6/PDF_Receipt_TP6/pdf_AC_his_statusbill_TP6.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class HistoryBills extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  const HistoryBills({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
  });

  @override
  State<HistoryBills> createState() => _HistoryBillsState();
}

class _HistoryBillsState extends State<HistoryBills> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  List<TransBillModel> _TransBillModels = [];
  List<TransModel> _TransModels = [];
  List<TransReBillModel> _TransReBillModels = [];
  List<InvoiceModel> _InvoiceModels = [];
  List<InvoiceHistoryModel> _InvoiceHistoryModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<PayMentModel> _PayMentModels = [];
  List<FinnancetransModel> finnancetransModels = [];
  List<RenTalModel> renTalModels = [];
  List<TeNantModel> teNantModels = [];
  // final sum_disamtx = TextEditingController();
  // final sum_dispx = TextEditingController();
  final Form_payment1 = TextEditingController();
  final Form_payment2 = TextEditingController();
  final Form_time = TextEditingController();

  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      total_amt = 0.00,
      sum_disp = 0,
      dis_sum_Matjum = 0.00;
  int select_page = 0,
      pamentpage = 0; // = 0 _TransModels : = 1 _InvoiceHistoryModels
  String? dtypeselect;
  String? numinvoice,
      Slip_history,
      numdoctax,
      paymentSer1,
      paymentName1,
      paymentSer2,
      paymentName2,
      Value_newDateY = '',
      Value_newDateD = '',
      Value_newDateY1 = '',
      Value_newDateD1 = '';
  DateTime newDatetime = DateTime.now();
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
      renTal_name,
      tem_page_ser,
      room_number_BillHistory,
      pdate;
  String? Form_nameshop,
      Form_typeshop,
      Form_bussshop,
      Form_bussscontact,
      Form_address,
      Form_tel,
      Form_email,
      Form_tax;
  @override
  void initState() {
    super.initState();
    red_Trans_bill();
    read_GC_rental();
    read_data();
    // sum_disamtx.text = '0.00';
    Value_newDateY1 = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD1 = DateFormat('dd-MM-yyyy').format(newDatetime);
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
            renTalModels.add(renTalModel);
            if (bill_defaultx == 'P') {
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
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_bill() async {
    if (_TransReBillModels.length != 0) {
      setState(() {
        _TransReBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_bill_pay.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          setState(() {
            _TransReBillModels.add(transReBillModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }

        print('result ${_TransReBillModels.length}');
      }
    } catch (e) {}
  }

  String Remark_ = '';

  Future<Null> red_Invoice(index) async {
    if (finnancetransModels.length != 0) {
      setState(() {
        finnancetransModels.clear();
        sum_disamt = 0;
        sum_disp = 0;
        dis_sum_Matjum = 0.00;
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = _TransReBillModels[index].ser;
    var qutser = _TransReBillModels[index].ser_in;
    var docnoin = _TransReBillModels[index].docno; //.toString().trim()
    print('>>>>>>>>>>>dd>>> in d  $docnoin');

    String url =
        '${MyConstant().domain}/GC_bill_pay_amt.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      print('BBBBBBBBBBBBBBBB>>>> $result');
      if (result.toString() != 'null') {
        for (var map in result) {
          FinnancetransModel finnancetransModel =
              FinnancetransModel.fromJson(map);

          var sidamt = double.parse(finnancetransModel.amt!);
          var siddisper = double.parse(finnancetransModel.disper!);
          var pdatex = finnancetransModel.pdate;

          setState(() {
            Slip_history = finnancetransModel.slip.toString();
            if (int.parse(finnancetransModel.receiptSer!) != 0) {
              finnancetransModels.add(finnancetransModel);
              pdate = pdatex;
            } else {
              if (finnancetransModel.type!.trim() == 'DISCOUNT') {
                sum_disamt = sidamt;
                sum_disp = siddisper;
              }
            }
          });
          if (finnancetransModel.dtype! == 'MM') {
            setState(() {
              dis_sum_Matjum =
                  dis_sum_Matjum + double.parse(finnancetransModel.amt!);
            });
          }
          print(
              '>>>>> ${finnancetransModel.slip}>>>>>>dd>>> in $sidamt $siddisper  ');
        }
      }
    } catch (e) {}
  }

  // Future<Null> red_Invoice(index) async {
  //   if (finnancetransModels.length != 0) {
  //     setState(() {
  //       finnancetransModels.clear();
  //       sum_disamt = 0;
  //       sum_disp = 0;
  //     });
  //   }

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;
  //   var docnoin = _TransReBillModels[index].docno;
  //   print('>>>>>>>>>>>dd>>> in d  $docnoin');

  //   String url =
  //       '${MyConstant().domain}/GC_bill_pay_amt.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&docnoin=$docnoin';
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     var result = json.decode(response.body);
  //     print('BBBBBBBBBBBBBBBB>>>> $result');
  //     if (result.toString() != 'null') {
  //       for (var map in result) {
  //         FinnancetransModel finnancetransModel =
  //             FinnancetransModel.fromJson(map);

  //         var sidamt = double.parse(finnancetransModel.amt!);
  //         var siddisper = double.parse(finnancetransModel.disper!);
  //         print('>>>>>>>>>>>dd>>> in $sidamt $siddisper');
  //         setState(() {
  //           Slip_history = finnancetransModel.slip;
  //           if (int.parse(finnancetransModel.receiptSer!) != 0) {
  //             finnancetransModels.add(finnancetransModel);
  //           } else {
  //             if (finnancetransModel.type!.trim() == 'DISCOUNT') {
  //               sum_disamt = sidamt;
  //               sum_disp = siddisper;
  //             }
  //           }
  //         });
  //       }
  //     }
  //   } catch (e) {}
  // }

  // Future<Null> red_InvoiceC() async {
  //   if (_TransReBillModels.length != 0) {
  //     setState(() {
  //       _TransReBillModels.clear();
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;

  //   String url =
  //       '${MyConstant().domain}/GC_re_bill_invoice.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser}';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result.toString() != 'null') {
  //       for (var map in result) {
  //         TransReBillModel _TransReBillModel = TransReBillModel.fromJson(map);
  //         setState(() {
  //           _TransReBillModels.add(_TransReBillModel);
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
  //         red_Trans_select2();
  //       });
  //       print('rrrrrrrrrrrrrr');
  //     }
  //   } catch (e) {}
  // }

  // Future<Null> deall_Trans_select() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;

  //   String url =
  //       '${MyConstant().domain}/D_tran_select.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result.toString() == 'true') {
  //       setState(() {
  //         red_Trans_select2();
  //       });
  //       print('rrrrrrrrrrrrrr');
  //     }
  //   } catch (e) {}
  // }

  // Future<Null> red_Trans_select2() async {
  //   if (_TransModels.length != 0) {
  //     setState(() {
  //       _TransModels.clear();
  //       sum_pvat = 0;
  //       sum_vat = 0;
  //       sum_wht = 0;
  //       sum_amt = 0;
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;

  //   String url =
  //       '${MyConstant().domain}/GC_tran_select.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result.toString() != 'null') {
  //       for (var map in result) {
  //         TransModel _TransModel = TransModel.fromJson(map);

  //         var sum_pvatx = double.parse(_TransModel.pvat!);
  //         var sum_vatx = double.parse(_TransModel.vat!);
  //         var sum_whtx = double.parse(_TransModel.wht!);
  //         var sum_amtx = double.parse(_TransModel.total!);
  //         setState(() {
  //           sum_pvat = sum_pvat + sum_pvatx;
  //           sum_vat = sum_vat + sum_vatx;
  //           sum_wht = sum_wht + sum_whtx;
  //           sum_amt = sum_amt + sum_amtx;
  //           _TransModels.add(_TransModel);
  //         });
  //       }
  //     }
  //   } catch (e) {}
  // }

  // Future<Null> red_Trans_select_re(index) async {
  //   if (_TransReBillHistoryModels.length != 0) {
  //     setState(() {
  //       _TransReBillHistoryModels.clear();
  //       sum_pvat = 0;
  //       sum_vat = 0;
  //       sum_wht = 0;
  //       sum_amt = 0;
  //       sum_disamt = 0;
  //       sum_disp = 0; //_TransReBillModels
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;
  //   var docnoin = _TransReBillModels[index].docno;

  //   print(
  //       'BBBBBBBBBBBB/... $docnoin == $ciddoc  ${_TransReBillHistoryModels.length}');

  //   String url =
  //       '${MyConstant().domain}/GC_re_bill_invoice_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result.toString() != 'null') {
  //       print('result1111');
  //       for (var map in result) {
  //         print('result2222');
  //         TransReBillHistoryModel _TransReBillHistoryModel =
  //             TransReBillHistoryModel.fromJson(map);

  //         var sum_pvatx = double.parse(_TransReBillHistoryModel.pvat!);
  //         var sum_vatx = double.parse(_TransReBillHistoryModel.vat!);
  //         var sum_whtx = double.parse(_TransReBillHistoryModel.wht!);
  //         var sum_amtx = double.parse(_TransReBillHistoryModel.total!);
  //         var sum_disamtx = _TransReBillHistoryModel.disend == null
  //             ? 0.00
  //             : double.parse(_TransReBillHistoryModel.disend!);
  //         var sum_dispx = _TransReBillHistoryModel.disendbillper == null
  //             ? 0.00
  //             : double.parse(_TransReBillHistoryModel.disendbillper!);
  //         print('${_TransReBillHistoryModel.name}');
  //         setState(() {
  //           sum_pvat = sum_pvat + sum_pvatx;
  //           sum_vat = sum_vat + sum_vatx;
  //           sum_wht = sum_wht + sum_whtx;
  //           sum_amt = sum_amt + sum_amtx;
  //           sum_disamt = sum_disamtx;
  //           sum_disp = sum_dispx;
  //           numinvoice = _TransReBillHistoryModel.docno;
  //           _TransReBillHistoryModels.add(_TransReBillHistoryModel);
  //         });
  //       }
  //       print(_TransReBillHistoryModels.length);
  //     }
  //   } catch (e) {}
  // }
/////////////------------------------------------------------>

  Future<Null> red_Trans_select(index) async {
    if (_TransReBillHistoryModels.length != 0) {
      setState(() {
        _TransReBillHistoryModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        total_amt = 0.00;
        // sum_disamt = 0;
        // sum_disp = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var docnoin = _TransReBillModels[index].docno;

    String url =
        '${MyConstant().domain}/GC_bill_pay_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel _TransReBillHistoryModel =
              TransReBillHistoryModel.fromJson(map);
          var dtypeinvoiceent = _TransReBillHistoryModel.dtype;
          var sum_pvatx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.pvat!)
              : 0.0;
          var sum_vatx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.vat!)
              : 0.0;
          var sum_whtx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.wht!)
              : 0.0;
          var sum_amtx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.total!)
              : 0.0;

          var total_amtx = dtypeinvoiceent != 'KP' || dtypeinvoiceent != '!Z'
              ? double.parse(_TransReBillHistoryModel.total!)
              : 0.0;
          // var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
          // var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
          var numinvoiceent = _TransReBillHistoryModel.docno;

          setState(() {
            if (dtypeinvoiceent == 'KP') {
              sum_pvat = sum_pvat + sum_pvatx;
              sum_vat = sum_vat + sum_vatx;
              sum_wht = sum_wht + sum_whtx;
              sum_amt = sum_amt + sum_amtx;
              // sum_disamt = sum_disamtx;
              // sum_disp = sum_dispx;
              numinvoice = _TransReBillHistoryModel.docno;
              numdoctax = _TransReBillHistoryModel.doctax;
              _TransReBillHistoryModels.add(_TransReBillHistoryModel);
            } else if (dtypeinvoiceent == '!Z') {
              sum_pvat = sum_pvat + sum_pvatx;
              sum_vat = sum_vat + sum_vatx;
              sum_wht = sum_wht + sum_whtx;
              sum_amt = sum_amt + sum_amtx;
              // sum_disamt = sum_disamtx;
              // sum_disp = sum_dispx;
              numinvoice = _TransReBillHistoryModel.docno;
              numdoctax = _TransReBillHistoryModel.doctax;
              _TransReBillHistoryModels.add(_TransReBillHistoryModel);
            } else {
              total_amt = total_amt + total_amtx;
              _TransReBillHistoryModels.add(_TransReBillHistoryModel);
            }
          });
        }
      }
      // setState(() {
      //   red_Invoice();
      // });
    } catch (e) {}
  }
///////////------------------------------------------->
  // Future<Null> red_Trans_selectde() async {
  //   if (_InvoiceHistoryModels.length != 0) {
  //     setState(() {
  //       _InvoiceHistoryModels.clear();
  //       sum_pvat = 0;
  //       sum_vat = 0;
  //       sum_wht = 0;
  //       sum_amt = 0;
  //       sum_disamt = 0;
  //       sum_disp = 0;
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;
  //   var docnoin = numinvoice;

  //   print('object11');

  //   String url =
  //       '${MyConstant().domain}/GC_bill_invoice_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     print('object22');
  //     if (result.toString() != 'null') {
  //       print('object33');
  //       for (var map in result) {
  //         print('object44');
  //         InvoiceHistoryModel _InvoiceHistoryModel =
  //             InvoiceHistoryModel.fromJson(map);

  //         var sum_pvatx = double.parse(_InvoiceHistoryModel.pvat_t!);
  //         var sum_vatx = double.parse(_InvoiceHistoryModel.vat_t!);
  //         var sum_whtx = double.parse(_InvoiceHistoryModel.wht!);
  //         var sum_amtx = double.parse(_InvoiceHistoryModel.total_t!);
  //         var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
  //         var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
  //         setState(() {
  //           sum_pvat = sum_pvat + sum_pvatx;
  //           sum_vat = sum_vat + sum_vatx;
  //           sum_wht = sum_wht + sum_whtx;
  //           sum_amt = sum_amt + sum_amtx;
  //           sum_disamt = sum_disamtx;
  //           sum_disp = sum_dispx;
  //           numinvoice = _InvoiceHistoryModel.docno;
  //           _InvoiceHistoryModels.add(_InvoiceHistoryModel);
  //         });
  //       }
  //     }
  //   } catch (e) {}
  // }

  String bills_name_ = '';
  List bills_name = [
    'บิลปกติ',
    'บิลเต็มรูปแบบ',
  ];
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 150,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 150,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 150,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 150,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  final Set<int> _pressedIndices = Set();

  ///----------------->
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: (Responsive.isDesktop(context))
                      ? MediaQuery.of(context).size.width * 0.85
                      : 1400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width / 3.5
                                : 400,
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _InvoiceModels.clear();
                                          _InvoiceHistoryModels.clear();
                                          _TransReBillHistoryModels.clear();
                                          numinvoice = null;
                                          numdoctax = null;
                                          // sum_disamtx.text = '0.00';
                                          // sum_dispx.text = '0.00';
                                          sum_pvat = 0.00;
                                          sum_vat = 0.00;
                                          sum_wht = 0.00;
                                          sum_amt = 0.00;
                                          sum_dis = 0.00;
                                          sum_disamt = 0.00;
                                          sum_disp = 0;
                                          select_page = 0;
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
                                        child: Center(
                                          child: Text(
                                            'รายการรับชำระ',
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
                                      child: Center(
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          'วันที่ชำระ',
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
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
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
                                  child:
                                      // select_page == 0
                                      //     ?
                                      ListView.builder(
                                    controller: _scrollController1,
                                    // itemExtent: 50,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _TransReBillModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Material(
                                        color: (_TransReBillModels[index]
                                                        .docno
                                                        .toString() ==
                                                    numinvoice.toString() ||
                                                _TransReBillModels[index]
                                                        .doctax
                                                        .toString() ==
                                                    numinvoice.toString())
                                            ? tappedIndex_Color
                                                .tappedIndex_Colors
                                            : _TransReBillModels[index].dtype ==
                                                    '!Z'
                                                ? Colors.red.shade100
                                                : AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                        child: ListTile(
                                          onTap: () async {
                                            print(
                                                '${_TransReBillModels[index].ser} ${_TransReBillModels[index].docno}');
                                            red_Trans_select(index);
                                            setState(() {
                                              Remark_ =
                                                  _TransReBillModels[index]
                                                      .remark!;
                                              room_number_BillHistory =
                                                  '${_TransReBillModels[index].room_number}';
                                            });
                                            red_Invoice(index);

                                            setState(() {
                                              dtypeselect =
                                                  _TransReBillModels[index]
                                                      .dtype;
                                            });
                                            // in_Trans_select(index);
                                          },
                                          title: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Tooltip(
                                                  richMessage: TextSpan(
                                                    text: _TransReBillModels[
                                                                    index]
                                                                .dtype ==
                                                            '!Z'
                                                        ? '${_TransReBillModels[index].expname} (ยกเลิก)'
                                                        : '${_TransReBillModels[index].expname}',
                                                    style: const TextStyle(
                                                      color: HomeScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey[200],
                                                  ),
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 25,
                                                    maxLines: 1,
                                                    _TransReBillModels[index]
                                                                .dtype ==
                                                            '!Z'
                                                        ? '${_TransReBillModels[index].expname} (ยกเลิก)'
                                                        : '${_TransReBillModels[index].expname}',
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 25,
                                                  maxLines: 1,
                                                  '${_TransReBillModels[index].daterec}',
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Tooltip(
                                                  richMessage: TextSpan(
                                                    text: _TransReBillModels[
                                                                    index]
                                                                .doctax ==
                                                            ''
                                                        ? '${_TransReBillModels[index].docno}'
                                                        : '${_TransReBillModels[index].doctax}',
                                                    style: const TextStyle(
                                                      color: HomeScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey[200],
                                                  ),
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 25,
                                                    maxLines: 1,
                                                    _TransReBillModels[index]
                                                                .doctax ==
                                                            ''
                                                        ? '${_TransReBillModels[index].docno}'
                                                        : '${_TransReBillModels[index].doctax}',
                                                    textAlign: TextAlign.end,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                              Container(
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width / 3.5
                                      : 400,
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
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Row(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.start,
                                                //     children: [
                                                //       InkWell(
                                                //         onTap: () {},
                                                //         child: Container(
                                                //           width: 100,
                                                //           decoration: const BoxDecoration(
                                                //             color: Colors.green,
                                                //             borderRadius:
                                                //                 BorderRadius.only(
                                                //                     topLeft: Radius
                                                //                         .circular(10),
                                                //                     topRight:
                                                //                         Radius.circular(
                                                //                             10),
                                                //                     bottomLeft:
                                                //                         Radius.circular(
                                                //                             10),
                                                //                     bottomRight:
                                                //                         Radius.circular(
                                                //                             10)),
                                                //             // border: Border.all(color: Colors.white, width: 1),
                                                //           ),
                                                //           padding:
                                                //               const EdgeInsets.all(8.0),
                                                //           child: const Center(
                                                //             child: AutoSizeText(
                                                //               minFontSize: 10,
                                                //               maxFontSize: 15,
                                                //               'เพิ่มใหม่',
                                                //               style: TextStyle(
                                                //                   color:
                                                //                       PeopleChaoScreen_Color
                                                //                           .Colors_Text2_,
                                                //                   //fontWeight: FontWeight.bold,
                                                //                   fontFamily:
                                                //                       Font_.Fonts_T),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                      // select_page == 0
                      //     ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width * 0.52
                                : 900,
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
                                      child: Center(
                                        child: Text(
                                          dtypeselect == '!Z'
                                              ? 'รายละเอียดบิล (ยกเลิก)'
                                              : 'รายละเอียดบิล', //numinvoice
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
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  numdoctax == ''
                                                      ? 'บิลเลขที่ $numinvoice'
                                                      : 'บิลเลขที่ $numdoctax', //
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                          'วันที่ชำระ',
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
                                          // 'รายการ',
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
                                          'เลขตั้งหนี้',
                                          // 'รายการ',
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
                                          'VAT(฿)',
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
                                          'WHT(฿)',
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
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Container(
                                  //     height: 50,
                                  //     color: Colors.brown[200],
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: const Center(
                                  //       child: AutoSizeText(
                                  //         minFontSize: 10,
                                  //         maxFontSize: 15,
                                  //         maxLines: 1,
                                  //         'หน่วย',
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(
                                  //             color: PeopleChaoScreen_Color.Colors_Text1_,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontFamily: FontWeight_.Fonts_T
                                  //             //fontSize: 10.0
                                  //             //fontSize: 10.0
                                  //             ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Container(
                                  //     height: 50,
                                  //     color: Colors.brown[200],
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: const Center(
                                  //       child: AutoSizeText(
                                  //         minFontSize: 10,
                                  //         maxFontSize: 15,
                                  //         maxLines: 1,
                                  //         'VAT',
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(
                                  //             color: PeopleChaoScreen_Color.Colors_Text1_,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontFamily: FontWeight_.Fonts_T
                                  //             //fontSize: 10.0
                                  //             //fontSize: 10.0
                                  //             ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Container(
                                  //     height: 50,
                                  //     color: Colors.brown[200],
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: const Center(
                                  //       child: AutoSizeText(
                                  //         minFontSize: 10,
                                  //         maxFontSize: 15,
                                  //         maxLines: 2,
                                  //         'ราคารวมก่อน VAT',
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(
                                  //             color: PeopleChaoScreen_Color.Colors_Text1_,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontFamily: FontWeight_.Fonts_T
                                  //             //fontSize: 10.0
                                  //             //fontSize: 10.0
                                  //             ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
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
                                          'ยอดสุทธิ',
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
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _TransReBillHistoryModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                                '${_TransReBillHistoryModels[index].daterec}',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                                '${_TransReBillHistoryModels[index].date}',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                                '${_TransReBillHistoryModels[index].refno}',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                                '${_TransReBillHistoryModels[index].expname}',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
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
                                                maxLines: 1,

                                                '${nFormat.format(double.parse(_TransReBillHistoryModels[index].nvat!))}',
                                                // '${_TransReBillHistoryModels[index].nvat}',
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
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
                                                maxLines: 1,

                                                '${nFormat.format(double.parse(_TransReBillHistoryModels[index].wht!))}',
                                                // '${_TransReBillHistoryModels[index].wht}',
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: AutoSizeText(
                                            //     minFontSize: 10,
                                            //     maxFontSize: 15,
                                            //     maxLines: 1,
                                            //     '${_TransReBillHistoryModels[index].vtype}',
                                            //     textAlign: TextAlign.end,
                                            //     style: const TextStyle(
                                            //         color: PeopleChaoScreen_Color
                                            //             .Colors_Text2_,
                                            //         //fontWeight: FontWeight.bold,
                                            //         fontFamily: Font_.Fonts_T),
                                            //   ),
                                            // ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: AutoSizeText(
                                            //     minFontSize: 10,
                                            //     maxFontSize: 15,
                                            //     maxLines: 1,
                                            //     '${nFormat.format(double.parse(_TransReBillHistoryModels[index].vat!))}',
                                            //     textAlign: TextAlign.end,
                                            //     style: const TextStyle(
                                            //         color: PeopleChaoScreen_Color
                                            //             .Colors_Text2_,
                                            //         //fontWeight: FontWeight.bold,
                                            //         fontFamily: Font_.Fonts_T),
                                            //   ),
                                            // ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: AutoSizeText(
                                            //     minFontSize: 10,
                                            //     maxFontSize: 15,
                                            //     maxLines: 1,
                                            //     '${nFormat.format(double.parse(_TransReBillHistoryModels[index].amt!))}',
                                            //     textAlign: TextAlign.end,
                                            //     style: const TextStyle(
                                            //         color: PeopleChaoScreen_Color
                                            //             .Colors_Text2_,
                                            //         //fontWeight: FontWeight.bold,
                                            //         fontFamily: Font_.Fonts_T),
                                            //   ),
                                            // ),
                                            Expanded(
                                              flex: 2,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
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
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width * 0.52
                                      : 900,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                // width: 100,
                                                decoration: BoxDecoration(
                                                  // color: Colors.green,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                  ),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      child: Text(
                                                    'หมายเหตุ : ${Remark_}',
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(flex: 1, child: Text('')),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                color: Colors.grey.shade300,
                                                // height: 100,
                                                // width: 300,
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
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_pvat)}',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
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
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_vat)}',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
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
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_wht)}',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
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
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_amt)}',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
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
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              width: 60,
                                                              height: 20,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 15,
                                                                '$sum_disp  %',
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
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
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
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
                                                  total_amt == 0.00
                                                      ? SizedBox()
                                                      : Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 15,
                                                                'หักชำระ',
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 15,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                '${nFormat.format(total_amt)}',
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
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
                                                          'ยอดชำระ',
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
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_amt - sum_disamt - total_amt)}',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))
                            ])),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        dtypeselect == '!Z'
            ? SizedBox()
            : Align(
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 800,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
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
                                      child: Center(
                                        child: Text(
                                          numinvoice == null
                                              ? 'บิลเลขที่'
                                              : numdoctax == ''
                                                  ? 'บิลเลขที่ $numinvoice'
                                                  : 'บิลเลขที่ $numdoctax',
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
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 10,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
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
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'หลักฐานการโอน',
                                        textAlign: TextAlign.start,
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
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: (Slip_history.toString() ==
                                                      null ||
                                                  Slip_history == null ||
                                                  Slip_history.toString() ==
                                                      'null')
                                              ? Colors.green[200]
                                              : Colors.green,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8)),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 2),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            (Slip_history.toString() == null ||
                                                    Slip_history == null ||
                                                    Slip_history.toString() ==
                                                        'null')
                                                ? 'ไม่พบหลักฐาน'
                                                : 'พบหลักฐาน ',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                      onTap:
                                          (Slip_history.toString() == null ||
                                                  Slip_history == null ||
                                                  Slip_history.toString() ==
                                                      'null')
                                              ? null
                                              : () async {
                                                  String Url =
                                                      await '${MyConstant().domain}/files/$foder/slip/${Slip_history}';
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                            title: Center(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    numinvoice ==
                                                                            null
                                                                        ? 'บิลเลขที่'
                                                                        : numdoctax ==
                                                                                ''
                                                                            ? 'บิลเลขที่ $numinvoice'
                                                                            : 'บิลเลขที่ $numdoctax',
                                                                    maxLines: 1,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_
                                                                                .Fonts_T,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                  Text(
                                                                    '${Slip_history}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_
                                                                                .Fonts_T,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            content: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Image.network(
                                                                    '$Url')
                                                              ],
                                                            ),
                                                            actions: <Widget>[
                                                          Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                                height: 4.0,
                                                              ),
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            context,
                                                                            'OK'),
                                                                        child:
                                                                            const Text(
                                                                          'ปิด',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ]),
                                                  );
                                                },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
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
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'รวม(บาท)',
                                        textAlign: TextAlign.start,
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
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${nFormat.format(sum_pvat)}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'บาท',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
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
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ภาษีมูลค่าเพิ่ม(vat)',
                                        textAlign: TextAlign.start,
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
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${nFormat.format(sum_vat)}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'บาท',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
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
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'หัก ณ ที่จ่าย',
                                        textAlign: TextAlign.start,
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
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${nFormat.format(sum_wht)}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'บาท',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
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
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ยอดรวม',
                                        textAlign: TextAlign.start,
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
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${nFormat.format(sum_amt)}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'บาท',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
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
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              'ส่วนลด',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '$sum_disp  %',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${nFormat.format(sum_disamt)}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'บาท',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              total_amt == 0.00
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 40,
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'หักชำระ',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: 40,
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${nFormat.format(total_amt)}',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 40,
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'บาท',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
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
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ยอดชำระรวม',
                                        textAlign: TextAlign.start,
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
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        // '${nFormat.format(sum_amt - sum_disamt)}',
                                        '${nFormat.format(sum_amt - sum_disamt - total_amt)}',
                                        textAlign: TextAlign.end,
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
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'บาท',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (room_number_BillHistory.toString().trim() !=
                                      '' ||
                                  room_number_BillHistory != null)
                                Row(children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ยอดชำระรวม',
                                        textAlign: TextAlign.start,
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
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        (room_number_BillHistory
                                                        .toString()
                                                        .trim() ==
                                                    '' ||
                                                room_number_BillHistory == null)
                                            ? ''
                                            : 'ประเภท ( ล็อคเสียบ )',
                                        textAlign: TextAlign.end,
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
                                ]),
                              Row(children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 40,
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            'รูปแบบการชำระ',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Row(
                                          children: [],
                                        ),
                                      ),
                                    ),
                                  ),
                                  for (var i = 0;
                                      i < finnancetransModels.length;
                                      i++)
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        height: 50,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 50,

                                                    // width: MediaQuery.of(context).size.width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        finnancetransModels[i]
                                                                    .dtype ==
                                                                'KP'
                                                            ? AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 15,
                                                                finnancetransModels[i]
                                                                            .type ==
                                                                        'CASH'
                                                                    ? '${finnancetransModels[i].type} (เงินสด)'
                                                                    : '${finnancetransModels[i].type} (เงินโอน)',
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              )
                                                            : AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 15,
                                                                '${finnancetransModels[i].remark}',
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
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
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Row(
                                          children: [],
                                        ),
                                      ),
                                    ),
                                  ),
                                  for (var i = 0;
                                      i < finnancetransModels.length;
                                      i++)
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        height: 50,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 50,
                                                    // width: MediaQuery.of(context).size.width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'จำนวน',
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 50,
                                                    // width: MediaQuery.of(context).size.width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      '${nFormat.format(double.parse(finnancetransModels[i].amt!))}',
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 50,
                                                    // width: MediaQuery.of(context).size.width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'บาท',
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        // width: MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(0),
                                          ),
                                          // border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                        height: 50,
                                        // width: MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          // border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap:
                                            (_TransReBillHistoryModels.length ==
                                                    0)
                                                ? null
                                                : () {
                                                    final tableData00 = [
                                                      for (int index = 0;
                                                          index <
                                                              _TransReBillHistoryModels
                                                                  .length;
                                                          index++)
                                                        [
                                                          '${index + 1}',
                                                          '${_TransReBillHistoryModels[index].date}',
                                                          '${_TransReBillHistoryModels[index].expname}',
                                                          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].nvat!))}',
                                                          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].wht!))}',
                                                          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].amt!))}',
                                                          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                        ],
                                                    ];

                                                    List newValuePDFimg = [];
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

                                                    ////////////////////----------------->

                                                    showMyDialog_SAVE(
                                                        tableData00,
                                                        newValuePDFimg,
                                                        room_number_BillHistory);

                                                    ////////////////////----------------->

                                                    //   Pdfgen_his_statusbill
                                                    // .exportPDF_statusbill(
                                                    //     tableData00,
                                                    //     context,
                                                    //     _TransReBillHistoryModels,
                                                    //     'Num_cid',
                                                    //     'Namenew',
                                                    //     sum_pvat,
                                                    //     sum_vat,
                                                    //     sum_wht,
                                                    //     sum_amt,
                                                    //     sum_disp,
                                                    //     sum_disamt,
                                                    //     '${sum_amt - sum_disamt}',
                                                    //     renTal_name,
                                                    //     Form_bussscontact,
                                                    //     Form_bussscontact,
                                                    //     Form_address,
                                                    //     Form_tax,
                                                    //     bill_addr,
                                                    //     bill_email,
                                                    //     bill_tel,
                                                    //     bill_tax,
                                                    //     bill_name,
                                                    //     newValuePDFimg,
                                                    //     numdoctax == ''
                                                    //         ? '$numinvoice'
                                                    //         : '$numdoctax',
                                                    //     numinvoice,
                                                    //     finnancetransModels,
                                                    //     '${finnancetransModels[0].date}');
                                                  },
                                        child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              // border: Border.all(color: Colors.white, width: 1),
                                            ),
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              'พิมพ์',
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ))),
                                      ),
                                    ),
                                  ),
                                  numdoctax != ''
                                      ? SizedBox()
                                      : Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                pPC_finantIbillREbill();
                                              },
                                              child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green[200],
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
                                                    // border: Border.all(color: Colors.white, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Center(
                                                      child: Text(
                                                    'เปลี่ยนสถานะบิล',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ))),
                                            ),
                                          ),
                                        ),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          final Formbecause_ =
                                              TextEditingController();
                                          // pPC_finantIbill();

                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: const Center(
                                                  child: Text(
                                                'ยกเลิกการรับชำระ',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
                                              )),
                                              content: Container(
                                                height: 120,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 2.0,
                                                    ),
                                                    Text(
                                                      'บิลเลขที่ ${numinvoice}',
                                                      style: const TextStyle(
                                                          color:
                                                              AccountScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight:
                                                          //     FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            Formbecause_,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                          }
                                                          // if (int.parse(value.toString()) < 13) {
                                                          //   return '< 13';
                                                          // }
                                                          return null;
                                                        },
                                                        // maxLength: 13,
                                                        cursorColor:
                                                            Colors.green,
                                                        decoration:
                                                            InputDecoration(
                                                                fillColor: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.3),
                                                                filled: true,
                                                                // prefixIcon: const Icon(Icons.water,
                                                                //     color: Colors.blue),
                                                                // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                focusedBorder:
                                                                    const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            15),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            15),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15),
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
                                                                            15),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            15),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                labelText:
                                                                    'หมายเหตุ',
                                                                labelStyle:
                                                                    const TextStyle(
                                                                  color: AccountScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight:
                                                                  //     FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
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
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 150,
                                                    height: 40,
                                                    // ignore: deprecated_member_use
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        String Formbecause =
                                                            Formbecause_.text
                                                                .toString();
                                                        if (Formbecause == '') {
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
                                                              title:
                                                                  const Center(
                                                                      child:
                                                                          Text(
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
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            100,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Colors.redAccent,
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                        ),
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            TextButton(
                                                                          onPressed: () => Navigator.pop(
                                                                              context,
                                                                              'OK'),
                                                                          child:
                                                                              const Text(
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
                                                          );
                                                        } else {
                                                          pPC_finantIbill(
                                                              Formbecause);
                                                          setState(() {
                                                            Formbecause_
                                                                .clear();
                                                          });
                                                          Navigator.pop(
                                                              context, 'OK');
                                                        }
                                                      },
                                                      child: const Text(
                                                        'ยืนยัน',
                                                        style: TextStyle(
                                                          // fontSize: 20.0,
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      // color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 150,
                                                    height: 40,
                                                    // ignore: deprecated_member_use
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.black,
                                                      ),
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
                                                          // fontSize: 20.0,
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      // color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              // border: Border.all(color: Colors.white, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                                child: Text(
                                              'ยกเลิกการรับชำระ',
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ))),
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
                ),
              ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  Future<Null> pPC_finantIbillREbill() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    var numin = numinvoice;
    print('>>>zzzz>>>>>> $numin');

    String url =
        '${MyConstant().domain}/UPC_finant_billREbill.php?isAdd=true&ren=$ren&user=$user&numin=$numin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        setState(() {
          _InvoiceModels.clear();
          _InvoiceHistoryModels.clear();
          _TransReBillHistoryModels.clear();
          numinvoice = null;
          numdoctax = null;
          // sum_disamtx.text = '0.00';
          // sum_dispx.text = '0.00';
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;
          select_page = 0;
          red_Trans_bill();
          finnancetransModels.clear();
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }
  // Future<Null> confirmOrderdelete(int index) async {
  //   print(_InvoiceHistoryModels[index].ser);
  //   print(numinvoice);
  //   showDialog(
  //       context: context,
  //       builder: (context) => StatefulBuilder(
  //             builder: (context, setState) => AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               title: Column(
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                           alignment: Alignment.center,
  //                           width: MediaQuery.of(context).size.width * 0.2,
  //                           child: Text(
  //                             'ยกเลิกวางบิล',
  //                             style: TextStyle(
  //                               fontSize: 20.0,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.red,
  //                             ),
  //                           )),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                           alignment: Alignment.center,
  //                           width: MediaQuery.of(context).size.width * 0.2,
  //                           child: Text(
  //                             '${_InvoiceHistoryModels[index].descr}',
  //                             style: TextStyle(
  //                               fontSize: 16.0,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black,
  //                             ),
  //                           )),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       Container(
  //                         width: 130,
  //                         height: 40,
  //                         // ignore: deprecated_member_use
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: AppBarColors.ABar_Colors,
  //                           ),
  //                           onPressed: () async {
  //                             SharedPreferences preferences =
  //                                 await SharedPreferences.getInstance();
  //                             var ren = preferences.getString('renTalSer');
  //                             var user = preferences.getString('ser');
  //                             var ciddoc = widget.Get_Value_cid;
  //                             var qutser = widget.Get_Value_NameShop_index;

  //                             var tser = _InvoiceHistoryModels[index].ser;
  //                             var tdocno = numinvoice;

  //                             print('tser >>.> $tser');

  //                             String url =
  //                                 '${MyConstant().domain}/Uc_invoice_de.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
  //                             try {
  //                               var response = await http.get(Uri.parse(url));

  //                               var result = json.decode(response.body);
  //                               print(result);
  //                               if (result.toString() == 'true') {
  //                                 setState(() {
  //                                   //  red_Trans_selectde();
  //                                   Navigator.pop(context);
  //                                 });
  //                                 print('rrrrrrrrrrrrrr');
  //                               }
  //                             // red_Trans_selectde();
  //                           },
  //                           child: Text(
  //                             'Confirm',
  //                             style: TextStyle(
  //                               // fontSize: 20.0,
  //                               // fontWeight: FontWeight.bold,
  //                               color: Colors.white,
  //                             ),
  //                           ),
  //                           // color: Colors.orange[900],
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         height: 40,
  //                         // ignore: deprecated_member_use
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: Colors.black,
  //                           ),
  //                           onPressed: () => Navigator.pop(context),
  //                           child: Text(
  //                             'Cancel',
  //                             style: TextStyle(
  //                               // fontSize: 20.0,
  //                               // fontWeight: FontWeight.bold,
  //                               color: Colors.white,
  //                             ),
  //                           ),
  //                           // color: Colors.black,
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ));
  // }
  Future<Null> pPC_finantIbill(Formbecause) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    var numin = numinvoice;

    String url =
        '${MyConstant().domain}/UPC_finant_bill.php?isAdd=true&ren=$ren&user=$user&numin=$numin&because=$Formbecause';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        Insert_log.Insert_logs('บัญชี',
            'ประวัติบิล>>ยกเลิกการรับชำระ($numin,เหตุผล:${Formbecause})');
        setState(() {
          _InvoiceModels.clear();
          _InvoiceHistoryModels.clear();
          _TransReBillHistoryModels.clear();
          numinvoice = null;
          numdoctax = null;
          // sum_disamtx.text = '0.00';
          // sum_dispx.text = '0.00';
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          total_amt = 0.00;
          sum_disp = 0;
          select_page = 0;
          red_Trans_bill();
          finnancetransModels.clear();
        });
        // print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }
  // Future<Null> pPC_finantIbill() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');
  //   var ciddoc = widget.Get_Value_cid;
  //   var qutser = widget.Get_Value_NameShop_index;

  //   var numin = numinvoice;

  //   String url =
  //       '${MyConstant().domain}/UPC_finant_bill.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&numin=$numin';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result.toString() == 'true') {
  //       Insert_log.Insert_logs(
  //           'ผู้เช่า', 'ประวัติบิล>>ยกเลิกรับชำระ(${numin.toString()})');
  //       setState(() {
  //         _InvoiceModels.clear();
  //         _InvoiceHistoryModels.clear();
  //         _TransReBillHistoryModels.clear();
  //         numinvoice = null;
  //         numdoctax = null;
  //         // sum_disamtx.text = '0.00';
  //         // sum_dispx.text = '0.00';
  //         sum_pvat = 0.00;
  //         sum_vat = 0.00;
  //         sum_wht = 0.00;
  //         sum_amt = 0.00;
  //         sum_dis = 0.00;
  //         sum_disamt = 0.00;
  //         total_amt = 0.00;
  //         sum_disp = 0;
  //         select_page = 0;
  //         red_Trans_bill();
  //         finnancetransModels.clear();
  //       });
  //       print('rrrrrrrrrrrrrr');
  //     }
  //   } catch (e) {}
  // }

  ////////////------------------------------------------------------>(Export file)
  Future<void> showMyDialog_SAVE(
      tableData00, newValuePDFimg, room_number_BillHistory) async {
    String _ReportValue_type = "ไม่ระบุ";
    String _verticalGroupValue_NameFile = "จากระบบ";
    String Value_Report = ' ';
    String NameFile_ = '';
    String Pre_and_Dow = '';
    String? TitleType_Default_Receipt_Name;
    final _formKey = GlobalKey<FormState>();
    final FormNameFile_text = TextEditingController();
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
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      const Text(
                        'หัวบิล :',
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
                          groupValue: _ReportValue_type,
                          horizontalAlignment: MainAxisAlignment.spaceAround,
                          onChanged: (value) {
                            // setState(() {
                            //   FormNameFile_text.clear();
                            // });
                            setState(() {
                              _ReportValue_type = value ?? '';
                            });

                            if (value == 'ไม่ระบุ') {
                              setState(() {
                                TitleType_Default_Receipt_Name = null;
                              });
                            } else {
                              setState(() {
                                TitleType_Default_Receipt_Name = value;
                              });
                            }
                          },
                          items: const <String>[
                            'ไม่ระบุ',
                            'ต้นฉบับ',
                            'สำเนา',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Receipt_his_statusbill(
                                tableData00,
                                newValuePDFimg,
                                room_number_BillHistory,
                                TitleType_Default_Receipt_Name);
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
                            child: Center(
                              child: Text(
                                'พิมพ์',
                                style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold, color:

                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () => Navigator.pop(context, 'OK'),
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
                            child: Center(
                              child: Text(
                                'ปิด',
                                style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold, color:

                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

//////////////-------------------------------------------------------------> ( รายการชำระ ประวัติบิล )
  Future<Null> Receipt_his_statusbill(tableData00, newValuePDFimg,
      room_number_BillHistory, TitleType_Default_Receipt_Name) async {
    var date_Transaction = (finnancetransModels.length == 0)
        ? ''
        : '${finnancetransModels[0].daterec}';
    var date_pay = (finnancetransModels.length == 0)
        ? ''
        : '${finnancetransModels[0].dateacc}';
    var cFinn_S = (numinvoice != '') ? numinvoice : numdoctax;
    Navigator.pop(context, 'OK');
    Future.delayed(Duration(milliseconds: 500), () async {
      // print('cFinn_S  ${cFinn_S}');
      // print('foder  ${foder}');
      // print('renTal_name   ${renTal_name}');
      // print('bill_addr  ${bill_addr}');
      // print('bill_email  ${bill_email}');
      // print('bill_tel   ${bill_tel}');
      // print('bill_tax  ${bill_tax}');
      // print('bill_name  ${bill_name}');
      // print('newValuePDFimg   ${newValuePDFimg}');
      // print(
      //     'TitleType_Default_Receipt_Name  ${TitleType_Default_Receipt_Name}');
      // print('tem_page_ser  ${tem_page_ser}');
      // print('bills_name_  ${bills_name_}');
      // print('numdoctax  ${numdoctax} /// numinvoice ${numinvoice}  ');
      ManPay_Receipt_PDF.ManPayReceipt_PDF(
          '${cFinn_S}',
          context,
          foder,
          renTal_name,
          // Form_nameshop,
          // Form_bussshop,
          // Form_address,
          // Form_tax,
          bill_addr,
          bill_email,
          bill_tel,
          bill_tax,
          bill_name,
          newValuePDFimg,
          TitleType_Default_Receipt_Name,
          tem_page_ser,
          bills_name_);
    });
    // if (tem_page_ser.toString() == '0' || tem_page_ser == null) {
    //   Pdfgen_his_statusbill.exportPDF_statusbill(
    //       foder,
    //       tableData00,
    //       tableData00,
    //       context,
    //       _TransReBillHistoryModels,
    //       'Num_cid',
    //       'Namenew',
    //       sum_pvat,
    //       sum_vat,
    //       sum_wht,
    //       sum_amt,
    //       sum_disp,
    //       sum_disamt,
    //       '${sum_amt - sum_disamt}',
    //       renTal_name,
    //       Form_bussscontact,
    //       Form_bussscontact,
    //       Form_address,
    //       Form_tax,
    //       bill_addr,
    //       bill_email,
    //       bill_tel,
    //       bill_tax,
    //       bill_name,
    //       newValuePDFimg,
    //       numinvoice,
    //       numdoctax,
    //       finnancetransModels,
    //       date_Transaction,
    //       date_pay,
    //       room_number_BillHistory,
    //       dis_sum_Matjum,
    //       TitleType_Default_Receipt_Name);
    // } else if (tem_page_ser.toString() == '1') {
    //   Pdfgen_his_statusbill_TP2.exportPDF_statusbill_TP2(
    //       foder,
    //       tableData00,
    //       tableData00,
    //       context,
    //       _TransReBillHistoryModels,
    //       'Num_cid',
    //       'Namenew',
    //       sum_pvat,
    //       sum_vat,
    //       sum_wht,
    //       sum_amt,
    //       sum_disp,
    //       sum_disamt,
    //       '${sum_amt - sum_disamt}',
    //       renTal_name,
    //       Form_bussscontact,
    //       Form_bussscontact,
    //       Form_address,
    //       Form_tax,
    //       bill_addr,
    //       bill_email,
    //       bill_tel,
    //       bill_tax,
    //       bill_name,
    //       newValuePDFimg,
    //       // numdoctax == '' ? '$numinvoice' : '$numdoctax',
    //       numinvoice,
    //       numdoctax,
    //       finnancetransModels,
    //       date_Transaction,
    //       date_pay,
    //       room_number_BillHistory,
    //       dis_sum_Matjum,
    //       TitleType_Default_Receipt_Name);
    // } else if (tem_page_ser.toString() == '2') {
    //   Pdfgen_his_statusbill_TP3.exportPDF_statusbill_TP3(
    //       foder,
    //       tableData00,
    //       tableData00,
    //       context,
    //       _TransReBillHistoryModels,
    //       'Num_cid',
    //       'Namenew',
    //       sum_pvat,
    //       sum_vat,
    //       sum_wht,
    //       sum_amt,
    //       sum_disp,
    //       sum_disamt,
    //       '${sum_amt - sum_disamt}',
    //       renTal_name,
    //       Form_bussscontact,
    //       Form_bussscontact,
    //       Form_address,
    //       Form_tax,
    //       bill_addr,
    //       bill_email,
    //       bill_tel,
    //       bill_tax,
    //       bill_name,
    //       newValuePDFimg,
    //       numinvoice,
    //       numdoctax,
    //       finnancetransModels,
    //       date_Transaction,
    //       date_pay,
    //       room_number_BillHistory,
    //       dis_sum_Matjum,
    //       TitleType_Default_Receipt_Name);
    // } else if (tem_page_ser.toString() == '3') {
    //   Pdfgen_his_statusbill_TP4.exportPDF_statusbill_TP4(
    //       foder,
    //       tableData00,
    //       tableData00,
    //       context,
    //       _TransReBillHistoryModels,
    //       'Num_cid',
    //       'Namenew',
    //       sum_pvat,
    //       sum_vat,
    //       sum_wht,
    //       sum_amt,
    //       sum_disp,
    //       sum_disamt,
    //       '${sum_amt - sum_disamt}',
    //       renTal_name,
    //       Form_bussscontact,
    //       Form_bussscontact,
    //       Form_address,
    //       Form_tax,
    //       bill_addr,
    //       bill_email,
    //       bill_tel,
    //       bill_tax,
    //       bill_name,
    //       newValuePDFimg,
    //       numinvoice,
    //       numdoctax,
    //       finnancetransModels,
    //       date_Transaction,
    //       date_pay,
    //       room_number_BillHistory,
    //       dis_sum_Matjum,
    //       TitleType_Default_Receipt_Name);
    // } else if (tem_page_ser.toString() == '4') {
    //   Pdfgen_his_statusbill_TP5.exportPDF_statusbill_TP5(
    //       foder,
    //       tableData00,
    //       tableData00,
    //       context,
    //       _TransReBillHistoryModels,
    //       'Num_cid',
    //       'Namenew',
    //       sum_pvat,
    //       sum_vat,
    //       sum_wht,
    //       sum_amt,
    //       sum_disp,
    //       sum_disamt,
    //       '${sum_amt - sum_disamt}',
    //       renTal_name,
    //       Form_bussscontact,
    //       Form_bussscontact,
    //       Form_address,
    //       Form_tax,
    //       bill_addr,
    //       bill_email,
    //       bill_tel,
    //       bill_tax,
    //       bill_name,
    //       newValuePDFimg,
    //       numinvoice,
    //       numdoctax,
    //       finnancetransModels,
    //       date_Transaction,
    //       date_pay,
    //       room_number_BillHistory,
    //       dis_sum_Matjum,
    //       TitleType_Default_Receipt_Name);
    // } else if (tem_page_ser.toString() == '5') {
    //   Pdfgen_his_statusbill_TP6.exportPDF_statusbill_TP6(
    //       foder,
    //       tableData00,
    //       tableData00,
    //       context,
    //       _TransReBillHistoryModels,
    //       'Num_cid',
    //       'Namenew',
    //       sum_pvat,
    //       sum_vat,
    //       sum_wht,
    //       sum_amt,
    //       sum_disp,
    //       sum_disamt,
    //       '${sum_amt - sum_disamt}',
    //       renTal_name,
    //       Form_bussscontact,
    //       Form_bussscontact,
    //       Form_address,
    //       Form_tax,
    //       bill_addr,
    //       bill_email,
    //       bill_tel,
    //       bill_tax,
    //       bill_name,
    //       newValuePDFimg,
    //       numinvoice,
    //       numdoctax,
    //       finnancetransModels,
    //       date_Transaction,
    //       date_pay,
    //       room_number_BillHistory,
    //       dis_sum_Matjum,
    //       TitleType_Default_Receipt_Name);
    // }
  }
}
