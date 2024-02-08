// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_string_interpolations, prefer_collection_literals, sort_child_properties_last, avoid_unnecessary_containers, prefer_is_empty, prefer_final_fields, camel_case_types, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, deprecated_member_use
import 'dart:convert';
import 'dart:js_util';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import '../AdminScaffold/AdminScaffold.dart';
import '../CRC_16_Prompay/generate_qrcode.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetFinnancetrans_Pay_Model.dart';
import '../Model/GetInvoice_Model.dart';
import '../Model/GetPakan_Contractx_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetTrans_Kon_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/Get_pakan_finnent_model.dart';
import '../Model/Get_trasn_Matjum_KF_RE_model.dart';
import '../Model/Get_trasn_Matjum_KF_model.dart';
import '../Model/Get_trasn_matjum_model.dart';
import '../Model/Get_trasn_pakan_KF_model.dart';
import '../Model/Get_trasn_pakan_Pay_model.dart';
import '../Model/Get_trasn_pakan_model.dart';
import '../PDF/pdf_Receipt_PayPakan.dart';
import '../PeopleChao/Pays_.dart';
import '../Style/colors.dart';
import 'dart:ui' as ui;

class ChaoReturnMadjum extends StatefulWidget {
  final Value_cid;
  final Get_Value_NameShop_index;
  const ChaoReturnMadjum({
    super.key,
    this.Value_cid,
    this.Get_Value_NameShop_index,
  });

  @override
  State<ChaoReturnMadjum> createState() => _ChaoReturnMadjumState();
}

class _ChaoReturnMadjumState extends State<ChaoReturnMadjum> {
  final Formbecause_ = TextEditingController();
  final text_add = TextEditingController();
  final price_add = TextEditingController();
  final Form_payment1 = TextEditingController();
  final Form_time = TextEditingController();
  List<TeNantModel> teNantModels = [];
  List<TransBillModel> _TransBillModels = [];
  List<InvoiceModel> _InvoiceModels = [];
  List<TransPakanModel> transPakanModels = [];
  List<TransPakanKFModel> transPakanKFModels = [];
  List<ContractxPakanModel> contractxPakanModels = [];
  List<TransModel> _TransModels = [];
  List<PayMentModel> _PayMentModels = [];
  List<RenTalModel> renTalModels = [];
  List<FinnancetransPayModel> finnancetransPayModels = [];
  List<TransPakanPayModel> transPakanPayModels = [];
  List<TransKonModel> transKonModels = [];
  List<TransPakanFinnetModel> transPakanFinnetModels = [];
  List<TransMatjumModel> transMatjumModels = [];
  List<TransMatjumKFModel> transMatjumKFModels = [];
  List<TransMatjumKFREModel> transMatjumKFREModels = [];

  var nFormat = NumberFormat("#,##0.00", "en_US");
  String? areanew, namenew, Sercid, reloadpakan;
  int? selectbot = 0,
      bot = 0,
      botc = 0,
      _Pakan = 0,
      renTal_lavel = 0,
      _matjum = 0;
  double sum_conx = 0,
      sum_ST = 0,
      sum_KKconx = 0,
      sum_Kon = 0,
      sum_matjum = 0.00,
      sum_Matjum_KF = 0,
      dis_matjum = 0,
      sum_Matjum_KF_RE = 0;
  String? paymentName1, paymentSer1, selectedValue;
  String? base64_Slip, fileName_Slip, renTal_name;
  GlobalKey qrImageKey = GlobalKey();
  DateTime newDatetime = DateTime.now();
  String? Value_newDateY = '',
      Value_newDateD = '',
      Value_newDateY1 = '',
      Value_newDateD1 = '';

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
      cFinn,
      expbill_name,
      bill_default,
      bill_tser,
      Slip_status,
      foder,
      bills_name_;

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
  @override
  void initState() {
    super.initState();
    read_GC_rental();
    read_GC_matjum();
    // read_GC_teNant();
    // read_GC_pkan();
    // red_Trans_billAll();
    // deall_Trans_select();
    // read_GC_pkan_total();
    red_Trans_select2();
    // read_GC_conx();
    // read_data();
    // red_payMent();
    Value_newDateY1 = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD1 = DateFormat('dd-MM-yyyy').format(newDatetime);
    Value_newDateY = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD = DateFormat('dd-MM-yyyy').format(newDatetime);
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
    var ciddoc = widget.Value_cid;
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
        // Map<String, dynamic> map = Map();
        // map['ser'] = '0';
        // map['datex'] = '';
        // map['timex'] = '';

        // map['ptser'] = '';
        // map['ptname'] = 'เลือก';
        // map['bser'] = '';
        // map['bank'] = '';
        // map['bno'] = '';
        // map['bname'] = '';
        // map['bsaka'] = '';
        // map['btser'] = '';
        // map['btype'] = '';
        // map['st'] = '1';
        // map['rser'] = '';
        // map['accode'] = '';
        // map['co'] = '';
        // map['data_update'] = '';
        // map['auto'] = '0';

        // PayMentModel _PayMentModel = PayMentModel.fromJson(map);

        // setState(() {
        //   _PayMentModels.add(_PayMentModel);
        // });

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
                  (sum_matjum - sum_ST > 0 ? 0 : (sum_ST - sum_matjum))
                      .toStringAsFixed(2)
                      .toString();
            }
          });
        }

        if (paymentName1 == null) {
          paymentSer1 = 0.toString();
          paymentName1 = 'เลือก'.toString();
          Form_payment1.text =
              (sum_matjum - sum_ST > 0 ? 0 : (sum_ST - sum_matjum))
                  .toStringAsFixed(2)
                  .toString();
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_select2() async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        sum_ST = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Value_cid;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_tran_select_pakan.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);

          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          setState(() {
            sum_ST = sum_ST + sum_amtx;
            _TransModels.add(_TransModel);
          });
        }
      }
    } catch (e) {}

    setState(() {
      red_Trans_Kon();
      red_payMent();
    });
  }

  Future<Null> red_Trans_Kon() async {
    if (transKonModels.isNotEmpty) {
      setState(() {
        transKonModels.clear();
        sum_Kon = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Value_cid;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_tran_Kon_pakan.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransKonModel transKonModel = TransKonModel.fromJson(map);
          var sum_amtx = double.parse(transKonModel.total!);
          setState(() {
            sum_Kon = sum_Kon + sum_amtx;
            bot = 1;
            transKonModels.add(transKonModel);
          });
        }
      }
    } catch (e) {}
    if (transKonModels.length != 0) {
      read_his_list();
    }
  }

  Future<Null> read_his_list() async {
    setState(() {
      if (transPakanFinnetModels.isNotEmpty) {
        setState(() {
          transPakanFinnetModels.clear();
        });
      }
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = transKonModels[0].docno;
    var qutser = 1;

    String url =
        '${MyConstant().domain}/GC_Pakan_finntnt.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------  $result');

      if (result.toString() != 'true') {
        for (var map in result) {
          TransPakanFinnetModel transPakanFinnetModel =
              TransPakanFinnetModel.fromJson(map);
          var sum_P = double.parse(transPakanFinnetModel.total!);
          setState(() {
            transPakanFinnetModels.add(transPakanFinnetModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> deall_Trans_select() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Value_cid;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/D_tran_select.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        // setState(() {
        //   red_Trans_select2();
        // });
        // print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        // setState(() {
        //   red_Trans_select2();
        // });
        // print('rrrrrrrrrrrrrrfalse');
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

  Future<Null> read_GC_teNant() async {
    if (teNantModels.length != 0) {
      setState(() {
        teNantModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      renTal_name = preferences.getString('renTalName');
    });
    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = widget.Value_cid;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_tenantlook.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);

          setState(() {
            areanew = teNantModel.area_c;
            namenew = teNantModel.cname;
            Sercid = teNantModel.ser;
            teNantModels.add(teNantModel);
          });
        }
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        String? _route = preferences.getString('route');
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => AdminScafScreen(route: _route));
        Navigator.pushAndRemoveUntil(
            context, materialPageRoute, (route) => false);
      }
    } catch (e) {}
  }

  Future<Null> read_GC_matjum() async {
    setState(() {
      _matjum = 0;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = widget.Value_cid;
    var qutser = 1;

    String url =
        '${MyConstant().domain}/GC_Matjum_quot.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------  $result');

      if (result.toString() == 'true') {
        setState(() {
          _matjum = 1;
          read_GC_matjum_total();
        });
      }
    } catch (e) {}
    setState(() {
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
    });
  }

  Future<Null> read_GC_matjum_total() async {
    setState(() {
      if (transMatjumModels.isNotEmpty) {
        setState(() {
          transMatjumModels.clear();
          sum_matjum = 0;
        });
      }
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = widget.Value_cid;
    var qutser = 1;

    String url =
        '${MyConstant().domain}/GC_Matjum_total.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------  $result');
      sum_matjum = 0;
      if (result.toString() != 'true') {
        for (var map in result) {
          TransMatjumModel transMatjumModel = TransMatjumModel.fromJson(map);
          var sum_P = double.parse(transMatjumModel.total!);
          setState(() {
            sum_matjum = sum_matjum + sum_P;
            transMatjumModels.add(transMatjumModel);
          });
        }
      }
    } catch (e) {}

    setState(() {
      read_GC_Matjum_total_MM();
    });
  }

  Future<Null> read_GC_Matjum_total_MM() async {
    setState(() {
      if (transMatjumKFModels.isNotEmpty) {
        setState(() {
          transMatjumKFModels.clear();
        });
      }
      sum_Matjum_KF = 0;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = widget.Value_cid;
    var qutser = 1;

    String url =
        '${MyConstant().domain}/GC_Matjum_total_KF.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------  $result');
      sum_Matjum_KF = 0;
      if (result.toString() != 'true') {
        for (var map in result) {
          TransMatjumKFModel transMatjumKFModel =
              TransMatjumKFModel.fromJson(map);
          var sum_P = double.parse(transMatjumKFModel.total!);
          setState(() {
            sum_Matjum_KF = sum_Matjum_KF + sum_P;
            transMatjumKFModels.add(transMatjumKFModel);
          });
        }
      }
      setState(() {
        sum_matjum = sum_matjum - sum_Matjum_KF;
      });
      if (sum_matjum != 0.0) {
        setState(() {
          selectbot = 2;
          bot = 0;
        });
      } else {
        setState(() {
          selectbot = 1;
          bot = 1;
        });
      }
    } catch (e) {}
    setState(() {
      read_GC_Matjum_total_MM_re();
    });
  }

  Future<Null> read_GC_Matjum_total_MM_re() async {
    setState(() {
      if (transMatjumKFREModels.isNotEmpty) {
        setState(() {
          transMatjumKFREModels.clear();
        });
      }
      sum_Matjum_KF_RE = 0;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    // var zone = preferences.getString('zoneSer');
    var ciddoc = widget.Value_cid;
    var qutser = 1;

    String url =
        '${MyConstant().domain}/GC_Matjum_total_KF_RE.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------  $result');
      sum_Matjum_KF_RE = 0;
      if (result.toString() != 'true') {
        for (var map in result) {
          TransMatjumKFREModel transMatjumKFREModel =
              TransMatjumKFREModel.fromJson(map);
          var sum_P = double.parse(transMatjumKFREModel.total!);
          var dtyp_P = transMatjumKFREModel.dtype;
          setState(() {
            sum_Matjum_KF_RE = sum_Matjum_KF_RE + sum_P;
            transMatjumKFREModels.add(transMatjumKFREModel);
          });
        }
      }
      setState(() {
        print(
            'sum_matjum >>> $sum_matjum sum_Matjum_KF_RE>>> $sum_Matjum_KF_RE');
        if (sum_Matjum_KF_RE > sum_matjum) {
          sum_matjum = 0.00;
        } else {
          sum_matjum = sum_matjum - sum_Matjum_KF_RE;
        }
      });
    } catch (e) {}

    if (sum_matjum != 0.0) {
      setState(() {
        selectbot = 2;
        bot = 0;
      });
    } else {
      setState(() {
        selectbot = 1;
        bot = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (bot == 1) {
                                  setState(() {
                                    selectbot = 1;
                                  });
                                }

                                // cancel();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bot == 1
                                      ? Colors.red[600]
                                      : Colors.red.shade200,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'ยกเลิกใบเสนอราคา',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  if ((sum_matjum - sum_ST) != 0.0) {
                                    selectbot = 2;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  maxLines: 1,
                                  'คืนเงินมัดจำ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              )),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (bot == 0) {
                                    bot = 1;
                                  } else {
                                    if ((sum_matjum - sum_ST) != 0.0) {
                                      bot = 0;
                                    } else {
                                      bot = 1;
                                    }
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bot == 1
                                      ? Colors.green[900]
                                      : Colors.grey[350],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  maxLines: 1,
                                  'ไม่คืนเงินมัดจำ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              )),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    selectbot == 0
                        ? AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 25,
                            maxLines: 1,
                            '${widget.Value_cid}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: Font_.Fonts_T),
                          )
                        : selectbot == 1
                            ? bot == 1
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                AutoSizeText(
                                                  minFontSize: 20,
                                                  maxFontSize: 50,
                                                  maxLines: 1,
                                                  'ยกเลิกใบเสนอราคา เลขที่ ${widget.Value_cid}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: Formbecause_,
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
                                                      cursorColor: Colors.green,
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
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomLeft: Radius
                                                                      .circular(
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
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomLeft: Radius
                                                                      .circular(
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
                                                                color: ManageScreen_Color
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 100,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
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
                                                      onPressed: () async {
                                                        print('Ser: ${Sercid}');
                                                        print(
                                                            'Cid: ${widget.Value_cid}');
                                                        print(
                                                            ' เหตุผล :${Formbecause_.text.toString()}');
                                                        String because_ =
                                                            '${Formbecause_.text.toString()}';

                                                        if (because_ == '') {
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
                                                                        padding: const EdgeInsets
                                                                            .all(
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
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        } else {
                                                          SharedPreferences
                                                              preferences =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          var ren = preferences
                                                              .getString(
                                                                  'renTalSer');
                                                          String url =
                                                              '${MyConstant().domain}/DC_Area_quot.php?isAdd=true&ren=$ren&ciddoc=${widget.Value_cid}&because=$because_';
                                                          try {
                                                            var response =
                                                                await http.get(
                                                                    Uri.parse(
                                                                        url));
                                                            var result = json
                                                                .decode(response
                                                                    .body);
                                                            print(
                                                                'BBBBBBBBBBBBBBBB>>>> $result');
                                                            if (result
                                                                    .toString() ==
                                                                'true') {
                                                              setState(
                                                                  () async {
                                                                SharedPreferences
                                                                    preferences =
                                                                    await SharedPreferences
                                                                        .getInstance();

                                                                String? _route =
                                                                    preferences
                                                                        .getString(
                                                                            'route');
                                                                MaterialPageRoute
                                                                    materialPageRoute =
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                AdminScafScreen(route: _route));
                                                                Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    materialPageRoute,
                                                                    (route) =>
                                                                        false);

                                                                setState(() {
                                                                  Formbecause_
                                                                      .clear();
                                                                });
                                                              });
                                                            }
                                                          } catch (e) {}
                                                        }

                                                        // Navigator.pop(context, 'OK');
                                                      },
                                                      child: const Text(
                                                        'ยืนยัน',
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
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox()
                            : Row(
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      'คืนเงินมัดจำ เลขที่ ${widget.Value_cid}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                  ),
                                ],
                              )
                  ],
                ),
              ),
            ),
          ],
        ),
        selectbot == 2 ? paysMadjum() : SizedBox(), //paysMadjum() : SizedBox(),
      ],
    );
  }

  Column paysMadjum() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                'รายการ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                'ยอดเงิน',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        for (int i = 0; i < transMatjumModels.length; i++)
                          Row(
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  maxLines: 1,
                                  '${transMatjumModels[i].expname}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  maxLines: 1,
                                  '${nFormat.format(double.parse(transMatjumModels[i].total!))}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                'ยอดรวม',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                '${nFormat.format(double.parse(transMatjumModels.map((e) => double.parse(e.total!)).reduce((a, b) => a + b).toStringAsFixed(2)))}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                'ยอดชำระรวม',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                transMatjumModels.length == 0
                                    ? '0.00'
                                    : '${nFormat.format(double.parse(transMatjumModels.map((e) => double.parse(e.total!)).reduce((a, b) => a + b).toStringAsFixed(2)))}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                '(คืน) ยอดคงเหลือ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 25,
                                maxLines: 1,
                                '${nFormat.format(sum_matjum)}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 200,
                                child: InkWell(
                                    onTap: () {
                                      addPlaySelect();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green[900],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 25,
                                        maxLines: 1,
                                        'เพิ่มรายการหัก',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    )),
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
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: transKonModels.length != 0
                      ? Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: EdgeInsets.all(8),
                          // child: his_lis_pay_pakan(),
                        )
                      : Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      'รายการตัดชำระ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      'ยอดเงิน',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(flex: 1, child: SizedBox()),
                                ],
                              ),
                              Divider(),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: ListView(
                                  children: [
                                    Column(
                                      children: [
                                        // for (int i = 0;
                                        //     i < transPakanKFModels.length;
                                        //     i++)
                                        //   Row(
                                        //     children: [
                                        //       Expanded(
                                        //         flex: 4,
                                        //         child: AutoSizeText(
                                        //           minFontSize: 10,
                                        //           maxFontSize: 25,
                                        //           maxLines: 1,
                                        //           'ค่าบริการค้างชำระ (${DateFormat('dd-MM-').format(DateTime.parse('${transPakanKFModels[i].date} 00:00:00'))}${int.parse(DateFormat('y').format(DateTime.parse('${transPakanKFModels[i].date} 00:00:00'))) + 543})',
                                        //           textAlign: TextAlign.start,
                                        //           style: TextStyle(
                                        //               color:
                                        //                   PeopleChaoScreen_Color
                                        //                       .Colors_Text2_,
                                        //               fontFamily:
                                        //                   Font_.Fonts_T),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         flex: 4,
                                        //         child: AutoSizeText(
                                        //           minFontSize: 10,
                                        //           maxFontSize: 25,
                                        //           maxLines: 1,
                                        //           '${nFormat.format(double.parse(transPakanKFModels[i].total!))}',
                                        //           textAlign: TextAlign.end,
                                        //           style: TextStyle(
                                        //               color:
                                        //                   PeopleChaoScreen_Color
                                        //                       .Colors_Text2_,
                                        //               fontFamily:
                                        //                   Font_.Fonts_T),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //           flex: 1, child: SizedBox()),
                                        //     ],
                                        //   ),
                                        for (int x = 0;
                                            x < _TransModels.length;
                                            x++)
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 25,
                                                  maxLines: 4,
                                                  '${_TransModels[x].name}',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 25,
                                                  maxLines: 1,
                                                  '${nFormat.format(double.parse(_TransModels[x].total!))}',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                    onPressed: () {
                                                      de_Trans_select(x);
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      'ยอดรวม',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      '${nFormat.format(sum_Matjum_KF + sum_ST)}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      minFontSize: 20,
                                      maxFontSize: 50,
                                      maxLines: 1,
                                      'ยอดคืนคงเหลือ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    child: AutoSizeText(
                                      minFontSize: 20,
                                      maxFontSize: 50,
                                      maxLines: 1,
                                      '${nFormat.format(sum_matjum - sum_ST)}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 4,
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
                                                  (sum_matjum - sum_ST > 0
                                                          ? 0
                                                          : (sum_ST -
                                                              sum_matjum))
                                                      .toStringAsFixed(2)
                                                      .toString();
                                            }
                                          });
                                          print(
                                              'mmmmm ${rtnameSer.toString()} $rtnameName');
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      nFormat.format(double.parse(
                                                  Form_payment1.text)) ==
                                              '0.00'
                                          ? 'ยอดคืนมัดจำ'
                                          : 'ยอดชำระ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 25,
                                      maxLines: 1,
                                      nFormat.format(double.parse(
                                                  Form_payment1.text)) ==
                                              '0.00'
                                          ? '${nFormat.format(sum_matjum - sum_ST)}'
                                          : '${nFormat.format(double.parse(Form_payment1.text))}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: (paymentName1.toString().trim() ==
                                            'Online Payment')
                                        ? Stack(
                                            children: [
                                              InkWell(
                                                child: Container(
                                                    width: 800,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[900],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft:
                                                                  const Radius
                                                                      .circular(
                                                                      10),
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            height: 50,
                                                            width: 100,
                                                            child: Image.asset(
                                                              'images/prompay.png',
                                                              height: 50,
                                                              width: 100,
                                                              fit: BoxFit.cover,
                                                            )),
                                                        const Center(
                                                            child: Text(
                                                          'QR PromtPay',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        )),
                                                      ],
                                                    )),
                                                onTap:
                                                    (paymentName1
                                                                .toString()
                                                                .trim() !=
                                                            'Online Payment')
                                                        ? null
                                                        : () {
                                                            double totalQr_ =
                                                                0.00;
                                                            if (paymentName1
                                                                    .toString()
                                                                    .trim() ==
                                                                'Online Payment') {
                                                              setState(() {
                                                                totalQr_ = 0.00;
                                                              });
                                                              setState(() {
                                                                totalQr_ =
                                                                    double.parse(
                                                                        '${Form_payment1.text}');
                                                              });
                                                            } else {
                                                              setState(() {
                                                                totalQr_ = 0.00;
                                                              });
                                                              setState(() {
                                                                totalQr_ =
                                                                    double.parse(
                                                                        '${Form_payment1.text}');
                                                              });
                                                            }

                                                            showDialog<void>(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false, // user must tap button!
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20.0))),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        ListBody(
                                                                      children: <Widget>[
                                                                        //  '${Form_bussshop}',
                                                                        //   '${Form_address}',
                                                                        //   '${Form_tel}',
                                                                        //   '${Form_email}',
                                                                        //   '${Form_tax}',
                                                                        //   '${Form_nameshop}',
                                                                        Center(
                                                                          child:
                                                                              RepaintBoundary(
                                                                            key:
                                                                                qrImageKey,
                                                                            child:
                                                                                Container(
                                                                              color: Colors.white,
                                                                              padding: const EdgeInsets.fromLTRB(4, 8, 4, 2),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Center(
                                                                                    child: Container(
                                                                                      width: 220,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.green[300],
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                      ),
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          '$renTal_name',
                                                                                          style: TextStyle(
                                                                                            color: Colors.white,
                                                                                            fontSize: 13,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  // Align(
                                                                                  //   alignment: Alignment
                                                                                  //       .centerLeft,
                                                                                  //   child: Text(
                                                                                  //     'คุณ : $Form_bussshop',
                                                                                  //     style:
                                                                                  //         TextStyle(
                                                                                  //       fontSize: 13,
                                                                                  //       fontWeight:
                                                                                  //           FontWeight
                                                                                  //               .bold,
                                                                                  //     ),
                                                                                  //   ),
                                                                                  // ),
                                                                                  Container(
                                                                                    height: 60,
                                                                                    width: 220,
                                                                                    child: Image.asset(
                                                                                      "images/thai_qr_payment.png",
                                                                                      height: 60,
                                                                                      width: 220,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 200,
                                                                                    height: 200,
                                                                                    child: Center(
                                                                                      child: PrettyQr(
                                                                                        // typeNumber: 3,
                                                                                        image: AssetImage(
                                                                                          "images/Icon-chao.png",
                                                                                        ),
                                                                                        size: 200,
                                                                                        data: generateQRCode(promptPayID: "$selectedValue", amount: totalQr_),
                                                                                        errorCorrectLevel: QrErrorCorrectLevel.M,
                                                                                        roundEdges: true,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'พร้อมเพย์ : $selectedValue',
                                                                                    style: TextStyle(
                                                                                      fontSize: 13,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'จำนวนเงิน : ${nFormat.format(totalQr_)} บาท',
                                                                                    style: TextStyle(
                                                                                      fontSize: 13,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '( ทำรายการ : $Value_newDateD1 / ชำระ : $Value_newDateD )',
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    color: Color(0xFFD9D9B7),
                                                                                    height: 60,
                                                                                    width: 220,
                                                                                    child: Image.asset(
                                                                                      "images/LOGOchao.png",
                                                                                      height: 70,
                                                                                      width: 220,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Center(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                220,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.green,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () async {
                                                                                // String qrCodeData = generateQRCode(promptPayID: "0613544026", amount: 1234.56);

                                                                                RenderRepaintBoundary boundary = qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                                                ui.Image image = await boundary.toImage();
                                                                                ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                                                                                Uint8List bytes = byteData!.buffer.asUint8List();
                                                                                html.Blob blob = html.Blob([
                                                                                  bytes
                                                                                ]);
                                                                                String url = html.Url.createObjectUrlFromBlob(blob);

                                                                                html.AnchorElement anchor = html.AnchorElement()
                                                                                  ..href = url
                                                                                  ..setAttribute('download', 'qrcode.png')
                                                                                  ..click();

                                                                                html.Url.revokeObjectUrl(url);
                                                                              },
                                                                              child: const Text(
                                                                                'Download QR Code',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
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
                                                                          height:
                                                                              5.0,
                                                                        ),
                                                                        const Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                          height:
                                                                              4.0,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Container(
                                                                                width: 100,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                ),
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: TextButton(
                                                                                  onPressed: () => Navigator.pop(context, 'OK'),
                                                                                  child: const Text(
                                                                                    'ปิด',
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                              ),
                                              if (paymentName1
                                                      .toString()
                                                      .trim() !=
                                                  'Online Payment')
                                                Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child: Container(
                                                      width: 800,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
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
                                                    )),
                                            ],
                                          )
                                        : SizedBox(),
                                  ),
                                  (paymentName1.toString().trim() ==
                                              'เงินโอน' ||
                                          paymentName1.toString().trim() ==
                                              'Online Payment')
                                      ? Expanded(
                                          flex: 3,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 50,
                                                  color: AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Center(
                                                    child: Text(
                                                      'เวลา',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T
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
                                                  color: AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 50,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                topRight: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                              ),
                                                              // border: Border.all(color: Colors.grey, width: 1),
                                                            ),
                                                            // padding: const EdgeInsets.all(8.0),
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  Form_time,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {});
                                                              },
                                                              // maxLength: 13,
                                                              cursorColor:
                                                                  Colors.green,
                                                              decoration: InputDecoration(
                                                                  fillColor: Colors.white.withOpacity(0.3),
                                                                  filled: true,
                                                                  // prefixIcon:
                                                                  //     const Icon(Icons.person, color: Colors.black),
                                                                  // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                  focusedBorder: const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                  enabledBorder: const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                  hintText: '00:00:00',
                                                                  // helperText: '00:00:00',
                                                                  // labelText: '00:00:00',
                                                                  labelStyle: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T)),

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
                                                              (base64_Slip ==
                                                                      null)
                                                                  ? uploadFile_Slip()
                                                                  : showDialog<
                                                                      void>(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false, // user must tap button!
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                                          title: const Center(
                                                                              child: Text(
                                                                            'มีไฟล์ slip อยู่แล้ว',
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          )),
                                                                          content:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                ListBody(
                                                                              children: const <Widget>[
                                                                                Text(
                                                                                  'มีไฟล์ slip อยู่แล้ว หากต้องการอัพโหลดกรุณาลบไฟล์ที่มีอยู่แล้วก่อน',
                                                                                  style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: <Widget>[
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                (base64_Slip == null)
                                                                                    ? SizedBox()
                                                                                    : Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
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
                                                                                                      '${widget.Value_cid}',
                                                                                                      maxLines: 1,
                                                                                                      textAlign: TextAlign.start,
                                                                                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  content: Stack(
                                                                                                    alignment: Alignment.center,
                                                                                                    children: <Widget>[
                                                                                                      Image.memory(
                                                                                                        base64Decode(base64_Slip.toString()),
                                                                                                        // height: 200,
                                                                                                        // fit: BoxFit.cover,
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  actions: <Widget>[
                                                                                                    Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                                          child: Container(
                                                                                                            width: 100,
                                                                                                            decoration: const BoxDecoration(
                                                                                                              color: Colors.black,
                                                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                            ),
                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                            child: TextButton(
                                                                                                              onPressed: () => Navigator.pop(context, 'OK'),
                                                                                                              child: const Text(
                                                                                                                'ปิด',
                                                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                                                            width: 120,
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.blue,
                                                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                              // border: Border.all(color: Colors.white, width: 1),
                                                                                            ),
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: const Text(
                                                                                              'เรียกดูไฟล์',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                                  //fontSize: 10.0
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: InkWell(
                                                                                    child: Container(
                                                                                        width: 100,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.red[600],
                                                                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: const Center(
                                                                                            child: Text(
                                                                                          'ลบไฟล์',
                                                                                          style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                        ))),
                                                                                    onTap: () async {
                                                                                      setState(() {
                                                                                        base64_Slip = null;
                                                                                      });
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: InkWell(
                                                                                    child: Container(
                                                                                        width: 100,
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.black,
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: const Center(
                                                                                            child: Text(
                                                                                          'ปิด',
                                                                                          style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                        ))),
                                                                                    onTap: () {
                                                                                      Navigator.of(context).pop();
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
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
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
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                // border: Border.all(
                                                                //     color: Colors.grey, width: 1),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: const Text(
                                                                'เพิ่มไฟล์',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
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
                                        )
                                      : SizedBox(),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        child: InkWell(
                                            onTap: () {
                                              if (transKonModels.length != 0) {
                                                _showMyDialogPay_Error(
                                                    'ไม่มียอดคืนคงเหลือ');
                                              } else {
                                                var v1 = sum_matjum;
                                                var v2 = sum_ST;
                                                setState(() {
                                                  Slip_status = '1';
                                                });
                                                print('$v1   $v2');
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
                                                pay_Pakan(newValuePDFimg);
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.orange[900],
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
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 25,
                                                  maxLines: 1,
                                                  'ยืนยัน',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
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
              ],
            ),
          )
        ],
      );

  Future<void> pay_Pakan(List<dynamic> newValuePDFimg) async {
    if ((sum_matjum - sum_ST) != 0.0) {
      if ((sum_matjum - sum_ST) > 0.0) {
        //คืนเงิน
        print('คืนเงิน');
        if (paymentName1 == null) {
          _showMyDialogPay_Error('กรุณาเลือกรูปแบบชำระ!');
        } else {
          if (paymentName1.toString().trim() == 'เงินโอน' ||
              paymentName1.toString().trim() == 'Online Payment') {
            if (base64_Slip != null) {
              try {
                OKuploadFile_Slip();
                await in_Trans_invoice(newValuePDFimg);
              } catch (e) {}
            } else {
              _showMyDialogPay_Error('กรุณาแนบหลักฐานการโอน(สลิป)!');
            }
          } else {
            try {
              await in_Trans_invoice(newValuePDFimg);
            } catch (e) {}
          }
        }
      } else {
        print('ชำระเพิ่ม');
        //ชำระเพิ่ม
        if (paymentName1 == null) {
          _showMyDialogPay_Error('กรุณาเลือกรูปแบบชำระ!');
        } else {
          if (paymentName1.toString().trim() == 'เงินโอน' ||
              paymentName1.toString().trim() == 'Online Payment') {
            if (base64_Slip != null) {
              try {
                OKuploadFile_Slip();
                await in_Trans_invoiceB(newValuePDFimg);
              } catch (e) {}
            } else {
              _showMyDialogPay_Error('กรุณาแนบหลักฐานการโอน(สลิป)!');
            }
          } else {
            // try {
            await in_Trans_invoiceB(newValuePDFimg);
            // } catch (e) {}
          }
        }
      }
    } else {}
  }

  Future<Null> in_Trans_invoice(newValuePDFimg) async {
    String? fileName_Slip_ = fileName_Slip.toString().trim();
    ////////////////------------------------------------------------------>
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Value_cid.toString();
    var qutser = '1';
    var sumdis = sum_matjum.toString();
    var sumdisp = sum_ST.toString();
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = Form_time.text;
    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    var payment1 = Form_payment1.text.toString();
    var pSer1 = paymentSer1.toString();

    print('in_Trans_invoice()///$fileName_Slip_');
    print('in_Trans_invoice>>> $payment1  $bill');

    String url =
        '${MyConstant().domain}/In_tran_return_Ma.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&pSer1=$pSer1&bill=$bill&fileNameSlip=$fileName_Slip_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(
          ' fileName_Slip_///// $fileName_Slip_////////////*------> ${result.toString()} ');
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

        Insert_log.Insert_logs(
            'ผู้เช่า', 'ยกเลิกสัญญา:$ciddoc >> คืนเงินประกัน : cFinn');

        setState(() {
          red_Trans_select2();
          read_GC_matjum();
          Form_payment1.clear();
          Form_time.clear();
          bills_name_ = 'บิลธรรมดา';
          cFinn = null;
          base64_Slip = null;
          // tableData00 = [];
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<Null> in_Trans_invoiceB(newValuePDFimg) async {
    print('111111');

    print('222');
    String? fileName_Slip_ = fileName_Slip.toString().trim();
    ////////////////------------------------------------------------------>
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Value_cid.toString();
    var qutser = '1';
    var sumdis = sum_matjum.toString();
    var sumdisp = sum_ST.toString();
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = Form_time.text;
    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    var payment1 = Form_payment1.text.toString();
    var pSer1 = paymentSer1.toString();

    print('in_Trans_invoice()///$fileName_Slip_');
    print('in_Trans_invoice>>> $payment1  $bill');

    String url =
        '${MyConstant().domain}/In_tran_returnB_Ma.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&pSer1=$pSer1&bill=$bill&fileNameSlip=$fileName_Slip_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(
          ' fileName_Slip_///// $fileName_Slip_////////////*------> ${result.toString()} ');
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

        Insert_log.Insert_logs(
            'ผู้เช่า', 'ยกเลิกสัญญา:$ciddoc >> คืนเงินประกัน : cFinn');

 

        setState(() {
          red_Trans_select2();
          read_GC_matjum();
          Form_payment1.clear();
          Form_time.clear();
          bills_name_ = 'บิลธรรมดา';
          cFinn = null;
          base64_Slip = null;
          // tableData00 = [];
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {
      print('$e');
    }
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
        fileName_Slip = 'slip_${widget.Value_cid}_${date}_$Time_.$extension_';
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
                            'เพิ่มรายการหัก',
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          // height: 350,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 80,
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
                                          labelText: 'รายการหัก',
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 80,
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
                                          labelText: 'ยอด',
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
    var ciddoc = widget.Value_cid;
    var qutser = '1';

    var textadd = text_add.text;
    var priceadd = price_add.text;

    String url =
        '${MyConstant().domain}/In_tran_select_pakan.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&textadd=$textadd&priceadd=$priceadd&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2();

          text_add.clear();
          price_add.clear();
        });
        print('rrrrrrrrrrrrrr');
      } else {
        setState(() {
          red_Trans_select2();

          text_add.clear();
          price_add.clear();
        });
      }
    } catch (e) {
      print('r $e');
    }
  }

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

  Future<Null> de_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Value_cid;
    var qutser = '1';

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
}
