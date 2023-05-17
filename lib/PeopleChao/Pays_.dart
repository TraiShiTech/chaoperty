import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
// import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetContractf_Model.dart';
import '../Model/GetInvoice_Model.dart';
import '../Model/GetInvoice_history_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../PDF/pdf_Receipt.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class Pays extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  final namenew;
  final Screen_name;
  final Form_bussshop;
  final Form_address;
  final Form_tax;
  const Pays({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
    this.namenew,
    this.Screen_name,
    this.Form_bussshop,
    this.Form_address,
    this.Form_tax,
  });

  @override
  State<Pays> createState() => _PaysState();
}

class _PaysState extends State<Pays> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  List<TransBillModel> _TransBillModels = [];
  List<TransModel> _TransModels = [];
  List<TransReBillModel> _TransReBillModels = [];
  List<InvoiceModel> _InvoiceModels = [];
  List<InvoiceHistoryModel> _InvoiceHistoryModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<PayMentModel> _PayMentModels = [];
  List<RenTalModel> renTalModels = [];
  List<ContractfModel> contractfModels = [];
  List<TeNantModel> teNantModels = [];
  final sum_disamtx = TextEditingController();
  final sum_dispx = TextEditingController();
  final Form_payment1 = TextEditingController();
  final Form_payment2 = TextEditingController();
  final Form_time = TextEditingController();
  final Formbecause_ = TextEditingController();
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;
  int select_page = 0,
      pamentpage = 0; // = 0 _TransModels : = 1 _InvoiceHistoryModels

  String? numinvoice,
      paymentSer1,
      paymentName1,
      paymentSer2,
      paymentName2,
      cFinn,
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
      foder;

  String? bills_name_;
  String? name_slip, name_slip_ser;
  String? base64_Slip, fileName_Slip;
  var renTal_name;

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
      Form_qty,
      discount_;

  List Default_ = [
    'บิลธรรมดา',
  ];
  List Default2_ = [
    'บิลธรรมดา',
    'ใบกำกับภาษี',
  ];

  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  String? Slip_status;
  @override
  void initState() {
    super.initState();
    red_Trans_bill();
    red_Trans_select2();
    red_payMent();
    read_GC_rental();
    sum_disamtx.text = '0.00';
    Value_newDateY1 = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD1 = DateFormat('dd-MM-yyyy').format(newDatetime);
    Value_newDateY = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD = DateFormat('dd-MM-yyyy').format(newDatetime);
    GC_contractf();
    read_data();
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
      // print(result);
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
    if (widget.Screen_name.toString().trim() == 'ACSceen') {
      setState(() {
        Form_bussshop = widget.Form_bussshop.toString();
        Form_address = widget.Form_address.toString();
        Form_tax = widget.Form_tax.toString();
      });
    }
  }

  Future<Null> GC_contractf() async {
    if (contractfModels.length != 0) {
      contractfModels.clear();
    }
    setState(() {
      name_slip = null;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ser_user = preferences.getString('ser');
    String Namecid = '${widget.Get_Value_cid}';
    String url =
        '${MyConstant().domain}/GC_contractf.php?isAdd=true&ren=$ren&ser_user=$ser_user&namecid=$Namecid';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ContractfModel contractfModelss = ContractfModel.fromJson(map);
          setState(() {
            contractfModels.add(contractfModelss);
          });

          if (contractfModelss.cxname.toString() == 'slip') {
            name_slip = contractfModelss.filename.toString();
            name_slip_ser = contractfModelss.ser.toString();
          } else {}
        }

        print('00000000>>>>>>>>>>>>>>>>> ${contractfModels.length}');
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

              Form_payment1.text =
                  (sum_amt - sum_disamt).toStringAsFixed(2).toString();
            }
          });
        }

        if (paymentName1 == null) {
          paymentSer1 = 0.toString();
          paymentName1 = 'เลือก'.toString();

          Form_payment1.text =
              (sum_amt - sum_disamt).toStringAsFixed(2).toString();
        }
      }
    } catch (e) {}
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
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrr');
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
        '${MyConstant().domain}/GC_tran_pays.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser}';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransBillModel _TransBillModel = TransBillModel.fromJson(map);
          setState(() {
            if (_TransBillModel.invoice == null) {
              _TransBillModels.add(_TransBillModel);
            }
            // _TransBillModels.add(_TransBillModel);
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
        '${MyConstant().domain}/GC_tran_bill_All.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser}';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
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
        '${MyConstant().domain}/GC_bill_invoice.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser}';
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

  Future<Null> red_InvoiceC() async {
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
        '${MyConstant().domain}/GC_re_bill_invoice.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser}';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel _TransReBillModel = TransReBillModel.fromJson(map);
          setState(() {
            _TransReBillModels.add(_TransReBillModel);
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
      // print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        setState(() {
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrrfalse');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
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
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        setState(() {
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrrfalse');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
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
      // print(result);
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

      setState(() {
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      });
    } catch (e) {}
  }

  Future<Null> red_Trans_select_re(index) async {
    if (_TransReBillHistoryModels.length != 0) {
      setState(() {
        _TransReBillHistoryModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        sum_disamt = 0;
        sum_disp = 0; //_TransReBillModels
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var docnoin = _TransReBillModels[index].docno;

    print(
        'BBBBBBBBBBBB/... $docnoin == $ciddoc  ${_TransReBillHistoryModels.length}');

    String url =
        '${MyConstant().domain}/GC_re_bill_invoice_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        print('result1111');
        for (var map in result) {
          print('result2222');
          TransReBillHistoryModel _TransReBillHistoryModel =
              TransReBillHistoryModel.fromJson(map);

          var sum_pvatx = double.parse(_TransReBillHistoryModel.pvat!);
          var sum_vatx = double.parse(_TransReBillHistoryModel.vat!);
          var sum_whtx = double.parse(_TransReBillHistoryModel.wht!);
          var sum_amtx = double.parse(_TransReBillHistoryModel.total!);
          var sum_disamtx = _TransReBillHistoryModel.disend == null
              ? 0.00
              : double.parse(_TransReBillHistoryModel.disend!);
          var sum_dispx = _TransReBillHistoryModel.disendbillper == null
              ? 0.00
              : double.parse(_TransReBillHistoryModel.disendbillper!);
          print('${_TransReBillHistoryModel.name}');
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_disamt = sum_disamtx;
            sum_disp = sum_dispx;
            numinvoice = _TransReBillHistoryModel.docno;
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          });
        }
        print(_TransReBillHistoryModels.length);
      } else if (result.toString() == 'false') {
        print('result1111');
        for (var map in result) {
          print('result2222');
          TransReBillHistoryModel _TransReBillHistoryModel =
              TransReBillHistoryModel.fromJson(map);

          var sum_pvatx = double.parse(_TransReBillHistoryModel.pvat!);
          var sum_vatx = double.parse(_TransReBillHistoryModel.vat!);
          var sum_whtx = double.parse(_TransReBillHistoryModel.wht!);
          var sum_amtx = double.parse(_TransReBillHistoryModel.total!);
          var sum_disamtx = _TransReBillHistoryModel.disend == null
              ? 0.00
              : double.parse(_TransReBillHistoryModel.disend!);
          var sum_dispx = _TransReBillHistoryModel.disendbillper == null
              ? 0.00
              : double.parse(_TransReBillHistoryModel.disendbillper!);
          print('${_TransReBillHistoryModel.name}');
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_disamt = sum_disamtx;
            sum_disp = sum_dispx;
            numinvoice = _TransReBillHistoryModel.docno;
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          });
        }
        print(_TransReBillHistoryModels.length);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
      }

      setState(() {
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                style:
                    TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      );
    }
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
      // print(result);
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
      } else if (result.toString() == 'false') {
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
      }

      setState(() {
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                style:
                    TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      );
    }
  }

  Future<Null> red_Trans_selectde() async {
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
    var docnoin = numinvoice;

    print('object11');

    String url =
        '${MyConstant().domain}/GC_bill_invoice_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      print('object22');
      if (result.toString() != 'null') {
        print('object33');
        for (var map in result) {
          print('object44');
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
      setState(() {
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      });
    } catch (e) {}
  }

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
/////////----------------------------------------------------------->
  var extension_;
  var file_;
  Future<void> uploadFile_Slip() async {
    // InsertFile_SQL(fileName, MixPath_);
    // Open the file picker and get the selected file
    final input = html.FileUploadInputElement();
    // input..accept = 'application/pdf';
    input.accept = 'image/jpeg,image/png,image/jpg';
    input.click();
    // deletedFile_('IDcard_LE000001_25-02-2023.pdf');
    await input.onChange.first;

    final file = input.files!.first;
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;
    String fileName_ = file.name;
    String extension = fileName_.split('.').last;
    print('File name: $fileName_');
    print('Extension: $extension');
    setState(() {
      base64_Slip = base64Encode(reader.result as Uint8List);
    });
    print(base64_Slip);
    setState(() {
      extension_ = extension;
      file_ = file;
    });
    // OKuploadFile_Slip(extension, file);
  }

  Future<void> OKuploadFile_Slip() async {
    if (base64_Slip != null) {
      String Path_foder = 'slip';
      String dateTimeNow = DateTime.now().toString();
      String date = DateFormat('ddMMyyyy')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      final formatter2 = DateFormat('HHmmss');
      final formattedTime2 = formatter2.format(dateTimeNow2);
      String Time_ = formattedTime2.toString();
      setState(() {
        fileName_Slip =
            'slip_${widget.Get_Value_cid}_${date}_$Time_.$extension_';
      });
      // String fileName = 'slip_${widget.Get_Value_cid}_${date}_$Time_.$extension_';
      // InsertFile_SQL(fileName, MixPath_, formattedTime1);
      // Create a new FormData object and add the file to it
      final formData = html.FormData();
      formData.appendBlob('file', file_, fileName_Slip);
      // Send the request
      final request = html.HttpRequest();
      request.open('POST',
          '${MyConstant().domain}/File_uploadSlip.php?name=$fileName_Slip&Foder=$foder&Pathfoder=$Path_foder');
      request.send(formData);
      print(formData);

      // Handle the response
      await request.onLoad.first;

      if (request.status == 200) {
        print('File uploaded successfully!');
      } else {
        print('File upload failed with status code: ${request.status}');
      }
    } else {
      print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

  // Future<void> downloadImage(String imageUrl) async {
  //   final response =
  //       await HttpRequest.request('$imageUrl', responseType: 'blob');
  //   final blob = response.response as Blob;
  //   final url = Url.createObjectUrlFromBlob(blob);
  //   final anchor = document.createElement('a') as AnchorElement;
  //   anchor.href = url;
  //   anchor.download = 'image.jpg'; // Set the filename
  //   anchor.click();
  //   Url.revokeObjectUrl(url);
  // }

  // Future<void> downloadImage2() async {
  //   try {
  //     // final imageUrl =
  //     //     'https://dzentric.com/chao_perty/chao_api/files/kad_taii/slip/slip_LE000001_28022023_142945.jpg';
  //     final imageUrl = 'https://picsum.photos/200';
  //     final response =
  //         await html.HttpRequest.request(imageUrl, responseType: 'blob');
  //     final blob = response.response as html.Blob;
  //     final url = html.Url.createObjectUrlFromBlob(blob);
  //     final anchor = html.document.createElement('a') as html.AnchorElement;
  //     anchor.href = url;
  //     anchor.download = 'download.jpg'; // Set the filename
  //     anchor.click();
  //     html.Url.revokeObjectUrl(url);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> downloadImage2() async {
  //   // final proxyUrl = 'https://your-proxy-server.com/proxy';
  //   // final targetUrl = 'https://target-server.com/data';

  //   // final response = await http.get(Uri.parse('$proxyUrl/$targetUrl'));
  //   const _url =
  //       'https://dzentric.com/chao_perty/chao_api/files/kad_taii/slip/slip_LE000001_28022023_142945.jpg';
  //   await WebImageDownloader.downloadImageFromWeb(
  //     _url,
  //     name: 'image01',
  //     imageType: ImageType.png,
  //   );
  // }
  Future<void> _showMyDialogPay_Error(text) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$text',
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
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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

  ///----------------->
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: (Responsive.isDesktop(context))
                        ? MediaQuery.of(context).size.width / 3.5
                        : 600,
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
                                  sum_disamtx.text = '0.00';
                                  sum_dispx.text = '0.00';
                                  sum_pvat = 0.00;
                                  sum_vat = 0.00;
                                  sum_wht = 0.00;
                                  sum_amt = 0.00;
                                  sum_dis = 0.00;
                                  sum_disamt = 0.00;
                                  sum_disp = 0;
                                  select_page = 0;
                                  red_Trans_bill();
                                  Form_payment1.text = (sum_amt - sum_disamt)
                                      .toStringAsFixed(2)
                                      .toString();
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
                                    'รายการยังไม่วางบิล',
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
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _InvoiceModels.clear();
                                  _InvoiceHistoryModels.clear();
                                  _TransReBillHistoryModels.clear();
                                  sum_disamtx.text = '0.00';
                                  sum_dispx.text = '0.00';
                                  sum_pvat = 0.00;
                                  sum_vat = 0.00;
                                  sum_wht = 0.00;
                                  sum_amt = 0.00;
                                  sum_dis = 0.00;
                                  sum_disamt = 0.00;
                                  sum_disp = 0;
                                  deall_Trans_select();
                                  red_Invoice();
                                  select_page = 1;
                                  numinvoice = null;
                                  Form_payment1.text = (sum_amt - sum_disamt)
                                      .toStringAsFixed(2)
                                      .toString();
                                });
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.orange[200],
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
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
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
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ),
                          ),
                          select_page == 0
                              ? Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.027,
                                          color: Colors.brown[200],
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Center(
                                              child: Icon(Icons.chevron_right)),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Expanded(
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
                                        'เลขตั้งหนี้',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                  )),
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
                        child: select_page == 0
                            ? ListView.builder(
                                // controller: _scrollController1,
                                // itemExtent: 50,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _TransBillModels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Material(
                                    color: (_TransModels.any((A) =>
                                                A.docno ==
                                                _TransBillModels[index]
                                                    .docno) &&
                                            _TransModels.any((A) =>
                                                A.date ==
                                                _TransBillModels[index].date))
                                        ? tappedIndex_Color.tappedIndex_Colors
                                        : null,
                                    child: InkWell(
                                      onTap: () {},
                                      child: ListTile(
                                        onTap: () {
                                          print(
                                              '${_TransBillModels[index].ser} ${_TransBillModels[index].docno}');

                                          in_Trans_select(index);
                                        },
                                        title: Container(
                                          //_TransModelsdocno
                                          // color: (_TransModels.any((A) =>
                                          //             A.docno ==
                                          //             _TransBillModels[index]
                                          //                 .docno) &&
                                          //         _TransModels.any((A) =>
                                          //             A.date ==
                                          //             _TransBillModels[index]
                                          //                 .date))
                                          //     ? tappedIndex_Color
                                          //         .tappedIndex_Colors
                                          //     : null,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 25,
                                                  maxLines: 1,
                                                  _TransBillModels[index]
                                                              .descr ==
                                                          null
                                                      ? '${_TransBillModels[index].expname}'
                                                      : '${_TransBillModels[index].descr}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 25,
                                                  maxLines: 1,
                                                  '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index].date} 00:00:00').year + 543}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
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
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 25,
                                                  maxLines: 1,
                                                  _TransBillModels[index]
                                                              .invoice ==
                                                          null
                                                      ? '${_TransBillModels[index].docno}'
                                                      : '${_TransBillModels[index].invoice}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : select_page == 1
                                ? ListView.builder(
                                    // controller: _scrollController1,
                                    // itemExtent: 50,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _InvoiceModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Material(
                                        color: (_InvoiceModels[index]
                                                    .docno
                                                    .toString() ==
                                                numinvoice.toString())
                                            ? tappedIndex_Color
                                                .tappedIndex_Colors
                                            : null,
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            onTap: () {
                                              print(
                                                  '${_InvoiceModels[index].ser} ${_InvoiceModels[index].docno}');

                                              red_Trans_select(index);
                                            },
                                            title: Container(
                                              // color: (_InvoiceModels[index]
                                              //             .docno
                                              //             .toString() ==
                                              //         numinvoice.toString())
                                              //     ? tappedIndex_Color
                                              //         .tappedIndex_Colors
                                              //     : null,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${_InvoiceModels[index].descr}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${DateFormat('dd-MM').format(DateTime.parse('${_InvoiceModels[index].date} 00:00:00'))}-${DateTime.parse('${_InvoiceModels[index].date} 00:00:00').year + 543}',
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
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${_InvoiceModels[index].docno}',
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    // controller: _scrollController1,
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
                                                numinvoice.toString())
                                            ? tappedIndex_Color
                                                .tappedIndex_Colors
                                            : null,
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            onTap: () {
                                              print(
                                                  '${_TransReBillModels[index].ser} ${_TransReBillModels[index].docno}');

                                              red_Trans_select_re(index);
                                            },
                                            title: Container(
                                              color: (_TransReBillModels[index]
                                                          .docno
                                                          .toString() ==
                                                      numinvoice.toString())
                                                  ? tappedIndex_Color
                                                      .tappedIndex_Colors
                                                  : null,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${_TransReBillModels[index].expname}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${_TransReBillModels[index].date}',
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
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${_TransReBillModels[index].docno}',
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                      Container(
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width / 3.5
                              : 600,
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
                                                onTap: () {},
                                                child: Container(
                                                  width: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.green,
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
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'เพิ่มใหม่',
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
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (select_page != 0)
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                            ),
                                          ),
                                        if (select_page == 0)
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
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
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
                                                            fontFamily:
                                                                Font_.Fonts_T),
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
                                                    _InvoiceModels.clear();
                                                    _InvoiceHistoryModels
                                                        .clear();
                                                    _TransReBillHistoryModels
                                                        .clear();
                                                    sum_disamtx.text = '0.00';
                                                    sum_dispx.text = '0.00';
                                                    sum_pvat = 0.00;
                                                    sum_vat = 0.00;
                                                    sum_wht = 0.00;
                                                    sum_amt = 0.00;
                                                    sum_dis = 0.00;
                                                    sum_disamt = 0.00;
                                                    sum_disp = 0;
                                                    deall_Trans_select();
                                                    red_InvoiceC();
                                                    select_page = 2;
                                                    numinvoice = null;
                                                  });
                                                },
                                                child: Container(
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
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
                                                    // border: Border.all(color: Colors.white, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Center(
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'ใบเสร็จชั่วคราว',
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
              select_page == 0
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.52
                              : 600,
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
                                        'จำนวน',
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
                                        'หน่วย',
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
                                              '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransModels[index].date} 00:00:00'))}', //${_TransModels[index].date}
                                              textAlign: TextAlign.start,
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
                                              textAlign: TextAlign.start,
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
                                              '${_TransModels[index].tqty}',
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
                                              '${_TransModels[index].unit_con}',
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
                                              '${_TransModels[index].vat}',
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
                                              '${nFormat.format(double.parse(_TransModels[index].wht!))}',
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
                                              '${nFormat.format(double.parse(_TransModels[index].total!))}',
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
                                width: (Responsive.isDesktop(context))
                                    ? MediaQuery.of(context).size.width * 0.52
                                    : 600,
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                                            TextInputType
                                                                .number,
                                                        controller: sum_dispx,
                                                        onChanged:
                                                            (value) async {
                                                          var valuenum =
                                                              double.parse(
                                                                  value);
                                                          var sum = ((sum_amt *
                                                                  valuenum) /
                                                              100);

                                                          setState(() {
                                                            discount_ =
                                                                '${valuenum.toString()}';
                                                            sum_dis = sum;
                                                            sum_disamt = sum;
                                                            sum_disamtx.text =
                                                                sum.toString();
                                                            Form_payment1
                                                                .text = (sum_amt -
                                                                    sum_disamt)
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString();
                                                          });

                                                          print(
                                                              'sum_dis $sum_dis   /////// ${valuenum.toString()}');
                                                        },
                                                        cursorColor:
                                                            Colors.black,
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
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5),
                                                                    bottomLeft:
                                                                        Radius.circular(
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
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5),
                                                                    bottomLeft:
                                                                        Radius.circular(
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
                                                                            Font_.Fonts_T)),
                                                        inputFormatters: <
                                                            TextInputFormatter>[
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
                                                    controller: sum_disamtx,
                                                    onChanged: (value) async {
                                                      var valuenum =
                                                          double.parse(value);

                                                      setState(() {
                                                        sum_dis = valuenum;
                                                        sum_disamt = valuenum;

                                                        // sum_disamt.text =
                                                        //     nFormat.format(sum_disamt);
                                                        sum_dispx.clear();
                                                        Form_payment1
                                                            .text = (sum_amt -
                                                                sum_disamt)
                                                            .toStringAsFixed(2)
                                                            .toString();
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
                                                          borderSide:
                                                              BorderSide(
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
                                                          borderSide:
                                                              BorderSide(
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
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r'[0-9 .]')),
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
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  textAlign: TextAlign.end,
                                                  '${nFormat.format(sum_amt - double.parse(sum_disamtx.text))}',
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                    )
                  : select_page == 1
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.52
                                  : 600,
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
                                        ? const SizedBox()
                                        : Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.orange[100],

                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'เลขที่ใบแจ้งหนี้ $numinvoice',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
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
                                            'กำหนดชำระ',
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
                                            'จำนวน',
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
                                            'หน่วย',
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
                                    //         'ยอดสุทธิรวม Vat',
                                    //         textAlign: TextAlign.center,
                                    //         style: TextStyle(
                                    //             color: PeopleChaoScreen_Color
                                    //                 .Colors_Text1_,
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
                                            'X',
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
                                    // controller: _scrollController2,
                                    // itemExtent: 50,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _InvoiceHistoryModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Material(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
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
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_InvoiceHistoryModels[index].date} 00:00:00'))}', //${_InvoiceHistoryModels[index].date}
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
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
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${_InvoiceHistoryModels[index].descr}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_InvoiceHistoryModels[index].qty!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_InvoiceHistoryModels[index].nvat!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_InvoiceHistoryModels[index].vat!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_InvoiceHistoryModels[index].wht!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              // Expanded(
                                              //   flex: 1,
                                              //   child: AutoSizeText(
                                              //     minFontSize: 10,
                                              //     maxFontSize: 15,
                                              //     maxLines: 1,
                                              //     '${nFormat.format(double.parse(_InvoiceHistoryModels[index].pvat!))}',
                                              //     textAlign: TextAlign.end,
                                              //     style: const TextStyle(
                                              //         color:
                                              //             PeopleChaoScreen_Color
                                              //                 .Colors_Text2_,
                                              //         //fontWeight: FontWeight.bold,
                                              //         fontFamily: Font_.Fonts_T),
                                              //   ),
                                              // ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_InvoiceHistoryModels[index].amt!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Center(
                                                  child: Container(
                                                      // height: 50,
                                                      // color: Colors.brown[200],
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            confirmOrderdelete(
                                                                index);
                                                          },
                                                          icon: const Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.red,
                                                          ))),
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
                                        ? MediaQuery.of(context).size.width *
                                            0.52
                                        : 600,
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
                                          (_InvoiceHistoryModels.length > 0)
                                              ? MainAxisAlignment.spaceBetween
                                              : MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (_InvoiceHistoryModels.length > 0)
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        confirmOrderdelete('');
                                                      },
                                                      child: const Text(
                                                        'ลบทั้งหมด',
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
                                          ),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                          width: 60,
                                                          height: 20,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            '$sum_disp  %',
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
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      textAlign: TextAlign.end,
                                                      '${nFormat.format(sum_amt - sum_disamt)}',
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.52
                                  : 600,
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
                                            'รายละเอียดบิลใบเสร็จชั่วคราว',
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
                                        ? const SizedBox()
                                        : Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.orange[100],

                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'เลขที่ใบแจ้งหนี้ $numinvoice',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
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
                                            'กำหนดชำระ',
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
                                            'จำนวน',
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
                                            'หน่วย',
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
                                            'Vat',
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
                                            'ราคารวม',
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
                                            'ราคารวม Vat',
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
                                    //         'X',
                                    //         textAlign: TextAlign.center,
                                    //         style: TextStyle(
                                    //             color: PeopleChaoScreen_Color
                                    //                 .Colors_Text1_,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontFamily: FontWeight_.Fonts_T
                                    //             //fontSize: 10.0
                                    //             //fontSize: 10.0
                                    //             ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
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
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _TransReBillHistoryModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Material(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
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
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${_TransReBillHistoryModels[index].date}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
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
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${_TransReBillHistoryModels[index].expname}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].tqty!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].nvat!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].vat!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].pvat!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              // Expanded(
                                              //   flex: 1,
                                              //   child: Container(
                                              //       // height: 50,
                                              //       // color: Colors.brown[200],
                                              //       padding:
                                              //           const EdgeInsets.all(8.0),
                                              //       child: IconButton(
                                              //           onPressed: () {
                                              //             // confirmOrderdelete(index);
                                              //           },
                                              //           icon: Icon(Icons
                                              //               .remove_circle_outline))),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                    width: (Responsive.isDesktop(context))
                                        ? MediaQuery.of(context).size.width *
                                            0.52
                                        : 600,
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                          width: 60,
                                                          height: 20,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            '$sum_disp  %',
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
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      textAlign: TextAlign.end,
                                                      '${nFormat.format(sum_amt - sum_disamt)}',
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
        ),
        Align(
          alignment: Alignment.bottomRight,
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
                                        ? 'เลขที่ใบแจ้งหนี้'
                                        : 'เลขที่ใบแจ้งหนี้ $numinvoice',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
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
                                height: 50,
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                    'ยอดชำระรวม',
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
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 50,
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    // '${nFormat.format(sum_amt - sum_disamt)}',
                                    '${nFormat.format(sum_amt - sum_disamt)}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
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
                                height: 50,
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      const Text(
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
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            Form_payment1.clear();
                                            Form_payment2.clear();
                                            Form_payment1.text = '';
                                            Form_payment2.text = '';
                                          });
                                          setState(() {
                                            if (pamentpage == 1) {
                                              pamentpage = 0;
                                              // Form_payment2.clear();
                                              // Form_payment1.text = (sum_amt -
                                              //         double.parse(
                                              //             sum_disamtx.text))
                                              //     .toStringAsFixed(2)
                                              //     .toString();
                                            } else {
                                              pamentpage = 1;
                                            }
                                          });
                                          if (pamentpage == 0) {
                                            setState(() {
                                              paymentName2 = null;
                                            });
                                          } else {}
                                        },
                                        icon: pamentpage == 0
                                            ? Icon(
                                                Icons.add_circle_outline,
                                                color: Colors.green,
                                              )
                                            : const Icon(
                                                Icons.remove_circle_outline,
                                                color: Colors.red,
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                        // border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
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
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ],
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black45,
                                        ),
                                        iconSize: 25,
                                        buttonHeight: 42,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        items: _PayMentModels.map((item) =>
                                            DropdownMenuItem<String>(
                                              value:
                                                  '${item.ser}:${item.ptname}',
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${item.ptname!}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '${item.bno!}',
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
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
                                            paymentSer1 = rtnameSer.toString();

                                            if (rtnameSer.toString() == '0') {
                                              paymentName1 = null;
                                            } else {
                                              paymentName1 =
                                                  rtnameName.toString();
                                            }
                                            if (rtnameSer.toString() == '0') {
                                              Form_payment1.clear();
                                            } else {
                                              Form_payment1.text =
                                                  (sum_amt - sum_disamt)
                                                      .toStringAsFixed(2)
                                                      .toString();
                                            }
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
                                  pamentpage == 0
                                      ? const SizedBox()
                                      : Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(6),
                                                bottomRight: Radius.circular(6),
                                              ),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
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
                                                  const Text(
                                                    'เลือก',
                                                    style: TextStyle(
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
                                              items: _PayMentModels.map(
                                                  (item) =>
                                                      DropdownMenuItem<String>(
                                                        value:
                                                            '${item.ser}:${item.ptname}',
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '${item.ptname!}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    fontSize: 14,
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${item.bno!}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: const TextStyle(
                                                                    fontSize: 14,
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )).toList(),
                                              onChanged: (value) async {
                                                // Do something when changing the item if you want.

                                                var zones = value!.indexOf(':');
                                                var rtnameSer =
                                                    value.substring(0, zones);
                                                var rtnameName =
                                                    value.substring(zones + 1);
                                                print(
                                                    'mmmmm ${rtnameSer.toString()} $rtnameName');
                                                setState(() {
                                                  paymentSer2 =
                                                      rtnameSer.toString();

                                                  if (rtnameSer.toString() ==
                                                      '0') {
                                                    paymentName2 = null;
                                                  } else {
                                                    paymentName2 =
                                                        rtnameName.toString();
                                                  }
                                                  if (rtnameSer.toString() ==
                                                      '0') {
                                                    Form_payment2.clear();
                                                  } else {
                                                    Form_payment2.text =
                                                        (sum_amt - sum_disamt)
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                  }
                                                });

                                                print(
                                                    'pppppp $paymentSer2 $paymentName2');
                                              },
                                              // onSaved: (value) {

                                              // },
                                            ),
                                          ),
                                        ),
                                ],
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
                                child: const Center(
                                  child: Text(
                                    'จำนวนเงิน',
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
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                        // border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: Form_payment1,
                                        // onChanged: (value) {
                                        //   setState(() {});
                                        // },
                                        onChanged: (value) {
                                          // var money1 = double.parse(value);
                                          // var money2 = (sum_amt - sum_disamt);
                                          // var money3 = (money2 - money1)
                                          //     .toStringAsFixed(2)
                                          //     .toString();
                                          // setState(() {
                                          //   if (paymentSer2 == null) {
                                          //     Form_payment1.text = (money1)
                                          //         .toStringAsFixed(2)
                                          //         .toString();
                                          //   } else {
                                          //     Form_payment1.text = (money1)
                                          //         .toStringAsFixed(2)
                                          //         .toString();
                                          //     Form_payment2.text = money3;
                                          //   }
                                          // });
                                          // setState(() {
                                          //   Form_payment1.text = value;
                                          // });
                                          final currentCursorPosition =
                                              Form_payment1.selection.start;

                                          // Update the text of the controller
                                          if (paymentSer2 != null) {
                                            setState(() {
                                              Form_payment2.text =
                                                  '${(sum_amt - sum_disamt) - double.parse(value)}';
                                            });
                                          }

                                          // Set the new cursor position
                                          final newCursorPosition =
                                              currentCursorPosition +
                                                  (value.length -
                                                      Form_payment1
                                                          .text.length);
                                          Form_payment1.selection =
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset:
                                                          newCursorPosition));
                                        },
                                        onFieldSubmitted: (value) {
                                          var money1 = double.parse(value);
                                          var money2 = (sum_amt - sum_disamt);
                                          var money3 = (money2 - money1)
                                              .toStringAsFixed(2)
                                              .toString();
                                          setState(() {
                                            if (paymentSer2 == null) {
                                              Form_payment1.text = (money1)
                                                  .toStringAsFixed(2)
                                                  .toString();
                                            } else {
                                              Form_payment1.text = (money1)
                                                  .toStringAsFixed(2)
                                                  .toString();
                                              Form_payment2.text = money3;
                                            }
                                          });
                                        },
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
                                            // labelText: 'ระบุอายุสัญญา',
                                            labelStyle: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T)),
                                        inputFormatters: <TextInputFormatter>[
                                          // for below version 2 use this
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9 .]')),
                                          // for version 2 and greater youcan also use this
                                          // FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                  ),
                                  pamentpage == 0
                                      ? const SizedBox()
                                      : Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(6),
                                                bottomRight: Radius.circular(6),
                                              ),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: Form_payment2,
                                              // onChanged: (value) {
                                              //   setState(() {});
                                              // },
                                              onChanged: (value) {
                                                // var money1 =
                                                //     double.parse(value);
                                                // var money2 =
                                                //     (sum_amt - sum_disamt);
                                                // var money3 = (money2 - money1)
                                                //     .toStringAsFixed(2)
                                                //     .toString();
                                                // setState(() {
                                                //   if (paymentSer1 == null) {
                                                //     Form_payment2.text =
                                                //         (money1)
                                                //             .toStringAsFixed(2)
                                                //             .toString();
                                                //   } else {
                                                //     Form_payment2.text =
                                                //         (money1)
                                                //             .toStringAsFixed(2)
                                                //             .toString();
                                                //     Form_payment1.text = money3;
                                                //   }
                                                // });
                                                // setState(() {
                                                //   Form_payment2.text = value;
                                                // });
                                                final currentCursorPosition =
                                                    Form_payment2
                                                        .selection.start;

                                                // Update the text of the controller
                                                if (paymentSer1 != null) {
                                                  setState(() {
                                                    Form_payment1.text =
                                                        '${(sum_amt - sum_disamt) - double.parse(value)}';
                                                  });
                                                }

                                                // Set the new cursor position
                                                final newCursorPosition =
                                                    currentCursorPosition +
                                                        (value.length -
                                                            Form_payment2
                                                                .text.length);
                                                Form_payment2.selection =
                                                    TextSelection.fromPosition(
                                                        TextPosition(
                                                            offset:
                                                                newCursorPosition));
                                              },
                                              onFieldSubmitted: (value) {
                                                var money1 =
                                                    double.parse(value);
                                                var money2 =
                                                    (sum_amt - sum_disamt);
                                                var money3 = (money2 - money1)
                                                    .toStringAsFixed(2)
                                                    .toString();
                                                setState(() {
                                                  if (paymentSer1 == null) {
                                                    Form_payment2.text =
                                                        (money1)
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                  } else {
                                                    Form_payment2.text =
                                                        (money1)
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                    Form_payment1.text = money3;
                                                  }
                                                });
                                              },
                                              // maxLength: 13,
                                              cursorColor: Colors.green,
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
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  // labelText: 'ระบุอายุสัญญา',
                                                  labelStyle: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T)),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                // for below version 2 use this
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9 .]')),
                                                // for version 2 and greater youcan also use this
                                                // FilteringTextInputFormatter.digitsOnly
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Center(
                                        child: Text(
                                          'วันที่ทำรายการ',
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
                                  Expanded(
                                    child: Container(
                                        height: 50,
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            // color: Colors.green,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              DateTime? newDate =
                                                  await showDatePicker(
                                                locale:
                                                    const Locale('th', 'TH'),
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now().add(
                                                    const Duration(days: -50)),
                                                lastDate: DateTime.now().add(
                                                    const Duration(days: 365)),
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          const ColorScheme
                                                              .light(
                                                        primary: AppBarColors
                                                            .ABar_Colors, // header background color
                                                        onPrimary: Colors
                                                            .white, // header text color
                                                        onSurface: Colors
                                                            .black, // body text color
                                                      ),
                                                      textButtonTheme:
                                                          TextButtonThemeData(
                                                        style: TextButton
                                                            .styleFrom(
                                                          primary: Colors
                                                              .black, // button text color
                                                        ),
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (newDate == null) {
                                                return;
                                              } else {
                                                String start =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(newDate);
                                                String end =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(newDate);

                                                print('$start $end');
                                                setState(() {
                                                  Value_newDateY1 = start;
                                                  Value_newDateD1 = end;
                                                });
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: AutoSizeText(
                                                Value_newDateD1 == ''
                                                    ? 'เลือกวันที่'
                                                    : '$Value_newDateD1',
                                                minFontSize: 16,
                                                maxFontSize: 20,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Center(
                                        child: Text(
                                          'วันที่ชำระ',
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
                                  Expanded(
                                    child: Container(
                                        height: 50,
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            // color: Colors.green,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              DateTime? newDate =
                                                  await showDatePicker(
                                                locale:
                                                    const Locale('th', 'TH'),
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now().add(
                                                    const Duration(days: -50)),
                                                lastDate: DateTime.now().add(
                                                    const Duration(days: 365)),
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          const ColorScheme
                                                              .light(
                                                        primary: AppBarColors
                                                            .ABar_Colors, // header background color
                                                        onPrimary: Colors
                                                            .white, // header text color
                                                        onSurface: Colors
                                                            .black, // body text color
                                                      ),
                                                      textButtonTheme:
                                                          TextButtonThemeData(
                                                        style: TextButton
                                                            .styleFrom(
                                                          primary: Colors
                                                              .black, // button text color
                                                        ),
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (newDate == null) {
                                                return;
                                              } else {
                                                String start =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(newDate);
                                                String end =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(newDate);

                                                print('$start $end');
                                                setState(() {
                                                  Value_newDateY = start;
                                                  Value_newDateD = end;
                                                });
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: AutoSizeText(
                                                Value_newDateD == ''
                                                    ? 'เลือกวันที่'
                                                    : '$Value_newDateD',
                                                minFontSize: 16,
                                                maxFontSize: 20,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //  print(
                        //                 'mmmmm ${rtnameSer.toString()} $rtnameName');
                        //             print(
                        //                 'pppppp $paymentSer1 $paymentName1');
                        if (paymentName1.toString().trim() == 'เงินโอน' ||
                            paymentName2.toString().trim() == 'เงินโอน')
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 50,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Center(
                                    child: Text(
                                      ' เวลา/หลักฐาน',
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
                              Expanded(
                                flex: 4,
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                              ),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            // padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: Form_time,
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              // maxLength: 13,
                                              cursorColor: Colors.green,
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
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  hintText: '00:00:00',
                                                  // helperText: '00:00:00',
                                                  // labelText: '00:00:00',
                                                  labelStyle: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T)),

                                              inputFormatters: [
                                                MaskedInputFormatter(
                                                    '##:##:##'),
                                                // FilteringTextInputFormatter.allow(
                                                //     RegExp(r'[0-9]')),
                                              ],
                                              // inputFormatters: <TextInputFormatter>[
                                              //   // for below version 2 use this
                                              //   FilteringTextInputFormatter.allow(
                                              //       RegExp(r'[0-9 .]')),
                                              //   // for version 2 and greater youcan also use this
                                              //   // FilteringTextInputFormatter.digitsOnly
                                              // ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              (base64_Slip == null)
                                                  ? uploadFile_Slip()
                                                  : showDialog<void>(
                                                      context: context,
                                                      barrierDismissible:
                                                          false, // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0))),
                                                          title: const Center(
                                                              child: Text(
                                                            'มีไฟล์ slip อยู่แล้ว',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          )),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: ListBody(
                                                              children: const <
                                                                  Widget>[
                                                                Text(
                                                                  'มีไฟล์ slip อยู่แล้ว หากต้องการอัพโหลดกรุณาลบไฟล์ที่มีอยู่แล้วก่อน',
                                                                  style: TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Container(
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              Colors.red[600],
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
                                                                          'ลบไฟล์',
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text3_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ))),
                                                                    onTap:
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        base64_Slip =
                                                                            null;
                                                                      });
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Container(
                                                                        width: 100,
                                                                        decoration: const BoxDecoration(
                                                                          color:
                                                                              Colors.black,
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
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text3_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ))),
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                'เพิ่มไฟล์',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
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
                        if (paymentName1.toString().trim() == 'เงินโอน' ||
                            paymentName2.toString().trim() == 'เงินโอน')
                          Container(
                            decoration: const BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                              // border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            (base64_Slip != null)
                                                ? 'สถานะหลักฐาน : เลือกไฟล์แล้ว '
                                                : 'สถานะหลักฐาน : ยังไม่ได้เลือกไฟล์',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: (base64_Slip != null)
                                                    ? Colors.green[600]
                                                    : Colors.red[600],
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(2.0),
                                        //   child: Text(
                                        //     (base64_Slip != null) ? '$base64_Slip' : '',
                                        //     textAlign: TextAlign.start,
                                        //     style: TextStyle(
                                        //         color: Colors.blue[600],
                                        //         fontWeight: FontWeight.bold,
                                        //         fontFamily: FontWeight_.Fonts_T,
                                        //         fontSize: 10.0),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () async {
                                      // String Url =
                                      //     await '${MyConstant().domain}/files/kad_taii/slip/$name_slip';
                                      // print(Url);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: Center(
                                              child: Text(
                                                '${widget.Get_Value_cid}',
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontSize: 12.0),
                                              ),
                                            ),
                                            content: Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Image.memory(
                                                  base64Decode(
                                                      base64_Slip.toString()),
                                                  // height: 200,
                                                  // fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.all(8.0),
                                                  //   child: Container(
                                                  //     width: 100,
                                                  //     decoration: const BoxDecoration(
                                                  //       color: Colors.green,
                                                  //       borderRadius:
                                                  //           BorderRadius.only(
                                                  //               topLeft: Radius
                                                  //                   .circular(10),
                                                  //               topRight:
                                                  //                   Radius.circular(
                                                  //                       10),
                                                  //               bottomLeft:
                                                  //                   Radius.circular(
                                                  //                       10),
                                                  //               bottomRight:
                                                  //                   Radius.circular(
                                                  //                       10)),
                                                  //     ),
                                                  //     padding:
                                                  //         const EdgeInsets.all(8.0),
                                                  //     child: TextButton(
                                                  //       onPressed: () async {
                                                  //         // downloadImage2();
                                                  //         // downloadImage(Url);
                                                  //         // Navigator.pop(
                                                  //         //     context, 'OK');
                                                  //       },
                                                  //       child: const Text(
                                                  //         'ดาวน์โหลด',
                                                  //         style: TextStyle(
                                                  //             color: Colors.white,
                                                  //             fontWeight:
                                                  //                 FontWeight.bold,
                                                  //             fontFamily: FontWeight_
                                                  //                 .Fonts_T),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 100,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black,
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
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text(
                                                          'ปิด',
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      );
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
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
                                      child: const Text(
                                        'เรียกดูไฟล์',
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
                          ),
                        Container(
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                            // border: Border.all(color: Colors.grey, width: 1),
                          ),
                        ),
                        // (double.parse(pay1) +
                        //                   double.parse(pay2) !=
                        //               (sum_amt - sum_disamt))
                        SizedBox(
                          height: 20,
                          //
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
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
                                    'รูปแบบบิล',
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
                                height: 50,
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  width: 120,
                                  child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      bills_name_.toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          //fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                    ),
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontFamily: Font_.Fonts_T),
                                    iconSize: 30,
                                    buttonHeight: 40,
                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    items: bill_tser == '1'
                                        ? Default_.map((item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            )).toList()
                                        : Default2_.map((item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            )).toList(),

                                    onChanged: (value) async {
                                      var bill_set =
                                          value == 'บิลธรรมดา' ? 'P' : 'F';
                                      setState(() {
                                        bills_name_ = bill_set;
                                      });
                                    },
                                    // onSaved: (value) {
                                    //   // selectedValue = value.toString();
                                    // },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                            // border: Border.all(color: Colors.grey, width: 1),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    var pay1;
                                    var pay2;
                                    setState(() {
                                      Slip_status = '1';
                                    });
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
                                    print((sum_amt - sum_disamt));
                                    if (pamentpage == 0) {
                                      setState(() {
                                        // Form_payment2.clear();
                                        Form_payment2.text = '';
                                      });
                                    }
                                    setState(() {
                                      pay1 = Form_payment1.text == ''
                                          ? '0.00'
                                          : Form_payment1.text;
                                      pay2 = Form_payment2.text == ''
                                          ? '0.00'
                                          : Form_payment2.text;
                                    });

                                    //                if (double.parse(pay1) < 0.00 ||
                                    //     double.parse(pay2) < 0.00) {
                                    //   print(
                                    //       '${double.parse(pay1)} ////////////****-////////${double.parse(pay2)}');
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(
                                    //     const SnackBar(
                                    //         content: Text(
                                    //             'กรุณากรอกจำนวนเงินให้ถูกต้อง!',
                                    //             style: TextStyle(
                                    //                 color: Colors.white,
                                    //                 fontFamily:
                                    //                     Font_.Fonts_T))),
                                    //   );
                                    // } else {}
                                    if ((double.parse(pay1) +
                                            double.parse(pay2) !=
                                        (sum_amt - sum_disamt))) {
                                      _showMyDialogPay_Error(
                                          'จำนวนเงินไม่ถูกต้อง ');
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //       content: Text(
                                      //           'จำนวนเงินไม่ถูกต้อง ',
                                      //           style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontFamily:
                                      //                   Font_.Fonts_T))),
                                      // );
                                    } else if (double.parse(pay1) < 0.00 ||
                                        double.parse(pay2) < 0.00) {
                                      _showMyDialogPay_Error(
                                          'จำนวนเงินไม่ถูกต้อง ');
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //       content: Text('จำนวนเงินไม่ถูกต้อง',
                                      //           style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontFamily:
                                      //                   Font_.Fonts_T))),
                                      // );
                                    } else {
                                      if (pamentpage == 0 &&
                                          // Form_payment1.text == '' ||
                                          paymentName1 == null) {
                                        _showMyDialogPay_Error(
                                            'กรุณาเลือกรูปแบบชำระ! ที่ 1');
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   const SnackBar(
                                        //       content: Text(
                                        //           'กรุณาเลือกรูปแบบชำระ! ที่ 1',
                                        //           style: TextStyle(
                                        //               color: Colors.white,
                                        //               fontFamily:
                                        //                   Font_.Fonts_T))),
                                        // );
                                      } else if (pamentpage == 1 &&
                                              // Form_payment2.text ==
                                              //     '' ||
                                              paymentName2 == null ||
                                          paymentName1 == null) {
                                        _showMyDialogPay_Error((paymentName1 ==
                                                null)
                                            ? 'กรุณาเลือกรูปแบบชำระ! ที่ 1'
                                            : 'กรุณาเลือกรูปแบบชำระ! ที่ 2');
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //       content: (paymentName1 == null)
                                        //           ?
                                        //           Text(
                                        //               'กรุณาเลือกรูปแบบชำระ! ที่ 1',
                                        //               style: TextStyle(
                                        //                   color: Colors.white,
                                        //                   fontFamily:
                                        //                       Font_.Fonts_T))
                                        //           : Text(
                                        //               'กรุณาเลือกรูปแบบชำระ! ที่ 2',
                                        //               style: TextStyle(
                                        //                   color: Colors.white,
                                        //                   fontFamily:
                                        //                       Font_.Fonts_T))),
                                        // );
                                      } else {
                                        if (select_page == 2) {
                                          // print('object963');
                                          PdfgenReceipt.exportPDF_Receipt2(
                                              context,
                                              Slip_status,
                                              _TransReBillHistoryModels,
                                              '${widget.Get_Value_cid}',
                                              '${widget.namenew}',
                                              '${sum_pvat}',
                                              '${sum_vat}',
                                              '${sum_wht}',
                                              '${sum_amt}',
                                              '$sum_disp',
                                              '${nFormat.format(sum_disamt)}',
                                              '${sum_amt - sum_disamt}',
                                              // '${nFormat.format(sum_amt - sum_disamt)}',
                                              '${renTal_name.toString()}',
                                              '${Form_bussshop}',
                                              '${Form_address}',
                                              '${Form_tel}',
                                              '${Form_email}',
                                              '${Form_tax}',
                                              ' ${Form_nameshop}',
                                              ' ${renTalModels[0].bill_addr}',
                                              ' ${renTalModels[0].bill_email}',
                                              ' ${renTalModels[0].bill_tel}',
                                              ' ${renTalModels[0].bill_tax}',
                                              ' ${renTalModels[0].bill_name}',
                                              newValuePDFimg,
                                              pamentpage,
                                              paymentName1,
                                              paymentName2,
                                              Form_payment1.text,
                                              Form_payment2.text,
                                              numinvoice,
                                              cFinn);
                                        } else {
                                          if (paymentSer1 != '0' &&
                                              paymentSer1 != null) {
                                            if ((double.parse(pay1) +
                                                    double.parse(pay2)) >=
                                                (sum_amt - sum_disamt)) {
                                              if ((sum_amt - sum_disamt) != 0) {
                                                if (select_page == 0) {
                                                  // print(
                                                  //     '(select_page == 0n_Trans_invoice_P)');
                                                  // _TransModels
                                                  // sum_disamtx sum_dispx
                                                  in_Trans_invoice_P(
                                                      newValuePDFimg);
                                                } else if (select_page == 1) {
                                                  final tableData00 = [
                                                    for (int index = 0;
                                                        index <
                                                            _InvoiceHistoryModels
                                                                .length;
                                                        index++)
                                                      [
                                                        '${index + 1}',
                                                        '${_InvoiceHistoryModels[index].date}',
                                                        '${_InvoiceHistoryModels[index].descr}',
                                                        '${nFormat.format(double.parse(_InvoiceHistoryModels[index].qty!))}',
                                                        '${nFormat.format(double.parse(_InvoiceHistoryModels[index].nvat!))}',
                                                        '${nFormat.format(double.parse(_InvoiceHistoryModels[index].vat!))}',
                                                        '${nFormat.format(double.parse(_InvoiceHistoryModels[index].pvat!))}',
                                                        '${nFormat.format(double.parse(_InvoiceHistoryModels[index].amt!))}',
                                                      ],
                                                  ];
                                                  //_InvoiceHistoryModels
                                                  in_Trans_invoice_refno_p();
                                                  PdfgenReceipt.exportPDF_Receipt1(
                                                      numinvoice,
                                                      tableData00,
                                                      context,
                                                      Slip_status,
                                                      _InvoiceHistoryModels,
                                                      '${widget.Get_Value_cid}',
                                                      '${widget.namenew}',
                                                      '${sum_pvat}',
                                                      '${sum_vat}',
                                                      '${sum_wht}',
                                                      '${sum_amt}',
                                                      '$sum_disp',
                                                      '${nFormat.format(sum_disamt)}',
                                                      '${sum_amt - sum_disamt}',
                                                      // '${nFormat.format(sum_amt - sum_disamt)}',
                                                      '${renTal_name.toString()}',
                                                      '${Form_bussshop}',
                                                      '${Form_address}',
                                                      '${Form_tel}',
                                                      '${Form_email}',
                                                      '${Form_tax}',
                                                      ' ${Form_nameshop}',
                                                      ' ${renTalModels[0].bill_addr}',
                                                      ' ${renTalModels[0].bill_email}',
                                                      ' ${renTalModels[0].bill_tel}',
                                                      ' ${renTalModels[0].bill_tax}',
                                                      ' ${renTalModels[0].bill_name}',
                                                      newValuePDFimg,
                                                      pamentpage,
                                                      paymentName1,
                                                      paymentName2,
                                                      Form_payment1.text,
                                                      Form_payment2.text);
                                                } else if (select_page == 2) {
                                                  //TransReBillHistoryModel
                                                  // in_Trans_re_invoice_refno();
                                                  //พิมพ์ซ้ำ
                                                  PdfgenReceipt.exportPDF_Receipt2(
                                                      context,
                                                      Slip_status,
                                                      _TransModels,
                                                      '${widget.Get_Value_cid}',
                                                      '${widget.namenew}',
                                                      '${sum_pvat}',
                                                      '${sum_vat}',
                                                      '${sum_wht}',
                                                      '${sum_amt}',
                                                      '$sum_disp',
                                                      '${nFormat.format(sum_disamt)}',
                                                      '${sum_amt - sum_disamt}',
                                                      // '${nFormat.format(sum_amt - sum_disamt)}',
                                                      '${renTal_name.toString()}',
                                                      '${Form_bussshop}',
                                                      '${Form_address}',
                                                      '${Form_tel}',
                                                      '${Form_email}',
                                                      '${Form_tax}',
                                                      '${Form_nameshop}',
                                                      '${renTalModels[0].bill_addr}',
                                                      '${renTalModels[0].bill_email}',
                                                      '${renTalModels[0].bill_tel}',
                                                      '${renTalModels[0].bill_tax}',
                                                      '${renTalModels[0].bill_name}',
                                                      newValuePDFimg,
                                                      pamentpage,
                                                      paymentName1,
                                                      paymentName2,
                                                      Form_payment1.text,
                                                      Form_payment2.text,
                                                      numinvoice,
                                                      cFinn);
                                                }
                                                // PdfgenReceipt.exportPDF_Receipt(context);
                                              } else {
                                                _showMyDialogPay_Error(
                                                    'จำนวนเงินไม่ถูกต้อง กรุณาเลือกรายการชำระ!');
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   const SnackBar(
                                                //       content: Text(
                                                //           'จำนวนเงินไม่ถูกต้อง กรุณาเลือกรายการชำระ!',
                                                //           style: TextStyle(
                                                //               color:
                                                //                   Colors.white,
                                                //               fontFamily: Font_
                                                //                   .Fonts_T))),
                                                // );
                                              }
                                            } else {
                                              _showMyDialogPay_Error(
                                                  'กรุณากรอกจำนวนเงินให้ถูกต้อง!');
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(
                                              //   const SnackBar(
                                              //       content: Text(
                                              //           'กรุณากรอกจำนวนเงินให้ถูกต้อง!',
                                              //           style: TextStyle(
                                              //               color: Colors.white,
                                              //               fontFamily: Font_
                                              //                   .Fonts_T))),
                                              // );
                                            }
                                          } else {
                                            _showMyDialogPay_Error(
                                                'กรุณาเลือกรูปแบบการชำระ!');
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   const SnackBar(
                                            //       content: Text(
                                            //           'กรุณาเลือกรูปแบบการชำระ!',
                                            //           style: TextStyle(
                                            //               color: Colors.white,
                                            //               fontFamily:
                                            //                   Font_.Fonts_T))),
                                            // );
                                          }
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        // border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: select_page == 2
                                              ? const Text(
                                                  'พิมพ์ซ้ำ',
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                )
                                              //
                                              : const Text(
                                                  'พิมพ์ใบเสร็จชั่วคราว',
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ))),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   flex: 2,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: InkWell(
                            //       onTap: () {},
                            //       child: Container(
                            //           height: 50,
                            //           decoration: const BoxDecoration(
                            //             color: Colors.green,
                            //             borderRadius: BorderRadius.only(
                            //                 topLeft: Radius.circular(10),
                            //                 topRight: Radius.circular(10),
                            //                 bottomLeft: Radius.circular(10),
                            //                 bottomRight: Radius.circular(10)),
                            //             // border: Border.all(color: Colors.white, width: 1),
                            //           ),
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: const Center(
                            //               child: Text(
                            //             'พิมพ์',
                            //             style: TextStyle(
                            //                 color: PeopleChaoScreen_Color
                            //                     .Colors_Text1_,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontFamily: FontWeight_.Fonts_T),
                            //           ))),
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    var pay1;
                                    var pay2;

                                    setState(() {
                                      Slip_status = '2';
                                    });
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
                                    if (pamentpage == 0) {
                                      setState(() {
                                        // Form_payment2.clear();
                                        Form_payment2.text = '';
                                      });
                                    }

                                    //select_page = 0 _TransModels : = 1 _InvoiceHistoryModels
                                    setState(() {
                                      pay1 = Form_payment1.text == ''
                                          ? '0.00'
                                          : Form_payment1.text;
                                      pay2 = Form_payment2.text == ''
                                          ? '0.00'
                                          : Form_payment2.text;
                                    });

                                    print(
                                        '${double.parse(pay1) + double.parse(pay2)} /// ${(sum_amt - sum_disamt)}****${Form_payment1.text}***${Form_payment2.text}');
                                    print(
                                        '************************************++++');
                                    print(
                                        '>>1>  ${Form_payment1.text} //// $pay1//***${double.parse(pay1)}');
                                    print(
                                        '>>2>  ${Form_payment2.text} //// $pay2 //***${double.parse(pay2)}');

                                    print(
                                        '${(sum_amt - sum_disamt)}//****${double.parse(pay1) + double.parse(pay2)}');
                                    print(
                                        '************************************++++');
                                    if (double.parse(pay1) < 0.00 ||
                                        double.parse(pay2) < 0.00) {
                                      _showMyDialogPay_Error(
                                          'กรุณากรอกจำนวนเงินให้ถูกต้อง!');
                                      // print(
                                      //     '${double.parse(pay1)} ////////////****-////////${double.parse(pay2)}');
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //       content: Text(
                                      //           'กรุณากรอกจำนวนเงินให้ถูกต้อง!',
                                      //           style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontFamily:
                                      //                   Font_.Fonts_T))),
                                      // );
                                    }
                                    if ((double.parse(pay1) +
                                            double.parse(pay2) !=
                                        (sum_amt - sum_disamt))) {
                                      _showMyDialogPay_Error(
                                          'จำนวนเงินไม่ถูกต้อง ');
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //       content: Text(
                                      //           'จำนวนเงินไม่ถูกต้อง ',
                                      //           style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontFamily:
                                      //                   Font_.Fonts_T))),
                                      // );
                                    } else if (double.parse(pay1) < 0.00 ||
                                        double.parse(pay2) < 0.00) {
                                      _showMyDialogPay_Error(
                                          'จำนวนเงินไม่ถูกต้อง');
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //       content: Text('จำนวนเงินไม่ถูกต้อง',
                                      //           style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontFamily:
                                      //                   Font_.Fonts_T))),
                                      // );
                                    } else {
                                      if (paymentSer1 != '0' &&
                                          paymentSer1 != null) {
                                        if ((double.parse(pay1) +
                                                    double.parse(pay2)) >=
                                                (sum_amt - sum_disamt) ||
                                            (double.parse(pay1) +
                                                    double.parse(pay2)) <
                                                (sum_amt - sum_disamt)) {
                                          if ((sum_amt - sum_disamt) != 0) {
                                            if (select_page == 0) {
                                              print('(select_page == 0)');
                                              if ((double.parse(pay1) +
                                                      double.parse(pay2) !=
                                                  (sum_amt - sum_disamt))) {
                                                _showMyDialogPay_Error(
                                                    'จำนวนเงินไม่ถูกต้อง ');
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   const SnackBar(
                                                //       content: Text(
                                                //           'จำนวนเงินไม่ถูกต้อง ',
                                                //           style: TextStyle(
                                                //               color:
                                                //                   Colors.white,
                                                //               fontFamily: Font_
                                                //                   .Fonts_T))),
                                                // );
                                              } else {
                                                if (pamentpage == 0 &&
                                                    // Form_payment1.text ==
                                                    //     '' ||
                                                    paymentName1 == null) {
                                                  _showMyDialogPay_Error(
                                                      'กรุณาเลือกรูปแบบชำระ! ที่ 1');
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   const SnackBar(
                                                  //       content: Text(
                                                  //           'กรุณาเลือกรูปแบบชำระ! ที่ 1',
                                                  //           style: TextStyle(
                                                  //               color: Colors
                                                  //                   .white,
                                                  //               fontFamily: Font_
                                                  //                   .Fonts_T))),
                                                  // );
                                                } else if (pamentpage == 1 &&
                                                    // Form_payment2.text ==
                                                    //     '' ||
                                                    paymentName2 == null) {
                                                  _showMyDialogPay_Error(
                                                      'กรุณาเลือกรูปแบบชำระ! ที่ 2');
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   const SnackBar(
                                                  //       content: Text(
                                                  //           'กรุณาเลือกรูปแบบชำระ! ที่ 2',
                                                  //           style: TextStyle(
                                                  //               color: Colors
                                                  //                   .white,
                                                  //               fontFamily: Font_
                                                  //                   .Fonts_T))),
                                                  // );
                                                } else {
                                                  if (paymentName1
                                                              .toString()
                                                              .trim() ==
                                                          'เงินโอน' ||
                                                      paymentName2
                                                              .toString()
                                                              .trim() ==
                                                          'เงินโอน') {
                                                    if (base64_Slip != null) {
                                                      try {
                                                        OKuploadFile_Slip();
                                                        // _TransModels
                                                        // sum_disamtx sum_dispx

                                                        await in_Trans_invoice(
                                                            newValuePDFimg);
                                                      } catch (e) {}
                                                    } else {
                                                      _showMyDialogPay_Error(
                                                          'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                      // ScaffoldMessenger.of(
                                                      //         context)
                                                      //     .showSnackBar(
                                                      //   const SnackBar(
                                                      //       content: Text(
                                                      //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                      //           style: TextStyle(
                                                      //               color: Colors
                                                      //                   .white,
                                                      //               fontFamily:
                                                      //                   Font_
                                                      //                       .Fonts_T))),
                                                      // );
                                                    }
                                                  } else {
                                                    try {
                                                      // OKuploadFile_Slip();
                                                      // _TransModels
                                                      // sum_disamtx sum_dispx

                                                      await in_Trans_invoice(
                                                          newValuePDFimg);
                                                    } catch (e) {}
                                                  }
                                                }
                                              }
                                            } else if (select_page == 1) {
                                              if ((double.parse(pay1) +
                                                      double.parse(pay2) !=
                                                  (sum_amt - sum_disamt))) {
                                                _showMyDialogPay_Error(
                                                    'จำนวนเงินไม่ถูกต้อง กรุณาเลือกรายการชำระ! ');
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   const SnackBar(
                                                //       content: Text(
                                                //           'จำนวนเงินไม่ถูกต้อง กรุณาเลือกรายการชำระ! ',
                                                //           style: TextStyle(
                                                //               color:
                                                //                   Colors.white,
                                                //               fontFamily: Font_
                                                //                   .Fonts_T))),
                                                // );
                                              } else {
                                                if (pamentpage == 0 &&
                                                    // Form_payment1.text ==
                                                    //     '' ||
                                                    paymentName1 == null) {
                                                  _showMyDialogPay_Error(
                                                      'กรุณาเลือกรูปแบบชำระ! ที่ 1');
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   const SnackBar(
                                                  //       content: Text(
                                                  //           'กรุณาเลือกรูปแบบชำระ! ที่ 1',
                                                  //           style: TextStyle(
                                                  //               color: Colors
                                                  //                   .white,
                                                  //               fontFamily: Font_
                                                  //                   .Fonts_T))),
                                                  // );
                                                } else if (pamentpage == 1 &&
                                                        // Form_payment2.text ==
                                                        //     '' ||
                                                        paymentName2 == null ||
                                                    paymentName1 == null) {
                                                  _showMyDialogPay_Error(
                                                      (paymentName1 == null)
                                                          ? 'กรุณาเลือกรูปแบบชำระ! ที่ 1'
                                                          : 'กรุณาเลือกรูปแบบชำระ! ที่ 2');
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   SnackBar(
                                                  //       content:
                                                  //(paymentName1 ==
                                                  //               null)
                                                  //           ? Text(
                                                  //               'กรุณาเลือกรูปแบบชำระ! ที่ 1',
                                                  //               style: TextStyle(
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                   fontFamily: Font_
                                                  //                       .Fonts_T))
                                                  //           : Text(
                                                  //               'กรุณาเลือกรูปแบบชำระ! ที่ 2',
                                                  //               style: TextStyle(
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                   fontFamily:
                                                  //                       Font_
                                                  //                           .Fonts_T))),
                                                  // );
                                                } else {
                                                  if (paymentName1
                                                              .toString()
                                                              .trim() ==
                                                          'เงินโอน' ||
                                                      paymentName2
                                                              .toString()
                                                              .trim() ==
                                                          'เงินโอน') {
                                                    if (base64_Slip != null) {
                                                      try {
                                                        final tableData00 = [
                                                          for (int index = 0;
                                                              index <
                                                                  _InvoiceHistoryModels
                                                                      .length;
                                                              index++)
                                                            [
                                                              '${index + 1}',
                                                              '${_InvoiceHistoryModels[index].date}',
                                                              '${_InvoiceHistoryModels[index].descr}',
                                                              '${nFormat.format(double.parse(_InvoiceHistoryModels[index].qty!))}',
                                                              '${nFormat.format(double.parse(_InvoiceHistoryModels[index].nvat!))}',
                                                              '${nFormat.format(double.parse(_InvoiceHistoryModels[index].vat!))}',
                                                              '${nFormat.format(double.parse(_InvoiceHistoryModels[index].pvat!))}',
                                                              '${nFormat.format(double.parse(_InvoiceHistoryModels[index].amt!))}',
                                                            ],
                                                        ];
                                                        OKuploadFile_Slip();

                                                        in_Trans_invoice_refno(
                                                            tableData00,
                                                            newValuePDFimg);
                                                      } catch (e) {}
                                                    } else {
                                                      _showMyDialogPay_Error(
                                                          'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                      // ScaffoldMessenger.of(
                                                      //         context)
                                                      //     .showSnackBar(
                                                      //   const SnackBar(
                                                      //       content: Text(
                                                      //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                      //           style: TextStyle(
                                                      //               color: Colors
                                                      //                   .white,
                                                      //               fontFamily:
                                                      //                   Font_
                                                      //                       .Fonts_T))),
                                                      // );
                                                    }
                                                  } else {
                                                    try {
                                                      final tableData00 = [
                                                        for (int index = 0;
                                                            index <
                                                                _InvoiceHistoryModels
                                                                    .length;
                                                            index++)
                                                          [
                                                            '${index + 1}',
                                                            '${_InvoiceHistoryModels[index].date}',
                                                            '${_InvoiceHistoryModels[index].descr}',
                                                            '${nFormat.format(double.parse(_InvoiceHistoryModels[index].qty!))}',
                                                            '${nFormat.format(double.parse(_InvoiceHistoryModels[index].nvat!))}',
                                                            '${nFormat.format(double.parse(_InvoiceHistoryModels[index].vat!))}',
                                                            '${nFormat.format(double.parse(_InvoiceHistoryModels[index].pvat!))}',
                                                            '${nFormat.format(double.parse(_InvoiceHistoryModels[index].amt!))}',
                                                          ],
                                                      ];
                                                      // OKuploadFile_Slip();
                                                      //_InvoiceHistoryModels

                                                      in_Trans_invoice_refno(
                                                          tableData00,
                                                          newValuePDFimg);
                                                    } catch (e) {}
                                                  }
                                                }
                                              }
                                            } else if (select_page == 2) {
                                              if ((double.parse(pay1) +
                                                      double.parse(pay2) !=
                                                  (sum_amt - sum_disamt))) {
                                                _showMyDialogPay_Error(
                                                    'จำนวนเงินไม่ถูกต้อง กรุณาเลือกรายการชำระ! ');
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   const SnackBar(
                                                //       content: Text(
                                                //           'จำนวนเงินไม่ถูกต้อง กรุณาเลือกรายการชำระ! 789',
                                                //           style: TextStyle(
                                                //               color:
                                                //                   Colors.white,
                                                //               fontFamily: Font_
                                                //                   .Fonts_T))),
                                                // );
                                              } else {
                                                if (pamentpage == 0 &&
                                                    // Form_payment1.text ==
                                                    //     '' ||
                                                    paymentName1 == null) {
                                                  _showMyDialogPay_Error(
                                                      'กรุณาเลือกรูปแบบชำระ! ที่ 1');
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   const SnackBar(
                                                  //       content: Text(
                                                  //           'กรุณาเลือกรูปแบบชำระ! ที่ 1',
                                                  //           style: TextStyle(
                                                  //               color: Colors
                                                  //                   .white,
                                                  //               fontFamily: Font_
                                                  //                   .Fonts_T))),
                                                  // );
                                                } else if (pamentpage == 1 &&
                                                        // Form_payment2.text ==
                                                        //     '' ||
                                                        paymentName2 == null ||
                                                    paymentName1 == null) {
                                                  _showMyDialogPay_Error(
                                                      (paymentName1 == null)
                                                          ? 'กรุณาเลือกรูปแบบชำระ! ที่ 1'
                                                          : 'กรุณาเลือกรูปแบบชำระ! ที่ 2');
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   SnackBar(
                                                  //       content: (paymentName1 ==
                                                  //               null)
                                                  //           ? Text(
                                                  //               'กรุณาเลือกรูปแบบชำระ! ที่ 1',
                                                  //               style: TextStyle(
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                   fontFamily: Font_
                                                  //                       .Fonts_T))
                                                  //           : Text(
                                                  //               'กรุณาเลือกรูปแบบชำระ! ที่ 2',
                                                  //               style: TextStyle(
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                   fontFamily:
                                                  //                       Font_
                                                  //                           .Fonts_T))),
                                                  // );
                                                } else {
                                                  if (paymentName1
                                                              .toString()
                                                              .trim() ==
                                                          'เงินโอน' ||
                                                      paymentName2
                                                              .toString()
                                                              .trim() ==
                                                          'เงินโอน') {
                                                    if (base64_Slip != null) {
                                                      try {
                                                        OKuploadFile_Slip();
                                                        //TransReBillHistoryModel

                                                        await in_Trans_re_invoice_refno(
                                                            newValuePDFimg);
                                                      } catch (e) {}
                                                    } else {
                                                      _showMyDialogPay_Error(
                                                          'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                      // ScaffoldMessenger.of(
                                                      //         context)
                                                      //     .showSnackBar(
                                                      //   const SnackBar(
                                                      //       content: Text(
                                                      //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                      //           style: TextStyle(
                                                      //               color: Colors
                                                      //                   .white,
                                                      //               fontFamily:
                                                      //                   Font_
                                                      //                       .Fonts_T))),
                                                      // );
                                                    }
                                                  } else {
                                                    try {
                                                      // OKuploadFile_Slip();
                                                      //TransReBillHistoryModel

                                                      await in_Trans_re_invoice_refno(
                                                          newValuePDFimg);
                                                    } catch (e) {}
                                                  }
                                                }
                                              }
                                            }
                                          } else {
                                            _showMyDialogPay_Error(
                                                'จำนวนเงินไม่ถูกต้อง กรุณาเลือกรายการชำระ!');
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   const SnackBar(
                                            //       content: Text(
                                            //           'จำนวนเงินไม่ถูกต้อง กรุณาเลือกรายการชำระ!',
                                            //           style: TextStyle(
                                            //               color: Colors.white,
                                            //               fontFamily:
                                            //                   Font_.Fonts_T))),
                                            // );
                                          }
                                        } else {
                                          _showMyDialogPay_Error(
                                              'กรุณากรอกจำนวนเงินให้ถูกต้อง!');
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(
                                          //   const SnackBar(
                                          //       content: Text(
                                          //           'กรุณากรอกจำนวนเงินให้ถูกต้อง!',
                                          //           style: TextStyle(
                                          //               color: Colors.white,
                                          //               fontFamily:
                                          //                   Font_.Fonts_T))),
                                          // );
                                        }
                                      } else {
                                        _showMyDialogPay_Error(
                                            'กรุณาเลือกรูปแบบการชำระ!');
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   const SnackBar(
                                        //       content: Text(
                                        //           'กรุณาเลือกรูปแบบการชำระ!',
                                        //           style: TextStyle(
                                        //               color: Colors.white,
                                        //               fontFamily:
                                        //                   Font_.Fonts_T))),
                                        // );
                                      }
                                    }
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
                                      child: Center(
                                          child: Text(
                                        'รับชำระ',
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
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
        const SizedBox(
          height: 50,
        )
      ],
    );
  }

  Future<Null> confirmOrderdelete(index) async {
    // print(_InvoiceHistoryModels[index].ser);
    // print(numinvoice);
    //  for (int index = 0;
    //                                                   index <
    //                                                       _InvoiceHistoryModels
    //                                                           .length;
    //                                                   index++){ }
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: const Text(
                              'ยกเลิกวางบิล',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (index != '')
                            ? Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  '${_InvoiceHistoryModels[index].descr}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ))
                            : Container(
                                alignment: Alignment.center,
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: ListView.builder(
                                  itemCount: _InvoiceHistoryModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Center(
                                      child: Text(
                                        '${_InvoiceHistoryModels[index].descr}',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            // prefixIcon: const Icon(Icons.water,
                            //     color: Colors.blue),
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
                            labelText: 'หมายเหตุ',
                            labelStyle: const TextStyle(
                              color: ManageScreen_Color.Colors_Text2_,
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
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 130,
                          height: 40,
                          // ignore: deprecated_member_use
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();

                              String Formbecause = Formbecause_.text.toString();

                              if (Formbecause == '') {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    title: const Center(
                                        child: Text(
                                      'กรุณากรอกเหตุผล !!',
                                      style: TextStyle(
                                          color: AdminScafScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    )),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                color: Colors.redAccent,
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
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text(
                                                  'ปิด',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                              } else if (index.toString() == '') {
                                print('index == ' '');
                                print('index == ' '');
                                print('index == ' '');
                                for (int index = 0;
                                    index < _InvoiceHistoryModels.length;
                                    index++) {
                                  var ren = preferences.getString('renTalSer');
                                  var user = preferences.getString('ser');
                                  var ciddoc = widget.Get_Value_cid;
                                  var qutser = widget.Get_Value_NameShop_index;

                                  var tser = _InvoiceHistoryModels[index].ser;
                                  var tdocno = numinvoice;
                                  print('tser >>.> $tser >>> $Formbecause');
                                  String url =
                                      '${MyConstant().domain}/Uc_invoice_de.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user&because=$Formbecause';
                                  try {
                                    var response =
                                        await http.get(Uri.parse(url));

                                    var result = json.decode(response.body);
                                    print(result);
                                    if (result.toString() == 'true') {
                                      setState(() {
                                        // red_Trans_select(-5);
                                        // _InvoiceModels.clear();
                                        // _InvoiceHistoryModels.clear();
                                        // numinvoice = null;
                                        // sum_disamtx.text = '0';
                                        // sum_dispx.text = '0';
                                        // sum_pvat = 0.00;
                                        // sum_vat = 0.00;
                                        // sum_wht = 0.00;
                                        // sum_amt = 0.00;
                                        // sum_dis = 0.00;
                                        // sum_disamt = 0.00;
                                        // sum_disp = 0;
                                        // select_page = 1;
                                        // red_Trans_selectde();
                                        // Navigator.pop(context);
                                      });
                                      print('rrrrrrrrrrrrrr');
                                    }
                                  } catch (e) {}
                                }
                                print('index == ' '');
                                red_Trans_selectde();
                                print('index == ' 'ลบทั้งหมดทีเดียว');
                                Navigator.pop(context);
                              } else if (index.toString() != '') {
                                print('index != ' '');
                                var ren = preferences.getString('renTalSer');
                                var user = preferences.getString('ser');
                                var ciddoc = widget.Get_Value_cid;
                                var qutser = widget.Get_Value_NameShop_index;

                                var tser = _InvoiceHistoryModels[index].ser;
                                var tdocno = numinvoice;
                                print('tser >>.> $tser >>> $Formbecause');
                                String url =
                                    '${MyConstant().domain}/Uc_invoice_de.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user&because=$Formbecause';
                                try {
                                  var response = await http.get(Uri.parse(url));

                                  var result = json.decode(response.body);
                                  print(result);
                                  if (result.toString() == 'true') {
                                    setState(() {
                                      // red_Trans_select(-5);
                                      // _InvoiceModels.clear();
                                      // _InvoiceHistoryModels.clear();
                                      // numinvoice = null;
                                      // sum_disamtx.text = '0';
                                      // sum_dispx.text = '0';
                                      // sum_pvat = 0.00;
                                      // sum_vat = 0.00;
                                      // sum_wht = 0.00;
                                      // sum_amt = 0.00;
                                      // sum_dis = 0.00;
                                      // sum_disamt = 0.00;
                                      // sum_disp = 0;
                                      // select_page = 1;
                                      red_Trans_selectde();
                                      Navigator.pop(context);
                                    });
                                    print('rrrrrrrrrrrrrr');
                                  }
                                } catch (e) {}
                              }
                              print('index != ' ' ลบทีละรายการ');
                              // red_Trans_selectde();
                            },
                            child: const Text(
                              'Confirm',
                              style: TextStyle(
                                // fontSize: 20.0,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            // color: Colors.orange[900],
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          // ignore: deprecated_member_use
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () => Navigator.pop(context),
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
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Future<Null> in_Trans_invoice_P(newValuePDFimg) async {
    var tableData00;
    setState(() {
      tableData00 = [
        for (int index = 0; index < _TransModels.length; index++)
          [
            '${index + 1}',
            '${_TransModels[index].date}',
            '${_TransModels[index].name}',
            '${_TransModels[index].tqty}',
            '${_TransModels[index].unit_con}',
            _TransModels[index].qty_con == '0.00'
                ? '${nFormat.format(double.parse(_TransModels[index].amt_con!))}'
                : '${nFormat.format(double.parse(_TransModels[index].qty_con!))}',
            '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
          ],
      ];
    });
    // fileName_Slip
    String? fileName_Slip_ = fileName_Slip.toString().trim();
    // if (fileName_Slip != null) {
    //   setState(() {
    //     fileName_Slip_ = fileName_Slip.toString().trim();
    //   });
    // } else {}
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var sumdis = sum_disamt.toString();
    var sumdisp = sum_disp.toString();
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = Form_time.text;
    //pamentpage == 0
    var payment1 = Form_payment1.text.toString();
    var payment2 = Form_payment2.text.toString();
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var sum_whta = sum_wht.toString();

    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    print('in_Trans_invoice_P()///$fileName_Slip_');

    print('$sumdis  $pSer1  $pSer2 $time');

    String url = pamentpage == 0
        ? '${MyConstant().domain}/In_tran_financet_P1.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_'
        : '${MyConstant().domain}/In_tran_financet_P2.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'No') {
        for (var map in result) {
          CFinnancetransModel cFinnancetransModel =
              CFinnancetransModel.fromJson(map);
          setState(() {
            cFinn = cFinnancetransModel.docno;
          });
          print(' in_Trans_invoice_P$discount_///zzzzasaaa123454>>>>  $cFinn');
          print(
              ' in_Trans_invoice_P///bnobnobnobno123454>>>>  ${cFinnancetransModel.bno}');
        }
        PdfgenReceipt.exportPDF_Receipt(
            tableData00,
            context,
            Slip_status,
            _TransModels,
            '${widget.Get_Value_cid}',
            '${widget.namenew}',
            '${sum_pvat}',
            '${sum_vat}',
            '${sum_wht}',
            '${sum_amt}',
            (discount_ == null) ? '0' : '${discount_} ',
            '${nFormat.format(sum_disamt)}',
            '${sum_amt - sum_disamt}',
            // '${nFormat.format(sum_amt - sum_disamt)}',
            '${renTal_name.toString()}',
            '${Form_bussshop}',
            '${Form_address}',
            '${Form_tel}',
            '${Form_email}',
            '${Form_tax}',
            '${Form_nameshop}',
            '${renTalModels[0].bill_addr}',
            '${renTalModels[0].bill_email}',
            '${renTalModels[0].bill_tel}',
            '${renTalModels[0].bill_tax}',
            '${renTalModels[0].bill_name}',
            newValuePDFimg,
            pamentpage,
            paymentName1,
            paymentName2,
            Form_payment1.text,
            Form_payment2.text,
            cFinn,
            Value_newDateD);
        setState(() async {
          await red_Trans_bill();
          red_Trans_select2();
          sum_disamtx.text = '0.00';
          sum_dispx.clear();
          Form_payment1.clear();
          Form_payment2.clear();
          Form_time.clear();
          // Value_newDateY = null;
          pamentpage = 0;
          bills_name_ = 'บิลธรรมดา';
          cFinn = null;
          // Value_newDateD = '';
          discount_ = null;
          base64_Slip = null;
          tableData00 = [];
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<Null> in_Trans_invoice(newValuePDFimg) async {
    var tableData00;
    setState(() {
      tableData00 = [
        for (int index = 0; index < _TransModels.length; index++)
          [
            '${index + 1}',
            '${_TransModels[index].date}',
            '${_TransModels[index].name}',
            '${_TransModels[index].tqty}',
            '${_TransModels[index].unit_con}',
            _TransModels[index].qty_con == '0.00'
                ? '${nFormat.format(double.parse(_TransModels[index].amt_con!))}'
                : '${nFormat.format(double.parse(_TransModels[index].qty_con!))}',
            '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
          ],
      ];
    });
    // fileName_Slip
    // String fileName_Slip_ = '';
    // if (fileName_Slip != null) {
    //   setState(() {
    //     fileName_Slip_ = fileName_Slip.toString().trim();
    //   });วันที่ชำระ
    // } else {}
    String? fileName_Slip_ = fileName_Slip.toString().trim();
    ////////////////------------------------------------------------------>
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var sumdis = sum_disamt.toString();
    var sumdisp = sum_disp.toString();
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = Form_time.text;
    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    //pamentpage == 0
    var payment1 = Form_payment1.text.toString();
    var payment2 = Form_payment2.text.toString();
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var sum_whta = sum_wht.toString();
    print('in_Trans_invoice()///$fileName_Slip_');
    print('in_Trans_invoice>>> $payment1  $payment2 $bill');

    String url = pamentpage == 0
        ? '${MyConstant().domain}/In_tran_financet1.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_'
        : '${MyConstant().domain}/In_tran_financet2.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(
          ' fileName_Slip_///// $fileName_Slip_///pamentpage//$pamentpage//////////*------> $result ');
      if (result.toString() != 'No') {
        for (var map in result) {
          CFinnancetransModel cFinnancetransModel =
              CFinnancetransModel.fromJson(map);
          setState(() {
            cFinn = cFinnancetransModel.docno;
          });
          print('in_Trans_invoice///zzzzasaaa123454>>>>  $cFinn');
          print(
              'in_Trans_invoice///bnobnobnobno123454>>>>  ${cFinnancetransModel.bno}');
        }
        PdfgenReceipt.exportPDF_Receipt(
            tableData00,
            context,
            Slip_status,
            _TransModels,
            '${widget.Get_Value_cid}',
            '${widget.namenew}',
            '${sum_pvat}',
            '${sum_vat}',
            '${sum_wht}',
            '${sum_amt}',
            (discount_ == null) ? '0' : '${discount_} ',
            '${nFormat.format(sum_disamt)}',
            '${sum_amt - sum_disamt}',
            // '${nFormat.format(sum_amt - sum_disamt)}',
            '${renTal_name.toString()}',
            '${Form_bussshop}',
            '${Form_address}',
            '${Form_tel}',
            '${Form_email}',
            '${Form_tax}',
            '${Form_nameshop}',
            '${renTalModels[0].bill_addr}',
            '${renTalModels[0].bill_email}',
            '${renTalModels[0].bill_tel}',
            '${renTalModels[0].bill_tax}',
            '${renTalModels[0].bill_name}',
            newValuePDFimg,
            pamentpage,
            paymentName1,
            paymentName2,
            Form_payment1.text,
            Form_payment2.text,
            cFinn,
            Value_newDateD);
        setState(() async {
          await red_Trans_bill();
          red_Trans_select2();
          sum_disamtx.text = '0.00';
          sum_dispx.clear();
          Form_payment1.clear();
          Form_payment2.clear();
          Form_time.clear();
          // Value_newDateY = null;
          pamentpage = 0;
          bills_name_ = 'บิลธรรมดา';
          cFinn = null;
          // Value_newDateD = '';
          discount_ = null;
          base64_Slip = null;
          tableData00 = [];
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<Null> in_Trans_invoice_refno_p() async {
    // fileName_Slip
    // String fileName_Slip_ = '';
    // if (fileName_Slip != null) {
    //   setState(() {
    //     fileName_Slip_ = fileName_Slip.toString().trim();
    //   });
    // } else {}
    String? fileName_Slip_ = fileName_Slip.toString().trim();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var sumdis = sum_disamt.toString();
    var sumdisp = sum_disp.toString();
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = Form_time.text;
    //pamentpage == 0
    var payment1 = Form_payment1.text.toString();
    var payment2 = Form_payment2.text.toString();
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var ref = numinvoice;
    var sum_whta = sum_wht.toString();
    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    print('in_Trans_invoice_refno_p()///$fileName_Slip_');
    print('$sumdis  $pSer1  $pSer2 $time');

    String url = pamentpage == 0
        ? '${MyConstant().domain}/In_tran_finanref_P1.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_'
        : '${MyConstant().domain}/In_tran_finanref_P2.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_bill();
          red_Trans_select2();
          sum_disamtx.text = '0.00';
          sum_dispx.clear();
          Form_payment1.clear();
          Form_payment2.clear();
          Form_time.clear();
          // Value_newDateY = null;
          pamentpage = 0;
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          bills_name_ = 'บิลธรรมดา';
          sum_disp = 0;
          deall_Trans_select();
          red_Invoice();
          select_page = 1;
          _InvoiceModels.clear();
          _InvoiceHistoryModels.clear();
          numinvoice = null;
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<Null> in_Trans_invoice_refno(tableData00, newValuePDFimg) async {
    // fileName_Slip
    // String fileName_Slip_ = '';
    // if (fileName_Slip != null) {
    //   setState(() {
    //     fileName_Slip_ = fileName_Slip.toString().trim();
    //   });
    // } else {}
    String? fileName_Slip_ = fileName_Slip.toString().trim();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var sumdis = sum_disamt.toString();
    var sumdisp = sum_disp.toString();
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = Form_time.text;
    //pamentpage == 0
    var payment1 = Form_payment1.text.toString();
    var payment2 = Form_payment2.text.toString();
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var ref = numinvoice;
    var sum_whta = sum_wht.toString();
    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    // print('in_Trans_invoice_refno()///$fileName_Slip_');
    // print('in_Trans_invoice_refno >>> $payment1  $payment2  $bill ');

    String url = pamentpage == 0
        ? '${MyConstant().domain}/In_tran_finanref1.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_'
        : '${MyConstant().domain}/In_tran_finanref2.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'No') {
        print('result.toString() != No');
        for (var map in result) {
          CFinnancetransModel cFinnancetransModel =
              CFinnancetransModel.fromJson(map);
          setState(() {
            cFinn = cFinnancetransModel.docno;
          });
          print('zzzzasaaa123454>>>>  $cFinn');
          print('bnobnobnobno123454>>>>  ${cFinnancetransModel.bno}');
        }
        PdfgenReceipt.exportPDF_Receipt1(
            cFinn,
            tableData00,
            context,
            Slip_status,
            _TransModels,
            '${widget.Get_Value_cid}',
            '${widget.namenew}',
            '${sum_pvat}',
            '${sum_vat}',
            '${sum_wht}',
            '${sum_amt}',
            '$sum_disp',
            '${nFormat.format(sum_disamt)}',
            '${sum_amt - sum_disamt}',
            // '${nFormat.format(sum_amt - sum_disamt)}',
            '${renTal_name.toString()}',
            '${Form_bussshop}',
            '${Form_address}',
            '${Form_tel}',
            '${Form_email}',
            '${Form_tax}',
            '${Form_nameshop}',
            '${renTalModels[0].bill_addr}',
            '${renTalModels[0].bill_email}',
            '${renTalModels[0].bill_tel}',
            '${renTalModels[0].bill_tax}',
            '${renTalModels[0].bill_name}',
            newValuePDFimg,
            pamentpage,
            paymentName1,
            paymentName2,
            Form_payment1.text,
            Form_payment2.text);
        setState(() async {
          await red_Trans_bill();
          red_Trans_select2();
          sum_disamtx.text = '0.00';
          sum_dispx.clear();
          Form_payment1.clear();
          Form_payment2.clear();
          Form_time.clear();
          // Value_newDateY = null;
          pamentpage = 0;
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;
          bills_name_ = 'บิลธรรมดา';
          deall_Trans_select();
          red_Invoice();
          select_page = 1;
          _InvoiceModels.clear();
          _InvoiceHistoryModels.clear();
          numinvoice = null;
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<Null> in_Trans_re_invoice_refno(newValuePDFimg) async {
    // fileName_Slip
    // String fileName_Slip_ = '';
    // if (fileName_Slip != null) {
    //   setState(() {
    //     fileName_Slip_ = fileName_Slip.toString().trim();
    //   });
    // } else {}
    String? fileName_Slip_ = fileName_Slip.toString().trim();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var sumdis = sum_disamt.toString();
    var sumdisp = sum_disp.toString();
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = Form_time.text;
    //pamentpage == 0
    var payment1 = Form_payment1.text.toString();
    var payment2 = Form_payment2.text.toString();
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var ref = numinvoice;
    var sum_whta = sum_wht.toString();
    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    print('in_Trans_re_invoice_refno()///$fileName_Slip_');
    print('in_Trans_invoice>>> $payment1  $payment2 $bill');

    String url = pamentpage == 0
        ? '${MyConstant().domain}/In_tran_re_finanref1.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_'
        : '${MyConstant().domain}/In_tran_re_finanref2.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);

      if (result.toString() != 'No') {
        for (var map in result) {
          CFinnancetransModel cFinnancetransModel =
              CFinnancetransModel.fromJson(map);
          setState(() {
            cFinn = cFinnancetransModel.docno;
          });
          print('zzzzasaaa123454>>>>  $cFinn');
          print('bnobnobnobno123454>>>>  ${cFinnancetransModel.bno}');
        }
        // int in_1 = int.parse(pSer1.toString());
        // int in_2 = int.parse(pSer2.toString()); 0897791278
        // _PayMentModels[in_].bno;
        PdfgenReceipt.exportPDF_Receipt2(
          context,
          Slip_status,
          _TransReBillHistoryModels,
          '${widget.Get_Value_cid}',
          '${widget.namenew}',
          '${sum_pvat}',
          '${sum_vat}',
          '${sum_wht}',
          '${sum_amt}',
          '$sum_disp',
          '${nFormat.format(sum_disamt)}',
          '${sum_amt - sum_disamt}',
          // '${nFormat.format(sum_amt - sum_disamt)}',
          '${renTal_name.toString()}',
          '${Form_bussshop}',
          '${Form_address}',
          '${Form_tel}',
          '${Form_email}',
          '${Form_tax}',
          '${Form_nameshop}',
          '${renTalModels[0].bill_addr}',
          '${renTalModels[0].bill_email}',
          '${renTalModels[0].bill_tel}',
          '${renTalModels[0].bill_tax}',
          '${renTalModels[0].bill_name}',
          newValuePDFimg,
          pamentpage,
          '${paymentName1}',
          '${paymentName2}',
          Form_payment1.text,
          Form_payment2.text,
          numinvoice,
          cFinn,
        );

        print('rrrrrrrrrrrrrr');
        setState(() async {
          await red_Trans_bill();
          red_Trans_select2();
          sum_disamtx.text = '0.00';
          sum_dispx.clear();
          Form_payment1.clear();
          Form_payment2.clear();
          Form_time.clear();
          // Value_newDateY = null;
          pamentpage = 0;
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;
          deall_Trans_select();
          red_Invoice();
          red_InvoiceC();
          select_page = 2;
          bills_name_ = 'บิลธรรมดา';
          _TransReBillHistoryModels.clear();
          _InvoiceModels.clear();
          _InvoiceHistoryModels.clear();
          numinvoice = null;
          cFinn = null;
        });
      }
    } catch (e) {}
  }
}

class PreviewPdfgen_Billsplay extends StatelessWidget {
  final pw.Document doc;
  final renTal_name;
  final title;
  const PreviewPdfgen_Billsplay(
      {Key? key, required this.doc, this.renTal_name, this.title})
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
            "$title",
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
          pdfFileName:
              "$title(ณ วันที่${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}).pdf",
        ),
      ),
    );
  }
}
