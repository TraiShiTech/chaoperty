// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names
import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../CRC_16_Prompay/generate_qrcode.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_Trans_play.dart';
import '../Model/Get_Trans_playList.dart';
import '../Model/Get_Trans_play_pay.dart';
import '../Model/Get_trans_playListx.dart';
import '../Model/Get_trans_playx.dart';
import '../Model/Get_trans_playx_pay.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class PlayColumn extends StatefulWidget {
  const PlayColumn({super.key});

  @override
  State<PlayColumn> createState() => _PlayColumnState();
}

class _PlayColumnState extends State<PlayColumn> {
  var nFormat = NumberFormat("#,##0", "en_US");
  // var formatter = DateFormat.yMMMMEEEEd();

  List<ExpModel> expModels = [];
  List<TransPlayModel> transPlayModels = [];
  List<TransPlayxModel> transPlayxModels = [];

  List<TransPlayPayModel> transPlayPayModels = [];
  List<TransPlayxPayModel> transPlayxPayModels = [];

  List<TransPlayListModel> transPlayListModels = [];
  List<TransPlayListxModel> transPlayListxModels = [];
  List<TransModel> _TransModels = [];
  List<PayMentModel> _PayMentModels = [];
  List<String> listcolor = [];
  List<dynamic> listcolorplay = [];
  List<RenTalModel> renTalModels = [];
  List<TeNantModel> teNantModels = [];
  List<ZoneModel> zoneModels = [];
  final sum_disamtx = TextEditingController();
  final sum_dispx = TextEditingController();
  final Form_payment1 = TextEditingController();
  final Form_payment2 = TextEditingController();
  final Form_time = TextEditingController();
  final Formbecause_ = TextEditingController();
  final Form_note = TextEditingController();

  final text_add = TextEditingController();
  final price_add = TextEditingController();
  DateTime newDatetime = DateTime.now();
  int listOrder = 0, his = 0;
  String? Slip_status;
  double sum = 0.00;
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0,
      sumarea = 0,
      sumarea_pay = 0;
  var renTal_name;
  int select_page = 0, pamentpage = 0, insexselect = 0, menulist = 0;
  String? refnoselect, nameselect, areaselect;
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
      zoneSelext,
      menunamelist;

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

  String? bills_name_;

  String? selectedValue;
  String? base64_Slip, fileName_Slip;
  GlobalKey qrImageKey = GlobalKey();
  ScrollController con = ScrollController();
  bool _customTileExpanded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // read_GC_Exp();
    // read_GC_Playcolumn();
    d_tran_selectall();
    red_payMent();
    read_GC_rental();
    read_GC_zone();
    Value_newDateY1 = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD1 = DateFormat('dd-MM-yyyy').format(newDatetime);
    Value_newDateY = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD = DateFormat('dd-MM-yyyy').format(newDatetime);
  }

  Future<Null> read_GC_zone() async {
    if (zoneModels.length != 0) {
      zoneModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zoneSer = preferences.getString('zonePSer');
    var zonesName = preferences.getString('zonesName');
    var zoneSubSer = preferences.getString('zoneSubSer');
    var zonesSubName = preferences.getString('zonesSubName');

    String url = '${MyConstant().domain}/GC_zone.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        var sub = zoneModel.sub_zone;
        setState(() {
          if (zoneSubSer == null || zoneSubSer == '0') {
            zoneModels.add(zoneModel);
          } else {
            if (sub == zoneSubSer) {
              zoneModels.add(zoneModel);
            }
          }
        });
      }
    } catch (e) {}

    print('zoneSerzoneSer>>>> $zoneSer');

    if (zoneSer != '0') {
      if (zoneSer != null) {
        setState(() {
          zoneSelext = zoneSer;
          read_GC_Exp();
          read_GC_Playcolumn();
        });
      }
    }
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
          var hisx = int.parse(renTalModel.his!);
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
            his = hisx;
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
    var ciddoc = refnoselect;
    var qutser = '1';

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

  Future<Null> d_tran_selectall() async {
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

    String url =
        '${MyConstant().domain}/D_tran_select.php?isAdd=true&ren=$ren&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print("....................... $result");
      if (result.toString() == 'true') {
        setState(() {
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
        });
      }

      setState(() {
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      });
    } catch (e) {}
  }

  Future<Null> read_GC_Playcolumn_pay() async {
    if (transPlayPayModels.isNotEmpty) {
      setState(() {
        transPlayPayModels.clear();
        transPlayxPayModels.clear();
        sumarea_pay = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer'); //widget.Get_Value_zone_ser;

    String url =
        '${MyConstant().domain}/GC_Playcolumn_pay.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      // print(result);

      print(
          '----------------------------------------------------3345653----------------------------------------------------------');
      if (result != null) {
        sumarea_pay = 0;
        transPlayPayModels.clear();
        transPlayxPayModels.clear();
        for (var map in result) {
          TransPlayPayModel transPlayPayModel = TransPlayPayModel.fromJson(map);
          var vv = transPlayPayModel.cid;
          List<dynamic> successList = transPlayPayModel.play_amt;
          var ara = double.parse(transPlayPayModel.area!);
          // List<dynamic> successList = result[][transPlayModel.play_amt];
          print('vv>>>>>cid  $vv >>>>araaraara $ara');
          setState(() {
            sumarea_pay = sumarea_pay + ara;
            transPlayPayModels.add(transPlayPayModel);
            transPlayxPayModels.clear();
          });

          for (int i = 0; i < successList.length; i++) {
            // print('${successList[i]}');
            //     var znx = transPlayModels[v].play_amt[i];
            for (int ii = 0; ii < expModels.length; ii++) {
              var result = successList[i][expModels[ii].ser];
              if (result != null) {
                var encodedString = jsonEncode(result);
                Map<String, dynamic> valueMap = json.decode(encodedString);
                TransPlayxPayModel transPlayxPayModel =
                    TransPlayxPayModel.fromJson(valueMap);
                // print(
                //     '----------ccccc $vv  --------${transPlayxModel.refno_trans}----->');
                // if (vv != transPlayxPayModel.refno_trans) {
                // if (expModels[ii].ser == transPlayxModel.expx_row) {
                setState(() {
                  transPlayxPayModels.add(transPlayxPayModel);
                });
                // }
                // }

                // break;
              }
              // break;
            }
          }
        }
      } else {}

      print('transPlayxPayModels -------------> ${transPlayxPayModels.length}');
    } catch (e) {
      print('e -------------> $e');
    }
  }

  Future<Null> read_GC_Playcolumn() async {
    if (transPlayModels.isNotEmpty) {
      setState(() {
        transPlayModels.clear();
        transPlayxModels.clear();
        sumarea = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer'); //widget.Get_Value_zone_ser;

    String url =
        '${MyConstant().domain}/GC_Playcolumn.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      // print(result);

      print(
          '----------------------------------------------------333----------------------------------------------------------');
      if (result != null) {
        sumarea = 0;
        transPlayModels.clear();
        transPlayxModels.clear();
        for (var map in result) {
          TransPlayModel transPlayModel = TransPlayModel.fromJson(map);
          var vv = transPlayModel.cid;
          List<dynamic> successList = transPlayModel.play_amt;

          print('>length>transPlayModel>>>>>>>${transPlayModel}');
          print('>>>>>>successList>>>>>>>$successList');
          print('>length>successList>>>>>>>${successList.length}');
          var ara = double.parse(transPlayModel.area.toString());
          // List<dynamic> successList = result[][transPlayModel.play_amt];
          print('>>>>>>araara>>>>>>>$ara');
          setState(() {
            sumarea = sumarea + ara;
            transPlayModels.add(transPlayModel);
            read_GC_Playcolumn_pay();
          });

          for (int i = 0; i < successList.length; i++) {
            //     var znx = transPlayModels[v].play_amt[i];
            for (int ii = 0; ii < expModels.length; ii++) {
              var result = successList[i][expModels[ii].ser];
              if (result != null) {
                var encodedString = jsonEncode(result);
                Map<String, dynamic> valueMap = json.decode(encodedString);
                TransPlayxModel transPlayxModel =
                    TransPlayxModel.fromJson(valueMap);
                // print(
                //     '----------ccccc $vv  --------${transPlayxModel.refno_trans}----->');
                if (vv == transPlayxModel.refno_trans) {
                  // if (expModels[ii].ser == transPlayxModel.expx_row) {
                  setState(() {
                    transPlayxModels.add(transPlayxModel);
                  });
                }
                // }

                // break;
              }
              // break;
            }
          }
        }
      } else {}
    } catch (e) {
      print('e -------------> $e');
    }
  }

  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      expModels.clear();
      listcolor.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_exp_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      if (result != null) {
        for (var map in result) {
          ExpModel expModel = ExpModel.fromJson(map);
          var au = expModel.auto;
          setState(() {
            if (au == '1') {
              expModels.add(expModel);
              listcolor.add('0');
            }
          });
        }
      } else {}
      print('-------------> ${listcolor.length}  ${listcolor.map((e) => e)}');
    } catch (e) {}
  }

  Future<Null> red_listdate(ciddoc) async {
    if (transPlayListModels.isNotEmpty) {
      setState(() {
        transPlayListModels.clear();
        transPlayListxModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer'); //widget.Get_Value_zone_ser;
    var ref = ciddoc;
    print('readddddd  -------------> $ref');
    String url =
        '${MyConstant().domain}/GC_Playcolumn1.php?isAdd=true&ren=$ren&zone=$zone&ref=$ref';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      // print(result);

      if (result != null) {
        transPlayListModels.clear();
        transPlayListxModels.clear();
        for (var map in result) {
          TransPlayListModel transPlayListModel =
              TransPlayListModel.fromJson(map);
          var vv = transPlayListModel.datex;
          List<dynamic> successList = transPlayListModel.play_amt;
          // List<dynamic> successList = result[][transPlayModel.play_amt];

          setState(() {
            transPlayListModels.add(transPlayListModel);
          });

          for (int i = 0; i < successList.length; i++) {
            //     var znx = transPlayModels[v].play_amt[i];
            for (int ii = 0; ii < expModels.length; ii++) {
              var result = successList[i][expModels[ii].ser];
              if (result != null) {
                var encodedString = jsonEncode(result);
                Map<String, dynamic> valueMap = json.decode(encodedString);
                TransPlayListxModel transPlayListxModel =
                    TransPlayListxModel.fromJson(valueMap);
                // print(
                //     '----------ccccc $vv  --------${transPlayxModel.refno_trans}----->');
                if (vv == transPlayListxModel.date_trans) {
                  // if (expModels[ii].ser == transPlayxModel.expx_row) {
                  setState(() {
                    transPlayListxModels.add(transPlayListxModel);
                    listcolorplay.add('0');
                  });
                }
                // }

                // break;
              }
              // break;
            }
          }
        }
      } else {}

      // for (var i = 0; i < transPlayListModels.length; i++) {
      //   for (var c = 0; c < expModels.length; c++) {
      //     setState(() {
      //       listcolorplay.insert(i, {"0", "1", "2", "3", "4"});
      //       // listcolorplay.add([
      //       //   {
      //       //     "$i": [
      //       //       {"0", "1", "2", "3", "4"}
      //       //     ]
      //       //   }
      //       // ]);
      //     });
      //   }
      // }

      print(
          '-------------------${transPlayListModels.length}--------------${listcolorplay.map((e) => e)}-----------------333456----------------------${transPlayListxModels.length}---------------------');
    } catch (e) {
      print('e -------------> $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                    controller: con,
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      const Text(
                        'โซน : ',
                        style: TextStyle(
                          color: AccountScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < zoneModels.length; i++)
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: Responsive.isDesktop(context)
                                      ? MediaQuery.of(context).size.width * 0.1
                                      : MediaQuery.of(context).size.width *
                                          0.22,
                                  child: InkWell(
                                    onTap: () async {
                                      var zoneSer = zoneModels[i].ser;
                                      var zonesName = zoneModels[i].zn;
                                      print(
                                          'mmmmm ${zoneSer.toString()} $zonesName');

                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      preferences.setString(
                                          'zonePSer', zoneSer.toString());
                                      preferences.setString(
                                          'zonesPName', zonesName.toString());

                                      preferences.setString(
                                          'zoneSer', zoneSer.toString());
                                      preferences.setString(
                                          'zonesName', zonesName.toString());
                                      setState(() {
                                        zoneSelext = zoneSer;
                                        read_GC_Exp();
                                        read_GC_Playcolumn();
                                        d_tran_selectall();
                                        refnoselect = null;
                                        nameselect = null;
                                        sum_disamtx.text = '0.00';
                                        sum_dispx.clear();
                                        Form_payment1.clear();
                                        Form_payment2.clear();
                                        Form_time.clear();
                                        Form_note.clear();
                                        pamentpage = 0;
                                        bills_name_ = 'บิลธรรมดา';
                                        cFinn = null;
                                        discount_ = null;
                                        base64_Slip = null;
                                        _customTileExpanded = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: zoneSelext == zoneModels[i].ser
                                            ? Colors.green
                                            : Colors.white38,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border:
                                            (zoneSelext == zoneModels[i].ser)
                                                ? Border.all(
                                                    color: Colors.white,
                                                    width: 1)
                                                : Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          zoneModels[i].zn.toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: (zoneSelext ==
                                                    zoneModels[i].ser)
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
        Responsive.isDesktop(context) ? forWeb() : fortablet(),
      ],
    );
  }

  Padding forWeb() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      height: MediaQuery.of(context).size.width * 0.07,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'พื้นที่',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ReportScreen_Color.Colors_Text1_,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                  Text(
                                    sumarea_pay == 0
                                        ? '( ${nFormat.format(sumarea)} )'
                                        : '( ${nFormat.format(sumarea_pay + sumarea)} )',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ReportScreen_Color.Colors_Text1_,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                  Text(
                                    '${nFormat.format(sumarea_pay)}',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                  Text(
                                    '${nFormat.format(sumarea)}',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ), //sumarea_pay
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'ชื่อ - สกุล',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ReportScreen_Color.Colors_Text1_,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          for (int i = 0; i < expModels.length; i++)
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '${expModels[i].expname}',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                    Text(
                                      transPlayxPayModels.length == 0
                                          ? transPlayxModels.length == 0
                                              ? '0'
                                              : '( ${(transPlayxModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b))} )'
                                          : transPlayxModels.length == 0
                                              ? '( ${(transPlayxPayModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b))} )'
                                              : '( ${(transPlayxPayModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b)) + (transPlayxModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b))} )',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                    Text(
                                      transPlayxPayModels.length == 0
                                          ? '0'
                                          : '${transPlayxPayModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b)}',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                    Text(
                                      transPlayxModels.length == 0
                                          ? '0'
                                          : '${transPlayxModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b)}',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                    // transPlayModels
                                  ],
                                ),
                              ),
                            ),
                          Expanded(
                            flex: 1,
                            child: refnoselect == null
                                ? Column(
                                    children: [
                                      Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      addPlaySelect();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade300,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        // border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Center(
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 15,
                                          'เพิ่มรายการ',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.width * 0.31,
                        child: ListView.builder(
                            itemCount: transPlayModels.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: ExpansionPanelList(
                                  animationDuration: Duration(milliseconds: 1),
                                  expandIconColor:
                                      transPlayModels[index].yon_amt == '1'
                                          ? his == 1
                                              ? Colors.red
                                              : Colors.white
                                          : Colors.white,
                                  // dividerColor: Colors.red,
                                  elevation: 1,
                                  children: [
                                    refnoselect == null
                                        ? ExpansionPanel(
                                            body: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[],
                                              ),
                                            ),

                                            headerBuilder:
                                                (BuildContext context,
                                                    bool isExpanded) {
                                              return Container(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '${transPlayModels[index].ln}',
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        '${transPlayModels[index].sname}',
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    for (int i = 0;
                                                        i < expModels.length;
                                                        i++)
                                                      Expanded(
                                                          child: Column(
                                                        children: [
                                                          for (int v = 0;
                                                              v <
                                                                  transPlayxModels
                                                                      .length;
                                                              v++)
                                                            if (transPlayModels[
                                                                        index]
                                                                    .cid ==
                                                                transPlayxModels[
                                                                        v]
                                                                    .refno_trans)
                                                              Row(
                                                                children: [
                                                                  (transPlayxModels[v]
                                                                              .expx_row ==
                                                                          expModels[i]
                                                                              .ser)
                                                                      ? transPlayxModels[v].pvat_trans ==
                                                                              null
                                                                          ? Expanded(
                                                                              child: Text(
                                                                              '0',
                                                                              textAlign: TextAlign.center,
                                                                            ))
                                                                          : Expanded(
                                                                              child: transPlayxModels[v].invoice_row != null
                                                                                  ? Text(
                                                                                      '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(color: Colors.orange.shade900),
                                                                                    )
                                                                                  : Card(
                                                                                      color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.green.shade700 : Colors.white,
                                                                                      child: SizedBox(
                                                                                        child: InkWell(
                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                            onDoubleTap: () {
                                                                                              print('onDoubleTap');

                                                                                              de_item(v);
                                                                                            },
                                                                                            onLongPress: () {
                                                                                              print('onLongPress');
                                                                                              de_item(v);
                                                                                            },
                                                                                            onTap: () async {
                                                                                              in_Trans_select(v, i);
                                                                                              var ciddoc = transPlayModels[index].cid;
                                                                                              setState(() {
                                                                                                if (his == 1) {
                                                                                                  red_listdate(ciddoc);
                                                                                                }

                                                                                                if (transPlayModels[index].yon_amt == '0') {
                                                                                                  _customTileExpanded = false;
                                                                                                }
                                                                                              });
                                                                                              setState(() {
                                                                                                insexselect = v;
                                                                                                areaselect = transPlayModels[index].ln;
                                                                                                nameselect = transPlayModels[index].sname;
                                                                                              });
                                                                                            },
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                                  style: TextStyle(
                                                                                                    color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.white : Colors.black,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )),
                                                                                      ),
                                                                                    ),
                                                                            )
                                                                      : SizedBox(),
                                                                ],
                                                              ),
                                                        ],
                                                      )),

                                                    // for (int v = 0;
                                                    //     v <
                                                    //         transPlayxModels
                                                    //             .length;
                                                    //     v++)
                                                    //   if (transPlayModels[index]
                                                    //           .cid ==
                                                    //       transPlayxModels[v]
                                                    //           .refno_trans)

                                                    //         Expanded(
                                                    //           child: Row(
                                                    //             children: [
                                                    //               for (int i =
                                                    //                       0;
                                                    //                   i <
                                                    //                       expModels
                                                    //                           .length;
                                                    //                   i++)
                                                    //                 (transPlayxModels[v].expx_row ==
                                                    //                         expModels[i]
                                                    //                             .ser)
                                                    //                     ? transPlayxModels[v].pvat_trans ==
                                                    //                             null
                                                    //                         ? Expanded(
                                                    //                             child: Text(
                                                    //                             '0',
                                                    //                             textAlign: TextAlign.center,
                                                    //                           ))
                                                    //                         : Expanded(
                                                    //                             child: transPlayxModels[v].invoice_row != null
                                                    //                                 ? Text(
                                                    //                                     '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                    //                                     textAlign: TextAlign.center,
                                                    //                                     style: TextStyle(color: Colors.orange.shade900),
                                                    //                                   )
                                                    //                                 : Card(
                                                    //                                     color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.green.shade700 : Colors.white,
                                                    //                                     child: SizedBox(
                                                    //                                       child: InkWell(
                                                    //                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                    //                                           onDoubleTap: () {
                                                    //                                             print('onDoubleTap');

                                                    //                                             de_item(v);
                                                    //                                           },
                                                    //                                           onLongPress: () {
                                                    //                                             print('onLongPress');
                                                    //                                             de_item(v);
                                                    //                                           },
                                                    //                                           onTap: () async {
                                                    //                                             in_Trans_select(v, i);
                                                    //                                             var ciddoc = transPlayModels[index].cid;
                                                    //                                             setState(() {
                                                    //                                               if (his == 1) {
                                                    //                                                 red_listdate(ciddoc);
                                                    //                                               }

                                                    //                                               if (transPlayModels[index].yon_amt == '0') {
                                                    //                                                 _customTileExpanded = false;
                                                    //                                               }
                                                    //                                             });
                                                    //                                             setState(() {
                                                    //                                               insexselect = v;
                                                    //                                               areaselect = transPlayModels[index].ln;
                                                    //                                               nameselect = transPlayModels[index].sname;
                                                    //                                             });
                                                    //                                           },
                                                    //                                           child: Padding(
                                                    //                                             padding: const EdgeInsets.all(8.0),
                                                    //                                             child: Center(
                                                    //                                               child: Text(
                                                    //                                                 '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                    //                                                 style: TextStyle(
                                                    //                                                   color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.white : Colors.black,
                                                    //                                                 ),
                                                    //                                               ),
                                                    //                                             ),
                                                    //                                           )),
                                                    //                                     ),
                                                    //                                   ),
                                                    //                           )
                                                    //                     : SizedBox(),

                                                    //     ],
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              );
                                            },
                                            // isExpanded: _customTileExpanded,
                                          )
                                        : refnoselect ==
                                                transPlayModels[index].cid
                                            ? ExpansionPanel(
                                                body: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: playList()),
                                                headerBuilder:
                                                    (BuildContext context,
                                                        bool isExpanded) {
                                                  return Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${transPlayModels[index].ln}',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            '${transPlayModels[index].sname}',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        for (int i = 0;
                                                            i <
                                                                expModels
                                                                    .length;
                                                            i++)
                                                          Expanded(
                                                              child: Column(
                                                            children: [
                                                              for (int v = 0;
                                                                  v <
                                                                      transPlayxModels
                                                                          .length;
                                                                  v++)
                                                                if (transPlayModels[
                                                                            index]
                                                                        .cid ==
                                                                    transPlayxModels[
                                                                            v]
                                                                        .refno_trans)
                                                                  Row(
                                                                    children: [
                                                                      (transPlayxModels[v].expx_row ==
                                                                              expModels[i].ser)
                                                                          ? transPlayxModels[v].pvat_trans == null
                                                                              ? Expanded(
                                                                                  child: Text(
                                                                                  '0',
                                                                                  textAlign: TextAlign.center,
                                                                                ))
                                                                              : Expanded(
                                                                                  child: transPlayxModels[v].invoice_row != null
                                                                                      ? Text(
                                                                                          '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(color: Colors.orange.shade900),
                                                                                        )
                                                                                      : Card(
                                                                                          color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.green.shade700 : Colors.white,
                                                                                          child: SizedBox(
                                                                                            child: InkWell(
                                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                onDoubleTap: () {
                                                                                                  print('onDoubleTap');
                                                                                                  in_Trans_select(v, i);
                                                                                                  var ciddoc = transPlayModels[index].cid;

                                                                                                  setState(() {
                                                                                                    if (his == 1) {
                                                                                                      red_listdate(ciddoc);
                                                                                                    }
                                                                                                    if (transPlayModels[index].yon_amt == '0') {
                                                                                                      _customTileExpanded = false;
                                                                                                    }
                                                                                                  });
                                                                                                  setState(() {
                                                                                                    insexselect = v;
                                                                                                    areaselect = transPlayModels[index].ln;
                                                                                                    nameselect = transPlayModels[index].sname;
                                                                                                  });
                                                                                                  de_item(v);
                                                                                                },
                                                                                                onLongPress: () {
                                                                                                  print('onLongPress');
                                                                                                  in_Trans_select(v, i);
                                                                                                  var ciddoc = transPlayModels[index].cid;

                                                                                                  setState(() {
                                                                                                    if (his == 1) {
                                                                                                      red_listdate(ciddoc);
                                                                                                    }
                                                                                                    if (transPlayModels[index].yon_amt == '0') {
                                                                                                      _customTileExpanded = false;
                                                                                                    }
                                                                                                  });
                                                                                                  setState(() {
                                                                                                    insexselect = v;
                                                                                                    areaselect = transPlayModels[index].ln;
                                                                                                    nameselect = transPlayModels[index].sname;
                                                                                                  });
                                                                                                  de_item(v);
                                                                                                },
                                                                                                onTap: () async {
                                                                                                  in_Trans_select(v, i);
                                                                                                  var ciddoc = transPlayModels[index].cid;

                                                                                                  setState(() {
                                                                                                    if (his == 1) {
                                                                                                      red_listdate(ciddoc);
                                                                                                    }
                                                                                                    if (transPlayModels[index].yon_amt == '0') {
                                                                                                      _customTileExpanded = false;
                                                                                                    }
                                                                                                  });
                                                                                                  setState(() {
                                                                                                    insexselect = v;
                                                                                                    areaselect = transPlayModels[index].ln;
                                                                                                    nameselect = transPlayModels[index].sname;
                                                                                                  });
                                                                                                },
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Center(
                                                                                                    child: Text(
                                                                                                      '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                                      style: TextStyle(
                                                                                                        color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.white : Colors.black,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )),
                                                                                          ),
                                                                                        ),
                                                                                )
                                                                          : SizedBox(),
                                                                    ],
                                                                  ),
                                                            ],
                                                          )),
                                                        // for (int v = 0;
                                                        //     v <
                                                        //         transPlayxModels
                                                        //             .length;
                                                        //     v++)
                                                        //   if (transPlayModels[
                                                        //               index]
                                                        //           .cid ==
                                                        //       transPlayxModels[
                                                        //               v]
                                                        //           .refno_trans)
                                                        //     Expanded(
                                                        //       child: Row(
                                                        //         children: [
                                                        //           for (int i =
                                                        //                   0;
                                                        //               i <
                                                        //                   expModels
                                                        //                       .length;
                                                        //               i++)
                                                        //             (transPlayxModels[v].expx_row ==
                                                        //                     expModels[i]
                                                        //                         .ser)
                                                        //                 ? transPlayxModels[v].pvat_trans ==
                                                        //                         null
                                                        //                     ? Expanded(
                                                        //                         child: Text(
                                                        //                         '0',
                                                        //                         textAlign: TextAlign.center,
                                                        //                       ))
                                                        //                     : Expanded(
                                                        //                         child: transPlayxModels[v].invoice_row != null
                                                        //                             ? Text(
                                                        //                                 '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                        //                                 textAlign: TextAlign.center,
                                                        //                                 style: TextStyle(color: Colors.orange.shade900),
                                                        //                               )
                                                        //                             : Card(
                                                        //                                 color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.green.shade700 : Colors.white,
                                                        //                                 child: SizedBox(
                                                        //                                   child: InkWell(
                                                        //                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                        //                                       onDoubleTap: () {
                                                        //                                         print('onDoubleTap');
                                                        //                                         in_Trans_select(v, i);
                                                        //                                         var ciddoc = transPlayModels[index].cid;

                                                        //                                         setState(() {
                                                        //                                           if (his == 1) {
                                                        //                                             red_listdate(ciddoc);
                                                        //                                           }
                                                        //                                           if (transPlayModels[index].yon_amt == '0') {
                                                        //                                             _customTileExpanded = false;
                                                        //                                           }
                                                        //                                         });
                                                        //                                         setState(() {
                                                        //                                           insexselect = v;
                                                        //                                           areaselect = transPlayModels[index].ln;
                                                        //                                           nameselect = transPlayModels[index].sname;
                                                        //                                         });
                                                        //                                         de_item(v);
                                                        //                                       },
                                                        //                                       onLongPress: () {
                                                        //                                         print('onLongPress');
                                                        //                                         in_Trans_select(v, i);
                                                        //                                         var ciddoc = transPlayModels[index].cid;

                                                        //                                         setState(() {
                                                        //                                           if (his == 1) {
                                                        //                                             red_listdate(ciddoc);
                                                        //                                           }
                                                        //                                           if (transPlayModels[index].yon_amt == '0') {
                                                        //                                             _customTileExpanded = false;
                                                        //                                           }
                                                        //                                         });
                                                        //                                         setState(() {
                                                        //                                           insexselect = v;
                                                        //                                           areaselect = transPlayModels[index].ln;
                                                        //                                           nameselect = transPlayModels[index].sname;
                                                        //                                         });
                                                        //                                         de_item(v);
                                                        //                                       },
                                                        //                                       onTap: () async {
                                                        //                                         in_Trans_select(v, i);
                                                        //                                         var ciddoc = transPlayModels[index].cid;

                                                        //                                         setState(() {
                                                        //                                           if (his == 1) {
                                                        //                                             red_listdate(ciddoc);
                                                        //                                           }
                                                        //                                           if (transPlayModels[index].yon_amt == '0') {
                                                        //                                             _customTileExpanded = false;
                                                        //                                           }
                                                        //                                         });
                                                        //                                         setState(() {
                                                        //                                           insexselect = v;
                                                        //                                           areaselect = transPlayModels[index].ln;
                                                        //                                           nameselect = transPlayModels[index].sname;
                                                        //                                         });
                                                        //                                       },
                                                        //                                       child: Padding(
                                                        //                                         padding: const EdgeInsets.all(8.0),
                                                        //                                         child: Center(
                                                        //                                           child: Text(
                                                        //                                             '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                        //                                             style: TextStyle(
                                                        //                                               color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.white : Colors.black,
                                                        //                                             ),
                                                        //                                           ),
                                                        //                                         ),
                                                        //                                       )),
                                                        //                                 ),
                                                        //                               ),
                                                        //                       )
                                                        //                 : SizedBox(),
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                isExpanded: his == 0
                                                    ? false
                                                    : _customTileExpanded,
                                              )
                                            : ExpansionPanel(
                                                backgroundColor:
                                                    AppbackgroundColor
                                                        .Abg_Colors,
                                                body: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[],
                                                  ),
                                                ),
                                                headerBuilder:
                                                    (BuildContext context,
                                                        bool isExpanded) {
                                                  return Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${transPlayModels[index].ln}',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            '${transPlayModels[index].sname}',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        for (int i = 0;
                                                            i <
                                                                expModels
                                                                    .length;
                                                            i++)
                                                          Expanded(
                                                              child: Column(
                                                            children: [
                                                              for (int v = 0;
                                                                  v <
                                                                      transPlayxModels
                                                                          .length;
                                                                  v++)
                                                                if (transPlayModels[
                                                                            index]
                                                                        .cid ==
                                                                    transPlayxModels[
                                                                            v]
                                                                        .refno_trans)
                                                                  Row(
                                                                    children: [
                                                                      (transPlayxModels[v].expx_row ==
                                                                              expModels[i].ser)
                                                                          ? transPlayxModels[v].pvat_trans == null
                                                                              ? Expanded(
                                                                                  child: Text(
                                                                                  '0',
                                                                                  textAlign: TextAlign.center,
                                                                                ))
                                                                              : Expanded(
                                                                                  child: transPlayxModels[v].invoice_row != null
                                                                                      ? Text(
                                                                                          '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(color: Colors.orange.shade900),
                                                                                        )
                                                                                      : Text(
                                                                                          '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(color: Colors.black),
                                                                                        ),
                                                                                )
                                                                          : SizedBox(),
                                                                    ],
                                                                  ),
                                                            ],
                                                          )),
                                                        // for (int v = 0;
                                                        //     v <
                                                        //         transPlayxModels
                                                        //             .length;
                                                        //     v++)
                                                        //   if (transPlayModels[
                                                        //               index]
                                                        //           .cid ==
                                                        //       transPlayxModels[
                                                        //               v]
                                                        //           .refno_trans)
                                                        //     Expanded(
                                                        //       child: Row(
                                                        //         children: [
                                                        //           for (int i =
                                                        //                   0;
                                                        //               i <
                                                        //                   expModels
                                                        //                       .length;
                                                        //               i++)
                                                        //             (transPlayxModels[v].expx_row ==
                                                        //                     expModels[i]
                                                        //                         .ser)
                                                        //                 ? transPlayxModels[v].pvat_trans ==
                                                        //                         null
                                                        //                     ? Expanded(
                                                        //                         child: Text(
                                                        //                         '0',
                                                        //                         textAlign: TextAlign.center,
                                                        //                       ))
                                                        //                     : Expanded(
                                                        //                         child: transPlayxModels[v].invoice_row != null
                                                        //                             ? Text(
                                                        //                                 '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                        //                                 textAlign: TextAlign.center,
                                                        //                                 style: TextStyle(color: Colors.orange.shade900),
                                                        //                               )
                                                        //                             : Text(
                                                        //                                 '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                        //                                 textAlign: TextAlign.center,
                                                        //                                 style: TextStyle(color: Colors.black),
                                                        //                               ),
                                                        //                       )
                                                        //                 : SizedBox(),
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                // isExpanded: _customTileExpanded,
                                              )
                                  ],
                                  expansionCallback: (int item, bool expanded) {
                                    setState(() {
                                      if (transPlayModels[index].yon_amt ==
                                          '1') {
                                        _customTileExpanded = !expanded;
                                      } else {
                                        _customTileExpanded = false;
                                      }
                                    });
                                  },
                                ),
                              );
                            })),
                  ],
                )),
            Expanded(
              flex: 4,
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
                              refnoselect == null
                                  ? 'ยอดชำระ '
                                  : '$areaselect ($refnoselect) : $nameselect',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (listOrder == 1) {
                                      listOrder = 0;
                                    } else {
                                      listOrder = 1;
                                    }
                                  });
                                },
                                icon: Icon(Icons.format_list_bulleted)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  listOrder == 1
                      ? Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'เลขตั้งหนี้',
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
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'รายการ',
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
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            'ราคา',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                ),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            'รวม',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                ),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            '',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                ),
                                          ))
                                    ]),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      color: Colors.white,
                                      padding: EdgeInsets.all(2),
                                      child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _TransModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${_TransModels[index].docno}',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontFamily: Font_.Fonts_T
                                                      //fontSize: 10.0
                                                      ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  '${_TransModels[index].name}',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontFamily: Font_.Fonts_T
                                                      //fontSize: 10.0
                                                      ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
                                                    textAlign: TextAlign.end,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontFamily:
                                                            Font_.Fonts_T
                                                        //fontSize: 10.0
                                                        ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${nFormat.format(double.parse(_TransModels[index].total!))}',
                                                    textAlign: TextAlign.end,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontFamily:
                                                            Font_.Fonts_T
                                                        //fontSize: 10.0
                                                        ),
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: _TransModels[index]
                                                            .docno
                                                            .toString()
                                                            .substring(
                                                                _TransModels[
                                                                            index]
                                                                        .docno
                                                                        .toString()
                                                                        .indexOf(
                                                                            '-') +
                                                                    1,
                                                                _TransModels[
                                                                        index]
                                                                    .docno
                                                                    .toString()
                                                                    .indexOf(
                                                                        '/')) ==
                                                        'O'
                                                    ? IconButton(
                                                        onPressed: () {
                                                          deall_Trans_select(
                                                              index);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .remove_circle_outline,
                                                          color: Colors.red,
                                                        ))
                                                    : Text(
                                                        '',
                                                      ),
                                              )
                                            ]);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
                                  //fontSize: 10.0
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
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
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            showCursor: true,
                            //add this line
                            readOnly: false,

                            // initialValue: sum_disamt.text,
                            textAlign: TextAlign.end,
                            controller: sum_disamtx,
                            onChanged: (value) async {
                              var valuex = value == '' ? 0 : value;
                              var valuenum = double.parse(valuex.toString());

                              setState(() {
                                sum_dis = valuenum;
                                sum_disamt = valuenum;

                                // sum_disamt.text =
                                //     nFormat.format(sum_disamt);
                                sum_dispx.clear();
                                Form_payment1.text = (sum_amt - sum_disamt)
                                    .toStringAsFixed(2)
                                    .toString();
                              });

                              print('sum_dis $sum_dis');
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                fillColor: Colors.white.withOpacity(0.3),
                                filled: true,
                                // prefixIcon:
                                //     const Icon(Icons.person, color: Colors.black),
                                // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    // width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                labelText: 'ส่วนลด',
                                labelStyle: const TextStyle(
                                    color: Colors.black54,

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
                        child: Container(
                          height: 50,
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  'การชำระ',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
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
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppbackgroundColor.Sub_Abg_Colors,
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
                                      borderRadius: BorderRadius.circular(15),
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
                                    borderRadius: BorderRadius.circular(15),
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
                                        value: '${item.ser}:${item.ptname}',
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${item.ptname!}',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
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
                                    var rtnameSer = value.substring(0, zones);
                                    var rtnameName = value.substring(zones + 1);
                                    // print(
                                    //     'mmmmm ${rtnameSer.toString()} $rtnameName');
                                    setState(() {
                                      paymentSer1 = rtnameSer.toString();

                                      if (rtnameSer.toString() == '0') {
                                        paymentName1 = null;
                                      } else {
                                        paymentName1 = rtnameName.toString();
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
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
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
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${Form_payment1.text}',
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
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      borderRadius: const BorderRadius.only(
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
                                          // locale: const Locale('th', 'TH'),
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now()
                                              .add(const Duration(days: -50)),
                                          lastDate: DateTime.now()
                                              .add(const Duration(days: 365)),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: AppBarColors
                                                      .ABar_Colors, // header background color
                                                  onPrimary: Colors
                                                      .white, // header text color
                                                  onSurface: Colors
                                                      .black, // body text color
                                                ),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
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
                                          String end = DateFormat('dd-MM-yyyy')
                                              .format(newDate);

                                          print('$start $end');
                                          setState(() {
                                            Value_newDateY1 = start;
                                            Value_newDateD1 = end;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: AutoSizeText(
                                          Value_newDateD1 == ''
                                              ? 'เลือกวันที่'
                                              : '$Value_newDateD1',
                                          minFontSize: 16,
                                          maxFontSize: 20,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: PeopleChaoScreen_Color
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
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      borderRadius: const BorderRadius.only(
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
                                          // locale: const Locale('th', 'TH'),
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now()
                                              .add(const Duration(days: -50)),
                                          lastDate: DateTime.now()
                                              .add(const Duration(days: 365)),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: AppBarColors
                                                      .ABar_Colors, // header background color
                                                  onPrimary: Colors
                                                      .white, // header text color
                                                  onSurface: Colors
                                                      .black, // body text color
                                                ),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
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
                                          String end = DateFormat('dd-MM-yyyy')
                                              .format(newDate);

                                          print('$start $end');
                                          setState(() {
                                            Value_newDateY = start;
                                            Value_newDateD = end;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: AutoSizeText(
                                          Value_newDateD == ''
                                              ? 'เลือกวันที่'
                                              : '$Value_newDateD',
                                          minFontSize: 16,
                                          maxFontSize: 20,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: PeopleChaoScreen_Color
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
                      paymentName2.toString().trim() == 'เงินโอน' ||
                      paymentName1.toString().trim() == 'Online Payment' ||
                      paymentName2.toString().trim() == 'Online Payment')
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
                                ' เวลา',
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
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
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
                                        keyboardType: TextInputType.number,
                                        controller: Form_time,
                                        onChanged: (value) {
                                          setState(() {});
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
                                            hintText: '00:00:00',
                                            // helperText: '00:00:00',
                                            // labelText: '00:00:00',
                                            labelStyle: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T)),

                                        inputFormatters: [
                                          MaskedInputFormatter('##:##:##'),
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
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    title: const Center(
                                                        child: Text(
                                                      'มีไฟล์ slip อยู่แล้ว',
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    )),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const <Widget>[
                                                          Text(
                                                            'มีไฟล์ slip อยู่แล้ว หากต้องการอัพโหลดกรุณาลบไฟล์ที่มีอยู่แล้วก่อน',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                fontFamily: Font_
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
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              child: Container(
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .red[
                                                                        600],
                                                                    borderRadius: const BorderRadius
                                                                        .only(
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
                                                                            Radius.circular(10)),
                                                                    // border: Border.all(color: Colors.white, width: 1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'ลบไฟล์',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text3_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ))),
                                                              onTap: () async {
                                                                setState(() {
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
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              child: Container(
                                                                  width: 100,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius: BorderRadius.only(
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
                                                                            Radius.circular(10)),
                                                                    // border: Border.all(color: Colors.white, width: 1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'ปิด',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text3_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'เพิ่มไฟล์',
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
                          ),
                        ),
                      ],
                    ), //Online Payment
                  if (paymentName1.toString().trim() == 'เงินโอน' ||
                      paymentName2.toString().trim() == 'เงินโอน' ||
                      paymentName1.toString().trim() == 'Online Payment' ||
                      paymentName2.toString().trim() == 'Online Payment')
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          '$refnoselect',
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 100,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
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
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                  child: const Text(
                                                    'ปิด',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
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
                        ],
                      ),
                    ),

                  SizedBox(
                    height: 10,
                  ),
                  (paymentName1.toString().trim() == 'Online Payment' ||
                          paymentName2.toString().trim() == 'Online Payment')
                      ? Stack(
                          children: [
                            InkWell(
                              child: Container(
                                  width: 800,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    // border: Border.all(color: Colors.white, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
                                      )),
                                    ],
                                  )),
                              onTap: (paymentName1.toString().trim() !=
                                          'Online Payment' &&
                                      paymentName2.toString().trim() !=
                                          'Online Payment')
                                  ? null
                                  : () {
                                      double totalQr_ = 0.00;
                                      if (paymentName1.toString().trim() ==
                                              'Online Payment' &&
                                          paymentName2.toString().trim() ==
                                              'Online Payment') {
                                        setState(() {
                                          totalQr_ = 0.00;
                                        });
                                        setState(() {
                                          totalQr_ = double.parse(
                                                  Form_payment1.text) +
                                              double.parse(Form_payment2.text);
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
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            // title: Center(
                                            //     child: Container(
                                            //         decoration:
                                            //             BoxDecoration(
                                            //           color: Colors
                                            //               .blue[300],
                                            //           borderRadius: const BorderRadius
                                            //                   .only(
                                            //               topLeft:
                                            //                   Radius.circular(
                                            //                       10),
                                            //               topRight: Radius
                                            //                   .circular(
                                            //                       10),
                                            //               bottomLeft:
                                            //                   Radius.circular(
                                            //                       10),
                                            //               bottomRight:
                                            //                   Radius.circular(
                                            //                       10)),
                                            //         ),
                                            //         padding:
                                            //             const EdgeInsets
                                            //                 .all(4.0),
                                            //         child: const Text(
                                            //           ' QR PromtPay',
                                            //           style:
                                            //               TextStyle(
                                            //             color: Colors
                                            //                 .white,
                                            //             fontWeight:
                                            //                 FontWeight
                                            //                     .bold,
                                            //           ),
                                            //         ))),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  //  '${Form_bussshop}',
                                                  //   '${Form_address}',
                                                  //   '${Form_tel}',
                                                  //   '${Form_email}',
                                                  //   '${Form_tax}',
                                                  //   '${Form_nameshop}',
                                                  Center(
                                                    child: RepaintBoundary(
                                                      key: qrImageKey,
                                                      child: Container(
                                                        color: Colors.white,
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                4, 8, 4, 2),
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
                                                                          .green[
                                                                      300],
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                        .all(
                                                                        8.0),
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
                                                              child:
                                                                  Image.asset(
                                                                "images/thai_qr_payment.png",
                                                                height: 60,
                                                                width: 220,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 200,
                                                              height: 200,
                                                              child: Center(
                                                                child: PrettyQr(
                                                                  // typeNumber: 3,
                                                                  image:
                                                                      AssetImage(
                                                                    "images/Icon-chao.png",
                                                                  ),
                                                                  size: 200,
                                                                  data: generateQRCode(
                                                                      promptPayID:
                                                                          "$selectedValue",
                                                                      amount:
                                                                          totalQr_),
                                                                  errorCorrectLevel:
                                                                      QrErrorCorrectLevel
                                                                          .M,
                                                                  roundEdges:
                                                                      true,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'พร้อมเพย์ : $selectedValue',
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              'จำนวนเงิน : ${nFormat.format(totalQr_)} บาท',
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              '( ทำรายการ : $Value_newDateD1 / ชำระ : $Value_newDateD )',
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Container(
                                                              color: Color(
                                                                  0xFFD9D9B7),
                                                              height: 60,
                                                              width: 220,
                                                              child:
                                                                  Image.asset(
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
                                                    child: Container(
                                                      width: 220,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
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
                                                        onPressed: () async {
                                                          // String qrCodeData = generateQRCode(promptPayID: "0613544026", amount: 1234.56);

                                                          RenderRepaintBoundary
                                                              boundary =
                                                              qrImageKey
                                                                      .currentContext!
                                                                      .findRenderObject()
                                                                  as RenderRepaintBoundary;
                                                          ui.Image image =
                                                              await boundary
                                                                  .toImage();
                                                          ByteData? byteData =
                                                              await image
                                                                  .toByteData(
                                                                      format: ui
                                                                          .ImageByteFormat
                                                                          .png);
                                                          Uint8List bytes =
                                                              byteData!.buffer
                                                                  .asUint8List();
                                                          html.Blob blob =
                                                              html.Blob(
                                                                  [bytes]);
                                                          String url = html.Url
                                                              .createObjectUrlFromBlob(
                                                                  blob);

                                                          html.AnchorElement
                                                              anchor =
                                                              html.AnchorElement()
                                                                ..href = url
                                                                ..setAttribute(
                                                                    'download',
                                                                    'qrcode.png')
                                                                ..click();

                                                          html.Url
                                                              .revokeObjectUrl(
                                                                  url);
                                                        },
                                                        child: const Text(
                                                          'Download QR Code',
                                                          style: TextStyle(
                                                            color: Colors.white,
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
                                                    color: Colors.grey,
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
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.black,
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
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      // border: Border.all(color: Colors.white, width: 1),
                                    ),
                                  )),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // color: Colors.white,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       'หมายเหตุ',
                                  //       textAlign: TextAlign.start,
                                  //       style: TextStyle(
                                  //           color: PeopleChaoScreen_Color
                                  //               .Colors_Text1_,
                                  //           fontFamily: Font_.Fonts_T),
                                  //     ),
                                  //   ],
                                  // ),
                                  TextFormField(
                                    // keyboardType: TextInputType.name,
                                    controller: Form_note,

                                    maxLines: 1,
                                    // maxLength: 13,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.3),
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
                                      labelText: 'หมายเหตุ',
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
                          )),
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
                                if (renTalModels[0].imglogo!.trim() == '') {
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
                              print('************************************++++');
                              print(
                                  '>>1>  ${Form_payment1.text} //// $pay1//***${double.parse(pay1)}');
                              print(
                                  '>>2>  ${Form_payment2.text} //// $pay2 //***${double.parse(pay2)}');

                              print(
                                  '${(sum_amt - sum_disamt)}//****${double.parse(pay1) + double.parse(pay2)}');
                              print('************************************++++');
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
                              if ((double.parse(pay1) + double.parse(pay2) !=
                                  (sum_amt - sum_disamt))) {
                                _showMyDialogPay_Error('จำนวนเงินไม่ถูกต้อง ');
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
                                _showMyDialogPay_Error('จำนวนเงินไม่ถูกต้อง');
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
                                if (paymentSer1 != '0' && paymentSer1 != null) {
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
                                      } else if (select_page == 2) {}
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
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
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
          ],
        ));
  }

  Future<String?> de_item(int index) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'ยกเลิกรับชำระ ${transPlayxModels[index].name_trans} : ${double.parse(transPlayxModels[index].pvat_trans!).toStringAsFixed(0)}', // Navigator.pop(context, 'OK');
                  style: TextStyle(
                      color: AdminScafScreen_Color.Colors_Text1_,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
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
                        onPressed: () async {
                          de_Trans_item(index);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Submit',
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
        ],
      ),
    );
  }

  Future<String?> de_item_his(int index) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'ยกเลิกรับชำระ ${transPlayListxModels[index].name_trans} : ${double.parse(transPlayListxModels[index].pvat_trans!).toStringAsFixed(0)}', // Navigator.pop(context, 'OK');
                  style: TextStyle(
                      color: AdminScafScreen_Color.Colors_Text1_,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
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
                        onPressed: () async {
                          de_Trans_item_his(index);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Submit',
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
        ],
      ),
    );
  }

  Future<Null> de_Trans_item(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = transPlayModels[index].cid;
    // var qutser = transPlayModels[index].sname;

    // var tser = transPlayxModels[indexx].ser_trans;
    // var tdocno = transPlayxModels[indexx].docno_trans;
    var ciddoc = transPlayxModels[index].refno_trans;
    var qutser = '1';

    var tser = transPlayxModels[index].ser_trans;
    var tdocno = transPlayxModels[index].docno_trans;

    var poslok = 'ยกเลิกรับชำระ';

    print('tser >>.> $tser');

    String url =
        '${MyConstant().domain}/De_tran_item_colum.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user&poslok=$poslok';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          //  red_Trans_select22();
          // text_add.clear();
          // price_add.clear();
          read_GC_Playcolumn();
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<Null> de_Trans_item_his(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = transPlayModels[index].cid;
    // var qutser = transPlayModels[index].sname;

    // var tser = transPlayxModels[indexx].ser_trans;
    // var tdocno = transPlayxModels[indexx].docno_trans;
    var ciddoc = transPlayListxModels[index].refno_trans;
    var qutser = '1';

    var tser = transPlayListxModels[index].ser_trans;
    var tdocno = transPlayListxModels[index].docno_trans;

    var poslok = 'ยกเลิกรับชำระ';

    print('tser >>.> $tser');

    String url =
        '${MyConstant().domain}/De_tran_item_colum.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user&poslok=$poslok';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          // read_GC_Playcolumn();
          if (his == 1) {
            red_listdate(ciddoc);
          }
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
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

    var ciddoc = refnoselect;
    var qutser = 1;

    var textadd = text_add.text;
    var priceadd = price_add.text;
    var dtypeadd = '';

    String url =
        '${MyConstant().domain}/In_tran_select_add.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&textadd=$textadd&priceadd=$priceadd&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select22();
          // red_Trans_bill();
          text_add.clear();
          price_add.clear();
        });
        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        setState(() {
          // red_Trans_bill();
          red_Trans_select22();
          text_add.clear();
          price_add.clear();
        });
        print('rrrrrrrrrrrrrrfalse');
      } else {
        setState(() {
          // red_Trans_bill();
          red_Trans_select22();
          text_add.clear();
          price_add.clear();
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text(
        //           'มีผู้ใช้อื่นกำลังทำรายการอยู่ หรือ ท่านเลือกรายการนี้แล้ว....',
        //           style: TextStyle(
        //               color: Colors.white, fontFamily: Font_.Fonts_T))),
        // );
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text(
      //           'มีผู้ใช้อื่นกำลังทำรายการอยู่ หรือ ท่านเลือกรายการนี้แล้ว....',
      //           style:
      //               TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      // );
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Padding fortablet() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey.shade200,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'พื้นที่',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                      Text(
                                        sumarea_pay == 0
                                            ? '( ${nFormat.format(sumarea)} )'
                                            : '( ${nFormat.format(sumarea_pay + sumarea)} )',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                      Text(
                                        '${nFormat.format(sumarea_pay)}',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                      Text(
                                        '${nFormat.format(sumarea)}',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ), //sumarea_pay
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'ชื่อ - สกุล',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              for (int i = 0; i < expModels.length; i++)
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${expModels[i].expname}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                        Text(
                                          transPlayxPayModels.length == 0
                                              ? transPlayxModels.length == 0
                                                  ? '0'
                                                  : '( ${(transPlayxModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b))} )'
                                              : transPlayxModels.length == 0
                                                  ? '( ${(transPlayxPayModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b))} )'
                                                  : '( ${(transPlayxPayModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b)) + (transPlayxModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b))} )',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                        Text(
                                          transPlayxPayModels.length == 0
                                              ? '0'
                                              : '${transPlayxPayModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b)}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                        Text(
                                          transPlayxModels.length == 0
                                              ? '0'
                                              : '${transPlayxModels.map((e) => double.parse(e.expx_row == expModels[i].ser ? e.pvat_trans == null ? 0.toString() : e.pvat_trans.toString() : 0.toString())).reduce((a, b) => a + b)}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                        // transPlayModels
                                      ],
                                    ),
                                  ),
                                ),
                              Expanded(
                                flex: 1,
                                child: refnoselect == null
                                    ? Column(
                                        children: [
                                          Text(
                                            '',
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: ReportScreen_Color
                                                  .Colors_Text1_,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          addPlaySelect();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade300,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            // border: Border.all(color: Colors.white, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Center(
                                            child: AutoSizeText(
                                              minFontSize: 8,
                                              maxFontSize: 15,
                                              'เพิ่มรายการ',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: ListView.builder(
                                itemCount: transPlayModels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: ExpansionPanelList(
                                      animationDuration:
                                          Duration(milliseconds: 1),
                                      expandIconColor:
                                          transPlayModels[index].yon_amt == '1'
                                              ? his == 1
                                                  ? Colors.red
                                                  : Colors.white
                                              : Colors.white,
                                      // dividerColor: Colors.red,
                                      elevation: 1,
                                      children: [
                                        refnoselect == null
                                            ? ExpansionPanel(
                                                body: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[],
                                                  ),
                                                ),

                                                headerBuilder:
                                                    (BuildContext context,
                                                        bool isExpanded) {
                                                  return Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${transPlayModels[index].ln}',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            '${transPlayModels[index].sname}',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                        for (int i = 0;
                                                            i <
                                                                expModels
                                                                    .length;
                                                            i++)
                                                          Expanded(
                                                              child: Column(
                                                            children: [
                                                              for (int v = 0;
                                                                  v <
                                                                      transPlayxModels
                                                                          .length;
                                                                  v++)
                                                                if (transPlayModels[
                                                                            index]
                                                                        .cid ==
                                                                    transPlayxModels[
                                                                            v]
                                                                        .refno_trans)
                                                                  Row(
                                                                    children: [
                                                                      (transPlayxModels[v].expx_row ==
                                                                              expModels[i].ser)
                                                                          ? transPlayxModels[v].pvat_trans == null
                                                                              ? Expanded(
                                                                                  child: Text(
                                                                                  '0',
                                                                                  textAlign: TextAlign.center,
                                                                                ))
                                                                              : Expanded(
                                                                                  child: transPlayxModels[v].invoice_row != null
                                                                                      ? Text(
                                                                                          '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(color: Colors.orange.shade900),
                                                                                        )
                                                                                      : Card(
                                                                                          color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.green.shade700 : Colors.white,
                                                                                          child: SizedBox(
                                                                                            child: InkWell(
                                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                onDoubleTap: () {
                                                                                                  print('onDoubleTap');

                                                                                                  de_item(v);
                                                                                                },
                                                                                                onLongPress: () {
                                                                                                  print('onLongPress');
                                                                                                  de_item(v);
                                                                                                },
                                                                                                onTap: () async {
                                                                                                  in_Trans_select(v, i);
                                                                                                  var ciddoc = transPlayModels[index].cid;
                                                                                                  setState(() {
                                                                                                    if (his == 1) {
                                                                                                      red_listdate(ciddoc);
                                                                                                    }
                                                                                                    if (transPlayModels[index].yon_amt == '0') {
                                                                                                      _customTileExpanded = false;
                                                                                                    }
                                                                                                  });
                                                                                                  setState(() {
                                                                                                    insexselect = v;
                                                                                                    areaselect = transPlayModels[index].ln;
                                                                                                    nameselect = transPlayModels[index].sname;
                                                                                                  });
                                                                                                },
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Center(
                                                                                                    child: Text(
                                                                                                      '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                                      style: TextStyle(
                                                                                                        color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.white : Colors.black,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )),
                                                                                          ),
                                                                                        ),
                                                                                )
                                                                          : SizedBox(),
                                                                      // Expanded(
                                                                      //     child: Text(
                                                                      //         '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}')),
                                                                    ],
                                                                  ),
                                                            ],
                                                          )),
                                                        // for (int v = 0;
                                                        //     v <
                                                        //         transPlayxModels
                                                        //             .length;
                                                        //     v++)
                                                        //   if (transPlayModels[
                                                        //               index]
                                                        //           .cid ==
                                                        //       transPlayxModels[
                                                        //               v]
                                                        //           .refno_trans)
                                                        //     Expanded(
                                                        //       child: Row(
                                                        //         children: [
                                                        //           for (int i =
                                                        //                   0;
                                                        //               i <
                                                        //                   expModels
                                                        //                       .length;
                                                        //               i++)
                                                        //             (transPlayxModels[v].expx_row ==
                                                        //                     expModels[i]
                                                        //                         .ser)
                                                        //                 ? transPlayxModels[v].pvat_trans ==
                                                        //                         null
                                                        //                     ? Expanded(
                                                        //                         child: Text(
                                                        //                         '0',
                                                        //                         textAlign: TextAlign.center,
                                                        //                       ))
                                                        //                     : Expanded(
                                                        //                         child: transPlayxModels[v].invoice_row != null
                                                        //                             ? Text(
                                                        //                                 '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                        //                                 textAlign: TextAlign.center,
                                                        //                                 style: TextStyle(color: Colors.orange.shade900),
                                                        //                               )
                                                        //                             : Card(
                                                        //                                 color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.green.shade700 : Colors.white,
                                                        //                                 child: SizedBox(
                                                        //                                   child: InkWell(
                                                        //                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                        //                                       onDoubleTap: () {
                                                        //                                         print('onDoubleTap');

                                                        //                                         de_item(v);
                                                        //                                       },
                                                        //                                       onLongPress: () {
                                                        //                                         print('onLongPress');
                                                        //                                         de_item(v);
                                                        //                                       },
                                                        //                                       onTap: () async {
                                                        //                                         in_Trans_select(v, i);
                                                        //                                         var ciddoc = transPlayModels[index].cid;
                                                        //                                         setState(() {
                                                        //                                           if (his == 1) {
                                                        //                                             red_listdate(ciddoc);
                                                        //                                           }
                                                        //                                           if (transPlayModels[index].yon_amt == '0') {
                                                        //                                             _customTileExpanded = false;
                                                        //                                           }
                                                        //                                         });
                                                        //                                         setState(() {
                                                        //                                           insexselect = v;
                                                        //                                           areaselect = transPlayModels[index].ln;
                                                        //                                           nameselect = transPlayModels[index].sname;
                                                        //                                         });
                                                        //                                       },
                                                        //                                       child: Padding(
                                                        //                                         padding: const EdgeInsets.all(8.0),
                                                        //                                         child: Center(
                                                        //                                           child: Text(
                                                        //                                             '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                        //                                             style: TextStyle(
                                                        //                                               color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.white : Colors.black,
                                                        //                                             ),
                                                        //                                           ),
                                                        //                                         ),
                                                        //                                       )),
                                                        //                                 ),
                                                        //                               ),
                                                        //                       )
                                                        //                 : SizedBox(),
                                                        //           // Expanded(
                                                        //           //     child: Text(
                                                        //           //         '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}')),
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                // isExpanded: _customTileExpanded,
                                              )
                                            : refnoselect ==
                                                    transPlayModels[index].cid
                                                ? ExpansionPanel(
                                                    body: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: playList()),
                                                    headerBuilder:
                                                        (BuildContext context,
                                                            bool isExpanded) {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                '${transPlayModels[index].ln}',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  color: ReportScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                '${transPlayModels[index].sname}',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  color: ReportScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                            for (int i = 0;
                                                                i <
                                                                    expModels
                                                                        .length;
                                                                i++)
                                                              Expanded(
                                                                  child: Column(
                                                                children: [
                                                                  for (int v =
                                                                          0;
                                                                      v <
                                                                          transPlayxModels
                                                                              .length;
                                                                      v++)
                                                                    if (transPlayModels[index]
                                                                            .cid ==
                                                                        transPlayxModels[v]
                                                                            .refno_trans)
                                                                      Row(
                                                                        children: [
                                                                          (transPlayxModels[v].expx_row == expModels[i].ser)
                                                                              ? transPlayxModels[v].pvat_trans == null
                                                                                  ? Expanded(
                                                                                      child: Text(
                                                                                      '0',
                                                                                      textAlign: TextAlign.center,
                                                                                    ))
                                                                                  : Expanded(
                                                                                      child: transPlayxModels[v].invoice_row != null
                                                                                          ? Text(
                                                                                              '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(color: Colors.orange.shade900),
                                                                                            )
                                                                                          : Card(
                                                                                              color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.green.shade700 : Colors.white,
                                                                                              child: SizedBox(
                                                                                                child: InkWell(
                                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                    onDoubleTap: () {
                                                                                                      print('onDoubleTap');
                                                                                                      in_Trans_select(v, i);
                                                                                                      var ciddoc = transPlayModels[index].cid;

                                                                                                      setState(() {
                                                                                                        if (his == 1) {
                                                                                                          red_listdate(ciddoc);
                                                                                                        }
                                                                                                        if (transPlayModels[index].yon_amt == '0') {
                                                                                                          _customTileExpanded = false;
                                                                                                        }
                                                                                                      });
                                                                                                      setState(() {
                                                                                                        insexselect = v;
                                                                                                        areaselect = transPlayModels[index].ln;
                                                                                                        nameselect = transPlayModels[index].sname;
                                                                                                      });
                                                                                                      de_item(v);
                                                                                                    },
                                                                                                    onLongPress: () {
                                                                                                      print('onLongPress');
                                                                                                      in_Trans_select(v, i);
                                                                                                      var ciddoc = transPlayModels[index].cid;

                                                                                                      setState(() {
                                                                                                        if (his == 1) {
                                                                                                          red_listdate(ciddoc);
                                                                                                        }
                                                                                                        if (transPlayModels[index].yon_amt == '0') {
                                                                                                          _customTileExpanded = false;
                                                                                                        }
                                                                                                      });
                                                                                                      setState(() {
                                                                                                        insexselect = v;
                                                                                                        areaselect = transPlayModels[index].ln;
                                                                                                        nameselect = transPlayModels[index].sname;
                                                                                                      });
                                                                                                      de_item(v);
                                                                                                    },
                                                                                                    onTap: () async {
                                                                                                      in_Trans_select(v, i);
                                                                                                      var ciddoc = transPlayModels[index].cid;
                                                                                                      setState(() {
                                                                                                        if (his == 1) {
                                                                                                          red_listdate(ciddoc);
                                                                                                        }
                                                                                                        if (transPlayModels[index].yon_amt == '0') {
                                                                                                          _customTileExpanded = false;
                                                                                                        }
                                                                                                      });
                                                                                                      setState(() {
                                                                                                        insexselect = v;
                                                                                                        areaselect = transPlayModels[index].ln;
                                                                                                        nameselect = transPlayModels[index].sname;
                                                                                                      });
                                                                                                    },
                                                                                                    child: Padding(
                                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                          '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                                          style: TextStyle(
                                                                                                            color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.white : Colors.black,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    )),
                                                                                              ),
                                                                                            ),
                                                                                    )
                                                                              : SizedBox(),
                                                                        ],
                                                                      ),
                                                                ],
                                                              )),
                                                            // for (int v = 0;
                                                            //     v <
                                                            //         transPlayxModels
                                                            //             .length;
                                                            //     v++)
                                                            //   if (transPlayModels[
                                                            //               index]
                                                            //           .cid ==
                                                            //       transPlayxModels[
                                                            //               v]
                                                            //           .refno_trans)
                                                            //     Expanded(
                                                            //       child: Row(
                                                            //         children: [
                                                            //           for (int i =
                                                            //                   0;
                                                            //               i < expModels.length;
                                                            //               i++)
                                                            //             (transPlayxModels[v].expx_row == expModels[i].ser)
                                                            //                 ? transPlayxModels[v].pvat_trans == null
                                                            //                     ? Expanded(
                                                            //                         child: Text(
                                                            //                         '0',
                                                            //                         textAlign: TextAlign.center,
                                                            //                       ))
                                                            //                     : Expanded(
                                                            //                         child: transPlayxModels[v].invoice_row != null
                                                            //                             ? Text(
                                                            //                                 '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                            //                                 textAlign: TextAlign.center,
                                                            //                                 style: TextStyle(color: Colors.orange.shade900),
                                                            //                               )
                                                            //                             : Card(
                                                            //                                 color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.green.shade700 : Colors.white,
                                                            //                                 child: SizedBox(
                                                            //                                   child: InkWell(
                                                            //                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                            //                                       onDoubleTap: () {
                                                            //                                         print('onDoubleTap');
                                                            //                                         in_Trans_select(v, i);
                                                            //                                         var ciddoc = transPlayModels[index].cid;

                                                            //                                         setState(() {
                                                            //                                           if (his == 1) {
                                                            //                                             red_listdate(ciddoc);
                                                            //                                           }
                                                            //                                           if (transPlayModels[index].yon_amt == '0') {
                                                            //                                             _customTileExpanded = false;
                                                            //                                           }
                                                            //                                         });
                                                            //                                         setState(() {
                                                            //                                           insexselect = v;
                                                            //                                           areaselect = transPlayModels[index].ln;
                                                            //                                           nameselect = transPlayModels[index].sname;
                                                            //                                         });
                                                            //                                         de_item(v);
                                                            //                                       },
                                                            //                                       onLongPress: () {
                                                            //                                         print('onLongPress');
                                                            //                                         in_Trans_select(v, i);
                                                            //                                         var ciddoc = transPlayModels[index].cid;

                                                            //                                         setState(() {
                                                            //                                           if (his == 1) {
                                                            //                                             red_listdate(ciddoc);
                                                            //                                           }
                                                            //                                           if (transPlayModels[index].yon_amt == '0') {
                                                            //                                             _customTileExpanded = false;
                                                            //                                           }
                                                            //                                         });
                                                            //                                         setState(() {
                                                            //                                           insexselect = v;
                                                            //                                           areaselect = transPlayModels[index].ln;
                                                            //                                           nameselect = transPlayModels[index].sname;
                                                            //                                         });
                                                            //                                         de_item(v);
                                                            //                                       },
                                                            //                                       onTap: () async {
                                                            //                                         in_Trans_select(v, i);
                                                            //                                         var ciddoc = transPlayModels[index].cid;
                                                            //                                         setState(() {
                                                            //                                           if (his == 1) {
                                                            //                                             red_listdate(ciddoc);
                                                            //                                           }
                                                            //                                           if (transPlayModels[index].yon_amt == '0') {
                                                            //                                             _customTileExpanded = false;
                                                            //                                           }
                                                            //                                         });
                                                            //                                         setState(() {
                                                            //                                           insexselect = v;
                                                            //                                           areaselect = transPlayModels[index].ln;
                                                            //                                           nameselect = transPlayModels[index].sname;
                                                            //                                         });
                                                            //                                       },
                                                            //                                       child: Padding(
                                                            //                                         padding: const EdgeInsets.all(8.0),
                                                            //                                         child: Center(
                                                            //                                           child: Text(
                                                            //                                             '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                            //                                             style: TextStyle(
                                                            //                                               color: listcolor[i] == transPlayxModels[v].docno_trans ? Colors.white : Colors.black,
                                                            //                                             ),
                                                            //                                           ),
                                                            //                                         ),
                                                            //                                       )),
                                                            //                                 ),
                                                            //                               ),
                                                            //                       )
                                                            //                 : SizedBox(),
                                                            //         ],
                                                            //       ),
                                                            //     ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    isExpanded: his == 0
                                                        ? false
                                                        : _customTileExpanded,
                                                  )
                                                : ExpansionPanel(
                                                    backgroundColor:
                                                        AppbackgroundColor
                                                            .Abg_Colors,
                                                    body: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[],
                                                      ),
                                                    ),
                                                    headerBuilder:
                                                        (BuildContext context,
                                                            bool isExpanded) {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                '${transPlayModels[index].ln}',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  color: ReportScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                '${transPlayModels[index].sname}',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  color: ReportScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                            for (int i = 0;
                                                                i <
                                                                    expModels
                                                                        .length;
                                                                i++)
                                                              Expanded(
                                                                  child: Column(
                                                                children: [
                                                                  for (int v =
                                                                          0;
                                                                      v <
                                                                          transPlayxModels
                                                                              .length;
                                                                      v++)
                                                                    if (transPlayModels[index]
                                                                            .cid ==
                                                                        transPlayxModels[v]
                                                                            .refno_trans)
                                                                      Row(
                                                                        children: [
                                                                          (transPlayxModels[v].expx_row == expModels[i].ser)
                                                                              ? transPlayxModels[v].pvat_trans == null
                                                                                  ? Expanded(
                                                                                      child: Text(
                                                                                      '0',
                                                                                      textAlign: TextAlign.center,
                                                                                    ))
                                                                                  : Expanded(
                                                                                      child: transPlayxModels[v].invoice_row != null
                                                                                          ? Text(
                                                                                              '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(color: Colors.orange.shade900),
                                                                                            )
                                                                                          : Text(
                                                                                              '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(color: Colors.black),
                                                                                            ),
                                                                                    )
                                                                              : SizedBox(),
                                                                        ],
                                                                      ),
                                                                ],
                                                              )),
                                                            // for (int v = 0;
                                                            //     v <
                                                            //         transPlayxModels
                                                            //             .length;
                                                            //     v++)
                                                            //   if (transPlayModels[
                                                            //               index]
                                                            //           .cid ==
                                                            //       transPlayxModels[
                                                            //               v]
                                                            //           .refno_trans)
                                                            //     Expanded(
                                                            //       child: Row(
                                                            //         children: [
                                                            //           for (int i =
                                                            //                   0;
                                                            //               i < expModels.length;
                                                            //               i++)
                                                            //             (transPlayxModels[v].expx_row == expModels[i].ser)
                                                            //                 ? transPlayxModels[v].pvat_trans == null
                                                            //                     ? Expanded(
                                                            //                         child: Text(
                                                            //                         '0',
                                                            //                         textAlign: TextAlign.center,
                                                            //                       ))
                                                            //                     : Expanded(
                                                            //                         child: transPlayxModels[v].invoice_row != null
                                                            //                             ? Text(
                                                            //                                 '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                            //                                 textAlign: TextAlign.center,
                                                            //                                 style: TextStyle(color: Colors.orange.shade900),
                                                            //                               )
                                                            //                             : Text(
                                                            //                                 '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                            //                                 textAlign: TextAlign.center,
                                                            //                                 style: TextStyle(color: Colors.black),
                                                            //                               ),
                                                            //                       )
                                                            //                 : SizedBox(),
                                                            //         ],
                                                            //       ),
                                                            //     ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    // isExpanded: _customTileExpanded,
                                                  )
                                      ],
                                      expansionCallback:
                                          (int item, bool expanded) {
                                        setState(() {
                                          if (transPlayModels[index].yon_amt ==
                                              '1') {
                                            _customTileExpanded = !expanded;
                                          } else {
                                            _customTileExpanded = false;
                                          }
                                        });
                                      },
                                    ),
                                  );
                                })),
                      ],
                    )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
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
                                  refnoselect == null
                                      ? 'ยอดชำระ '
                                      : '$areaselect ($refnoselect) : $nameselect',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (listOrder == 1) {
                                          listOrder = 0;
                                        } else {
                                          listOrder = 1;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.format_list_bulleted)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      listOrder == 1
                          ? Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'เลขตั้งหนี้',
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
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'รายการ',
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
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                'ราคา',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                'รวม',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ))
                                        ]),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                          color: Colors.white,
                                          padding: EdgeInsets.all(2),
                                          child: ListView.builder(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: _TransModels.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Row(children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${_TransModels[index].docno}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontFamily:
                                                              Font_.Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '${_TransModels[index].name}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontFamily:
                                                              Font_.Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T
                                                            //fontSize: 10.0
                                                            ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '${nFormat.format(double.parse(_TransModels[index].total!))}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T
                                                            //fontSize: 10.0
                                                            ),
                                                      )),
                                                  Expanded(
                                                    flex: 1,
                                                    child: _TransModels[index].docno.toString().substring(
                                                                _TransModels[
                                                                            index]
                                                                        .docno
                                                                        .toString()
                                                                        .indexOf(
                                                                            '-') +
                                                                    1,
                                                                _TransModels[
                                                                        index]
                                                                    .docno
                                                                    .toString()
                                                                    .indexOf(
                                                                        '/')) ==
                                                            'O'
                                                        ? IconButton(
                                                            onPressed: () {
                                                              deall_Trans_select(
                                                                  index);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .remove_circle_outline,
                                                              color: Colors.red,
                                                            ))
                                                        : Text(
                                                            '',
                                                          ),
                                                  )
                                                ]);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
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
                          Expanded(
                            flex: 3,
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
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                showCursor: true,
                                //add this line
                                readOnly: false,

                                // initialValue: sum_disamt.text,
                                textAlign: TextAlign.end,
                                controller: sum_disamtx,
                                onChanged: (value) async {
                                  var valuex = value == '' ? 0 : value;
                                  var valuenum =
                                      double.parse(valuex.toString());

                                  setState(() {
                                    sum_dis = valuenum;
                                    sum_disamt = valuenum;

                                    // sum_disamt.text =
                                    //     nFormat.format(sum_disamt);
                                    sum_dispx.clear();
                                    Form_payment1.text = (sum_amt - sum_disamt)
                                        .toStringAsFixed(2)
                                        .toString();
                                  });

                                  print('sum_dis $sum_dis');
                                },
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    fillColor: Colors.white.withOpacity(0.3),
                                    filled: true,
                                    // prefixIcon:
                                    //     const Icon(Icons.person, color: Colors.black),
                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
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
                            child: Container(
                              height: 50,
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      'การชำระ',
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
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
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
                                        borderRadius: BorderRadius.circular(15),
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
                                            value: '${item.ser}:${item.ptname}',
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${item.ptname!}',
                                                    textAlign: TextAlign.start,
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
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                                      // border: Border.all(color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${Form_payment1.text}',
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
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          // color: Colors.green,
                                          borderRadius: const BorderRadius.only(
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
                                              // locale: const Locale('th', 'TH'),
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
                                                        const ColorScheme.light(
                                                      primary: AppBarColors
                                                          .ABar_Colors, // header background color
                                                      onPrimary: Colors
                                                          .white, // header text color
                                                      onSurface: Colors
                                                          .black, // body text color
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style:
                                                          TextButton.styleFrom(
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
                                            padding: const EdgeInsets.all(5.0),
                                            child: AutoSizeText(
                                              Value_newDateD1 == ''
                                                  ? 'เลือกวันที่'
                                                  : '$Value_newDateD1',
                                              minFontSize: 16,
                                              maxFontSize: 20,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
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
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          // color: Colors.green,
                                          borderRadius: const BorderRadius.only(
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
                                              // locale: const Locale('th', 'TH'),
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
                                                        const ColorScheme.light(
                                                      primary: AppBarColors
                                                          .ABar_Colors, // header background color
                                                      onPrimary: Colors
                                                          .white, // header text color
                                                      onSurface: Colors
                                                          .black, // body text color
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style:
                                                          TextButton.styleFrom(
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
                                            padding: const EdgeInsets.all(5.0),
                                            child: AutoSizeText(
                                              Value_newDateD == ''
                                                  ? 'เลือกวันที่'
                                                  : '$Value_newDateD',
                                              minFontSize: 16,
                                              maxFontSize: 20,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
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
                          paymentName2.toString().trim() == 'เงินโอน' ||
                          paymentName1.toString().trim() == 'Online Payment' ||
                          paymentName2.toString().trim() == 'Online Payment')
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
                                    ' เวลา',
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
                                            keyboardType: TextInputType.number,
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
                                                    fontFamily: Font_.Fonts_T)),

                                            inputFormatters: [
                                              MaskedInputFormatter('##:##:##'),
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
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
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
                                                            children: const <Widget>[
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
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 100,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .red[600],
                                                                        borderRadius: const BorderRadius
                                                                            .only(
                                                                            topLeft:
                                                                                Radius.circular(10),
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
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text3_,
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
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 100,
                                                                      decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
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
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text3_,
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
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              // border: Border.all(
                                              //     color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'เพิ่มไฟล์',
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ), //Online Payment
                      if (paymentName1.toString().trim() == 'เงินโอน' ||
                          paymentName2.toString().trim() == 'เงินโอน' ||
                          paymentName1.toString().trim() == 'Online Payment' ||
                          paymentName2.toString().trim() == 'Online Payment')
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              '$refnoselect',
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
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 100,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.black,
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
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, 'OK'),
                                                      child: const Text(
                                                        'ปิด',
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

                      SizedBox(
                        height: 10,
                      ),
                      (paymentName1.toString().trim() == 'Online Payment' ||
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
                                            topLeft: const Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        // border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
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
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          )),
                                        ],
                                      )),
                                  onTap:
                                      (paymentName1.toString().trim() !=
                                                  'Online Payment' &&
                                              paymentName2.toString().trim() !=
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
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    // title: Center(
                                                    //     child: Container(
                                                    //         decoration:
                                                    //             BoxDecoration(
                                                    //           color: Colors
                                                    //               .blue[300],
                                                    //           borderRadius: const BorderRadius
                                                    //                   .only(
                                                    //               topLeft:
                                                    //                   Radius.circular(
                                                    //                       10),
                                                    //               topRight: Radius
                                                    //                   .circular(
                                                    //                       10),
                                                    //               bottomLeft:
                                                    //                   Radius.circular(
                                                    //                       10),
                                                    //               bottomRight:
                                                    //                   Radius.circular(
                                                    //                       10)),
                                                    //         ),
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .all(4.0),
                                                    //         child: const Text(
                                                    //           ' QR PromtPay',
                                                    //           style:
                                                    //               TextStyle(
                                                    //             color: Colors
                                                    //                 .white,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold,
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
                                                              key: qrImageKey,
                                                              child: Container(
                                                                color: Colors
                                                                    .white,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        4,
                                                                        8,
                                                                        4,
                                                                        2),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            220,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.green[300],
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(0),
                                                                              bottomRight: Radius.circular(0)),
                                                                        ),
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            '$renTal_name',
                                                                            style:
                                                                                TextStyle(
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
                                                                      height:
                                                                          60,
                                                                      width:
                                                                          220,
                                                                      child: Image
                                                                          .asset(
                                                                        "images/thai_qr_payment.png",
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            220,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            PrettyQr(
                                                                          // typeNumber: 3,
                                                                          image:
                                                                              AssetImage(
                                                                            "images/Icon-chao.png",
                                                                          ),
                                                                          size:
                                                                              200,
                                                                          data: generateQRCode(
                                                                              promptPayID: "$selectedValue",
                                                                              amount: totalQr_),
                                                                          errorCorrectLevel:
                                                                              QrErrorCorrectLevel.M,
                                                                          roundEdges:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'พร้อมเพย์ : $selectedValue',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'จำนวนเงิน : ${nFormat.format(totalQr_)} บาท',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '( ทำรายการ : $Value_newDateD1 / ชำระ : $Value_newDateD )',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      color: Color(
                                                                          0xFFD9D9B7),
                                                                      height:
                                                                          60,
                                                                      width:
                                                                          220,
                                                                      child: Image
                                                                          .asset(
                                                                        "images/LOGOchao.png",
                                                                        height:
                                                                            70,
                                                                        width:
                                                                            220,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Container(
                                                              width: 220,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  // String qrCodeData = generateQRCode(promptPayID: "0613544026", amount: 1234.56);

                                                                  RenderRepaintBoundary
                                                                      boundary =
                                                                      qrImageKey
                                                                          .currentContext!
                                                                          .findRenderObject() as RenderRepaintBoundary;
                                                                  ui.Image
                                                                      image =
                                                                      await boundary
                                                                          .toImage();
                                                                  ByteData?
                                                                      byteData =
                                                                      await image.toByteData(
                                                                          format: ui
                                                                              .ImageByteFormat
                                                                              .png);
                                                                  Uint8List
                                                                      bytes =
                                                                      byteData!
                                                                          .buffer
                                                                          .asUint8List();
                                                                  html.Blob
                                                                      blob =
                                                                      html.Blob([
                                                                    bytes
                                                                  ]);
                                                                  String url = html
                                                                          .Url
                                                                      .createObjectUrlFromBlob(
                                                                          blob);

                                                                  html.AnchorElement
                                                                      anchor =
                                                                      html.AnchorElement()
                                                                        ..href =
                                                                            url
                                                                        ..setAttribute(
                                                                            'download',
                                                                            'qrcode.png')
                                                                        ..click();

                                                                  html.Url
                                                                      .revokeObjectUrl(
                                                                          url);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Download QR Code',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                                            color: Colors.grey,
                                                            height: 4.0,
                                                          ),
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  width: 100,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius: BorderRadius.only(
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
                                                                            Radius.circular(10)),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            'OK'),
                                                                    child:
                                                                        const Text(
                                                                      'ปิด',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
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
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          // border: Border.all(color: Colors.white, width: 1),
                                        ),
                                      )),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // color: Colors.white,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'หมายเหตุ',
                                      //       textAlign: TextAlign.start,
                                      //       style: TextStyle(
                                      //           color: PeopleChaoScreen_Color
                                      //               .Colors_Text1_,
                                      //           fontFamily: Font_.Fonts_T),
                                      //     ),
                                      //   ],
                                      // ),
                                      TextFormField(
                                        // keyboardType: TextInputType.name,
                                        controller: Form_note,

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
                                          labelText: 'หมายเหตุ',
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
                              )),
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
                                    if (renTalModels[0].imglogo!.trim() == '') {
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
                                          } else if (select_page == 2) {}
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
              ],
            ),
          ],
        ));
  }

  Widget playList() {
    return Container(
      color: Color.fromARGB(255, 225, 246, 255),
      height: MediaQuery.of(context).size.width * 0.15,
      child: ListView.builder(
          itemCount: transPlayListModels.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    '',
                    // '${DateFormat.EEEE('th').formatInBuddhistCalendarThai(DateTime.parse('${transPlayListModels[index].datex} 00:00:00'))}',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ReportScreen_Color.Colors_Text1_,
                      fontFamily: Font_.Fonts_T,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${transPlayListModels[index].datex}',
                    //'${DateFormat.yMMMMd('th').formatInBuddhistCalendarThai(DateTime.parse('${transPlayListModels[index].datex} 00:00:00'))}',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ReportScreen_Color.Colors_Text1_,
                      fontFamily: Font_.Fonts_T,
                    ),
                  ),
                ),
                for (int i = 0; i < expModels.length; i++)
                  Expanded(
                      child: Column(
                    children: [
                      for (int v = 0; v < transPlayListxModels.length; v++)
                        if (transPlayListModels[index].datex ==
                            transPlayListxModels[v].date_trans)
                          Row(
                            children: [
                              (transPlayListxModels[v].expx_row ==
                                      expModels[i].ser)
                                  ? transPlayListxModels[v].pvat_trans == null
                                      ? Expanded(
                                          child: Text(
                                            '0',
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : Expanded(
                                          child: transPlayListxModels[v]
                                                      .invoice_row !=
                                                  null
                                              ? Text(
                                                  '${nFormat.format(double.parse(transPlayListxModels[v].pvat_trans!))}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .orange.shade900),
                                                )
                                              : Card(
                                                  color: listcolorplay[v] ==
                                                          transPlayListxModels[
                                                                  v]
                                                              .docno_trans
                                                      ? Colors.green.shade700
                                                      : Colors.white,
                                                  child: SizedBox(
                                                    child: InkWell(
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
                                                        onDoubleTap: () {
                                                          print('onDoubleTap');
                                                          if (listcolorplay[
                                                                  v] ==
                                                              transPlayListxModels[
                                                                      v]
                                                                  .docno_trans) {
                                                            in_TransList_select(
                                                                v, i);
                                                          }

                                                          de_item_his(v);
                                                        },
                                                        onLongPress: () {
                                                          print('onLongPress');
                                                          if (listcolorplay[
                                                                  v] ==
                                                              transPlayListxModels[
                                                                      v]
                                                                  .docno_trans) {
                                                            in_TransList_select(
                                                                v, i);
                                                          }
                                                          de_item_his(v);
                                                        },
                                                        onTap: () async {
                                                          in_TransList_select(
                                                              v, i);
                                                          // var ciddoc =
                                                          //     transPlayModels[
                                                          //             index]
                                                          //         .cid;
                                                          // setState(() {
                                                          //   red_listdate(ciddoc);
                                                          // });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child: Text(
                                                              '${nFormat.format(double.parse(transPlayListxModels[v].pvat_trans!))}',
                                                              style: TextStyle(
                                                                color: listcolorplay[
                                                                            v] ==
                                                                        transPlayListxModels[v]
                                                                            .docno_trans
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                        )
                                  : SizedBox(),
                            ],
                          ),
                    ],
                  )),
                // for (int v = 0; v < transPlayListxModels.length; v++)
                //   if (transPlayListModels[index].datex ==
                //       transPlayListxModels[v].date_trans)
                //     Expanded(
                //       flex: 1,
                //       child: Row(
                //         children: [
                //           for (int i = 0; i < expModels.length; i++)
                //             (transPlayListxModels[v].expx_row ==
                //                     expModels[i].ser)
                //                 ? transPlayListxModels[v].pvat_trans == null
                //                     ? Expanded(
                //                         child: Text(
                //                           '0',
                //                           textAlign: TextAlign.center,
                //                         ),
                //                       )
                //                     : Expanded(
                //                         child: transPlayListxModels[v]
                //                                     .invoice_row !=
                //                                 null
                //                             ? Text(
                //                                 '${nFormat.format(double.parse(transPlayListxModels[v].pvat_trans!))}',
                //                                 textAlign: TextAlign.center,
                //                                 style: TextStyle(
                //                                     color:
                //                                         Colors.orange.shade900),
                //                               )
                //                             : Card(
                //                                 color: listcolorplay[v] ==
                //                                         transPlayListxModels[v]
                //                                             .docno_trans
                //                                     ? Colors.green.shade700
                //                                     : Colors.white,
                //                                 child: SizedBox(
                //                                   child: InkWell(
                //                                       borderRadius:
                //                                           BorderRadius.only(
                //                                               topLeft: Radius
                //                                                   .circular(10),
                //                                               topRight: Radius
                //                                                   .circular(10),
                //                                               bottomLeft: Radius
                //                                                   .circular(10),
                //                                               bottomRight:
                //                                                   Radius
                //                                                       .circular(
                //                                                           10)),
                //                                       onDoubleTap: () {
                //                                         print('onDoubleTap');
                //                                         if (listcolorplay[v] ==
                //                                             transPlayListxModels[
                //                                                     v]
                //                                                 .docno_trans) {
                //                                           in_TransList_select(
                //                                               v, i);
                //                                         }

                //                                         de_item_his(v);
                //                                       },
                //                                       onLongPress: () {
                //                                         print('onLongPress');
                //                                         if (listcolorplay[v] ==
                //                                             transPlayListxModels[
                //                                                     v]
                //                                                 .docno_trans) {
                //                                           in_TransList_select(
                //                                               v, i);
                //                                         }
                //                                         de_item_his(v);
                //                                       },
                //                                       onTap: () async {
                //                                         in_TransList_select(
                //                                             v, i);
                //                                         // var ciddoc =
                //                                         //     transPlayModels[
                //                                         //             index]
                //                                         //         .cid;
                //                                         // setState(() {
                //                                         //   red_listdate(ciddoc);
                //                                         // });
                //                                       },
                //                                       child: Padding(
                //                                         padding:
                //                                             const EdgeInsets
                //                                                 .all(8.0),
                //                                         child: Center(
                //                                           child: Text(
                //                                             '${nFormat.format(double.parse(transPlayListxModels[v].pvat_trans!))}',
                //                                             style: TextStyle(
                //                                               color: listcolorplay[
                //                                                           v] ==
                //                                                       transPlayListxModels[
                //                                                               v]
                //                                                           .docno_trans
                //                                                   ? Colors.white
                //                                                   : Colors
                //                                                       .black,
                //                                             ),
                //                                           ),
                //                                         ),
                //                                       )),
                //                                 ),
                //                               ),
                //                       )
                //                 : SizedBox(),
                //         ],
                //       ),
                //     ),
                Expanded(
                  child: Text(
                    '',
                  ),
                )
              ],
            );
          }),
    );
  }

  Future<Null> in_TransList_select(index, incolor) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = transPlayListxModels[index].refno_trans;
    var qutser = '1';

    var tser = transPlayListxModels[index].ser_trans;
    var tdocno = transPlayListxModels[index].docno_trans;

    print('object $tdocno');
    String url =
        '${MyConstant().domain}/In_tran_select_column.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          // sum = sum + double.parse(transPlayxModels[index].pvat_trans!);
          red_Trans_select3(index);

          listcolorplay.removeAt(index);
          listcolorplay.insert(
              index, transPlayListxModels[index].docno_trans.toString());
        });

        print('rrrrrrrrrrrrrr ${listcolorplay.map((e) => e)}');
      } else if (result.toString() == 'false') {
        // deall_Trans_select(index);
        setState(() {
          // sum = sum + double.parse(transPlayxModels[index].pvat_trans!);
          red_Trans_select3(index);
          listcolorplay.removeAt(index);
          listcolorplay.insert(index, '0');
        });
        print('rrrrrrrrrrrrrrfalse ${listcolorplay.map((e) => e)}');
      } else {
        // setState(() {
        //   red_Trans_select2();
        // });
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text(
      //           'มีผู้ใช้อื่นกำลังทำรายการอยู่ หรือ ท่านเลือกรายการนี้แล้ว....',
      //           style:
      //               TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      // );
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> in_Trans_select(index, incolor) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = transPlayxModels[index].refno_trans;
    var qutser = '1';

    var tser = transPlayxModels[index].ser_trans;
    var tdocno = transPlayxModels[index].docno_trans;

    print('object $tdocno');
    String url =
        '${MyConstant().domain}/In_tran_select_column.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          // sum = sum + double.parse(transPlayxModels[index].pvat_trans!);
          red_Trans_select2(index);

          listcolor.removeAt(incolor);
          listcolor.insert(
              incolor, transPlayxModels[index].docno_trans.toString());
        });

        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        // deall_Trans_select(index);
        setState(() {
          // sum = sum + double.parse(transPlayxModels[index].pvat_trans!);
          red_Trans_select2(index);
          listcolor.removeAt(incolor);
          listcolor.insert(incolor, '0');
        });
        print('rrrrrrrrrrrrrrfalse');
      } else {
        // setState(() {
        //   red_Trans_select2();
        // });
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text(
      //           'มีผู้ใช้อื่นกำลังทำรายการอยู่ หรือ ท่านเลือกรายการนี้แล้ว....',
      //           style:
      //               TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      // );
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> deall_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = _TransModels[index].docno;

    String url =
        '${MyConstant().domain}/D_tran_select_column.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select22();
          sum = sum - double.parse(_TransModels[index].pvat!);
        });
        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        setState(() {});
        print('rrrrrrrrrrrrrrfalse');
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
        //           style: TextStyle(
        //               color: Colors.white, fontFamily: Font_.Fonts_T))),
        // );
      }
    } catch (e) {
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> red_Trans_select3(index) async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        // listcolor.clear();
        refnoselect = null;
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = transPlayListxModels[index].refno_trans;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_tran_select.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        setState(() {
          // listcolor.clear();
          _TransModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          refnoselect = null;
        });
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);
          var refnox = _TransModel.refno.toString().trim();

          var docnox = _TransModel.docno.toString().trim();
          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          setState(() {
            // listcolor.add(docnox);

            // listcolor.insert(index, docnox);
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            refnoselect = refnox;

            _TransModels.add(_TransModel);
          });
        }
      }

      print(
          '${listcolorplay.length}  ${listcolorplay.map((e) => e)} ${listcolorplay[index]} ${transPlayListxModels[index].date_trans}');

      setState(() {
        // read_data();
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
        if (_TransModels.length == 0) {
          refnoselect = null;
          nameselect = null;
          areaselect = null;
          Form_payment1.text = '0.00';
          insexselect = 0;
          transPlayListModels.clear();
          transPlayListxModels.clear();
          // for (var i = 0; i < expModels.length; i++) {
          //   listcolor.add('0');
          // }
        }
      });
    } catch (e) {}
  }

  Future<Null> red_Trans_select2(index) async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        // listcolor.clear();
        refnoselect = null;
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = transPlayxModels[index].refno_trans;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_tran_select.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        setState(() {
          // listcolor.clear();
          _TransModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          refnoselect = null;
        });
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);
          var refnox = _TransModel.refno.toString().trim();

          var docnox = _TransModel.docno.toString().trim();
          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          setState(() {
            // listcolor.add(docnox);

            // listcolor.insert(index, docnox);
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            refnoselect = refnox;

            _TransModels.add(_TransModel);
          });
        }

        setState(() {
          print('>>>>>>>>>>>ssssss>>>>$sum_amt');
          Form_payment1.text =
              (sum_amt - sum_disamt).toStringAsFixed(2).toString();
        });
      } else {
        setState(() {
          print('>>>>>>>>>>>ssssss>>>>$sum_amt');
          Form_payment1.text = '0.00';
        });
      }

      print(
          '${listcolor.length}  ${listcolor.map((e) => e)} ${listcolor[index]} ${transPlayxModels[index].date_trans}');

      setState(() {
        read_data();
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
        if (_TransModels.length == 0) {
          refnoselect = null;
          nameselect = null;
          areaselect = null;
          insexselect = 0;
          Form_payment1.text = '0.00';
          transPlayListModels.clear();
          transPlayListxModels.clear();

          // for (var i = 0; i < expModels.length; i++) {
          //   listcolor.add('0');
          // }
        }
      });

      if (refnoselect == null) {
        d_tran_selectall();
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_select22() async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        // listcolor.clear();

        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = refnoselect;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_tran_select.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        setState(() {
          // listcolor.clear();
          _TransModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          refnoselect = null;
        });
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);
          var refnox = _TransModel.refno.toString().trim();

          var docnox = _TransModel.docno.toString().trim();
          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          setState(() {
            // listcolor.add(docnox);

            // listcolor.insert(index, docnox);
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            refnoselect = refnox;

            _TransModels.add(_TransModel);
          });
        }

        setState(() {
          print('>>>>>>>>>>>ssssss>>>>$sum_amt');
          Form_payment1.text =
              (sum_amt - sum_disamt).toStringAsFixed(2).toString();
        });
      } else {
        setState(() {
          print('>>>>>>>>>>>ssssss>>>>$sum_amt');
          Form_payment1.text = '0.00';
        });
      }

      // print(
      //     '${listcolor.length}  ${listcolor.map((e) => e)} ${listcolor[index]} ${transPlayxModels[index].date_trans}');

      setState(() {
        read_data();
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
        if (_TransModels.length == 0) {
          refnoselect = null;
          nameselect = null;
          areaselect = null;
          insexselect = 0;
          Form_payment1.text = '0.00';
          transPlayListModels.clear();
          transPlayListxModels.clear();

          // for (var i = 0; i < expModels.length; i++) {
          //   listcolor.add('0');
          // }
        }
      });
    } catch (e) {}
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
        fileName_Slip = 'slip_${refnoselect}_${date}_$Time_.$extension_';
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
    var ciddoc = refnoselect;
    var qutser = '1';
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
    var comment = Form_note.text.toString();

    print('in_Trans_invoice()///$fileName_Slip_');
    print('in_Trans_invoice>>> $payment1  $payment2 $bill');

    String url = pamentpage == 0
        ? '${MyConstant().domain}/In_tran_financet1.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_&comment=$comment'
        : '${MyConstant().domain}/In_tran_financet2.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_&comment=$comment';
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

        Insert_log.Insert_logs(
            'บัญชี',
            (Slip_status.toString() == '1')
                ? 'รับชำระ:$numinvoice '
                : 'รับชำระ:$cFinn ');
        // PdfgenReceipt.exportPDF_Receipt(
        //     tableData00,
        //     context,
        //     Slip_status,
        //     _TransModels,
        //     '${refnoselect}',
        //     '${nameselect}',
        //     '${sum_pvat}',
        //     '${sum_vat}',
        //     '${sum_wht}',
        //     '${sum_amt}',
        //     (discount_ == null) ? '0' : '${discount_} ',
        //     '${nFormat.format(sum_disamt)}',
        //     '${sum_amt - sum_disamt}',
        //     // '${nFormat.format(sum_amt - sum_disamt)}',
        //     '${renTal_name.toString()}',
        //     '${Form_bussshop}',
        //     '${Form_address}',
        //     '${Form_tel}',
        //     '${Form_email}',
        //     '${Form_tax}',
        //     '${Form_nameshop}',
        //     '${renTalModels[0].bill_addr}',
        //     '${renTalModels[0].bill_email}',
        //     '${renTalModels[0].bill_tel}',
        //     '${renTalModels[0].bill_tax}',
        //     '${renTalModels[0].bill_name}',
        //     newValuePDFimg,
        //     pamentpage,
        //     paymentName1,
        //     paymentName2,
        //     Form_payment1.text,
        //     Form_payment2.text,
        //     cFinn,
        //     Value_newDateD);
        confrem();
        setState(() async {
          Form_payment1.text = '0.00';
          Form_payment2.clear();
          // read_GC_Exp();
          read_GC_Playcolumn();

          red_Trans_select2(insexselect);
          // red_Trans_select3(insexselect);
          sum_disamtx.clear();
          sum_dispx.clear();
          sum_disamt = 0;

          Form_time.clear();
          Form_note.clear();
          // Value_newDateY = null;
          pamentpage = 0;
          bills_name_ = 'บิลธรรมดา';
          cFinn = null;
          // Value_newDateD = '';
          discount_ = null;
          base64_Slip = null;
          tableData00 = [];
          _customTileExpanded = false;
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<String?> confrem() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: const Center(
            child: Column(
          children: [
            Text(
              'ชำระสำเร็จ',
              style: TextStyle(
                  color: AdminScafScreen_Color.Colors_Text1_,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T),
            ),
          ],
        )),
        // content:
        //     const SingleChildScrollView(
        //   child:
        //       Column(
        //     crossAxisAlignment:
        //         CrossAxisAlignment.center,
        //     children: <Widget>[
        //       Text(
        //         'สถานะ : เช่าแล้ว',
        //         style: TextStyle(
        //             color: AdminScafScreen_Color.Colors_Text1_,
        //             // fontWeight: FontWeight.bold,
        //             fontFamily: Font_.Fonts_T),
        //       ),
        //     ],
        //   ),
        // ),
        actions: <Widget>[
          Column(
            children: [
              const SizedBox(
                height: 2.0,
              ),
              const Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            padding: const EdgeInsets.all(5.0),
                            child: TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
