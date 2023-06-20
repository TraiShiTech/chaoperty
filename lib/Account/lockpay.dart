import 'dart:convert';
import 'dart:html';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../CRC_16_Prompay/generate_qrcode.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/GetType_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/areak_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../PDF/pdf_LockReceipt.dart';
import '../PDF/pdf_Receipt.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class LockpayScreen extends StatefulWidget {
  const LockpayScreen({super.key});

  @override
  State<LockpayScreen> createState() => _LockpayScreenState();
}

class _LockpayScreenState extends State<LockpayScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  int Status_ = 1;
  String No_Area_ = '';
  String tappedIndex_ = '';
  List<ZoneModel> zoneModels = [];
  List<CustomerModel> customerModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];
  List<TeNantModel> teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<TransReBillModel> _TransReBillModels = [];
  Set<int> _selectedIndexes = Set();
  String? renTal_user,
      renTal_name,
      zone_ser,
      zone_name,
      Value_cid,
      fname_,
      pdate,
      number_custno;
  var Value_selectDate;
  List<RenTalModel> renTalModels = [];
  List<TypeModel> typeModels = [];
  List<AreaModel> areaModels = [];
  List<AreakModel> areakModels = [];
  List<PayMentModel> _PayMentModels = [];
  String? selectedValue;
  List Area_ = [
    'คอมมูนิตี้มอลล์',
    'ออฟฟิศให้เช่า',
    'ตลาดนัด',
    'อื่นๆ',
  ];
  List buttonview_ = [
    'ข้อมูลการเช่า',
    'ตั้งหนี้/วางบิล',
    'รับชำระ',
    'ลดหนี้',
    'ประวัติบิล',
  ];
  List Status = [
    'ภาพรวม',
    'ค้างชำระ',
    'ประวัติบิล',
    'ล็อกเสียบ ',
  ];
  List Default_ = [
    'บิลธรรมดา',
  ];
  List Default2_ = [
    'บิลธรรมดา',
    'ใบกำกับภาษี',
  ];
  String? teNantcid, teNantsname, teNantnamenew;
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
      numinvoice;
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
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;
  ////////////////----------------------------------->
  final _formKey = GlobalKey<FormState>();
  final Status4Form_nameshop = TextEditingController();
  final Status4Form_typeshop = TextEditingController();
  final Status4Form_bussshop = TextEditingController();
  final Status4Form_bussscontact = TextEditingController();
  final Status4Form_address = TextEditingController();
  final Status4Form_tel = TextEditingController();
  final Status4Form_email = TextEditingController();
  final Status4Form_tax = TextEditingController();
  final Status5Form_NoArea_ = TextEditingController();
  final Status5Form_NoArea_ren = TextEditingController();

  String _verticalGroupValue = '';
  int Value_AreaSer_ = 0;
  String? _Form_nameshop,
      _Form_typeshop,
      _Form_bussshop,
      _Form_bussscontact,
      _Form_address,
      _Form_tel,
      _Form_email,
      _Form_tax;
  List<String> _selecteSerbool = [];
  List _selecteSer = [];
  List _selecteZnSer = [];
  double _area_sum = 0;
  double _area_rent_sum = 0;
///////////////////////////////////--------------------------------->pay
  final sum_disamtx = TextEditingController();
  final sum_dispx = TextEditingController();
  final Form_payment1 = TextEditingController();
  final Form_payment2 = TextEditingController();
  final Form_time = TextEditingController();
  final Form_note = TextEditingController();

  int select_page = 0,
      pamentpage = 0; // = 0 _TransModels : = 1 _InvoiceHistoryModels
  String? paymentSer1,
      paymentName1,
      paymentSer2,
      paymentName2,
      cFinn,
      Value_newDateY = '',
      Value_newDateD = '',
      Value_newDateY1 = '',
      Value_newDateD1 = '';
  DateTime newDatetime = DateTime.now();
  String? name_slip, name_slip_ser;
  String? base64_Slip, fileName_Slip, Slip_status;
  List<ExpModel> expModels = [];
  List<TransModel> _TransModels = [];
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_zone();
    read_GC_tenant();
    red_Trans_bill();
    read_GC_rental();
    read_GC_type();
    read_GC_areaSelect();
    red_payMent();
    read_GC_Exp();
    red_Trans_select2();
    read_GC_areak();
    Value_newDateY1 = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD1 = DateFormat('dd-MM-yyyy').format(newDatetime);
    Value_newDateY = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD = DateFormat('dd-MM-yyyy').format(newDatetime);
  }

  Future<Null> read_GC_areak() async {
    if (areaModels.isNotEmpty) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');
    String url = '${MyConstant().domain}/In_c_areak.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);

      if (result != null) {
        for (var map in result) {
          AreaModel areakModel = AreaModel.fromJson(map);

          setState(() {
            if (int.parse(areakModel.aserQout!) == 0) {
              if (zone == areakModel.zser) {
                areaModels.add(areakModel);
              } else if (zone == '0') {
                areaModels.add(areakModel);
              }
            }
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  Future<Null> red_Trans_select2() async {
    if (_TransModels.length != 0) {
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
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_tran_select_new.php?isAdd=true&ren=$ren&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);

          var sum_pvatx =
              _TransModel.total == null ? 0 : double.parse(_TransModel.pvat!);
          var sum_vatx =
              _TransModel.total == null ? 0 : double.parse(_TransModel.vat!);
          var sum_whtx =
              _TransModel.total == null ? 0 : double.parse(_TransModel.wht!);
          var sum_amtx =
              _TransModel.total == null ? 0 : double.parse(_TransModel.total!);
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

      print('------------>>>>> $sum_amt =====  ${sum_disamtx.text}');
    } catch (e) {}
  }

  Future<Null> de_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    var tser = _TransModels[index].ser;
    var tdocno = _TransModels[index].docno;

    print('tser >>.> $tser');

    String url =
        '${MyConstant().domain}/De_tran_select.php?isAdd=true&ren=$ren&tser=$tser&tdocno=$tdocno&user=$user';
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
          setState(() {
            Form_payment1.text =
                (sum_amt - sum_disamt).toStringAsFixed(2).toString();
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> read_GC_areaSelect() async {
    if (areaModels.length != 0) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    String url = zone == null
        ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          if (areaModel.quantity != '1' && areaModel.quantity != '3') {
            setState(() {
              areaModels.add(areaModel);
            });
          }
        }
      } else {
        setState(() {
          if (areaModels.isEmpty) {
            preferences.remove('zoneSer');
            preferences.remove('zonesName');
            zone_ser = null;
            zone_name = null;
          }
        });
      }
      setState(() {
        // _areaModels = areaModels;
        zone_ser = preferences.getString('zoneSer');
        zone_name = preferences.getString('zonesName');
      });
    } catch (e) {}
  }

  Future<Null> read_GC_type() async {
    if (typeModels.isNotEmpty) {
      typeModels.clear();
    }

    String url = '${MyConstant().domain}/GC_type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TypeModel typeModel = TypeModel.fromJson(map);
          setState(() {
            typeModels.add(typeModel);
          });
        }
        // setState(() {
        //   for (var i = 0; i < typeModels.length; i++) {
        //     _verticalGroupValue = typeModels[i].type!;
        //   }
        // });
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
      print(result);
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

  Future<Null> red_Trans_bill() async {
    if (_TransReBillModels.length != 0) {
      setState(() {
        _TransReBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
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
        ? '${MyConstant().domain}/GC_tenantAll_setring.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_tenantAll_setring.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_tenant_setring.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            if (teNantModel.cid != '') {
              var daterx = teNantModel.ldate;
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
            // teNantModels.add(teNantModel);
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

  ///----------------->
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveUp3() {
    _scrollController3.animateTo(_scrollController3.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown3() {
    _scrollController3.animateTo(_scrollController3.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  Future<Null> _select_Date(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่เริ่มต้น', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      // selectableDayPredicate: _decideWhichDayToEnable,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppBarColors.ABar_Colors, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    picked.then((result) {
      if (picked != null) {
        print("${result!.year}/${result.month}/${result.day}");
        setState(() {
          Value_selectDate = "${result.day}-${result.month}-${result.year}";
        });
      }
    });
  }

  Future<Null> in_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    DateTime newDatetimex = DateTime.now();

    var tser = expModels[index].ser;

    var selecte = _selecteSerbool.length;
    var selecte_ln =
        '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}';

    var day = DateFormat('dd').format(newDatetimex);
    var timex = DateFormat('HHmmss').format(newDatetimex);

    var ciddoc = No_Area_ == 'ไม่ระบุพื้นที่'
        ? 'L$day$timex-${Status5Form_NoArea_.text}'
        : 'L$day$timex-${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}'; //In_c_paynew

    print('$tser>>>>$selecte>>>>$_area_rent_sum');

    var area_rent_sum = expModels[index].cal_auto == '1'
        ? expModels[index].pri_auto
        : _area_rent_sum; //ราคาพื้นที่

    // print('object $tdocno');
    String url =
        '${MyConstant().domain}/In_c_paynew.php?isAdd=true&ren=$ren&tser=$tser&selecte=$selecte&selecte_ln=$selecte_ln&_area_rent_sum=$area_rent_sum&user=$user&ciddoc=$ciddoc';
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

  ///----------------->
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

  Future<void> OKuploadFile_Slip(cFinn) async {
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
        fileName_Slip = 'slip_${cFinn}_${date}_$Time_.$extension_';
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

  ///----------------------------------------------------------->
  _searchBarAll() {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 0)),
        builder: (context, snapshot) {
          return TextField(
            autofocus: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              // fontSize: 22.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.white,
              hintText: ' Search...',
              hintStyle: const TextStyle(
                color: PeopleChaoScreen_Color.Colors_Text1_,
                // fontWeight: FontWeight.bold,
                fontFamily: Font_.Fonts_T,
              ),
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
              text = text.toLowerCase();
              print(text);

              print(customerModels.map((e) => e.docno));
              print(_customerModels.map((e) => e.docno));

              setState(() {
                customerModels = _customerModels.where((customerModel) {
                  var notTitle = customerModel.custno.toString().toLowerCase();
                  var notTitle2 = customerModel.tax.toString().toLowerCase();
                  var notTitle3 = customerModel.scname.toString().toLowerCase();
                  return notTitle.contains(text) ||
                      notTitle2.contains(text) ||
                      notTitle3.contains(text);
                }).toList();
              });

              print(customerModels.map((e) => e.scname));
              print(_customerModels.map((e) => e.scname));
            },
          );
        });
  }

  ///----------------------------------------------------------->

  Future<Null> select_coutumerAll() async {
    if (customerModels.isNotEmpty) {
      setState(() {
        customerModels.clear();
        _customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_custo_se.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            customerModels.add(customerModel);
          });
        }
      }
      setState(() {
        _customerModels = customerModels;
      });
    } catch (e) {}

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
          // stream: Stream.periodic(const Duration(seconds: 0)),
          builder: (context, snapshot) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: const [
              Center(
                child: Text(
                  'เลือกรายชื่อจากทะเบียน',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: _searchBarAll(),
                      ),
                    ],
                  ),
                ),
                ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    dragStartBehavior: DragStartBehavior.start,
                    child: Row(
                      children: [
                        Container(
                          // height:
                          //     MediaQuery.of(context).size.height /
                          //         1.5,
                          width: (!Responsive.isDesktop(context))
                              ? 1000
                              : MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            // border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade600,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            flex: 2,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'รหัสสมาชิก',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'ชื่อร้าน',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'ชื่อผู่เช่า/บริษัท',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'ประเภท',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'Select',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width: (!Responsive.isDesktop(context))
                                            ? 1000
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: StreamBuilder(
                                            stream: Stream.periodic(
                                                const Duration(seconds: 0)),
                                            builder: (context, snapshot) {
                                              return ListView.builder(
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      customerModels.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            Status4Form_nameshop
                                                                    .text =
                                                                '${customerModels[index].scname}';
                                                            Status4Form_typeshop
                                                                    .text =
                                                                '${customerModels[index].stype}';
                                                            Status4Form_bussshop
                                                                    .text =
                                                                '${customerModels[index].cname}';
                                                            Status4Form_bussscontact
                                                                    .text =
                                                                '${customerModels[index].attn}';
                                                            Status4Form_address
                                                                    .text =
                                                                '${customerModels[index].addr1}';
                                                            Status4Form_tel
                                                                    .text =
                                                                '${customerModels[index].tel}';
                                                            Status4Form_email
                                                                    .text =
                                                                '${customerModels[index].email}';
                                                            Status4Form_tax
                                                                .text = customerModels[
                                                                            index]
                                                                        .tax ==
                                                                    'null'
                                                                ? "-"
                                                                : '${customerModels[index].tax}';
                                                            Value_AreaSer_ = int.parse(
                                                                    customerModels[
                                                                            index]
                                                                        .typeser!) -
                                                                1; // ser ประเภท
                                                            _verticalGroupValue =
                                                                '${customerModels[index].type}'; // ประเภท

                                                            _Form_nameshop =
                                                                '${customerModels[index].scname}';
                                                            _Form_typeshop =
                                                                '${customerModels[index].stype}';
                                                            _Form_bussshop =
                                                                '${customerModels[index].cname}';
                                                            _Form_bussscontact =
                                                                '${customerModels[index].attn}';
                                                            _Form_address =
                                                                '${customerModels[index].addr1}';
                                                            _Form_tel =
                                                                '${customerModels[index].tel}';
                                                            _Form_email =
                                                                '${customerModels[index].email}';
                                                            _Form_tax = customerModels[
                                                                            index]
                                                                        .tax ==
                                                                    'null'
                                                                ? "-"
                                                                : '${customerModels[index].tax}';

                                                            number_custno =
                                                                customerModels[
                                                                        index]
                                                                    .custno
                                                                    .toString();
                                                          });

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        title: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 18,
                                                                customerModels[index]
                                                                            .custno ==
                                                                        null
                                                                    ? ''
                                                                    : '${customerModels[index].custno}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                  // fontWeight: FontWeight.bold,
                                                                  // fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 18,
                                                                '${customerModels[index].scname}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                  // fontWeight: FontWeight.bold,
                                                                  // fontWeight: FontWeight.bold,  549 3 02891 8
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 18,
                                                                '${customerModels[index].cname}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                  // fontWeight: FontWeight.bold,
                                                                  // fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 18,
                                                                '${customerModels[index].type}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                  // fontWeight: FontWeight.bold,
                                                                  // fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            const Expanded(
                                                              flex: 1,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 18,
                                                                'Select',
                                                                style:
                                                                    TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                  // fontWeight: FontWeight.bold,
                                                                  // fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            })),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
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
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

///////----------------------------------------->
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
  GlobalKey qrImageKey = GlobalKey();
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                Form(
                  key: _formKey,
                  child: Container(
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    // height: 450,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 20,
                                'ข้อมูลผู้เช่า ( ล็อกเสียบ )',
                                style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // _searchBar(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'ประเภท',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: StreamBuilder(
                                          stream: Stream.periodic(
                                              const Duration(seconds: 0)),
                                          builder: (context, snapshot) {
                                            return RadioGroup<
                                                TypeModel>.builder(
                                              direction: Axis.horizontal,
                                              groupValue: typeModels
                                                  .elementAt(Value_AreaSer_),
                                              horizontalAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              onChanged: (value) {
                                                Status4Form_nameshop.clear();
                                                Status4Form_bussshop.clear();
                                                Status4Form_bussscontact
                                                    .clear();
                                                setState(() {
                                                  Value_AreaSer_ =
                                                      int.parse(value!.ser!) -
                                                          1;
                                                  _verticalGroupValue =
                                                      value.type!;
                                                  _TransModels = [];
                                                });
                                                print(Value_AreaSer_);
                                              },
                                              items: typeModels,
                                              textStyle: const TextStyle(
                                                fontSize: 15,
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                              ),
                                              itemBuilder: (typeXModels) =>
                                                  RadioButtonBuilder(
                                                typeXModels.type!,
                                              ),
                                            );
                                          })),
                                ),
                              ),
                              (Responsive.isDesktop(context))
                                  ? Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                            onTap: () {},
                                            child: const Text('')),
                                      ),
                                    )
                                  : SizedBox(),
                              (Responsive.isDesktop(context))
                                  ? Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: StreamBuilder(
                                            stream: Stream.periodic(
                                                const Duration(seconds: 0)),
                                            builder: (context, snapshot) {
                                              return Container(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          const AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            'พื้นที่ ',
                                                            style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                    .TiTile_Colors,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
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
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  PopupMenuButton(
                                                                child: (No_Area_
                                                                            .toString() !=
                                                                        '')
                                                                    ? AutoSizeText(
                                                                        '$No_Area_',
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            15,
                                                                        maxLines:
                                                                            3,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text1_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: FontWeight_.Fonts_T),
                                                                      )
                                                                    : AutoSizeText(
                                                                        (_selecteSer.length ==
                                                                                0)
                                                                            ? 'เลือก'
                                                                            : '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)}',
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            15,
                                                                        maxLines:
                                                                            3,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text1_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: FontWeight_.Fonts_T),
                                                                      ),
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context) =>
                                                                        [
                                                                  PopupMenuItem(
                                                                    child: InkWell(
                                                                        onTap: () async {
                                                                          setState(
                                                                              () {
                                                                            No_Area_ =
                                                                                'ไม่ระบุพื้นที่';
                                                                            _selecteSer.clear();
                                                                            _selecteSer.clear();
                                                                            _selecteZnSer.clear();
                                                                            _selecteSerbool.clear();
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Container(
                                                                            padding: const EdgeInsets.all(10),
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: Row(
                                                                              children: const [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'ไม่ระบุพื้นที่',
                                                                                    style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ))),
                                                                  ),
                                                                  PopupMenuItem(
                                                                    child: InkWell(
                                                                        onTap: () async {
                                                                          // read_GC_areaSelect();
                                                                          read_GC_areak();
                                                                          showDialog<
                                                                              String>(
                                                                            barrierDismissible:
                                                                                false,
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                AlertDialog(
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                              title: const Center(
                                                                                  child: Text(
                                                                                'เลือกพื้นที่',
                                                                                style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                              )),
                                                                              content: SingleChildScrollView(
                                                                                child: ListBody(
                                                                                  children: <Widget>[
                                                                                    StreamBuilder(
                                                                                        stream: Stream.periodic(const Duration(seconds: 0)),
                                                                                        builder: (context, snapshot) {
                                                                                          return CheckboxGroup(
                                                                                              checked: _selecteSerbool,
                                                                                              activeColor: Colors.red,
                                                                                              checkColor: Colors.white,
                                                                                              labels: <String>[
                                                                                                for (var i = 0; i < areaModels.length; i++) '${areaModels[i].lncode}',
                                                                                              ],
                                                                                              labelStyle: const TextStyle(
                                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                // fontWeight: FontWeight.bold,
                                                                                                fontFamily: Font_.Fonts_T,
                                                                                              ),
                                                                                              onChange: (isChecked, label, index) {
                                                                                                if (isChecked == false) {
                                                                                                  _selecteSer.remove(areaModels[index].ser);
                                                                                                  _selecteZnSer.remove(areaModels[index].zser);

                                                                                                  double areax = double.parse(areaModels[index].area!);
                                                                                                  double rentx = double.parse(areaModels[index].rent!);
                                                                                                  _area_sum = _area_sum - areax;
                                                                                                  _area_rent_sum = _area_rent_sum - rentx;

                                                                                                  if (isChecked == true) {
                                                                                                    setState(() {
                                                                                                      _area_sum = _area_sum + areax;
                                                                                                      _area_rent_sum = _area_rent_sum + rentx;
                                                                                                      _selecteSer.add(areaModels[index].ser);
                                                                                                      _selecteZnSer.add(areaModels[index].zser);
                                                                                                    });
                                                                                                  }
                                                                                                } else {
                                                                                                  double areax = double.parse(areaModels[index].area!);
                                                                                                  double rentx = double.parse(areaModels[index].rent!);
                                                                                                  if (isChecked == true) {
                                                                                                    setState(() {
                                                                                                      _area_sum = _area_sum + areax;
                                                                                                      _area_rent_sum = _area_rent_sum + rentx;
                                                                                                      _selecteSer.add(areaModels[index].ser);
                                                                                                      _selecteZnSer.add(areaModels[index].zser);
                                                                                                    });
                                                                                                  }
                                                                                                }
                                                                                                print('เลือกพื้นที่ :  ${_selecteSer.map((e) => e)}  : _area_sum = $_area_sum _area_rent_sum = $_area_rent_sum ');
                                                                                              },
                                                                                              onSelected: (List<String> selected) {
                                                                                                setState(() {
                                                                                                  _selecteSerbool = selected;
                                                                                                });
                                                                                                print('SerGetBankModels_ : ${_selecteSerbool}');
                                                                                              });
                                                                                        })
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              actions: <Widget>[
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: 100,
                                                                                              decoration: const BoxDecoration(
                                                                                                color: Colors.green,
                                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                              ),
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: TextButton(
                                                                                                onPressed: () {
                                                                                                  setState(() {
                                                                                                    No_Area_ = '';
                                                                                                    Status5Form_NoArea_.clear();
                                                                                                  });
                                                                                                  // setState(
                                                                                                  //     () {
                                                                                                  //   read_GC_areaSelectSer();
                                                                                                  // });
                                                                                                  Navigator.pop(context, 'OK');
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                child: const Text(
                                                                                                  'บันทึก',
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.white,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 100,
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.black,
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: TextButton(
                                                                                          onPressed: () {
                                                                                            setState(() {
                                                                                              _selecteSer.clear();
                                                                                              _selecteSerbool.clear();
                                                                                            });
                                                                                            Navigator.pop(context);
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: const Text(
                                                                                            'ยกเลิก',
                                                                                            style: TextStyle(
                                                                                              color: Colors.white,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                            padding: const EdgeInsets.all(10),
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: Row(
                                                                              children: const [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'ระบุพื้นที่',
                                                                                    style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ))),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          // InkWell(
                                                          //   child: Container(
                                                          //     width: 100,
                                                          //     decoration:
                                                          //         BoxDecoration(
                                                          //       color: AppbackgroundColor
                                                          //           .TiTile_Colors,
                                                          //       borderRadius: const BorderRadius
                                                          //               .only(
                                                          //           topLeft:
                                                          //               Radius.circular(
                                                          //                   10),
                                                          //           topRight: Radius
                                                          //               .circular(
                                                          //                   10),
                                                          //           bottomLeft:
                                                          //               Radius.circular(
                                                          //                   10),
                                                          //           bottomRight:
                                                          //               Radius.circular(
                                                          //                   10)),
                                                          //       border: Border.all(
                                                          //           color: Colors
                                                          //               .black,
                                                          //           width: 1),
                                                          //     ),
                                                          //     padding:
                                                          //         const EdgeInsets
                                                          //             .all(8.0),
                                                          //     child:
                                                          //         AutoSizeText(
                                                          //       minFontSize: 10,
                                                          //       maxFontSize: 15,
                                                          //       maxLines: 3,
                                                          //       _selecteSer.length ==
                                                          //               0
                                                          //           ? 'เลือก'
                                                          //           : '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)}',
                                                          //       style: const TextStyle(
                                                          //           color: PeopleChaoScreen_Color
                                                          //               .Colors_Text1_,
                                                          //           fontWeight:
                                                          //               FontWeight
                                                          //                   .bold,
                                                          //           fontFamily:
                                                          //               FontWeight_
                                                          //                   .Fonts_T),
                                                          //     ),
                                                          //   ),
                                                          //   onTap: () async {
                                                          //     // read_GC_areaSelect();
                                                          //     read_GC_areak();
                                                          //     showDialog<
                                                          //         String>(
                                                          //       barrierDismissible:
                                                          //           false,
                                                          //       context:
                                                          //           context,
                                                          //       builder: (BuildContext
                                                          //               context) =>
                                                          //           AlertDialog(
                                                          //         shape: const RoundedRectangleBorder(
                                                          //             borderRadius:
                                                          //                 BorderRadius.all(
                                                          //                     Radius.circular(20.0))),
                                                          //         title:
                                                          //             const Center(
                                                          //                 child:
                                                          //                     Text(
                                                          //           'เลือกพื้นที่',
                                                          //           style: TextStyle(
                                                          //               color: PeopleChaoScreen_Color
                                                          //                   .Colors_Text1_,
                                                          //               fontWeight:
                                                          //                   FontWeight
                                                          //                       .bold,
                                                          //               fontFamily:
                                                          //                   FontWeight_.Fonts_T),
                                                          //         )),
                                                          //         content:
                                                          //             SingleChildScrollView(
                                                          //           child:
                                                          //               ListBody(
                                                          //             children: <Widget>[
                                                          //               StreamBuilder(
                                                          //                   stream:
                                                          //                       Stream.periodic(const Duration(seconds: 0)),
                                                          //                   builder: (context, snapshot) {
                                                          //                     return CheckboxGroup(
                                                          //                         checked: _selecteSerbool,
                                                          //                         activeColor: Colors.red,
                                                          //                         checkColor: Colors.white,
                                                          //                         labels: <String>[
                                                          //                           for (var i = 0; i < areaModels.length; i++) '${areaModels[i].lncode}',
                                                          //                         ],
                                                          //                         labelStyle: const TextStyle(
                                                          //                           color: PeopleChaoScreen_Color.Colors_Text2_,
                                                          //                           // fontWeight: FontWeight.bold,
                                                          //                           fontFamily: Font_.Fonts_T,
                                                          //                         ),
                                                          //                         onChange: (isChecked, label, index) {
                                                          //                           if (isChecked == false) {
                                                          //                             _selecteSer.remove(areaModels[index].ser);
                                                          //                             _selecteZnSer.remove(areaModels[index].zser);

                                                          //                             double areax = double.parse(areaModels[index].area!);
                                                          //                             double rentx = double.parse(areaModels[index].rent!);
                                                          //                             _area_sum = _area_sum - areax;
                                                          //                             _area_rent_sum = _area_rent_sum - rentx;

                                                          //                             if (isChecked == true) {
                                                          //                               setState(() {
                                                          //                                 _area_sum = _area_sum + areax;
                                                          //                                 _area_rent_sum = _area_rent_sum + rentx;
                                                          //                                 _selecteSer.add(areaModels[index].ser);
                                                          //                                 _selecteZnSer.add(areaModels[index].zser);
                                                          //                               });
                                                          //                             }
                                                          //                           } else {
                                                          //                             double areax = double.parse(areaModels[index].area!);
                                                          //                             double rentx = double.parse(areaModels[index].rent!);
                                                          //                             if (isChecked == true) {
                                                          //                               setState(() {
                                                          //                                 _area_sum = _area_sum + areax;
                                                          //                                 _area_rent_sum = _area_rent_sum + rentx;
                                                          //                                 _selecteSer.add(areaModels[index].ser);
                                                          //                                 _selecteZnSer.add(areaModels[index].zser);
                                                          //                               });
                                                          //                             }
                                                          //                           }
                                                          //                           print('เลือกพื้นที่ :  ${_selecteSer.map((e) => e)}  : _area_sum = $_area_sum _area_rent_sum = $_area_rent_sum ');
                                                          //                         },
                                                          //                         onSelected: (List<String> selected) {
                                                          //                           setState(() {
                                                          //                             _selecteSerbool = selected;
                                                          //                           });
                                                          //                           print('SerGetBankModels_ : ${_selecteSerbool}');
                                                          //                         });
                                                          //                   })
                                                          //             ],
                                                          //           ),
                                                          //         ),
                                                          //         actions: <Widget>[
                                                          //           Padding(
                                                          //             padding:
                                                          //                 const EdgeInsets.all(
                                                          //                     8.0),
                                                          //             child:
                                                          //                 Row(
                                                          //               mainAxisAlignment:
                                                          //                   MainAxisAlignment.end,
                                                          //               children: [
                                                          //                 Padding(
                                                          //                   padding:
                                                          //                       const EdgeInsets.all(8.0),
                                                          //                   child:
                                                          //                       Row(
                                                          //                     mainAxisAlignment: MainAxisAlignment.center,
                                                          //                     children: [
                                                          //                       Container(
                                                          //                         width: 100,
                                                          //                         decoration: const BoxDecoration(
                                                          //                           color: Colors.green,
                                                          //                           borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                          //                         ),
                                                          //                         padding: const EdgeInsets.all(8.0),
                                                          //                         child: TextButton(
                                                          //                           onPressed: () {
                                                          //                             setState(() {
                                                          //                               No_Area_ = '';
                                                          //                               Status5Form_NoArea_.clear();
                                                          //                             });
                                                          //                             // setState(
                                                          //                             //     () {
                                                          //                             //   read_GC_areaSelectSer();
                                                          //                             // });
                                                          //                             Navigator.pop(context, 'OK');
                                                          //                           },
                                                          //                           child: const Text(
                                                          //                             'บันทึก',
                                                          //                             style: TextStyle(
                                                          //                               color: Colors.white,
                                                          //                               fontWeight: FontWeight.bold,
                                                          //                               fontFamily: FontWeight_.Fonts_T,
                                                          //                             ),
                                                          //                           ),
                                                          //                         ),
                                                          //                       ),
                                                          //                     ],
                                                          //                   ),
                                                          //                 ),
                                                          //                 Container(
                                                          //                   width:
                                                          //                       100,
                                                          //                   decoration:
                                                          //                       const BoxDecoration(
                                                          //                     color: Colors.black,
                                                          //                     borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                          //                   ),
                                                          //                   padding:
                                                          //                       const EdgeInsets.all(8.0),
                                                          //                   child:
                                                          //                       TextButton(
                                                          //                     onPressed: () {
                                                          //                       Navigator.pop(context);
                                                          //                       setState(() {
                                                          //                         _selecteSer.clear();
                                                          //                         _selecteSerbool.clear();
                                                          //                       });
                                                          //                     },
                                                          //                     child: const Text(
                                                          //                       'ยกเลิก',
                                                          //                       style: TextStyle(
                                                          //                         color: Colors.white,
                                                          //                         fontWeight: FontWeight.bold,
                                                          //                         fontFamily: FontWeight_.Fonts_T,
                                                          //                       ),
                                                          //                     ),
                                                          //                   ),
                                                          //                 ),
                                                          //               ],
                                                          //             ),
                                                          //           ),
                                                          //         ],
                                                          //       ),
                                                          //     );
                                                          //   },
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  : SizedBox(),
                              Expanded(
                                flex: (Responsive.isDesktop(context)) ? 1 : 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: (Responsive.isDesktop(context))
                                      ? InkWell(
                                          onTap: () {
                                            // setState(() {
                                            //   select_coutumerindex = 1;
                                            // });
                                            select_coutumerAll();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ค้นจากทะเบียน',
                                              maxLines: 5,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                                fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                              ),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                StreamBuilder(
                                                    stream: Stream.periodic(
                                                        const Duration(
                                                            seconds: 0)),
                                                    builder:
                                                        (context, snapshot) {
                                                      return Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  const AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        15,
                                                                    'พื้นที่ ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text1_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppbackgroundColor
                                                                            .TiTile_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                            width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            15,
                                                                        maxLines:
                                                                            3,
                                                                        _selecteSer.length ==
                                                                                0
                                                                            ? 'เลือก'
                                                                            : '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)}',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text1_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: FontWeight_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      // read_GC_areaSelect();
                                                                      read_GC_areak();
                                                                      showDialog<
                                                                          String>(
                                                                        barrierDismissible:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                AlertDialog(
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                          title: const Center(
                                                                              child: Text(
                                                                            'เลือกพื้นที่',
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          )),
                                                                          content:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                ListBody(
                                                                              children: <Widget>[
                                                                                StreamBuilder(
                                                                                    stream: Stream.periodic(const Duration(seconds: 0)),
                                                                                    builder: (context, snapshot) {
                                                                                      return CheckboxGroup(
                                                                                          checked: _selecteSerbool,
                                                                                          activeColor: Colors.red,
                                                                                          checkColor: Colors.white,
                                                                                          labels: <String>[
                                                                                            for (var i = 0; i < areaModels.length; i++) '${areaModels[i].lncode}',
                                                                                          ],
                                                                                          labelStyle: const TextStyle(
                                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                          onChange: (isChecked, label, index) {
                                                                                            if (isChecked == false) {
                                                                                              _selecteSer.remove(areaModels[index].ser);
                                                                                              _selecteZnSer.remove(areaModels[index].zser);

                                                                                              double areax = double.parse(areaModels[index].area!);
                                                                                              double rentx = double.parse(areaModels[index].rent!);
                                                                                              _area_sum = _area_sum - areax;
                                                                                              _area_rent_sum = _area_rent_sum - rentx;

                                                                                              if (isChecked == true) {
                                                                                                setState(() {
                                                                                                  _area_sum = _area_sum + areax;
                                                                                                  _area_rent_sum = _area_rent_sum + rentx;
                                                                                                  _selecteSer.add(areaModels[index].ser);
                                                                                                  _selecteZnSer.add(areaModels[index].zser);
                                                                                                });
                                                                                              }
                                                                                            } else {
                                                                                              double areax = double.parse(areaModels[index].area!);
                                                                                              double rentx = double.parse(areaModels[index].rent!);
                                                                                              if (isChecked == true) {
                                                                                                setState(() {
                                                                                                  _area_sum = _area_sum + areax;
                                                                                                  _area_rent_sum = _area_rent_sum + rentx;
                                                                                                  _selecteSer.add(areaModels[index].ser);
                                                                                                  _selecteZnSer.add(areaModels[index].zser);
                                                                                                });
                                                                                              }
                                                                                            }
                                                                                            print('เลือกพื้นที่ :  ${_selecteSer.map((e) => e)}  : _area_sum = $_area_sum _area_rent_sum = $_area_rent_sum ');
                                                                                          },
                                                                                          onSelected: (List<String> selected) {
                                                                                            setState(() {
                                                                                              _selecteSerbool = selected;
                                                                                            });
                                                                                            print('SerGetBankModels_ : ${_selecteSerbool}');
                                                                                          });
                                                                                    })
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: <Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 100,
                                                                                          decoration: const BoxDecoration(
                                                                                            color: Colors.green,
                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                No_Area_ = '';
                                                                                                Status5Form_NoArea_.clear();
                                                                                              });
                                                                                              // setState(
                                                                                              //     () {
                                                                                              //   read_GC_areaSelectSer();
                                                                                              // });
                                                                                              Navigator.pop(context, 'OK');
                                                                                            },
                                                                                            child: const Text(
                                                                                              'บันทึก',
                                                                                              style: TextStyle(
                                                                                                color: Colors.white,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 100,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.black,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: TextButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                        setState(() {
                                                                                          _selecteSer.clear();
                                                                                          _selecteSerbool.clear();
                                                                                        });
                                                                                      },
                                                                                      child: const Text(
                                                                                        'ยกเลิก',
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   select_coutumerindex = 1;
                                                    // });
                                                    select_coutumerAll();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Text(
                                                      'ค้นจากทะเบียน',
                                                      maxLines: 5,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        //fontSize: 10.0
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (No_Area_.toString() == 'ไม่ระบุพื้นที่')
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'อธิบายเพิ่มเติม(ไม่ระบุพื้นที่)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      // color: Colors.green,
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
                                      //keyboardType: TextInputType.none,
                                      controller: Status5Form_NoArea_,
                                      // onChanged: (value) =>
                                      //     _Form_typeshop =
                                      //         value.trim(),
                                      //initialValue: _Form_typeshop,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรอกข้อมูลให้ครบถ้วน ';
                                        }
                                        // if (int.parse(value.toString()) < 13) {
                                        //   return '< 13';
                                        // }
                                        return null;
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
                                          labelText: 'คำอธิบายเพิ่มเติม',
                                          labelStyle: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          )),
                                      // inputFormatters: <TextInputFormatter>[
                                      //   // for below version 2 use this
                                      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      //   // for version 2 and greater youcan also use this
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                    ),
                                    // _selecteSerbool
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      // color: Colors.green,
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
                                      //keyboardType: TextInputType.none,
                                      controller: Status5Form_NoArea_ren,
                                      onChanged: (value) {
                                        setState(() {
                                          _selecteSerbool.clear();
                                        });
                                        for (var i = 0;
                                            i < int.parse(value);
                                            i++) {
                                          setState(() {
                                            _selecteSerbool.add('${i + 1}');
                                          });
                                        }
                                      },
                                      //initialValue: _Form_typeshop,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรอกข้อมูลให้ครบถ้วน ';
                                        }
                                        // if (int.parse(value.toString()) < 13) {
                                        //   return '< 13';
                                        // }
                                        return null;
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
                                          labelText: 'จำนวนพื้นที่',
                                          labelStyle: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          )),
                                      inputFormatters: <TextInputFormatter>[
                                        // for below version 2 use this
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                        // for version 2 and greater youcan also use this
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    // _selecteSerbool
                                  ),
                                ),
                              ],
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'ชื่อร้านค้า',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
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
                                    // keyboardType: TextInputType.name,
                                    controller: Status4Form_nameshop,
                                    // onChanged: (value) {
                                    //   // Status4Form_nameshop.text = value.trim();
                                    //   (Value_AreaSer_ + 1) == 1
                                    //       ? Status4Form_bussshop.text =
                                    //           value.trim()
                                    //       : Status4Form_bussscontact.text =
                                    //           value.trim();
                                    // },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                      }
                                      // if (int.parse(value.toString()) < 13) {
                                      //   return '< 13';
                                      // }
                                      return null;
                                    },
//  controller: (Value_AreaSer_ + 1) == 1
//                                         ? Status4Form_bussshop
//                                         : Status4Form_bussscontact,
//                                     onChanged: (value) {
//                                       Status4Form_nameshop.text = value.trim();
//                                       if ((Value_AreaSer_ + 1) == 1) {
//                                         _Form_bussshop = value.trim();
//                                         Status4Form_bussshop.text =
//                                                 value.trim()
//                                       } else {
//                                         _Form_bussscontact = value.trim();
//                                         Status4Form_bussscontact.text =
//                                                 value.trim()
//                                       }
//                                     },

                                    // maxLength: 13,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        filled: true,
                                        // prefixIcon:
                                        //     const Icon(Icons.person, color: Colors.black),
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
                                        labelText: 'ระบุชื่อร้านค้า',
                                        labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        )),
                                    // inputFormatters: <TextInputFormatter>[
                                    // for below version 2 use this
                                    // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    // // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                    // ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'ประเภทร้านค้า',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
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
                                    //keyboardType: TextInputType.none,
                                    controller: Status4Form_typeshop,
                                    // onChanged: (value) =>
                                    //     _Form_typeshop =
                                    //         value.trim(),
                                    //initialValue: _Form_typeshop,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'กรอกข้อมูลให้ครบถ้วน ';
                                    //   }
                                    //   // if (int.parse(value.toString()) < 13) {
                                    //   //   return '< 13';
                                    //   // }
                                    //   return null;
                                    // },
                                    // maxLength: 13,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        filled: true,
                                        // prefixIcon:
                                        //     const Icon(Icons.person, color: Colors.black),
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
                                        labelText: 'ระบุประเภทร้านค้า',
                                        labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        )),
                                    // inputFormatters: <TextInputFormatter>[
                                    //   // for below version 2 use this
                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    //   // for version 2 and greater youcan also use this
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
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
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'ชื่อผู้เช่า/บริษัท',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
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
                                    //keyboardType: TextInputType.none,
                                    controller: (Value_AreaSer_ + 1) == 1
                                        ? Status4Form_bussshop
                                        : Status4Form_bussscontact,
                                    onChanged: (value) {
                                      Status4Form_nameshop.text = value.trim();
                                      if ((Value_AreaSer_ + 1) == 1) {
                                        _Form_bussshop = value.trim();
                                      } else {
                                        _Form_bussscontact = value.trim();
                                      }
                                    },

                                    //initialValue: _Form_bussshop,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'กรอกข้อมูลให้ครบถ้วน ';
                                    //   }
                                    //   // if (int.parse(value.toString()) < 13) {
                                    //   //   return '< 13';
                                    //   // }
                                    //   return null;
                                    // },
                                    // maxLength: 13,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        filled: true,
                                        // prefixIcon:
                                        //     const Icon(Icons.person, color: Colors.black),
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
                                        labelText: 'ระบุชื่อผู้เช่า/บริษัท',
                                        labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        )),
                                    // inputFormatters: <TextInputFormatter>[
                                    //   // for below version 2 use this
                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    //   // for version 2 and greater youcan also use this
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'ชื่อบุคคลติดต่อ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
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
                                    //keyboardType: TextInputType.none,
                                    controller: Status4Form_bussshop,
                                    onChanged: (value) {
                                      if ((Value_AreaSer_ + 1) == 1) {
                                        Status4Form_nameshop.text =
                                            value.trim();
                                      } else {}
                                    },
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'กรอกข้อมูลให้ครบถ้วน ';
                                    //   }
                                    //   // if (int.parse(value.toString()) < 13) {
                                    //   //   return '< 13';
                                    //   // }
                                    //   return null;
                                    // },
                                    // maxLength: 13,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        filled: true,
                                        // prefixIcon:
                                        //     const Icon(Icons.person, color: Colors.black),
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
                                        labelText: 'ระบุชื่อบุคคลติดต่อ',
                                        labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        )),
                                    // inputFormatters: <TextInputFormatter>[
                                    //   // for below version 2 use this
                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    //   // for version 2 and greater youcan also use this
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
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
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'ที่อยู่',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
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
                                    //keyboardType: TextInputType.none,
                                    controller: Status4Form_address,
                                    // onChanged: (value) =>
                                    //     _Form_address =
                                    //         value.trim(),
                                    //initialValue: _Form_address,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'กรอกข้อมูลให้ครบถ้วน ';
                                    //   }
                                    //   // if (int.parse(value.toString()) < 13) {
                                    //   //   return '< 13';
                                    //   // }
                                    //   return null;
                                    // },
                                    // maxLength: 13,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        filled: true,
                                        // prefixIcon:
                                        //     const Icon(Icons.person, color: Colors.black),
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
                                        labelText: 'ระบุที่อยู่',
                                        labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        )),
                                    // inputFormatters: <TextInputFormatter>[
                                    //   // for below version 2 use this
                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    //   // for version 2 and greater youcan also use this
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
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
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'เบอร์โทร',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
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
                                    //keyboardType: TextInputType.none,
                                    controller: Status4Form_tel,
                                    // onChanged: (value) =>
                                    //     _Form_tel =
                                    //         value.trim(),
                                    //initialValue: _Form_tel,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'กรอกข้อมูลให้ครบถ้วน ';
                                    //   }
                                    //   // if (int.parse(value.toString()) < 13) {
                                    //   //   return '< 13';
                                    //   // }
                                    //   return null;
                                    // },
                                    // maxLength: 13,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        filled: true,
                                        // prefixIcon:
                                        //     const Icon(Icons.person, color: Colors.black),
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
                                        labelText: 'ระบุเบอร์โทร',
                                        labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        )),
                                    // inputFormatters: <TextInputFormatter>[
                                    //   // for below version 2 use this
                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    //   // for version 2 and greater youcan also use this
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'อีเมล',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
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
                                    //keyboardType: TextInputType.none,
                                    controller: Status4Form_email,
                                    // onChanged: (value) =>
                                    //     _Form_email =
                                    //         value.trim(),
                                    //initialValue: _Form_email,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'กรอกข้อมูลให้ครบถ้วน ';
                                    //   }
                                    //   // if (int.parse(value.toString()) < 13) {
                                    //   //   return '< 13';
                                    //   // }
                                    //   return null;
                                    // },
                                    // maxLength: 13,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        filled: true,
                                        // prefixIcon:
                                        //     const Icon(Icons.person, color: Colors.black),
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
                                        labelText: 'ระบุอีเมล',
                                        labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        )),
                                    // inputFormatters: <TextInputFormatter>[
                                    //   // for below version 2 use this
                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    //   // for version 2 and greater youcan also use this
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
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
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'ID/TAX ID',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
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
                                    //keyboardType: TextInputType.none,
                                    controller: Status4Form_tax,
                                    // onChanged: (value) =>
                                    //     _Form_tax =
                                    //         value.trim(),
                                    //initialValue: _Form_tax,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                      }
                                      // if (int.parse(value.toString()) < 13) {
                                      //   return '< 13';
                                      // }
                                      return null;
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
                                        labelText: 'ระบุID/TAX ID',
                                        labelStyle: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        )),
                                    // inputFormatters: <TextInputFormatter>[
                                    //   // for below version 2 use this
                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    //   // for version 2 and greater youcan also use this
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  // child: const Icon(Icons.check_box_outline_blank)
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        // Status4Form_nameshop.text =
                        //     _Form_nameshop.toString();
                        // Status4Form_typeshop.text =
                        //     _Form_typeshop.toString();
                        // Status4Form_bussshop.text =
                        //     _Form_bussshop.toString();
                        // Status4Form_bussscontact.text =
                        //     _Form_bussscontact.toString();
                        // Status4Form_address.text =
                        //     _Form_address.toString();
                        // Status4Form_tel.text = _Form_tel.toString();
                        // Status4Form_email.text = _Form_email.toString();
                        // Status4Form_tax.text = _Form_tax == null
                        //     ? "-"
                        //     : _Form_tax.toString();
                        // //----------------------------------->

                        // if (_formKey.currentState!.validate()) {
                        //   print('---------------------------------->');
                        //   print(Value_AreaSer_);
                        //   print(_verticalGroupValue);
                        //   print(
                        //       '${typeModels.elementAt(Value_AreaSer_).type}');

                        //   print('---------------------------------->');
                        //   print(Status4Form_typeshop.text);
                        //   print(Status4Form_nameshop.text);
                        //   print(Status4Form_typeshop.text);
                        //   print(Status4Form_bussshop.text);
                        //   print(Status4Form_bussscontact.text);
                        //   print(Status4Form_address.text);
                        //   print(Status4Form_tel.text);
                        //   print(Status4Form_tax.text);
                        //   print('----------------------------------');
                        //   print(
                        //       '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}');
                        // }
                        //       },
                        //       child: Container(
                        //         width: 130,
                        //         height: 50,
                        //         decoration: const BoxDecoration(
                        //           color: Colors.green,
                        //           borderRadius: BorderRadius.only(
                        //               topLeft: Radius.circular(20),
                        //               topRight: Radius.circular(20),
                        //               bottomLeft: Radius.circular(20),
                        //               bottomRight: Radius.circular(20)),
                        //         ),
                        //         child: const Center(
                        //           child: Text('พิมพ์',
                        //               maxLines: 3,
                        //               overflow: TextOverflow.ellipsis,
                        //               softWrap: false,
                        //               style: TextStyle(
                        //                 fontSize: 20,
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontFamily: FontWeight_.Fonts_T,
                        //               )),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // ScrollConfiguration(
          //   behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          //     PointerDeviceKind.touch,
          //     PointerDeviceKind.mouse,
          //   }),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: (Responsive.isDesktop(context))
                          ? MediaQuery.of(context).size.width * 0.35
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
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                                // padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                    'เลือกรายการชำระ',
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
                                    '>',
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
                          height: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.height * 0.6
                              : MediaQuery.of(context).size.height * 0.76,
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
                            itemCount: expModels.length,
                            // itemCount: _TransModels.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Material(
                                color: (_TransModels.any((A) =>
                                        A.name.toString() ==
                                        expModels[index].expname.toString()))
                                    ? tappedIndex_Color.tappedIndex_Colors
                                    : AppbackgroundColor.Sub_Abg_Colors,
                                child: Container(
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text:
                                                  '${expModels[index].expname}',
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
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              '${expModels[index].expname}',
                                              textAlign: TextAlign.start,
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
                                            child: IconButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    //   print('---------------------------------->');
                                                    print(Status4Form_typeshop
                                                        .text);
                                                    print(Status4Form_nameshop
                                                        .text);
                                                    print(Status4Form_typeshop
                                                        .text);
                                                    print(Status4Form_bussshop
                                                        .text);
                                                    print(
                                                        Status4Form_bussscontact
                                                            .text);
                                                    print(Status4Form_address
                                                        .text);
                                                    print(Status4Form_tel.text);
                                                    print(
                                                        Status4Form_email.text);
                                                    print(Status4Form_tax.text);
                                                    print(Status5Form_NoArea_
                                                        .text);
                                                    //   print('----------------------------------');

                                                    if (_selecteSerbool
                                                                .length !=
                                                            0 ||
                                                        No_Area_ != '') {
                                                      in_Trans_select(index);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                'กรุณาเลือกพื้นที่',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T))),
                                                      );
                                                    }
                                                  }
                                                },
                                                icon: Icon(Icons.east))),
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
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: (Responsive.isDesktop(context))
                          ? MediaQuery.of(context).size.width * 0.35
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
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                                // padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                    'รายการชำระ',
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
                                    'จำนวนพื้นที่',
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
                          height: (Responsive.isDesktop(context))
                              ? 290
                              : MediaQuery.of(context).size.height * 0.6,
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
                            itemCount: _TransModels.length,
                            // itemCount: _TransModels.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Material(
                                // color: (expModels.any((A) =>
                                //         A.expname.toString() ==
                                //         _TransModels[index].name.toString()))
                                //     ? tappedIndex_Color.tappedIndex_Colors
                                //     : null,

                                //  (_TransReBillModels[index]
                                //             .docno
                                //             .toString() ==
                                //         _TransModels[index].name.toString())
                                //     ? tappedIndex_Color.tappedIndex_Colors
                                //     : null,
                                child: ListTile(
                                  onTap: () {},
                                  title: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          maxLines: 1,
                                          '${_TransModels[index].name}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ), //
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          maxLines: 1,
                                          '${_TransModels[index].tqty}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextFormField(
                                            textAlign: TextAlign.end,
                                            keyboardType: TextInputType.number,
                                            // controller: sum_dispx,
                                            initialValue: nFormat.format(
                                                double.parse(
                                                    _TransModels[index].pvat!)),
                                            onFieldSubmitted: (value) async {
                                              var valuex = value;
                                              var tser =
                                                  _TransModels[index].ser;

                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var ren = preferences
                                                  .getString('renTalSer');
                                              var user =
                                                  preferences.getString('ser');
                                              String url =
                                                  '${MyConstant().domain}/UP_c_trans_select.php?isAdd=true&ren=$ren&user=$user&valuex=$valuex&tser=$tser';
                                              try {
                                                var response = await http
                                                    .get(Uri.parse(url));

                                                var result =
                                                    json.decode(response.body);
                                                // print(result);
                                                if (result.toString() !=
                                                    'null') {
                                                  setState(() {
                                                    red_Trans_select2();
                                                  });
                                                }
                                                print(
                                                    '------------>>>>> $sum_amt =====  ${sum_disamtx.text}');
                                              } catch (e) {}

                                              print(
                                                  'sum_dis $sum_dis   /////// ${value.toString()}');
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
                                                        Radius.circular(5),
                                                    topLeft: Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
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
                                                        Radius.circular(5),
                                                    topLeft: Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                // labelText: 'ระบุชื่อร้านค้า',
                                                labelStyle: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 8,

                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T)),
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9 .]')),
                                              // FilteringTextInputFormatter.digitsOnly
                                            ],
                                          ),
                                        ),
                                        // AutoSizeText(
                                        //   minFontSize: 10,
                                        //   maxFontSize: 15,
                                        //   maxLines: 1,
                                        //   '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
                                        //   textAlign: TextAlign.end,
                                        //   style: TextStyle(
                                        //       color: PeopleChaoScreen_Color
                                        //           .Colors_Text2_,
                                        //       //fontWeight: FontWeight.bold,
                                        //       fontFamily: Font_.Fonts_T),
                                        // ),
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
                                              style: const TextStyle(
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
                                          const Expanded(
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
                                              style: const TextStyle(
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
                                          const Expanded(
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
                                              style: const TextStyle(
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
                                          const Expanded(
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
                                          ), //
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              textAlign: TextAlign.end,
                                              '${nFormat.format(sum_amt)}',
                                              style: const TextStyle(
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
                                                    controller: sum_dispx,
                                                    onFieldSubmitted:
                                                        (value) async {
                                                      var valuenum =
                                                          double.parse(value);
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
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                      });

                                                      print(
                                                          'sum_dis $sum_dis   /////// ${valuenum.toString()}');
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
                                                            width: 1,
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
                                                          .allow(RegExp(
                                                              r'[0-9 .]')),
                                                      // FilteringTextInputFormatter.digitsOnly
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ), //
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
                                                onFieldSubmitted:
                                                    (value) async {
                                                  var valuenum =
                                                      double.parse(value);

                                                  setState(() {
                                                    sum_dis = valuenum;
                                                    sum_disamt = valuenum;
                                                    // sum_disamt.text =
                                                    //     nFormat.format(sum_disamt);
                                                    sum_dispx.clear();
                                                    Form_payment1.text =
                                                        (sum_amt - sum_disamt)
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                  });

                                                  print('sum_dis $sum_dis');
                                                }, //
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
                                                            Radius.circular(5),
                                                        topLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                        bottomLeft:
                                                            Radius.circular(5),
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
                                                            Radius.circular(5),
                                                        topLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                      ),
                                                      borderSide: BorderSide(
                                                        // width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    // labelText: 'ระบุชื่อร้านค้า',
                                                    labelStyle: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 8,

                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T)),
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
                                              sum_disamtx.text == ''
                                                  ? '${nFormat.format(sum_amt - 0).toString()}'
                                                  : '${nFormat.format(sum_amt - double.parse(sum_disamtx.text)).toString()}',
                                              style: const TextStyle(
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
              ),
              (Responsive.isDesktop(context))
                  ? Expanded(
                      flex: 4,
                      child: Padding(
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
                                          _selecteSerbool.length == 0
                                              ? 'ใบเสร็จรับเงิน'
                                              : 'ใบเสร็จรับเงิน ', //${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}
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
                                              'การชำระ',
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
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (pamentpage == 1) {
                                                    pamentpage = 0;
                                                    Form_payment2.clear();
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
                                                    Form_payment2.clear();
                                                    Form_payment2.text = '';
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
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Colors.red,
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Expanded(
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
                                                  Text(
                                                    '$paymentName1',
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
                                                        onTap: () {
                                                          setState(() {
                                                            selectedValue =
                                                                item.bno!;
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
                                                  // paymentName1 =
                                                  //     rtnameName.toString();

                                                  if (rtnameSer.toString() ==
                                                      '0') {
                                                    paymentName1 = null;
                                                  } else {
                                                    paymentName1 =
                                                        rtnameName.toString();
                                                  }

                                                  if (rtnameSer.toString() ==
                                                      '0') {
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
                                            ? SizedBox()
                                            : Expanded(
                                                child: Container(
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
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      //Add isDense true and zero Padding.
                                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      //Add more decoration as you want here
                                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                    ),
                                                    isExpanded: true,
                                                    // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                    hint: Row(
                                                      children: const [
                                                        Text(
                                                          'เลือก',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
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
                                                            left: 10,
                                                            right: 10),
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    items: _PayMentModels.map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
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

                                                      var zones =
                                                          value!.indexOf(':');
                                                      var rtnameSer = value
                                                          .substring(0, zones);
                                                      var rtnameName = value
                                                          .substring(zones + 1);
                                                      print(
                                                          'mmmmm ${rtnameSer.toString()} $rtnameName');
                                                      setState(() {
                                                        paymentSer2 = rtnameSer
                                                            .toString();
                                                        // paymentName2 =
                                                        //     rtnameName.toString();

                                                        if (rtnameSer
                                                                .toString() ==
                                                            '0') {
                                                          paymentName2 = null;
                                                        } else {
                                                          paymentName2 =
                                                              rtnameName
                                                                  .toString();
                                                        }

                                                        if (rtnameSer
                                                                .toString() ==
                                                            '0') {
                                                          Form_payment2.clear();
                                                        } else {
                                                          Form_payment2
                                                              .text = (sum_amt -
                                                                  sum_disamt)
                                                              .toStringAsFixed(
                                                                  2)
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
                                              controller: Form_payment1,
                                              onChanged: (value) async {
                                                if (pamentpage == 1) {
                                                  setState(() {
                                                    Form_payment2.clear();
                                                    Form_payment2.text = '';
                                                  });
                                                }
                                                final currentCursorPosition =
                                                    Form_payment1
                                                        .selection.start;

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
                                                var money1 =
                                                    double.parse(value);
                                                var money2 =
                                                    (sum_amt - sum_disamt);
                                                var money3 = (money2 - money1)
                                                    .toStringAsFixed(2)
                                                    .toString();
                                                setState(() {
                                                  if (paymentSer2 == null) {
                                                    Form_payment1.text =
                                                        (money1)
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                  } else {
                                                    Form_payment1.text =
                                                        (money1)
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                    Form_payment2.text = money3;
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
                                              inputFormatters: <TextInputFormatter>[
                                                // for below version 2 use this
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9 .]')),
                                                // for version 2 and greater youcan also use this
                                                // FilteringTextInputFormatter.digitsOnly
                                              ],
                                            ),
                                          ),
                                        ),
                                        pamentpage == 0
                                            ? SizedBox()
                                            : Expanded(
                                                child: Container(
                                                  height: 50,
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
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: Form_payment2,
                                                    onChanged: (value) async {
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
                                                                      .text
                                                                      .length);
                                                      Form_payment2.selection =
                                                          TextSelection
                                                              .fromPosition(
                                                                  TextPosition(
                                                                      offset:
                                                                          newCursorPosition));
                                                    },
                                                    onFieldSubmitted: (value) {
                                                      var money1 =
                                                          double.parse(value);
                                                      var money2 = (sum_amt -
                                                          sum_disamt);
                                                      var money3 = (money2 -
                                                              money1)
                                                          .toStringAsFixed(2)
                                                          .toString();
                                                      setState(() {
                                                        if (paymentSer1 ==
                                                            null) {
                                                          Form_payment2.text =
                                                              (money1)
                                                                  .toStringAsFixed(
                                                                      2)
                                                                  .toString();
                                                        } else {
                                                          Form_payment2.text =
                                                              (money1)
                                                                  .toStringAsFixed(
                                                                      2)
                                                                  .toString();
                                                          Form_payment1.text =
                                                              money3;
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
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
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
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
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
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        // labelText: 'ระบุอายุสัญญา',
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T)),
                                                    inputFormatters: <TextInputFormatter>[
                                                      // for below version 2 use this
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r'[0-9 .]')),
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
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: Text(
                                                'วันที่ทำรายการ',
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
                                        Expanded(
                                          child: Container(
                                              height: 50,
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 50,
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
                                                child: InkWell(
                                                  onTap: () async {
                                                    DateTime? newDate =
                                                        await showDatePicker(
                                                      locale: const Locale(
                                                          'th', 'TH'),
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: -50)),
                                                      lastDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: 365)),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                              Theme.of(context)
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
                                                      String start = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(newDate);
                                                      String end = DateFormat(
                                                              'dd-MM-yyyy')
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
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: AutoSizeText(
                                                      Value_newDateD1 == ''
                                                          ? 'เลือกวันที่'
                                                          : '$Value_newDateD1',
                                                      minFontSize: 16,
                                                      maxFontSize: 20,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: Text(
                                                'วันที่ชำระ',
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
                                        Expanded(
                                          child: Container(
                                              height: 50,
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 50,
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
                                                child: InkWell(
                                                  onTap: () async {
                                                    DateTime? newDate =
                                                        await showDatePicker(
                                                      locale: const Locale(
                                                          'th', 'TH'),
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: -50)),
                                                      lastDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: 365)),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                              Theme.of(context)
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
                                                      String start = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(newDate);
                                                      String end = DateFormat(
                                                              'dd-MM-yyyy')
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
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: AutoSizeText(
                                                      Value_newDateD == ''
                                                          ? 'เลือกวันที่'
                                                          : '$Value_newDateD',
                                                      minFontSize: 16,
                                                      maxFontSize: 20,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                  paymentName2.toString().trim() == 'เงินโอน' ||
                                  paymentName1.toString().trim() ==
                                      'Online Payment' ||
                                  paymentName2.toString().trim() ==
                                      'Online Payment')
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
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
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        padding: const EdgeInsets.all(8.0),
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
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0),
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
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
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
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
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
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        hintText: '00:00:00',
                                                        // helperText: '00:00:00',
                                                        // labelText: '00:00:00',
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T)),

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
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                title:
                                                                    const Center(
                                                                        child:
                                                                            Text(
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
                                                                  child:
                                                                      ListBody(
                                                                    children: const <Widget>[
                                                                      Text(
                                                                        'มีไฟล์ slip อยู่แล้ว หากต้องการอัพโหลดกรุณาลบไฟล์ที่มีอยู่แล้วก่อน',
                                                                        style: TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text2_,
                                                                            fontFamily: Font_.Fonts_T),
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
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            InkWell(
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
                                                                          onTap:
                                                                              () async {
                                                                            setState(() {
                                                                              base64_Slip = null;
                                                                            });
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            InkWell(
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
                                                                          onTap:
                                                                              () {
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
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      // border: Border.all(
                                                      //     color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Text(
                                                      'เพิ่มไฟล์',
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (paymentName1.toString().trim() == 'เงินโอน' ||
                                  paymentName2.toString().trim() == 'เงินโอน' ||
                                  paymentName1.toString().trim() ==
                                      'Online Payment' ||
                                  paymentName2.toString().trim() ==
                                      'Online Payment')
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
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
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  (base64_Slip != null)
                                                      ? 'สถานะหลักฐาน : เลือกไฟล์แล้ว '
                                                      : 'สถานะหลักฐาน : ยังไม่ได้เลือกไฟล์',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: (base64_Slip !=
                                                              null)
                                                          ? Colors.green[600]
                                                          : Colors.red[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                  title: const Center(
                                                    child: Text(
                                                      '',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  content: Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Image.memory(
                                                        base64Decode(base64_Slip
                                                            .toString()),
                                                        // height: 200,
                                                        // fit: BoxFit.cover,
                                                      ),
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.black,
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
                                                                        .white,
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
                                                bottomRight:
                                                    Radius.circular(10),
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
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       flex: 1,
                              //       child: Container(
                              //         height: 50,
                              //         decoration: BoxDecoration(
                              //           color: Colors.green[200],
                              //           borderRadius: const BorderRadius.only(
                              //             topLeft: Radius.circular(10),
                              //             topRight: Radius.circular(10),
                              //             bottomLeft: Radius.circular(0),
                              //             bottomRight: Radius.circular(0),
                              //           ),
                              //           // border: Border.all(
                              //           //     color: Colors.grey, width: 1),
                              //         ),
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: const Center(
                              //           child: Text(
                              //             'รูปแบบบิล',
                              //             textAlign: TextAlign.center,
                              //             style: TextStyle(
                              //                 color: PeopleChaoScreen_Color
                              //                     .Colors_Text1_,
                              //                 fontWeight: FontWeight.bold,
                              //                 fontFamily: FontWeight_.Fonts_T
                              //                 //fontSize: 10.0
                              //                 ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       flex: 1,
                              //       child: Container(
                              //         height: 50,
                              //         color: AppbackgroundColor.Sub_Abg_Colors,
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Container(
                              //           decoration: BoxDecoration(
                              //             color: AppbackgroundColor.Sub_Abg_Colors,
                              //             borderRadius: const BorderRadius.only(
                              //                 topLeft: Radius.circular(10),
                              //                 topRight: Radius.circular(10),
                              //                 bottomLeft: Radius.circular(10),
                              //                 bottomRight: Radius.circular(10)),
                              //             border: Border.all(
                              //                 color: Colors.grey, width: 1),
                              //           ),
                              //           width: 120,
                              //           child: DropdownButtonFormField2(
                              //             decoration: InputDecoration(
                              //               isDense: true,
                              //               contentPadding: EdgeInsets.zero,
                              //               border: OutlineInputBorder(
                              //                 borderRadius: BorderRadius.circular(10),
                              //               ),
                              //             ),
                              //             isExpanded: true,
                              //             hint: Text(
                              //               bills_name_.toString(),
                              //               maxLines: 1,
                              //               style: const TextStyle(
                              //                   fontSize: 14,
                              //                   color: PeopleChaoScreen_Color
                              //                       .Colors_Text2_,
                              //                   //fontWeight: FontWeight.bold,
                              //                   fontFamily: Font_.Fonts_T),
                              //             ),
                              //             icon: const Icon(
                              //               Icons.arrow_drop_down,
                              //               color:
                              //                   PeopleChaoScreen_Color.Colors_Text2_,
                              //             ),
                              //             style: const TextStyle(
                              //                 color: Colors.green,
                              //                 fontFamily: Font_.Fonts_T),
                              //             iconSize: 30,
                              //             buttonHeight: 40,
                              //             // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              //             dropdownDecoration: BoxDecoration(
                              //               borderRadius: BorderRadius.circular(10),
                              //             ),
                              //             items: bill_tser == '1'
                              //                 ? Default_.map((item) =>
                              //                     DropdownMenuItem<String>(
                              //                       value: item,
                              //                       child: Text(
                              //                         item,
                              //                         style: const TextStyle(
                              //                             fontSize: 14,
                              //                             color:
                              //                                 PeopleChaoScreen_Color
                              //                                     .Colors_Text2_,
                              //                             //fontWeight: FontWeight.bold,
                              //                             fontFamily: Font_.Fonts_T),
                              //                       ),
                              //                     )).toList()
                              //                 : Default2_.map((item) =>
                              //                     DropdownMenuItem<String>(
                              //                       value: item,
                              //                       child: Text(
                              //                         item,
                              //                         style: const TextStyle(
                              //                             fontSize: 14,
                              //                             color:
                              //                                 PeopleChaoScreen_Color
                              //                                     .Colors_Text2_,
                              //                             //fontWeight: FontWeight.bold,
                              //                             fontFamily: Font_.Fonts_T),
                              //                       ),
                              //                     )).toList(),

                              //             onChanged: (value) async {
                              //               var bill_set =
                              //                   value == 'บิลธรรมดา' ? 'P' : 'F';
                              //               setState(() {
                              //                 bills_name_ = bill_set;
                              //               });
                              //             },
                              //             // onSaved: (value) {
                              //             //   // selectedValue = value.toString();
                              //             // },
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.white,
                                      // height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.33,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'หมายเหตุ',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            // keyboardType: TextInputType.name,
                                            controller: Form_note,

                                            maxLines: 2,
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
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15),
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
                                              // labelText: 'ระบุชื่อร้านค้า',
                                              labelStyle: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              (paymentName1.toString().trim() ==
                                          'Online Payment' ||
                                      paymentName2.toString().trim() ==
                                          'Online Payment')
                                  ? Stack(
                                      children: [
                                        InkWell(
                                          child: Container(
                                              width: 800,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[900],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                // border: Border.all(color: Colors.white, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                    'Generator QR Code PromtPay',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  )),
                                                ],
                                              )),
                                          onTap:
                                              (paymentName1.toString().trim() !=
                                                          'Online Payment' &&
                                                      paymentName2
                                                              .toString()
                                                              .trim() !=
                                                          'Online Payment')
                                                  ? null
                                                  : () {
                                                      double totalQr_ = 0.00;
                                                      if (paymentName1
                                                                  .toString()
                                                                  .trim() ==
                                                              'Online Payment' &&
                                                          paymentName2
                                                                  .toString()
                                                                  .trim() ==
                                                              'Online Payment') {
                                                        setState(() {
                                                          totalQr_ = 0.00;
                                                        });
                                                        setState(() {
                                                          totalQr_ = double.parse(
                                                                  '${Form_payment1.text}') +
                                                              double.parse(
                                                                  '${Form_payment2.text}');
                                                        });
                                                      } else if (paymentName1
                                                              .toString()
                                                              .trim() ==
                                                          'Online Payment') {
                                                        setState(() {
                                                          totalQr_ = 0.00;
                                                        });
                                                        setState(() {
                                                          totalQr_ = double.parse(
                                                              '${Form_payment1.text}');
                                                        });
                                                      } else if (paymentName2
                                                              .toString()
                                                              .trim() ==
                                                          'Online Payment') {
                                                        setState(() {
                                                          totalQr_ = 0.00;
                                                        });
                                                        setState(() {
                                                          totalQr_ = double.parse(
                                                              '${Form_payment2.text}');
                                                        });
                                                      }

                                                      showDialog<void>(
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
                                                                            20.0))),
                                                            // title: Center(
                                                            //     child: Container(
                                                            //         decoration: BoxDecoration(
                                                            //           color: Colors.blue[300],
                                                            //           borderRadius:
                                                            //               const BorderRadius
                                                            //                       .only(
                                                            //                   topLeft: Radius
                                                            //                       .circular(10),
                                                            //                   topRight: Radius
                                                            //                       .circular(10),
                                                            //                   bottomLeft: Radius
                                                            //                       .circular(10),
                                                            //                   bottomRight:
                                                            //                       Radius
                                                            //                           .circular(
                                                            //                               10)),
                                                            //         ),
                                                            //         padding:
                                                            //             const EdgeInsets.all(
                                                            //                 4.0),
                                                            //         child: const Text(
                                                            //           ' QR PromtPay',
                                                            //           style: TextStyle(
                                                            //             color: Colors.white,
                                                            //             fontWeight:
                                                            //                 FontWeight.bold,
                                                            //           ),
                                                            //         ))),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
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
                                                                        color: Colors
                                                                            .white,
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            4,
                                                                            8,
                                                                            4,
                                                                            2),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            // Text(
                                                                            //   '*** กำลังทดลอง ห้ามใช้งาน จ่ายจริง',
                                                                            //   style: TextStyle(
                                                                            //     color:
                                                                            //         Colors.red,
                                                                            //     fontWeight:
                                                                            //         FontWeight
                                                                            //             .bold,
                                                                            //   ),
                                                                            // ),
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
                                                                        color: Colors
                                                                            .green,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(0),
                                                                            topRight: Radius.circular(0),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          // String qrCodeData = generateQRCode(promptPayID: "0613544026", amount: 1234.56);

                                                                          RenderRepaintBoundary
                                                                              boundary =
                                                                              qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                                          ui.Image
                                                                              image =
                                                                              await boundary.toImage();
                                                                          ByteData?
                                                                              byteData =
                                                                              await image.toByteData(format: ui.ImageByteFormat.png);
                                                                          Uint8List
                                                                              bytes =
                                                                              byteData!.buffer.asUint8List();
                                                                          html.Blob
                                                                              blob =
                                                                              html.Blob([
                                                                            bytes
                                                                          ]);
                                                                          String
                                                                              url =
                                                                              html.Url.createObjectUrlFromBlob(blob);

                                                                          html.AnchorElement
                                                                              anchor =
                                                                              html.AnchorElement()
                                                                                ..href = url
                                                                                ..setAttribute('download', 'qrcode.png')
                                                                                ..click();

                                                                          html.Url.revokeObjectUrl(
                                                                              url);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Download QR Code',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
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
                                                                    height: 5.0,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 4.0,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Colors.black,
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
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, 'OK'),
                                                                            child:
                                                                                const Text(
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
                                        if (paymentName1.toString().trim() !=
                                                'Online Payment' &&
                                            paymentName2.toString().trim() !=
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
                                              )),
                                      ],
                                    )
                                  : SizedBox(),
                              Row(
                                children: [
                                  const Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      // child: InkWell(
                                      //   onTap: () {
                                      //   },
                                      //   child: Container(
                                      //     height: 50,
                                      //     decoration: const BoxDecoration(
                                      //       color: Colors.green,
                                      //       borderRadius: BorderRadius.only(
                                      //           topLeft: Radius.circular(10),
                                      //           topRight: Radius.circular(10),
                                      //           bottomLeft: Radius.circular(10),
                                      //           bottomRight: Radius.circular(10)),
                                      //       // border: Border.all(color: Colors.white, width: 1),
                                      //     ),
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Center(
                                      //       child: select_page == 2
                                      //           ? const Text(
                                      //               'พิมพ์ซ้ำ',
                                      //               style: TextStyle(
                                      //                   color: PeopleChaoScreen_Color
                                      //                       .Colors_Text1_,
                                      //                   fontWeight: FontWeight.bold,
                                      //                   fontFamily:
                                      //                       FontWeight_.Fonts_T),
                                      //             )
                                      //           //
                                      //           : const Text(
                                      //               'พิมพ์ใบเสร็จชั่วคราว',
                                      //               style: TextStyle(
                                      //                   color: PeopleChaoScreen_Color
                                      //                       .Colors_Text1_,
                                      //                   fontWeight: FontWeight.bold,
                                      //                   fontFamily:
                                      //                       FontWeight_.Fonts_T),
                                      //             ),
                                      //     ),
                                      //   ),
                                      // ),
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
                                          if (_Form_nameshop != null) {
                                            Status4Form_nameshop.text =
                                                _Form_nameshop.toString();
                                            Status4Form_typeshop.text =
                                                _Form_typeshop.toString();
                                            Status4Form_bussshop.text =
                                                _Form_bussshop.toString();
                                            Status4Form_bussscontact.text =
                                                _Form_bussscontact.toString();
                                            Status4Form_address.text =
                                                _Form_address.toString();
                                            Status4Form_tel.text =
                                                _Form_tel.toString();
                                            Status4Form_email.text =
                                                _Form_email.toString();
                                            Status4Form_tax.text =
                                                _Form_tax == null
                                                    ? "-"
                                                    : _Form_tax.toString();
                                          }

                                          //----------------------------------->

                                          setState(() {
                                            Slip_status = '2';
                                          });

                                          List newValuePDFimg = [];
                                          for (int index = 0;
                                              index < 1;
                                              index++) {
                                            if (renTalModels[index]
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
                                          if (pamentpage == 0) {
                                            setState(() {
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
                                          } else if (double.parse(pay1) <
                                                  0.00 ||
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
                                                if ((sum_amt - sum_disamt) !=
                                                    0) {
                                                  if (select_page == 0) {
                                                    print('(select_page == 0)');
                                                    if (paymentName1
                                                                .toString()
                                                                .trim() ==
                                                            'เงินโอน' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'เงินโอน') {
                                                      if (base64_Slip != null) {
                                                        final tableData00 = [
                                                          for (int index = 0;
                                                              index <
                                                                  _TransModels
                                                                      .length;
                                                              index++)
                                                            [
                                                              '${index + 1}',
                                                              '${_TransModels[index].name}',
                                                              '${_TransModels[index].tqty}',
                                                              '${nFormat.format(double.parse(_TransModels[index].pvat!))}'
                                                            ],
                                                        ];
                                                        String Area_ =
                                                            '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}';

                                                        try {
                                                          print(
                                                              'tableData00.length');
                                                          print(tableData00
                                                              .length);
                                                          in_Trans(
                                                              newValuePDFimg);
                                                        } catch (e) {}
                                                      } else {
                                                        _showMyDialogPay_Error(
                                                            'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                        // ScaffoldMessenger.of(context)
                                                        //     .showSnackBar(
                                                        //   const SnackBar(
                                                        //       content: Text(
                                                        //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                        //           style: TextStyle(
                                                        //               color:
                                                        //                   Colors.white,
                                                        //               fontFamily: Font_
                                                        //                   .Fonts_T))),
                                                        // );
                                                      }
                                                    } else {
                                                      try {
                                                        in_Trans(
                                                            newValuePDFimg);
                                                        // OKuploadFile_Slip();
                                                      } catch (e) {}
                                                      // try {

                                                      //   // in_Trans();ใช้
                                                      // } catch (e) {}
                                                    }
                                                  } else if (select_page == 1) {
                                                    if (paymentName1.toString().trim() == 'เงินโอน' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'เงินโอน' ||
                                                        paymentName1
                                                                .toString()
                                                                .trim() ==
                                                            'Online Payment' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'Online Payment') {
                                                      if (base64_Slip != null) {
                                                      } else {
                                                        _showMyDialogPay_Error(
                                                            'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                        // ScaffoldMessenger.of(context)
                                                        //     .showSnackBar(
                                                        //   const SnackBar(
                                                        //       content: Text(
                                                        //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                        //           style: TextStyle(
                                                        //               color:
                                                        //                   Colors.white,
                                                        //               fontFamily: Font_
                                                        //                   .Fonts_T))),
                                                        // );
                                                      }
                                                    } else {}
                                                  } else if (select_page == 2) {
                                                    if (paymentName1.toString().trim() == 'เงินโอน' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'เงินโอน' ||
                                                        paymentName1
                                                                .toString()
                                                                .trim() ==
                                                            'Online Payment' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'Online Payment') {
                                                      if (base64_Slip != null) {
                                                        try {
                                                          // OKuploadFile_Slip();
                                                          //TransReBillHistoryModel

                                                          // await in_Trans_re_invoice_refno(
                                                          //     newValuePDFimg);
                                                        } catch (e) {}
                                                      } else {
                                                        _showMyDialogPay_Error(
                                                            'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                        // ScaffoldMessenger.of(context)
                                                        //     .showSnackBar(
                                                        //   const SnackBar(
                                                        //       content: Text(
                                                        //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                        //           style: TextStyle(
                                                        //               color:
                                                        //                   Colors.white,
                                                        //               fontFamily: Font_
                                                        //                   .Fonts_T))),
                                                        // );
                                                      }
                                                    } else {
                                                      try {
                                                        // OKuploadFile_Slip();
                                                        //TransReBillHistoryModel

                                                        // await in_Trans_re_invoice_refno(
                                                        //     newValuePDFimg);
                                                      } catch (e) {}
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
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              // border: Border.all(color: Colors.white, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                                child: Text(
                                              'รับชำระ',
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
                    )
                  : SizedBox(),
            ],
          ),
          (Responsive.isDesktop(context))
              ? SizedBox()
              : Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
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
                                          _selecteSerbool.length == 0
                                              ? 'ใบเสร็จรับเงิน'
                                              : 'ใบเสร็จรับเงิน ', //${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}
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
                                              'การชำระ',
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
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (pamentpage == 1) {
                                                    pamentpage = 0;
                                                    Form_payment2.clear();
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
                                                    Form_payment2.clear();
                                                    Form_payment2.text = '';
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
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Colors.red,
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Expanded(
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
                                                  Text(
                                                    '$paymentName1',
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
                                                        onTap: () {
                                                          setState(() {
                                                            selectedValue =
                                                                item.bno!;
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
                                                  // paymentName1 =
                                                  //     rtnameName.toString();

                                                  if (rtnameSer.toString() ==
                                                      '0') {
                                                    paymentName1 = null;
                                                  } else {
                                                    paymentName1 =
                                                        rtnameName.toString();
                                                  }

                                                  if (rtnameSer.toString() ==
                                                      '0') {
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
                                            ? SizedBox()
                                            : Expanded(
                                                child: Container(
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
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      //Add isDense true and zero Padding.
                                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      //Add more decoration as you want here
                                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                    ),
                                                    isExpanded: true,
                                                    // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                    hint: Row(
                                                      children: const [
                                                        Text(
                                                          'เลือก',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
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
                                                            left: 10,
                                                            right: 10),
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    items: _PayMentModels.map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
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

                                                      var zones =
                                                          value!.indexOf(':');
                                                      var rtnameSer = value
                                                          .substring(0, zones);
                                                      var rtnameName = value
                                                          .substring(zones + 1);
                                                      print(
                                                          'mmmmm ${rtnameSer.toString()} $rtnameName');
                                                      setState(() {
                                                        paymentSer2 = rtnameSer
                                                            .toString();
                                                        // paymentName2 =
                                                        //     rtnameName.toString();

                                                        if (rtnameSer
                                                                .toString() ==
                                                            '0') {
                                                          paymentName2 = null;
                                                        } else {
                                                          paymentName2 =
                                                              rtnameName
                                                                  .toString();
                                                        }

                                                        if (rtnameSer
                                                                .toString() ==
                                                            '0') {
                                                          Form_payment2.clear();
                                                        } else {
                                                          Form_payment2
                                                              .text = (sum_amt -
                                                                  sum_disamt)
                                                              .toStringAsFixed(
                                                                  2)
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
                                              controller: Form_payment1,
                                              onChanged: (value) async {
                                                if (pamentpage == 1) {
                                                  setState(() {
                                                    Form_payment2.clear();
                                                    Form_payment2.text = '';
                                                  });
                                                }
                                                final currentCursorPosition =
                                                    Form_payment1
                                                        .selection.start;

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
                                                var money1 =
                                                    double.parse(value);
                                                var money2 =
                                                    (sum_amt - sum_disamt);
                                                var money3 = (money2 - money1)
                                                    .toStringAsFixed(2)
                                                    .toString();
                                                setState(() {
                                                  if (paymentSer2 == null) {
                                                    Form_payment1.text =
                                                        (money1)
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                  } else {
                                                    Form_payment1.text =
                                                        (money1)
                                                            .toStringAsFixed(2)
                                                            .toString();
                                                    Form_payment2.text = money3;
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
                                              inputFormatters: <TextInputFormatter>[
                                                // for below version 2 use this
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9 .]')),
                                                // for version 2 and greater youcan also use this
                                                // FilteringTextInputFormatter.digitsOnly
                                              ],
                                            ),
                                          ),
                                        ),
                                        pamentpage == 0
                                            ? SizedBox()
                                            : Expanded(
                                                child: Container(
                                                  height: 50,
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
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: Form_payment2,
                                                    onChanged: (value) async {
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
                                                                      .text
                                                                      .length);
                                                      Form_payment2.selection =
                                                          TextSelection
                                                              .fromPosition(
                                                                  TextPosition(
                                                                      offset:
                                                                          newCursorPosition));
                                                    },
                                                    onFieldSubmitted: (value) {
                                                      var money1 =
                                                          double.parse(value);
                                                      var money2 = (sum_amt -
                                                          sum_disamt);
                                                      var money3 = (money2 -
                                                              money1)
                                                          .toStringAsFixed(2)
                                                          .toString();
                                                      setState(() {
                                                        if (paymentSer1 ==
                                                            null) {
                                                          Form_payment2.text =
                                                              (money1)
                                                                  .toStringAsFixed(
                                                                      2)
                                                                  .toString();
                                                        } else {
                                                          Form_payment2.text =
                                                              (money1)
                                                                  .toStringAsFixed(
                                                                      2)
                                                                  .toString();
                                                          Form_payment1.text =
                                                              money3;
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
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
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
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
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
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        // labelText: 'ระบุอายุสัญญา',
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T)),
                                                    inputFormatters: <TextInputFormatter>[
                                                      // for below version 2 use this
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r'[0-9 .]')),
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
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: Text(
                                                'วันที่ทำรายการ',
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
                                        Expanded(
                                          child: Container(
                                              height: 50,
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 50,
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
                                                child: InkWell(
                                                  onTap: () async {
                                                    DateTime? newDate =
                                                        await showDatePicker(
                                                      locale: const Locale(
                                                          'th', 'TH'),
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: -50)),
                                                      lastDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: 365)),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                              Theme.of(context)
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
                                                      String start = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(newDate);
                                                      String end = DateFormat(
                                                              'dd-MM-yyyy')
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
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: AutoSizeText(
                                                      Value_newDateD1 == ''
                                                          ? 'เลือกวันที่'
                                                          : '$Value_newDateD1',
                                                      minFontSize: 16,
                                                      maxFontSize: 20,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: Text(
                                                'วันที่ชำระ',
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
                                        Expanded(
                                          child: Container(
                                              height: 50,
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 50,
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
                                                child: InkWell(
                                                  onTap: () async {
                                                    DateTime? newDate =
                                                        await showDatePicker(
                                                      locale: const Locale(
                                                          'th', 'TH'),
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: -50)),
                                                      lastDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: 365)),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                              Theme.of(context)
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
                                                      String start = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(newDate);
                                                      String end = DateFormat(
                                                              'dd-MM-yyyy')
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
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: AutoSizeText(
                                                      Value_newDateD == ''
                                                          ? 'เลือกวันที่'
                                                          : '$Value_newDateD',
                                                      minFontSize: 16,
                                                      maxFontSize: 20,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                  paymentName2.toString().trim() == 'เงินโอน' ||
                                  paymentName1.toString().trim() ==
                                      'Online Payment' ||
                                  paymentName2.toString().trim() ==
                                      'Online Payment')
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
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
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        padding: const EdgeInsets.all(8.0),
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
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0),
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
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
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
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
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
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        hintText: '00:00:00',
                                                        // helperText: '00:00:00',
                                                        // labelText: '00:00:00',
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T)),

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
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                title:
                                                                    const Center(
                                                                        child:
                                                                            Text(
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
                                                                  child:
                                                                      ListBody(
                                                                    children: const <Widget>[
                                                                      Text(
                                                                        'มีไฟล์ slip อยู่แล้ว หากต้องการอัพโหลดกรุณาลบไฟล์ที่มีอยู่แล้วก่อน',
                                                                        style: TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text2_,
                                                                            fontFamily: Font_.Fonts_T),
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
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            InkWell(
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
                                                                          onTap:
                                                                              () async {
                                                                            setState(() {
                                                                              base64_Slip = null;
                                                                            });
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            InkWell(
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
                                                                          onTap:
                                                                              () {
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
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      // border: Border.all(
                                                      //     color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Text(
                                                      'เพิ่มไฟล์',
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (paymentName1.toString().trim() == 'เงินโอน' ||
                                  paymentName2.toString().trim() == 'เงินโอน' ||
                                  paymentName1.toString().trim() ==
                                      'Online Payment' ||
                                  paymentName2.toString().trim() ==
                                      'Online Payment')
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
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
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  (base64_Slip != null)
                                                      ? 'สถานะหลักฐาน : เลือกไฟล์แล้ว '
                                                      : 'สถานะหลักฐาน : ยังไม่ได้เลือกไฟล์',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: (base64_Slip !=
                                                              null)
                                                          ? Colors.green[600]
                                                          : Colors.red[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
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
                                                  title: const Center(
                                                    child: Text(
                                                      '',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  content: Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Image.memory(
                                                        base64Decode(base64_Slip
                                                            .toString()),
                                                        // height: 200,
                                                        // fit: BoxFit.cover,
                                                      ),
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.black,
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
                                                                        .white,
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
                                                bottomRight:
                                                    Radius.circular(10),
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
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       flex: 1,
                              //       child: Container(
                              //         height: 50,
                              //         decoration: BoxDecoration(
                              //           color: Colors.green[200],
                              //           borderRadius: const BorderRadius.only(
                              //             topLeft: Radius.circular(10),
                              //             topRight: Radius.circular(10),
                              //             bottomLeft: Radius.circular(0),
                              //             bottomRight: Radius.circular(0),
                              //           ),
                              //           // border: Border.all(
                              //           //     color: Colors.grey, width: 1),
                              //         ),
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: const Center(
                              //           child: Text(
                              //             'รูปแบบบิล',
                              //             textAlign: TextAlign.center,
                              //             style: TextStyle(
                              //                 color: PeopleChaoScreen_Color
                              //                     .Colors_Text1_,
                              //                 fontWeight: FontWeight.bold,
                              //                 fontFamily: FontWeight_.Fonts_T
                              //                 //fontSize: 10.0
                              //                 ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       flex: 1,
                              //       child: Container(
                              //         height: 50,
                              //         color: AppbackgroundColor.Sub_Abg_Colors,
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Container(
                              //           decoration: BoxDecoration(
                              //             color: AppbackgroundColor.Sub_Abg_Colors,
                              //             borderRadius: const BorderRadius.only(
                              //                 topLeft: Radius.circular(10),
                              //                 topRight: Radius.circular(10),
                              //                 bottomLeft: Radius.circular(10),
                              //                 bottomRight: Radius.circular(10)),
                              //             border: Border.all(
                              //                 color: Colors.grey, width: 1),
                              //           ),
                              //           width: 120,
                              //           child: DropdownButtonFormField2(
                              //             decoration: InputDecoration(
                              //               isDense: true,
                              //               contentPadding: EdgeInsets.zero,
                              //               border: OutlineInputBorder(
                              //                 borderRadius: BorderRadius.circular(10),
                              //               ),
                              //             ),
                              //             isExpanded: true,
                              //             hint: Text(
                              //               bills_name_.toString(),
                              //               maxLines: 1,
                              //               style: const TextStyle(
                              //                   fontSize: 14,
                              //                   color: PeopleChaoScreen_Color
                              //                       .Colors_Text2_,
                              //                   //fontWeight: FontWeight.bold,
                              //                   fontFamily: Font_.Fonts_T),
                              //             ),
                              //             icon: const Icon(
                              //               Icons.arrow_drop_down,
                              //               color:
                              //                   PeopleChaoScreen_Color.Colors_Text2_,
                              //             ),
                              //             style: const TextStyle(
                              //                 color: Colors.green,
                              //                 fontFamily: Font_.Fonts_T),
                              //             iconSize: 30,
                              //             buttonHeight: 40,
                              //             // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              //             dropdownDecoration: BoxDecoration(
                              //               borderRadius: BorderRadius.circular(10),
                              //             ),
                              //             items: bill_tser == '1'
                              //                 ? Default_.map((item) =>
                              //                     DropdownMenuItem<String>(
                              //                       value: item,
                              //                       child: Text(
                              //                         item,
                              //                         style: const TextStyle(
                              //                             fontSize: 14,
                              //                             color:
                              //                                 PeopleChaoScreen_Color
                              //                                     .Colors_Text2_,
                              //                             //fontWeight: FontWeight.bold,
                              //                             fontFamily: Font_.Fonts_T),
                              //                       ),
                              //                     )).toList()
                              //                 : Default2_.map((item) =>
                              //                     DropdownMenuItem<String>(
                              //                       value: item,
                              //                       child: Text(
                              //                         item,
                              //                         style: const TextStyle(
                              //                             fontSize: 14,
                              //                             color:
                              //                                 PeopleChaoScreen_Color
                              //                                     .Colors_Text2_,
                              //                             //fontWeight: FontWeight.bold,
                              //                             fontFamily: Font_.Fonts_T),
                              //                       ),
                              //                     )).toList(),

                              //             onChanged: (value) async {
                              //               var bill_set =
                              //                   value == 'บิลธรรมดา' ? 'P' : 'F';
                              //               setState(() {
                              //                 bills_name_ = bill_set;
                              //               });
                              //             },
                              //             // onSaved: (value) {
                              //             //   // selectedValue = value.toString();
                              //             // },
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.white,
                                      // height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.33,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'หมายเหตุ',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            // keyboardType: TextInputType.name,
                                            controller: Form_note,

                                            maxLines: 2,
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
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15),
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
                                              // labelText: 'ระบุชื่อร้านค้า',
                                              labelStyle: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              (paymentName1.toString().trim() ==
                                          'Online Payment' ||
                                      paymentName2.toString().trim() ==
                                          'Online Payment')
                                  ? Stack(
                                      children: [
                                        InkWell(
                                          child: Container(
                                              width: 800,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[900],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                // border: Border.all(color: Colors.white, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                    'Generator QR Code PromtPay',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  )),
                                                ],
                                              )),
                                          onTap:
                                              (paymentName1.toString().trim() !=
                                                          'Online Payment' &&
                                                      paymentName2
                                                              .toString()
                                                              .trim() !=
                                                          'Online Payment')
                                                  ? null
                                                  : () {
                                                      double totalQr_ = 0.00;
                                                      if (paymentName1
                                                                  .toString()
                                                                  .trim() ==
                                                              'Online Payment' &&
                                                          paymentName2
                                                                  .toString()
                                                                  .trim() ==
                                                              'Online Payment') {
                                                        setState(() {
                                                          totalQr_ = 0.00;
                                                        });
                                                        setState(() {
                                                          totalQr_ = double.parse(
                                                                  '${Form_payment1.text}') +
                                                              double.parse(
                                                                  '${Form_payment2.text}');
                                                        });
                                                      } else if (paymentName1
                                                              .toString()
                                                              .trim() ==
                                                          'Online Payment') {
                                                        setState(() {
                                                          totalQr_ = 0.00;
                                                        });
                                                        setState(() {
                                                          totalQr_ = double.parse(
                                                              '${Form_payment1.text}');
                                                        });
                                                      } else if (paymentName2
                                                              .toString()
                                                              .trim() ==
                                                          'Online Payment') {
                                                        setState(() {
                                                          totalQr_ = 0.00;
                                                        });
                                                        setState(() {
                                                          totalQr_ = double.parse(
                                                              '${Form_payment2.text}');
                                                        });
                                                      }

                                                      showDialog<void>(
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
                                                                            20.0))),
                                                            // title: Center(
                                                            //     child: Container(
                                                            //         decoration: BoxDecoration(
                                                            //           color: Colors.blue[300],
                                                            //           borderRadius:
                                                            //               const BorderRadius
                                                            //                       .only(
                                                            //                   topLeft: Radius
                                                            //                       .circular(10),
                                                            //                   topRight: Radius
                                                            //                       .circular(10),
                                                            //                   bottomLeft: Radius
                                                            //                       .circular(10),
                                                            //                   bottomRight:
                                                            //                       Radius
                                                            //                           .circular(
                                                            //                               10)),
                                                            //         ),
                                                            //         padding:
                                                            //             const EdgeInsets.all(
                                                            //                 4.0),
                                                            //         child: const Text(
                                                            //           ' QR PromtPay',
                                                            //           style: TextStyle(
                                                            //             color: Colors.white,
                                                            //             fontWeight:
                                                            //                 FontWeight.bold,
                                                            //           ),
                                                            //         ))),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
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
                                                                        color: Colors
                                                                            .white,
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            4,
                                                                            8,
                                                                            4,
                                                                            2),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            // Text(
                                                                            //   '*** กำลังทดลอง ห้ามใช้งาน จ่ายจริง',
                                                                            //   style: TextStyle(
                                                                            //     color:
                                                                            //         Colors.red,
                                                                            //     fontWeight:
                                                                            //         FontWeight
                                                                            //             .bold,
                                                                            //   ),
                                                                            // ),
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
                                                                        color: Colors
                                                                            .green,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(0),
                                                                            topRight: Radius.circular(0),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          // String qrCodeData = generateQRCode(promptPayID: "0613544026", amount: 1234.56);

                                                                          RenderRepaintBoundary
                                                                              boundary =
                                                                              qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                                          ui.Image
                                                                              image =
                                                                              await boundary.toImage();
                                                                          ByteData?
                                                                              byteData =
                                                                              await image.toByteData(format: ui.ImageByteFormat.png);
                                                                          Uint8List
                                                                              bytes =
                                                                              byteData!.buffer.asUint8List();
                                                                          html.Blob
                                                                              blob =
                                                                              html.Blob([
                                                                            bytes
                                                                          ]);
                                                                          String
                                                                              url =
                                                                              html.Url.createObjectUrlFromBlob(blob);

                                                                          html.AnchorElement
                                                                              anchor =
                                                                              html.AnchorElement()
                                                                                ..href = url
                                                                                ..setAttribute('download', 'qrcode.png')
                                                                                ..click();

                                                                          html.Url.revokeObjectUrl(
                                                                              url);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Download QR Code',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
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
                                                                    height: 5.0,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 4.0,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Colors.black,
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
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, 'OK'),
                                                                            child:
                                                                                const Text(
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
                                        if (paymentName1.toString().trim() !=
                                                'Online Payment' &&
                                            paymentName2.toString().trim() !=
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
                                              )),
                                      ],
                                    )
                                  : SizedBox(),
                              Row(
                                children: [
                                  const Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      // child: InkWell(
                                      //   onTap: () {
                                      //   },
                                      //   child: Container(
                                      //     height: 50,
                                      //     decoration: const BoxDecoration(
                                      //       color: Colors.green,
                                      //       borderRadius: BorderRadius.only(
                                      //           topLeft: Radius.circular(10),
                                      //           topRight: Radius.circular(10),
                                      //           bottomLeft: Radius.circular(10),
                                      //           bottomRight: Radius.circular(10)),
                                      //       // border: Border.all(color: Colors.white, width: 1),
                                      //     ),
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Center(
                                      //       child: select_page == 2
                                      //           ? const Text(
                                      //               'พิมพ์ซ้ำ',
                                      //               style: TextStyle(
                                      //                   color: PeopleChaoScreen_Color
                                      //                       .Colors_Text1_,
                                      //                   fontWeight: FontWeight.bold,
                                      //                   fontFamily:
                                      //                       FontWeight_.Fonts_T),
                                      //             )
                                      //           //
                                      //           : const Text(
                                      //               'พิมพ์ใบเสร็จชั่วคราว',
                                      //               style: TextStyle(
                                      //                   color: PeopleChaoScreen_Color
                                      //                       .Colors_Text1_,
                                      //                   fontWeight: FontWeight.bold,
                                      //                   fontFamily:
                                      //                       FontWeight_.Fonts_T),
                                      //             ),
                                      //     ),
                                      //   ),
                                      // ),
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
                                          if (_Form_nameshop != null) {
                                            Status4Form_nameshop.text =
                                                _Form_nameshop.toString();
                                            Status4Form_typeshop.text =
                                                _Form_typeshop.toString();
                                            Status4Form_bussshop.text =
                                                _Form_bussshop.toString();
                                            Status4Form_bussscontact.text =
                                                _Form_bussscontact.toString();
                                            Status4Form_address.text =
                                                _Form_address.toString();
                                            Status4Form_tel.text =
                                                _Form_tel.toString();
                                            Status4Form_email.text =
                                                _Form_email.toString();
                                            Status4Form_tax.text =
                                                _Form_tax == null
                                                    ? "-"
                                                    : _Form_tax.toString();
                                          }

                                          //----------------------------------->

                                          setState(() {
                                            Slip_status = '2';
                                          });

                                          List newValuePDFimg = [];
                                          for (int index = 0;
                                              index < 1;
                                              index++) {
                                            if (renTalModels[index]
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
                                          if (pamentpage == 0) {
                                            setState(() {
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
                                          } else if (double.parse(pay1) <
                                                  0.00 ||
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
                                                if ((sum_amt - sum_disamt) !=
                                                    0) {
                                                  if (select_page == 0) {
                                                    print('(select_page == 0)');
                                                    if (paymentName1
                                                                .toString()
                                                                .trim() ==
                                                            'เงินโอน' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'เงินโอน') {
                                                      if (base64_Slip != null) {
                                                        final tableData00 = [
                                                          for (int index = 0;
                                                              index <
                                                                  _TransModels
                                                                      .length;
                                                              index++)
                                                            [
                                                              '${index + 1}',
                                                              '${_TransModels[index].name}',
                                                              '${_TransModels[index].tqty}',
                                                              '${nFormat.format(double.parse(_TransModels[index].pvat!))}'
                                                            ],
                                                        ];
                                                        String Area_ =
                                                            '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}';

                                                        try {
                                                          print(
                                                              'tableData00.length');
                                                          print(tableData00
                                                              .length);
                                                          in_Trans(
                                                              newValuePDFimg);
                                                        } catch (e) {}
                                                      } else {
                                                        _showMyDialogPay_Error(
                                                            'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                        // ScaffoldMessenger.of(context)
                                                        //     .showSnackBar(
                                                        //   const SnackBar(
                                                        //       content: Text(
                                                        //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                        //           style: TextStyle(
                                                        //               color:
                                                        //                   Colors.white,
                                                        //               fontFamily: Font_
                                                        //                   .Fonts_T))),
                                                        // );
                                                      }
                                                    } else {
                                                      try {
                                                        in_Trans(
                                                            newValuePDFimg);
                                                        // OKuploadFile_Slip();
                                                      } catch (e) {}
                                                      // try {

                                                      //   // in_Trans();ใช้
                                                      // } catch (e) {}
                                                    }
                                                  } else if (select_page == 1) {
                                                    if (paymentName1.toString().trim() == 'เงินโอน' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'เงินโอน' ||
                                                        paymentName1
                                                                .toString()
                                                                .trim() ==
                                                            'Online Payment' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'Online Payment') {
                                                      if (base64_Slip != null) {
                                                      } else {
                                                        _showMyDialogPay_Error(
                                                            'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                        // ScaffoldMessenger.of(context)
                                                        //     .showSnackBar(
                                                        //   const SnackBar(
                                                        //       content: Text(
                                                        //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                        //           style: TextStyle(
                                                        //               color:
                                                        //                   Colors.white,
                                                        //               fontFamily: Font_
                                                        //                   .Fonts_T))),
                                                        // );
                                                      }
                                                    } else {}
                                                  } else if (select_page == 2) {
                                                    if (paymentName1.toString().trim() == 'เงินโอน' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'เงินโอน' ||
                                                        paymentName1
                                                                .toString()
                                                                .trim() ==
                                                            'Online Payment' ||
                                                        paymentName2
                                                                .toString()
                                                                .trim() ==
                                                            'Online Payment') {
                                                      if (base64_Slip != null) {
                                                        try {
                                                          // OKuploadFile_Slip();
                                                          //TransReBillHistoryModel

                                                          // await in_Trans_re_invoice_refno(
                                                          //     newValuePDFimg);
                                                        } catch (e) {}
                                                      } else {
                                                        _showMyDialogPay_Error(
                                                            'กรุณาแนบหลักฐานการโอน(สลิป)!');
                                                        // ScaffoldMessenger.of(context)
                                                        //     .showSnackBar(
                                                        //   const SnackBar(
                                                        //       content: Text(
                                                        //           'กรุณาแนบหลักฐานการโอน(สลิป)!',
                                                        //           style: TextStyle(
                                                        //               color:
                                                        //                   Colors.white,
                                                        //               fontFamily: Font_
                                                        //                   .Fonts_T))),
                                                        // );
                                                      }
                                                    } else {
                                                      try {
                                                        // OKuploadFile_Slip();
                                                        //TransReBillHistoryModel

                                                        // await in_Trans_re_invoice_refno(
                                                        //     newValuePDFimg);
                                                      } catch (e) {}
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
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              // border: Border.all(color: Colors.white, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                                child: Text(
                                              'รับชำระ',
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
                    )
                  ],
                )
        ]));
  }

  // Future<Null> in_Trans_invoice_P(newValuePDFimg) async {
  //   var tableData00;
  //   setState(() {
  //     tableData00 = [
  //       for (int index = 0; index < _TransModels.length; index++)
  //         [
  //           '${index + 1}',
  //           '${_TransModels[index].date}',
  //           '${_TransModels[index].name}',
  //           '${_TransModels[index].tqty}',
  //           '${_TransModels[index].unit_con}',
  //           _TransModels[index].qty_con == '0.00'
  //               ? '${nFormat.format(double.parse(_TransModels[index].amt_con!))}'
  //               : '${nFormat.format(double.parse(_TransModels[index].qty_con!))}',
  //           '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
  //         ],
  //     ];
  //   });
  //   // fileName_Slip
  //   String? fileName_Slip_ = fileName_Slip.toString().trim();
  //   // if (fileName_Slip != null) {
  //   //   setState(() {
  //   //     fileName_Slip_ = fileName_Slip.toString().trim();
  //   //   });
  //   // } else {}
  //   var day = DateFormat('dd').format(newDatetime);
  //   var timex = DateFormat('HHmmss').format(newDatetime);

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');
  //   var ciddoc =
  //       'L$day$timex${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}';
  //   var qutser = _selecteSerbool.length.toString();
  //   var sumdis = sum_disamt.toString();
  //   var sumdisp = sum_disp.toString();
  //   var dateY = Value_newDateY;
  //   var dateY1 = Value_newDateY1;
  //   var time = Form_time.text;
  //   //pamentpage == 0
  //   var payment1 = Form_payment1.text.toString();
  //   var payment2 = Form_payment2.text.toString();
  //   var pSer1 = paymentSer1;
  //   var pSer2 = paymentSer2;
  //   var sum_whta = sum_wht.toString();

  //   var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
  //   print('in_Trans_invoice_P()///$fileName_Slip_');

  //   print('$sumdis  $pSer1  $pSer2 $time');

  //   String url = pamentpage == 0
  //       ? '${MyConstant().domain}/In_tran_financet_P1_lok1.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_'
  //       : '${MyConstant().domain}/In_tran_financet_P1_lok2.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result.toString() != 'No') {
  //       for (var map in result) {
  //         CFinnancetransModel cFinnancetransModel =
  //             CFinnancetransModel.fromJson(map);
  //         setState(() {
  //           cFinn = cFinnancetransModel.docno;
  //         });
  //         print(' in_Trans_invoice_P$discount_///zzzzasaaa123454>>>>  $cFinn');
  //         print(
  //             ' in_Trans_invoice_P///bnobnobnobno123454>>>>  ${cFinnancetransModel.bno}');
  //       }
  //       // PdfgenReceipt.exportPDF_Receipt(
  //       //     tableData00,
  //       //     context,
  //       //     Slip_status,
  //       //     _TransModels,
  //       //     '${widget.Get_Value_cid}',
  //       //     '${widget.namenew}',
  //       //     '${sum_pvat}',
  //       //     '${sum_vat}',
  //       //     '${sum_wht}',
  //       //     '${sum_amt}',
  //       //     (discount_ == null) ? '0' : '${discount_} ',
  //       //     '${nFormat.format(sum_disamt)}',
  //       //     '${sum_amt - sum_disamt}',
  //       //     // '${nFormat.format(sum_amt - sum_disamt)}',
  //       //     '${renTal_name.toString()}',
  //       //     '${Form_bussshop}',
  //       //     '${Form_address}',
  //       //     '${Form_tel}',
  //       //     '${Form_email}',
  //       //     '${Form_tax}',
  //       //     '${Form_nameshop}',
  //       //     '${renTalModels[0].bill_addr}',
  //       //     '${renTalModels[0].bill_email}',
  //       //     '${renTalModels[0].bill_tel}',
  //       //     '${renTalModels[0].bill_tax}',
  //       //     '${renTalModels[0].bill_name}',
  //       //     newValuePDFimg,
  //       //     pamentpage,
  //       //     paymentName1,
  //       //     paymentName2,
  //       //     Form_payment1.text,
  //       //     Form_payment2.text,
  //       //     cFinn,
  //       //     Value_newDateD);
  //       // setState(() async {
  //       //   await red_Trans_bill();
  //       //   red_Trans_select2();
  //       //   sum_disamtx.text = '0.00';
  //       //   sum_dispx.clear();
  //       //   Form_payment1.clear();
  //       //   Form_payment2.clear();
  //       //   Form_time.clear();
  //       //   Value_newDateY = null;
  //       //   pamentpage = 0;
  //       //   bills_name_ = 'บิลธรรมดา';
  //       //   cFinn = null;
  //       //   Value_newDateD = '';
  //       //   discount_ = null;
  //       //   base64_Slip = null;
  //       //   tableData00 = [];
  //       // });
  //       print('rrrrrrrrrrrrrr');
  //     }
  //   } catch (e) {}
  // }

  Future<Null> in_Trans(newValuePDFimg) async {
    print(
        ' ${_selecteZnSer.map((e) => e).toString().substring(1, _selecteZnSer.map((e) => e).toString().length - 1).trim()}');
    final tableData00 = [
      for (int index = 0; index < _TransModels.length; index++)
        [
          '${index + 1}',
          '${_TransModels[index].name}',
          '${_TransModels[index].tqty}',
          '${nFormat.format(double.parse(_TransModels[index].pvat!))}'
        ],
    ];
    String Area_ = (No_Area_ != '')
        ? '$No_Area_(${Status5Form_NoArea_.text})'
        : '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}';
    print('tableData00.length');
    print(tableData00.length);
    print('---------------------------------->');
    print(Value_AreaSer_);
    print(_verticalGroupValue);
    print('${typeModels.elementAt(Value_AreaSer_).type}');

    print('---------------------------------->');
    print(Status4Form_typeshop.text);
    print(Status4Form_nameshop.text);
    print(Status4Form_typeshop.text);
    print(Status4Form_bussshop.text);
    print(Status4Form_bussscontact.text);
    print(Status4Form_address.text);
    print(Status4Form_tel.text);
    print(Status4Form_tax.text);
    print('----------------------------------');
    print(
        '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}');

    var day = DateFormat('dd').format(newDatetime);
    var timex = DateFormat('mmss').format(newDatetime);

    String? fileName_Slip_ = fileName_Slip.toString().trim();
    ////////////////------------------------------------------------------>
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = No_Area_ == 'ไม่ระบุพื้นที่'
        ? 'L$day$timex-${Status5Form_NoArea_.text}'
        : 'L$day$timex-${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1).trim()}';
    var qutser = _selecteSerbool.length.toString();
    var sumdis = sum_disamt.toString();
    var sumdisp = sum_disp.toString();
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = Form_time.text;
    var bill = 'P';
    // var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    //pamentpage == 0
    var payment1 = Form_payment1.text.toString();
    var payment2 = Form_payment2.text.toString();
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var sum_whta = sum_wht.toString();
    var comment = Form_note.text.toString();
    print('in_Trans_invoice()///$fileName_Slip_');
    print('in_Trans_invoice>>> $payment1  $payment2 $bill');
    print('$sumdis  $pSer1  $pSer2 $time');
    String url =
        '${MyConstant().domain}/In_tran_financet_lock3.php?isAdd=true&ren=$ren';

    var response = await http.post(Uri.parse(url), body: {
      'ciddoc': ciddoc.toString(),
      'qutser': qutser.toString(),
      'user': user.toString(),
      'sumdis': sumdis.toString(),
      'sumdisp': sumdisp.toString(),
      'dateY': dateY.toString(),
      'dateY1': dateY1.toString(),
      'time': time.toString(),
      'payment1': payment1.toString(),
      'payment2': payment2.toString(),
      'pSer1': pSer1.toString(),
      'pSer2': pSer2.toString(),
      'sum_whta': sum_whta.toString(),
      'bill': bill.toString(),
      'fileNameSlip': fileName_Slip_.toString(),
      'areaSer': (Value_AreaSer_ + 1).toString(),
      'typeModels': typeModels.elementAt(Value_AreaSer_).type.toString(),
      'typeshop': Status4Form_typeshop.text.toString(),
      'nameshop': Status4Form_nameshop.text.toString(),
      'bussshop': Status4Form_bussshop.text.toString(),
      'bussscontact': Status4Form_bussscontact.text.toString(),
      'address': Status4Form_address.text.toString(),
      'tel': Status4Form_tel.text.toString(),
      'tax': Status4Form_tax.text.toString(),
      'email': Status4Form_email.text.toString(),
      'Serbool': _selecteSerbool
          .map((e) => e)
          .toString()
          .substring(1, _selecteSerbool.map((e) => e).toString().length - 1)
          .trim()
          .toString(),
      'area_rent_sum': _area_rent_sum.toString(),
      'comment': comment.toString(),
      'zser': _selecteZnSer
          .map((e) => e)
          .toString()
          .substring(1, _selecteZnSer.map((e) => e).toString().length - 1)
          .trim()
          .toString(),
    }).then((value) async {
      print('$value');
      var result = json.decode(value.body);
      print('$result ');
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
        if (paymentName1.toString().trim() == 'เงินโอน' ||
            paymentName2.toString().trim() == 'เงินโอน') {
          if (base64_Slip != null) {
            OKuploadFile_Slip(cFinn);
          }
        }
        Insert_log.Insert_logs('บัญชี', 'ล็อกเสียบ>>รับชำระ($cFinn)');
        PdfgenReceiptLock.exportPDF_ReceiptLock2(
            tableData00,
            context,
            Slip_status,
            '$cFinn',
            '$cFinn',
            '${nFormat.format(sum_pvat)}',
            '${nFormat.format(sum_vat)}',
            '${nFormat.format(sum_wht)}',
            '${nFormat.format(sum_amt)}',
            '${sum_dispx.text.toString()}',
            '$sum_disamt',
            sum_disamtx.text == ''
                ? '${sum_amt - 0}'
                : '${sum_amt - double.parse(sum_disamtx.text.toString())}',
            // ? '${nFormat.format(sum_amt - 0).toString()}'
            // : '${nFormat.format(sum_amt - double.parse(sum_disamtx.text)).toString()}',
            renTal_name,
            Status4Form_bussshop.text.toString(),
            Status4Form_address.text.toString(),
            Status4Form_tel.text.toString(),
            Status4Form_email.text.toString(),
            Status4Form_tax.text.toString(),
            Status4Form_nameshop.text.toString(),
            bill_addr,
            bill_email,
            bill_tel,
            bill_tax,
            bill_name,
            newValuePDFimg,
            pamentpage,
            paymentName1,
            paymentName2,
            Form_payment1.text,
            Form_payment2.text,
            numinvoice,
            cFinn,
            '${Area_}',
            '${Value_newDateD}');

        setState(() async {
          await red_Trans_bill();
          red_Trans_select2();
          sum_disamtx.text = '0.00';
          sum_dispx.clear();
          Form_payment1.clear();
          Form_payment2.clear();
          Form_time.clear();
          Form_note.clear();
          _area_rent_sum = 0.00;
          // Value_newDateY = null;
          pamentpage = 0;
          bills_name_ = 'บิลธรรมดา';
          cFinn = null;
          // Value_newDateD = '';
          discount_ = null;
          base64_Slip = null;

          _selecteSer = [];
          _selecteSerbool = [];
          Status4Form_nameshop.text = '';
          Status4Form_typeshop.text = '';
          Status4Form_bussshop.text = '';
          Status4Form_bussscontact.text = '';
          Status4Form_address.text = '';
          Status4Form_tel.text = '';
          Status4Form_email.text = '';
          Status4Form_tax.text = '';
          Status5Form_NoArea_.text = '';
          No_Area_ = '';
        });

        print('rrrrrrrrrrrrrr');
        checkPreferance();
        read_GC_zone();
        read_GC_tenant();
        red_Trans_bill();
        read_GC_rental();
        read_GC_type();
        read_GC_areaSelect();
        red_payMent();
        read_GC_Exp();
        red_Trans_select2();
      }
    });
  }
}
