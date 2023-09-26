import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:fl_pin_code/pin_code.dart';
import 'package:fl_pin_code/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simple_barcode_scanner/screens/io_device.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetInvoice_history_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class Verifi_Payment_History extends StatefulWidget {
  const Verifi_Payment_History({super.key});

  @override
  State<Verifi_Payment_History> createState() => _Verifi_Payment_HistoryState();
}

class _Verifi_Payment_HistoryState extends State<Verifi_Payment_History> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  List<InvoiceHistoryModel> _InvoiceHistoryModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<FinnancetransModel> finnancetransModels = [];
  List<TransReBillModel> _TransReBillModels = [];
  List<TeNantModel> teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<TransReBillModel> TransReBillModels_ = [];
  String tappedIndex_ = '';
  ScrollController _scrollController2 = ScrollController();
  List<TransModel> _TransModels = [];
  List<RenTalModel> renTalModels = [];
  String? cid_Name, name_Name;
  String? base64_Slip, fileName_Slip, Slip_history;
  final Formbecause_ = TextEditingController();
  String? renTal_user,
      renTal_name,
      zone_ser,
      zone_name,
      Value_cid,
      fname_,
      pdate;
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;
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
  String? Slip_status, resultqr;
  final sum_disamtx = TextEditingController();
  final sum_dispx = TextEditingController();
  final Form_payment1 = TextEditingController();
  final Form_payment2 = TextEditingController();
  final Form_time = TextEditingController();
  final Form_note = TextEditingController();
  final Pincontroller = TextEditingController();
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
      bills_name_;
  @override
  void initState() {
    super.initState();
    checkPreferance();
    red_Trans_bill();
    read_GC_rental();
  }

  String? email_login;
  String? seremail_login;

  String randomString = '';
  generateRandomString() {
    setState(() {
      randomString = '';
    });
    final random = Random();
    const characters = '0123456789';
    final length = 2; // Change this to the desired length

    for (int i = 0; i < length; i++) {
      final index = random.nextInt(characters.length);
      randomString += characters[index];
    }

    // return randomString;
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');
      email_login = preferences.getString('email');
      seremail_login = preferences.getString('ser');
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

  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
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
        '${MyConstant().domain}/GC_bill_pay_BC_Verifi.php?isAdd=true&ren=$ren';
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
        setState(() {
          TransReBillModels_ = _TransReBillModels;
        });
        print('result ${_TransReBillModels.length}');
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_select(index) async {
    if (_TransReBillHistoryModels.length != 0) {
      setState(() {
        _TransReBillHistoryModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        // sum_disamt = 0;
        // sum_disp = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = _TransReBillModels[index].ser;
    var qutser = _TransReBillModels[index].ser_in;
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

          var sumPvatx = double.parse(_TransReBillHistoryModel.pvat!);
          var sumVatx = double.parse(_TransReBillHistoryModel.vat!);
          var sumWhtx = double.parse(_TransReBillHistoryModel.wht!);
          var sumAmtx = double.parse(_TransReBillHistoryModel.total!);
          // var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
          // var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
          var numinvoiceent = _TransReBillHistoryModel.docno;
          setState(() {
            sum_pvat = sum_pvat + sumPvatx;
            sum_vat = sum_vat + sumVatx;
            sum_wht = sum_wht + sumWhtx;
            sum_amt = sum_amt + sumAmtx;
            // sum_disamt = sum_disamtx;
            // sum_disp = sum_dispx;
            numinvoice = _TransReBillHistoryModel.docno;
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          });
        }
      }
      // setState(() {
      //   red_Invoice(index);
      // });
    } catch (e) {}
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
    var ciddoc = cid_Name;
    var qutser = name_Name;

    String url =
        '${MyConstant().domain}/GC_tran_select.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);

          var sumPvatx = double.parse(_TransModel.pvat!);
          var sumVatx = double.parse(_TransModel.vat!);
          var sumWhtx = double.parse(_TransModel.wht!);
          var sumAmtx = double.parse(_TransModel.total!);
          setState(() {
            sum_pvat = sum_pvat + sumPvatx;
            sum_vat = sum_vat + sumVatx;
            sum_wht = sum_wht + sumWhtx;
            sum_amt = sum_amt + sumAmtx;
            _TransModels.add(_TransModel);
          });
        }
      }

      // setState(() {
      //   Form_payment1.text =
      //       (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      // });
    } catch (e) {}
  }

  Future<Null> red_Invoice(index) async {
    if (finnancetransModels.length != 0) {
      setState(() {
        finnancetransModels.clear();
        sum_disamt = 0;
        sum_disp = 0;
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
          print(
              '>>>>> ${finnancetransModel.slip}>>>>>>dd>>> in $sidamt $siddisper  ');
        }
      }
    } catch (e) {}
  }

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
      print(result);
      if (result.toString() == 'true') {
        Insert_log.Insert_logs('บัญชี',
            'ประวัติบิล>>ยกเลิกการรับชำระ($numin,เหตุผล:${Formbecause})');
        setState(() {
          // _InvoiceModels.clear();
          // _InvoiceHistoryModels.clear();
          _TransReBillHistoryModels.clear();
          // numinvoice = null;
          // sum_disamtx.text = '0.00';
          // sum_dispx.text = '0.00';
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;
          // select_page = 0;
          red_Trans_bill();
          finnancetransModels.clear();
          Navigator.pop(context);
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
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
                                        width: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85
                                            : 1200,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'เลขที่สัญญา',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'วันที่ทำรายการ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'วันที่รับชำระ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'เลขที่ใบเสร็จ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: Padding(
                                            //     padding: EdgeInsets.all(8.0),
                                            //     child: Text(
                                            //       'เลขที่ใบวางบิล',
                                            //       textAlign: TextAlign.center,
                                            //       style: TextStyle(
                                            //         color: AccountScreen_Color
                                            //             .Colors_Text1_,
                                            //         fontWeight: FontWeight.bold,
                                            //         fontFamily:
                                            //             FontWeight_.Fonts_T,
                                            //         //fontSize: 10.0
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'รหัสพื้นที่',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ชื่อร้านค้า',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'จำนวนเงิน',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'รูปแบบชำระ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  '...',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          width: Responsive.isDesktop(context)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85
                                              : 1200,
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          child: _TransReBillModels.isEmpty
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
                                                          if (!snapshot.hasData)
                                                            return const Text(
                                                                '');
                                                          double elapsed = double
                                                                  .parse(snapshot
                                                                      .data
                                                                      .toString()) *
                                                              0.05;
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: (elapsed >
                                                                    8.00)
                                                                ? const Text(
                                                                    'ไม่พบข้อมูล',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  )
                                                                : Text(
                                                                    'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                    // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T
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
                                                      _TransReBillModels.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Material(
                                                      color: tappedIndex_ ==
                                                              index.toString()
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
                                                        child: ListTile(
                                                            onTap: () async {
                                                              generateRandomString();
                                                              setState(() {
                                                                red_Trans_select(
                                                                    index);
                                                                red_Invoice(
                                                                    index);
                                                              });
                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  () async {
                                                                checkshowDialog(
                                                                  index,
                                                                );
                                                              });
                                                            },
                                                            title: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text:
                                                                            '${_TransReBillModels[index].cid}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .grey[200],
                                                                      ),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        '${_TransReBillModels[index].cid}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text2_,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          const TextSpan(
                                                                        text:
                                                                            '',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .grey[200],
                                                                      ),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].daterec} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].daterec} 00:00:00').year + 543}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text2_,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Tooltip(
                                                                    richMessage:
                                                                        const TextSpan(
                                                                      text: '',
                                                                      style:
                                                                          TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                    ),
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].pdate} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].pdate} 00:00:00').year + 543}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Tooltip(
                                                                    richMessage:
                                                                        TextSpan(
                                                                      text: _TransReBillModels[index].doctax ==
                                                                              ''
                                                                          ? '${_TransReBillModels[index].docno}'
                                                                          : '${_TransReBillModels[index].doctax}',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                    ),
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      _TransReBillModels[index].doctax ==
                                                                              ''
                                                                          ? '${_TransReBillModels[index].docno}'
                                                                          : '${_TransReBillModels[index].doctax}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Expanded(
                                                                //   flex: 1,
                                                                //   child:
                                                                //       Padding(
                                                                //     padding:
                                                                //         const EdgeInsets.all(
                                                                //             8.0),
                                                                //     child:
                                                                //         Tooltip(
                                                                //       richMessage:
                                                                //           TextSpan(
                                                                //         text:
                                                                //             '${_TransReBillModels[index].inv}',
                                                                //         style:
                                                                //             const TextStyle(
                                                                //           color:
                                                                //               HomeScreen_Color.Colors_Text1_,
                                                                //           fontWeight:
                                                                //               FontWeight.bold,
                                                                //           fontFamily:
                                                                //               FontWeight_.Fonts_T,
                                                                //           //fontSize: 10.0
                                                                //         ),
                                                                //       ),
                                                                //       decoration:
                                                                //           BoxDecoration(
                                                                //         borderRadius:
                                                                //             BorderRadius.circular(5),
                                                                //         color: Colors
                                                                //             .grey[200],
                                                                //       ),
                                                                //       child:
                                                                //           AutoSizeText(
                                                                //         minFontSize:
                                                                //             10,
                                                                //         maxFontSize:
                                                                //             25,
                                                                //         maxLines:
                                                                //             1,
                                                                //         '${_TransReBillModels[index].inv}',
                                                                //         textAlign:
                                                                //             TextAlign.center,
                                                                //         overflow:
                                                                //             TextOverflow.ellipsis,
                                                                //         style: const TextStyle(
                                                                //             color:
                                                                //                 PeopleChaoScreen_Color.Colors_Text2_,
                                                                //             fontFamily: Font_.Fonts_T),
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Tooltip(
                                                                    richMessage:
                                                                        TextSpan(
                                                                      text: _TransReBillModels[index].ln ==
                                                                              null
                                                                          ? '${_TransReBillModels[index].room_number}'
                                                                          : '${_TransReBillModels[index].ln}',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                    ),
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      _TransReBillModels[index].ln ==
                                                                              null
                                                                          ? '${_TransReBillModels[index].room_number}'
                                                                          : '${_TransReBillModels[index].ln}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Tooltip(
                                                                    richMessage:
                                                                        TextSpan(
                                                                      text: _TransReBillModels[index].sname ==
                                                                              null
                                                                          ? '${_TransReBillModels[index].remark}'
                                                                          : '${_TransReBillModels[index].sname}',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                    ),
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      _TransReBillModels[index].sname ==
                                                                              null
                                                                          ? '${_TransReBillModels[index].remark}'
                                                                          : '${_TransReBillModels[index].sname}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Tooltip(
                                                                    richMessage:
                                                                        const TextSpan(
                                                                      text: '',
                                                                      style:
                                                                          TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                    ),
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      _TransReBillModels[index].total_dis ==
                                                                              null
                                                                          ? '${nFormat.format(double.parse(_TransReBillModels[index].total_bill!))}'
                                                                          : '${nFormat.format(double.parse(_TransReBillModels[index].total_dis!))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Tooltip(
                                                                    richMessage:
                                                                        const TextSpan(
                                                                      text: '',
                                                                      style:
                                                                          TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                    ),
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      '${_TransReBillModels[index].type}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .orange,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          const AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            1,
                                                                        'ตวจสอบ',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text2_,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            _scrollController2.animateTo(
                                              0,
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                // color: AppbackgroundColor
                                                //     .TiTile_Colors,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(8)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Text(
                                                'Top',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_scrollController2.hasClients) {
                                            final position = _scrollController2
                                                .position.maxScrollExtent;
                                            _scrollController2.animateTo(
                                              position,
                                              duration:
                                                  const Duration(seconds: 1),
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
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(3.0),
                                            child: const Text(
                                              'Down',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,
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
                                              alignment: Alignment.centerLeft,
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
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
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
                                              alignment: Alignment.centerRight,
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

  ///---------------------------------------------------------------------->
  Future<Null> checkshowDialog(index) async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        'เลขที่บิล ${_TransReBillModels[index].docno}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                content: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ScrollConfiguration(
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
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.85
                                  : 1200,
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
                                            'รายละเอียดบิล', //numinvoice
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
                                        decoration: BoxDecoration(
                                          color: Colors.orange[100],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
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
                                              'บิลเลขที่ ${_TransReBillModels[index].docno}', //
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
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
                                            textAlign: TextAlign.start,
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
                                    //         'VAT',
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
                                    // if (renTal_user.toString() == '65' ||
                                    //     renTal_user.toString() == '50')
                                    //   Expanded(
                                    //     flex: 1,
                                    //     child: Container(
                                    //       height: 50,
                                    //       color: Colors.brown[200],
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: const Center(
                                    //         child: AutoSizeText(
                                    //           minFontSize: 10,
                                    //           maxFontSize: 15,
                                    //           maxLines: 1,
                                    //           '70',
                                    //           textAlign: TextAlign.end,
                                    //           style: TextStyle(
                                    //               color: PeopleChaoScreen_Color
                                    //                   .Colors_Text1_,
                                    //               fontWeight: FontWeight.bold,
                                    //               fontFamily:
                                    //                   FontWeight_.Fonts_T
                                    //               //fontSize: 10.0
                                    //               //fontSize: 10.0
                                    //               ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // if (renTal_user.toString() == '65' ||
                                    //     renTal_user.toString() == '50')
                                    //   Expanded(
                                    //     flex: 1,
                                    //     child: Container(
                                    //       height: 50,
                                    //       color: Colors.brown[200],
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: const Center(
                                    //         child: AutoSizeText(
                                    //           minFontSize: 10,
                                    //           maxFontSize: 15,
                                    //           maxLines: 1,
                                    //           '30',
                                    //           textAlign: TextAlign.end,
                                    //           style: TextStyle(
                                    //               color: PeopleChaoScreen_Color
                                    //                   .Colors_Text1_,
                                    //               fontWeight: FontWeight.bold,
                                    //               fontFamily:
                                    //                   FontWeight_.Fonts_T
                                    //               //fontSize: 10.0
                                    //               //fontSize: 10.0
                                    //               ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
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
                                            'ยอดสุทธิ',
                                            textAlign: TextAlign.end,
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
                                Expanded(
                                  // height:
                                  //     MediaQuery.of(context).size.height / 4.8,
                                  // decoration: const BoxDecoration(
                                  //   color: AppbackgroundColor.Sub_Abg_Colors,
                                  //   borderRadius: BorderRadius.only(
                                  //     topLeft: Radius.circular(0),
                                  //     topRight: Radius.circular(0),
                                  //     bottomLeft: Radius.circular(0),
                                  //     bottomRight: Radius.circular(0),
                                  //   ),
                                  //   // border: Border.all(
                                  //   //     color: Colors.grey, width: 1),
                                  // ),
                                  child: StreamBuilder(
                                    stream: Stream.periodic(
                                        const Duration(seconds: 0)),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        controller: _scrollController2,
                                        // itemExtent: 50,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            _TransReBillHistoryModels.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${index + 1}',
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
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransReBillHistoryModels[index].dateacc} 00:00:00'))}',
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
                                                    // '${_TransReBillHistoryModels[index].duedate}',
                                                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransReBillHistoryModels[index].date} 00:00:00'))}',
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
                                                    '${_TransReBillHistoryModels[index].refno}',
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
                                                    '${_TransReBillHistoryModels[index].vat}',
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
                                                    '${_TransReBillHistoryModels[index].wht}',
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
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: AutoSizeText(
                                                //     minFontSize: 10,
                                                //     maxFontSize: 15,
                                                //     maxLines: 1,
                                                //     '${nFormat.format(double.parse(_TransReBillHistoryModels[index].vat!))}',
                                                //     textAlign:
                                                //         TextAlign.center,
                                                //     style: const TextStyle(
                                                //         color:
                                                //             PeopleChaoScreen_Color
                                                //                 .Colors_Text2_,
                                                //         //fontWeight: FontWeight.bold,
                                                //         fontFamily:
                                                //             Font_.Fonts_T),
                                                //   ),
                                                // ),
                                                // if (renTal_user.toString() ==
                                                //         '65' ||
                                                //     renTal_user.toString() ==
                                                //         '50')
                                                //   Expanded(
                                                //     flex: 1,
                                                //     child: Container(
                                                //       height: 50,
                                                //       // color: Colors.brown[200],
                                                //       // padding:
                                                //       //     const EdgeInsets.all(
                                                //       //         8.0),
                                                //       child: Center(
                                                //         child: AutoSizeText(
                                                //           minFontSize: 10,
                                                //           maxFontSize: 15,
                                                //           maxLines: 1,
                                                //           (_TransReBillHistoryModels[
                                                //                           index]
                                                //                       .ramt
                                                //                       .toString() ==
                                                //                   'null')
                                                //               ? '-'
                                                //               : '${_TransReBillHistoryModels[index].ramt}',
                                                //           textAlign:
                                                //               TextAlign.end,
                                                //           style: const TextStyle(
                                                //               color: PeopleChaoScreen_Color
                                                //                   .Colors_Text1_,
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .bold,
                                                //               fontFamily:
                                                //                   FontWeight_
                                                //                       .Fonts_T
                                                //               //fontSize: 10.0
                                                //               //fontSize: 10.0
                                                //               ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // if (renTal_user.toString() ==
                                                //         '65' ||
                                                //     renTal_user.toString() ==
                                                //         '50')
                                                //   Expanded(
                                                //     flex: 1,
                                                //     child: Container(
                                                //       height: 50,
                                                //       // color: Colors.brown[200],
                                                //       // padding:
                                                //       //     const EdgeInsets.all(
                                                //       //         8.0),
                                                //       child: Center(
                                                //         child: AutoSizeText(
                                                //           minFontSize: 10,
                                                //           maxFontSize: 15,
                                                //           maxLines: 1,
                                                //           (_TransReBillHistoryModels[
                                                //                           index]
                                                //                       .ramtd
                                                //                       .toString() ==
                                                //                   'null')
                                                //               ? '-'
                                                //               : '${_TransReBillHistoryModels[index].ramtd}',
                                                //           textAlign:
                                                //               TextAlign.end,
                                                //           style: const TextStyle(
                                                //               color: PeopleChaoScreen_Color
                                                //                   .Colors_Text1_,
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .bold,
                                                //               fontFamily:
                                                //                   FontWeight_
                                                //                       .Fonts_T
                                                //               //fontSize: 10.0
                                                //               //fontSize: 10.0
                                                //               ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: AutoSizeText(
                                                //     minFontSize: 10,
                                                //     maxFontSize: 15,
                                                //     maxLines: 1,
                                                //     '${nFormat.format(double.parse(_TransReBillHistoryModels[index].amt!))}',
                                                //     textAlign:
                                                //         TextAlign.center,
                                                //     style: const TextStyle(
                                                //         color:
                                                //             PeopleChaoScreen_Color
                                                //                 .Colors_Text2_,
                                                //         //fontWeight: FontWeight.bold,
                                                //         fontFamily:
                                                //             Font_.Fonts_T),
                                                //   ),
                                                // ),
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
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: (Responsive.isDesktop(context))
                                        ? MediaQuery.of(context).size.width *
                                            0.85
                                        : 1200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          // height: 50,
                                          // color: Colors.red,
                                          child: StreamBuilder(
                                              stream: Stream.periodic(
                                                  const Duration(seconds: 0)),
                                              builder: (context, snapshot) {
                                                return Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'วันที่ชำระ : ${DateFormat('dd-MM').format(DateTime.parse('$pdate 00:00:00'))}-${DateTime.parse('$pdate 00:00:00').year + 543}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            // fontWeight:
                                                            //     FontWeight
                                                            //         .bold,
                                                            fontFamily:
                                                                Font_.Fonts_T
                                                            //fontSize: 10.0
                                                            ),
                                                      ),
                                                    ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'รูปแบบการชำระ',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            // fontWeight:
                                                            //     FontWeight
                                                            //         .bold,
                                                            fontFamily:
                                                                Font_.Fonts_T
                                                            //fontSize: 10.0
                                                            ),
                                                      ),
                                                    ),
                                                    for (var i = 0;
                                                        i <
                                                            finnancetransModels
                                                                .length;
                                                        i++)
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          // minFontSize: 10,
                                                          // maxFontSize: 15,
                                                          '${i + 1}.(${finnancetransModels[i].type}) จำนวน ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              }),
                                        ),
                                        Container(
                                          width: 350,
                                          // height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(0),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(0)),
                                          ),
                                          child: StreamBuilder(
                                            stream: Stream.periodic(
                                                const Duration(seconds: 0)),
                                            builder: (context, snapshot) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
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
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_pvat)}',
                                                          style:
                                                              const TextStyle(
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
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
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
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_vat)}',
                                                          style:
                                                              const TextStyle(
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
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
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
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_wht)}',
                                                          style:
                                                              const TextStyle(
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
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
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
                                                          style:
                                                              const TextStyle(
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
                                                      Container(
                                                        width: 120,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ส่วนลด $sum_disp  %',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          '${nFormat.format(sum_disamt)}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style:
                                                              const TextStyle(
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
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
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
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_amt - sum_disamt)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ])),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 0)),
                          builder: (context, snapshot) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    width: 180,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                            context: context,
                                            builder:
                                                (BuildContext context) =>
                                                    StreamBuilder(
                                                        stream: Stream.periodic(
                                                            const Duration(
                                                                seconds: 0)),
                                                        builder: (context,
                                                            snapshot) {
                                                          return AlertDialog(
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20.0))),
                                                            title: const Center(
                                                                child: Text(
                                                              'ถูกต้อง/อนุมัติ การรับชำระ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .orange,
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
                                                                        children: <Widget>[
                                                                  const SizedBox(
                                                                    height: 2.0,
                                                                  ),
                                                                  Text(
                                                                    'บิลเลขที่ ${_TransReBillModels[index].docno}',
                                                                    style: const TextStyle(
                                                                        color: AccountScreen_Color.Colors_Text2_,
                                                                        // fontWeight:
                                                                        //     FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        // color: Colors.grey,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(6),
                                                                            topRight: Radius.circular(6),
                                                                            bottomLeft: Radius.circular(6),
                                                                            bottomRight: Radius.circular(6)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'ยอดชำระ ',
                                                                            style: const TextStyle(
                                                                                color: AccountScreen_Color.Colors_Text2_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                          Text(
                                                                            '- ${nFormat.format(sum_amt - sum_disamt)}',
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: AccountScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                4,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              'หลักฐานการชำระ ',
                                                                              style: const TextStyle(color: AccountScreen_Color.Colors_Text2_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            (Slip_history.toString() == null || Slip_history == null || Slip_history.toString() == 'null')
                                                                                ? '- ไม่พบหลักฐาน ✖️'
                                                                                : '- พบหลักฐาน ✔️',
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: AccountScreen_Color.Colors_Text2_,
                                                                                //(Slip_history.toString() == null || Slip_history == null || Slip_history.toString() == 'null') ? Colors.red : Colors.green,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                          Text(
                                                                            (Slip_history.toString() == null || Slip_history == null || Slip_history.toString() == 'null')
                                                                                ? ''
                                                                                : '($Slip_history)',
                                                                            style: TextStyle(
                                                                                fontSize: 10,
                                                                                color: Colors.grey,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                          const Padding(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                0,
                                                                                4,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              'ผู้ตวจสอบ/อนุมัติ ',
                                                                              style: TextStyle(color: AccountScreen_Color.Colors_Text2_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '- ${email_login}($seremail_login)',
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: AccountScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    'CODE : ',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(2),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        color: Color.fromARGB(255, 179, 177, 170),
                                                                                        // image:
                                                                                        //     const DecorationImage(
                                                                                        //   image: AssetImage(
                                                                                        //       "assets/pngegg2.png"),
                                                                                        //   fit: BoxFit
                                                                                        //       .cover,
                                                                                        // ),
                                                                                      ),
                                                                                      width: 65,
                                                                                      // color: Colors.black,
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          '${randomString}',
                                                                                          style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                height: 40,
                                                                                width: 90,
                                                                                child: PinCode(
                                                                                  keyboardType: TextInputType.number,
                                                                                  numberOfFields: 2,
                                                                                  fieldWidth: 40.0,
                                                                                  style: TextStyle(
                                                                                    fontFamily: Font_.Fonts_T,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  fieldStyle: PinCodeStyle.box,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      Pincontroller.text = value.trim();
                                                                                    });
                                                                                  },
                                                                                  onCompleted: (text) {
                                                                                    setState(() {
                                                                                      Pincontroller.text = text.trim();
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ])),
                                                            actions: <Widget>[
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    '** โปรดตรวจสอบความถูกต้องทุกครั้งก่อนอนุมัติ',
                                                                    style: TextStyle(
                                                                        color: Colors.red[
                                                                            800],
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 1.0,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              150,
                                                                          height:
                                                                              40,
                                                                          // ignore: deprecated_member_use
                                                                          child:
                                                                              ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: (Pincontroller.text != "$randomString") ? Colors.grey : Colors.green,
                                                                            ),
                                                                            onPressed: (Pincontroller.text != "$randomString")
                                                                                ? null
                                                                                : () async {
                                                                                    SharedPreferences preferences = await SharedPreferences.getInstance();

                                                                                    var ren = preferences.getString('renTalSer');
                                                                                    var Remark = '${email_login}($seremail_login)';
                                                                                    var docno = '${_TransReBillModels[index].docno}';

                                                                                    String url = '${MyConstant().domain}/OK_Verifi_Payment.php?isAdd=true&ren=$ren&ciddoc=$docno&Re_mark=$Remark';

                                                                                    try {
                                                                                      var response = await http.get(Uri.parse(url));

                                                                                      var result = json.decode(response.body);
                                                                                      if (result.toString() == 'true') {
                                                                                        Insert_log.Insert_logs('บัญชี', 'ประวัติบิลรอตรวจสอบ>>อนุมัติ($docno,ผู้อนุมัตื:${Remark})');
                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                          SnackBar(backgroundColor: Colors.green, content: Text('$docno อนุมัติเสร็จสิ้น!', style: TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
                                                                                        );
                                                                                        Navigator.pop(context, 'OK');
                                                                                        Navigator.pop(context, 'OK');
                                                                                        setState(() {
                                                                                          Pincontroller.clear;
                                                                                          checkPreferance();
                                                                                          red_Trans_bill();
                                                                                          read_GC_rental();
                                                                                        });
                                                                                      }
                                                                                    } catch (e) {
                                                                                      Pincontroller.clear;
                                                                                    }
                                                                                  },
                                                                            child:
                                                                                const Text(
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
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              150,
                                                                          height:
                                                                              40,
                                                                          // ignore: deprecated_member_use
                                                                          child:
                                                                              ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.black,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                Formbecause_.clear();
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child:
                                                                                const Text(
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
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        }));
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(Icons.check,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ถูกต้อง/อนุมัติ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    // fontWeight:
                                                    //     FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    // width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        (Slip_history.toString() == null ||
                                                Slip_history == null ||
                                                Slip_history.toString() ==
                                                    'null')
                                            ? const SizedBox()
                                            : Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                width: 180,
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                              title: Center(
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      'เลขที่บิล ${_TransReBillModels[index].docno}',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily: FontWeight_
                                                                              .Fonts_T,
                                                                          fontSize:
                                                                              14.0),
                                                                    ),
                                                                    Text(
                                                                      '(${Slip_history})',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily: FontWeight_
                                                                              .Fonts_T,
                                                                          fontSize:
                                                                              10.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              content:
                                                                  SingleChildScrollView(
                                                                      child: ListBody(
                                                                          children: <Widget>[
                                                                    SizedBox(
                                                                      width:
                                                                          300,
                                                                      child: Image
                                                                          .network(
                                                                              '${MyConstant().domain}/files/$foder/slip/${Slip_history}'),
                                                                    )
                                                                  ])),
                                                              actions: <Widget>[
                                                            SizedBox(
                                                              // width: 300,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '*** วิธีตรวจสอบ "สลิป" เบื้องต้น',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                  Text(
                                                                    '1. สังเกตความละเอียดของ ตัวเลข หรือ ตัวหนังสือ',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                  Text(
                                                                    '2. เปิดแอปฯ ธนาคารขึ้นมา สแกน QR CODE บนสลิปโอนเงิน',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                  Text(
                                                                    '3. ใช้  Mobile Banking เช็ก ยอดเงิน วัน-เวลาที่โอน ตรงกับในสลิปที่ได้มาหรือไม่',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                  Text(
                                                                    '4. ควรตรวจสอบสลิปทันทีที่ได้รับมา เพราะ QR code บนสลิปของบางธนาคารจะมีอายุจำกัด ตั้งเเต่ 7 วัน ถึง 60 วัน ',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
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
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
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
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ]),
                                                    );
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue[200],
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
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Icon(
                                                                Icons.image,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              'หลักฐานการโอน',
                                                              style: TextStyle(
                                                                color: AccountScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: 180,
                                          child: InkWell(
                                            onTap: () {
                                              showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  )),
                                                  content: Container(
                                                    height: 120,
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text(
                                                          'บิลเลขที่ ${_TransReBillModels[index].docno}',
                                                          style:
                                                              const TextStyle(
                                                                  color: AccountScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight:
                                                                  //     FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                Formbecause_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
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
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon: const Icon(Icons.water,
                                                                    //     color: Colors.blue),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
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
                                                                      fontFamily:
                                                                          Font_
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
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                                Formbecause_
                                                                    .text
                                                                    .toString();
                                                            if (Formbecause ==
                                                                '') {
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20.0))),
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
                                                                            FontWeight_.Fonts_T),
                                                                  )),
                                                                  actions: <Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.redAccent,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () => Navigator.pop(context, 'OK'),
                                                                              child: const Text(
                                                                                'ปิด',
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                                  context,
                                                                  'OK');
                                                            }
                                                          },
                                                          child: const Text(
                                                            'ยืนยัน',
                                                            style: TextStyle(
                                                              // fontSize: 20.0,
                                                              // fontWeight: FontWeight.bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          // color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                              Formbecause_
                                                                  .clear();
                                                            });
                                                            Navigator.pop(
                                                                context, 'OK');
                                                          },
                                                          child: const Text(
                                                            'ปิด',
                                                            style: TextStyle(
                                                              // fontSize: 20.0,
                                                              // fontWeight: FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                decoration: BoxDecoration(
                                                  color: Colors.orange[200],
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
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                          Icons
                                                              .cancel_presentation,
                                                          color: Colors.black),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'ยกเลิกการรับชำระ',
                                                        style: TextStyle(
                                                          color:
                                                              AccountScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight:
                                                          //     FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: 180,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
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
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                          Icons.highlight_off,
                                                          color: Colors.white),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'ปิด',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          // fontWeight:
                                                          //     FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
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
                ],
              ),
            ));
  }
}
