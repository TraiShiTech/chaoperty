import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
// import 'package:ftpconnect/ftpconnect.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetInvoiceRe_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Style/colors.dart';

class AccountInvoicePay extends StatefulWidget {
  const AccountInvoicePay({super.key});

  @override
  State<AccountInvoicePay> createState() => _AccountInvoicePayState();
}

class _AccountInvoicePayState extends State<AccountInvoicePay> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  String? MONTH_Now, YEAR_Now;
  List<String> YE_Th = [];
  DateTime newDatetime = DateTime.now();
  List<TransModel> _TransModels = [];
  List<RenTalModel> renTalModels = [];
  List<InvoiceReModel> InvoiceModels = [];
  List<PayMentModel> _PayMentModels = [];
  List<InvoiceReModel> _InvoiceModels = <InvoiceReModel>[];
  List<InvoiceReModel> limitedList_InvoiceModels_ = [];
  DateTime? _selected;
  String? renTal_user, renTal_name, zone_ser, zone_name;
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
      zone_Subser,
      zone_Subname,
      newValuePDFimg_QR,
      cidSelect;
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
      fine_total2 = 0,
      sum_fine = 0;
  String? paymentSer1,
      paymentName1,
      paymentSer2,
      paymentName2,
      cFinn,
      tappedIndex_ = '',
      Value_newDateY = '',
      Value_newDateD = '',
      Value_newDateY1 = '',
      selectedValue,
      bname1,
      Value_newDateD1 = '';

  // String? base64_Slip, fileName_Slip;
  String? tem_page_ser, doctax;
  int limit = 50; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    read_GC_rental();
    checkPreferance();
    red_Trans_select2();
    red_payMent();
    Value_newDateY1 = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD1 = DateFormat('dd-MM-yyyy').format(newDatetime);
    Value_newDateY = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD = DateFormat('dd-MM-yyyy').format(newDatetime);
  }

  Future<Null> red_payMent() async {
    // if (_PayMentModels.length != 0) {
    //   setState(() {
    //     _PayMentModels.clear();
    //   });
    // }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

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
      map['fine'] = '0';
      map['fine_a'] = '0';
      map['fine_c'] = '0';

      PayMentModel _PayMentModel = PayMentModel.fromJson(map);

      setState(() {
        _PayMentModels.add(_PayMentModel);
      });
      if (result.toString() != 'null') {
        for (var map in result) {
          PayMentModel _PayMentModel = PayMentModel.fromJson(map);
          var autox = _PayMentModel.auto;
          var serx = _PayMentModel.ser;
          var ptnamex = _PayMentModel.ptname;
          var fine = _PayMentModel.fine;
          var fine_amt = fine == '1'
              ? _PayMentModel.fine_c == '0.00'
                  ? double.parse(_PayMentModel.fine_a!)
                  : (((sum_amt - sum_disamt - dis_sum_Pakan - dis_sum_Matjum) *
                          double.parse(_PayMentModel.fine_c!)) /
                      100)
              : 0.00;
          setState(() {
            _PayMentModels.add(_PayMentModel);
            if (autox == '1') {
              paymentSer1 = serx.toString();
              paymentName1 = ptnamex.toString();
              selectedValue = _PayMentModel.bno.toString();
              bname1 = _PayMentModel.bname.toString();
              fine_total = fine_amt;
            }
          });
        }

        if (paymentName1 == null) {
          paymentSer1 = 1.toString();
          paymentName1 = 'เงินสด'.toString();
        }
      }
    } catch (e) {}
  }

  Future<Null> checkPreferance() async {
    int currentYear = DateTime.now().year;
    for (int i = currentYear; i >= currentYear - 10; i--) {
      YE_Th.add(i.toString());
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      MONTH_Now = DateFormat('MM').format(DateTime.parse('${datex}'));
      YEAR_Now = DateFormat('yyyy').format(DateTime.parse('${datex}'));
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      // fname_ = preferences.getString('fname');
      // if (preferences.getString('renTalSer') == '65') {
      //   viewTab = 0;
      // }
    });
    red_InvoiceMon_bill();
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
    } catch (e) {
      print('Error-Dis(read_GC_rental) : ${e}');
    }
    // print('name>>>>>  $renname');
  }

  Future<Null> red_InvoiceMon_bill() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');
    var zone_Sub = preferences.getString('zoneSubSer');

    print('zone>>>ser $zone');

    if (limitedList_InvoiceModels_.length != 0) {
      setState(() {
        limitedList_InvoiceModels_.clear();
      });
    }
    String Serdata =
        (zone.toString() == '0' || zone == null) ? 'All' : 'Allzone';
    String url = (Serdata.toString() == 'All')
        ? '${MyConstant().domain}/GC_bill_invoiceMon_historyReport.php?isAdd=true&ren=$ren&Serdata=$Serdata&serzone=$zone&_monts=$MONTH_Now&yex=$YEAR_Now'
        : '${MyConstant().domain}/GC_bill_invoiceMon_historyReport.php?isAdd=true&ren=$ren&Serdata=$Serdata&serzone=$zone&_monts=$MONTH_Now&yex=$YEAR_Now';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          InvoiceReModel transMeterModel = InvoiceReModel.fromJson(map);
          setState(() {
            limitedList_InvoiceModels_.add(transMeterModel);
          });
        }
      }

      Future.delayed(const Duration(milliseconds: 200), () async {
        setState(() {
          _InvoiceModels = limitedList_InvoiceModels_;
        });
      });
      read_Invoice_limit();
    } catch (e) {}
  }

  Future<Null> read_Invoice_limit() async {
    setState(() {
      endIndex = offset + limit;
      InvoiceModels = limitedList_InvoiceModels_.sublist(
          offset, // Start index
          (endIndex <= limitedList_InvoiceModels_.length)
              ? endIndex
              : limitedList_InvoiceModels_.length // End index
          );
    });
  }

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        // fontSize: 22.0,
        color: TextHome_Color.TextHome_Colors,
      ),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(
          // fontSize: 20.0,
          color: TextHome_Color.TextHome_Colors,
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
        setState(() {
          // ignore: non_constant_identifier_names
          InvoiceModels = limitedList_InvoiceModels_.where((InvoiceModelx) {
            var notTitle = InvoiceModelx.cid.toString().toLowerCase();
            var notdocno = InvoiceModelx.docno.toString().toLowerCase();
            var notdate = InvoiceModelx.date.toString().toLowerCase();
            var notdatex = DateFormat.yMMMd('th_TH')
                .format(DateTime.parse('${InvoiceModelx.date} 00:00:00'))
                .toString()
                .toLowerCase();
            var notln = InvoiceModelx.ln.toString().toLowerCase();
            var notsname = InvoiceModelx.scname.toString().toLowerCase();
            var notcname = InvoiceModelx.cname.toString().toLowerCase();
            return notTitle.contains(text) ||
                notsname.contains(text) ||
                notcname.contains(text) ||
                notdatex.contains(text) ||
                notdocno.contains(text) ||
                notln.contains(text);
          }).toList();
        });
      },
    );
  }

  Future<Null> in_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = InvoiceModels[index].cid;
    var qutser = '1';

    var tser = InvoiceModels[index].ser;
    var tdocno = InvoiceModels[index].docno;
    var total_bill = ((double.parse(InvoiceModels[index].total_dis!) +
        double.parse(InvoiceModels[index].total_vat!)));
    var total_dis = ((double.parse(InvoiceModels[index].total_bill!) -
        double.parse(InvoiceModels[index].total_dis!)));
    var total_vat = InvoiceModels[index].total_vat;
    var total_wht = InvoiceModels[index].total_wht;
    var total_amt = InvoiceModels[index].total_bill;

    print('object $tdocno');
    String url =
        '${MyConstant().domain}/In_tran_select_Inv.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user&total_bill=$total_bill&total_dis=$total_dis&total_vat=$total_vat&total_wht=$total_wht&total_amt=$total_amt';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrr');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('ไม่สามารถเลือกรายการซ้ำได้',
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
        sum_tran_dis = 0;
        sum_matjum = 0;
        sum_fine = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = '';
    var qutser = '';

    String url =
        '${MyConstant().domain}/GC_tran_select_inv.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc'; //GC_tran_select_fin
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
          sum_fine = 0;
        });
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);

          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          var sum_disx = double.parse(_TransModel.dis!);
          var sum_finex = double.parse(_TransModel.fine!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_tran_dis = sum_tran_dis + sum_disx;
            sum_fine = sum_fine + sum_finex;
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
    print('_TransModels.length >>>>> ${_TransModels.length}');
    // setState(() {
    //   red_Trans_select2_fin();
    //   read_GC_matjum();

    //   Form_payment1.text =
    //       (sum_amt - sum_disamt - dis_sum_Pakan - sum_tran_dis - dis_sum_Matjum)
    //           .toStringAsFixed(2)
    //           .toString();
    // });
  }

  Widget Next_page() {
    return Row(
      children: [
        Expanded(child: Text('')),
        StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 300)),
            builder: (context, snapshot) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: (offset == 0)
                            ? null
                            : () async {
                                if (offset == 0) {
                                } else {
                                  setState(() {
                                    offset = offset - limit;

                                    read_Invoice_limit();
                                    tappedIndex_ = '';
                                  });
                                  _scrollController2.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeOut,
                                  );
                                }
                              },
                        child: Icon(
                          Icons.arrow_left,
                          color:
                              (offset == 0) ? Colors.grey[200] : Colors.black,
                          size: 25,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        /// '*//$endIndex /${limitedList_teNantModels.length} ///${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                        '${(endIndex / limit)}/${(limitedList_InvoiceModels_.length / limit).ceil()}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                          //fontSize: 10.0
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (endIndex >= limitedList_InvoiceModels_.length)
                            ? null
                            : () async {
                                setState(() {
                                  offset = offset + limit;
                                  tappedIndex_ = '';
                                  read_Invoice_limit();
                                });
                                _scrollController2.animateTo(
                                  0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: (endIndex >= limitedList_InvoiceModels_.length)
                              ? Colors.grey[200]
                              : Colors.black,
                          size: 25,
                        )),
                  ],
                ),
              );
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.width * 0.35,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: AppbackgroundColor.TiTile_Colors,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextButton(
                                    onPressed: () async {
                                      // _onshowMonth(context: context, locale: 'th');
                                    },
                                    child: Text(
                                      'รายการวางบิล',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color:
                                            AccountScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: _searchBar(),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    child: Next_page(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: AppbackgroundColor.TiTile_Colors,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'เลขที่สัญญา',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AccountScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'เลขที่วางบิล',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AccountScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'กำหนดชำระ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AccountScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   flex: 1,
                                //   child: Text(
                                //     'WHT',
                                //     textAlign: TextAlign.end,
                                //   ),
                                // ),
                                // Expanded(
                                //   flex: 1,
                                //   child: Text(
                                //     'VAT',
                                //     textAlign: TextAlign.end,
                                //   ),
                                // ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'ส่วนลด',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: AccountScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'ยอดรวม',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: AccountScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int index = 0;
                                          index < InvoiceModels.length;
                                          index++)
                                        TextButton(
                                          onPressed: () async {
                                            if (_TransModels.length != 10) {
                                              in_Trans_select(index);
                                              setState(() {
                                                cidSelect =
                                                    InvoiceModels[index].cid;
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'ไม่สามารถทำมากกว่า 10 รายการได้ ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: Font_
                                                                .Fonts_T))),
                                              );
                                            }

                                            print(
                                                '${InvoiceModels[index].ser} ${InvoiceModels[index].cid} ${InvoiceModels[index].docno}');
                                          },
                                          style: TextButton.styleFrom(
                                            primary: Colors.black, // Text Color
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                // color: Colors.green[100]!
                                                //     .withOpacity(0.5),
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black12,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '${InvoiceModels[index].ln}',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '${InvoiceModels[index].scname}',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '${InvoiceModels[index].cname}',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '${nFormat.format(double.parse(InvoiceModels[index].total_wht!))}',
                                                      //     textAlign: TextAlign.end,
                                                      //   ),
                                                      // ),
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '${nFormat.format(double.parse(InvoiceModels[index].total_vat!))}',
                                                      //     textAlign: TextAlign.end,
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            '${index + 1}: ${InvoiceModels[index].cid}'),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            '${InvoiceModels[index].docno}'),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(DateFormat
                                                                .yMMMd('th_TH')
                                                            .format(DateTime.parse(
                                                                '${InvoiceModels[index].date} 00:00:00'))
                                                            .toString()),
                                                      ),
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '${nFormat.format(double.parse(InvoiceModels[index].total_wht!))}',
                                                      //     textAlign: TextAlign.end,
                                                      //   ),
                                                      // ),
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '${nFormat.format(double.parse(InvoiceModels[index].total_vat!))}',
                                                      //     textAlign: TextAlign.end,
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '${nFormat.format(((double.parse(InvoiceModels[index].total_bill!) - double.parse(InvoiceModels[index].total_dis!))))}',
                                                          // '${nFormat.format(double.parse(InvoiceModels[index].amt_expname!.split(',').reduce((a, b) => (double.parse(a.toString()) + double.parse(b.toString())).toString())) - double.parse(InvoiceModels[index].total_dis!) == 0.00 ? double.parse(InvoiceModels[index].amt_expname!.split(',').reduce((a, b) => (double.parse(a.toString()) + double.parse(b.toString())).toString())) : double.parse(InvoiceModels[index].amt_expname!.split(',').reduce((a, b) => (double.parse(a.toString()) + double.parse(b.toString())).toString())) - double.parse(InvoiceModels[index].total_dis!))}',
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          '${nFormat.format((double.parse(InvoiceModels[index].total_dis!) + double.parse(InvoiceModels[index].total_vat!)))}',
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // ignore: deprecated_member_use
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.35,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: () async {
                                          // if (_TransModels.length != 0) {
                                          //   in_Trans_invoice_all();
                                          // } else {
                                          //   ScaffoldMessenger.of(context)
                                          //       .showSnackBar(
                                          //     const SnackBar(
                                          //         content: Text(
                                          //             'กรุณาเลือก เดือน ปี ที่ต้องการวางบิล',
                                          //             style: TextStyle(
                                          //                 color: Colors.white,
                                          //                 fontFamily:
                                          //                     Font_.Fonts_T))),
                                          //   );
                                          // }
                                        },
                                        child: const Text(
                                          "รายละเอียด",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: Font_.Fonts_T,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              color: AppbackgroundColor.TiTile_Box,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'เลขที่สัญญา',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              AccountScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'เลขที่วางบิล',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              AccountScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'WHT',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color:
                                              AccountScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'VAT',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color:
                                              AccountScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'ยอด',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color:
                                              AccountScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'ส่วนลด',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color:
                                              AccountScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'ยอดรวม',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color:
                                              AccountScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            for (var index = 0;
                                                index < _TransModels.length;
                                                index++) {
                                              de_Trans_item_inv(index);
                                            }
                                          },
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.2,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (int index = 0;
                                        index < _TransModels.length;
                                        index++)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.green[100]!
                                            //     .withOpacity(0.5),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black12,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                        '${index + 1}.${_TransModels[index].refno}'),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '${_TransModels[index].docno}'),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${nFormat.format(double.parse(_TransModels[index].wht.toString()))}',
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${nFormat.format(double.parse(_TransModels[index].vat.toString()))}',
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${nFormat.format(double.parse(_TransModels[index].amt.toString()))}',
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${nFormat.format(double.parse(_TransModels[index].dis.toString()))}',
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${nFormat.format(double.parse(_TransModels[index].total.toString()))}',
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          de_Trans_item_inv(
                                                              index);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .remove_circle_outline,
                                                          color: Colors.red,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              if (_TransModels[index].fine !=
                                                  '0.00')
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        '',
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        '',
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '',
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '',
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        '',
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .subdirectory_arrow_right,
                                                            color: Colors.red,
                                                          ),
                                                          Text(
                                                            'ค่าปรับ',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        '${nFormat.format(double.parse(_TransModels[index].fine.toString()))}',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '',
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Column(
                                    //     children: [
                                    //       Row(
                                    //         children: [
                                    //           Expanded(
                                    //             flex: 2,
                                    //             child: Text(
                                    //                 '${index + 1}.${_TransModels[index].refno}'),
                                    //           ),
                                    //           Expanded(
                                    //             flex: 3,
                                    //             child: Text(
                                    //                 '${_TransModels[index].docno}'),
                                    //           ),
                                    //           Expanded(
                                    //             flex: 1,
                                    //             child: Text(
                                    //               '${nFormat.format(double.parse(_TransModels[index].wht.toString()))}',
                                    //               textAlign: TextAlign.end,
                                    //             ),
                                    //           ),
                                    //           Expanded(
                                    //             flex: 1,
                                    //             child: Text(
                                    //               '${nFormat.format(double.parse(_TransModels[index].vat.toString()))}',
                                    //               textAlign: TextAlign.end,
                                    //             ),
                                    //           ),
                                    //           Expanded(
                                    //             flex: 2,
                                    //             child: Text(
                                    //               '${nFormat.format(double.parse(_TransModels[index].amt.toString()))}',
                                    //               textAlign: TextAlign.end,
                                    //             ),
                                    //           ),
                                    //           Expanded(
                                    //             flex: 2,
                                    //             child: Text(
                                    //               '${nFormat.format(double.parse(_TransModels[index].dis.toString()))}',
                                    //               textAlign: TextAlign.end,
                                    //             ),
                                    //           ),
                                    //           Expanded(
                                    //             flex: 2,
                                    //             child: Text(
                                    //               '${nFormat.format(double.parse(_TransModels[index].total.toString()))}',
                                    //               textAlign: TextAlign.end,
                                    //             ),
                                    //           ),
                                    //           Expanded(
                                    //             flex: 1,
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   de_Trans_item_inv(index);
                                    //                 },
                                    //                 icon: Icon(
                                    //                   Icons.remove_circle_outline,
                                    //                   color: Colors.red,
                                    //                 )),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       if (_TransModels[index].fine != '0.00')
                                    //         Row(
                                    //           children: [
                                    //             Expanded(
                                    //               flex: 2,
                                    //               child: Text(
                                    //                 '',
                                    //                 textAlign: TextAlign.end,
                                    //               ),
                                    //             ),
                                    //             Expanded(
                                    //               flex: 3,
                                    //               child: Text(
                                    //                 '',
                                    //                 textAlign: TextAlign.end,
                                    //               ),
                                    //             ),
                                    //             Expanded(
                                    //               flex: 1,
                                    //               child: Text(
                                    //                 '',
                                    //                 textAlign: TextAlign.end,
                                    //               ),
                                    //             ),
                                    //             Expanded(
                                    //               flex: 1,
                                    //               child: Text(
                                    //                 '',
                                    //                 textAlign: TextAlign.end,
                                    //               ),
                                    //             ),
                                    //             Expanded(
                                    //               flex: 2,
                                    //               child: Text(
                                    //                 '',
                                    //                 textAlign: TextAlign.end,
                                    //               ),
                                    //             ),
                                    //             Expanded(
                                    //               flex: 2,
                                    //               child: Row(
                                    //                 mainAxisAlignment:
                                    //                     MainAxisAlignment.end,
                                    //                 children: [
                                    //                   Icon(
                                    //                     Icons
                                    //                         .subdirectory_arrow_right,
                                    //                     color: Colors.red,
                                    //                   ),
                                    //                   Text(
                                    //                     'ค่าปรับ',
                                    //                     style: TextStyle(
                                    //                         color: Colors.red),
                                    //                     textAlign: TextAlign.end,
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //             Expanded(
                                    //               flex: 2,
                                    //               child: Text(
                                    //                 '${nFormat.format(double.parse(_TransModels[index].fine.toString()))}',
                                    //                 style: TextStyle(
                                    //                     color: Colors.red),
                                    //                 textAlign: TextAlign.end,
                                    //               ),
                                    //             ),
                                    //             Expanded(
                                    //               flex: 1,
                                    //               child: Text(
                                    //                 '',
                                    //                 textAlign: TextAlign.end,
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            fine_total == 0.00
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            'ค่าธรรมเนียม ( บิล/บาท )',
                                            style: TextStyle(
                                                color: Colors.red,
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
                                            '${_TransModels.length} ( ${nFormat.format((fine_total))} ) / ${nFormat.format((fine_total * _TransModels.length))}',
                                            style: const TextStyle(
                                                color: Colors.red,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'ยอดรวม',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(''),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(''),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(''),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${nFormat.format(sum_amt + sum_fine + (fine_total * _TransModels.length))}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
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
                                    height: 50,
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red[50]!.withOpacity(0.5),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          // '${nFormat.format(sum_amt - sum_disamt)}',
                                          '${nFormat.format(sum_amt + sum_fine + (fine_total * _TransModels.length))}',
                                          textAlign: TextAlign.end,
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
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(0),
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
                                                (paymentName1 == null)
                                                    ? 'เลือก'
                                                    : '$paymentName1',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        PeopleChaoScreen_Color
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
                                          buttonHeight: 50,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          items:
                                              _PayMentModels
                                                  .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            onTap: () {
                                                              bname1 =
                                                                  item.bname;
                                                              var fine_amt = item
                                                                          .fine ==
                                                                      '1'
                                                                  ? item.fine_c ==
                                                                          '0.00'
                                                                      ? double.parse(double.parse(item
                                                                              .fine_a!)
                                                                          .toStringAsFixed(
                                                                              2)
                                                                          .toString())
                                                                      : double.parse((((sum_amt - sum_disamt - dis_sum_Pakan - dis_sum_Matjum) * double.parse(item.fine_c!)) /
                                                                              100)
                                                                          .toStringAsFixed(
                                                                              2)
                                                                          .toString())
                                                                  : fine_total;

                                                              setState(() {
                                                                fine_total =
                                                                    item.fine ==
                                                                            '1'
                                                                        ? fine_amt
                                                                        : 0.00;
                                                                // sum_amt = item.fine == '1'
                                                                //     ? sum_amt + fine_amt
                                                                //     : sum_amt - fine_amt;
                                                                newValuePDFimg_QR = (item.img ==
                                                                            null ||
                                                                        item.img.toString() ==
                                                                            '')
                                                                    ? '${MyConstant().domain}/Awaitdownload/imagenot.png'
                                                                    : '${MyConstant().domain}/files/$foder/payment/${item.img}';
                                                                selectedValue =
                                                                    item.bno!;
                                                              });
                                                              print(
                                                                  '**/*/*   --- ${selectedValue}');
                                                            },
                                                            value:
                                                                '${item.ser}:${item.ptname}',
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        '${item.ptname!}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            fontSize: 12,
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        '${item.bno!}',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            fontSize: 12,
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        (item.ptser.toString() ==
                                                                                '2')
                                                                            ? '( แบบแนบรูป QR เอง )'
                                                                            : (item.ptser.toString() == '5')
                                                                                ? '( ระบบ Gen PromptPay QR ให้ )'
                                                                                : (item.ptser.toString() == '6')
                                                                                    ? '( ระบบ Gen Standard QR [ref.1 , ref.2] ให้ )'
                                                                                    : '',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            fontSize: 9,
                                                                            color: Colors.grey,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        item.fine.toString() ==
                                                                                '0'
                                                                            ? ''
                                                                            : item.fine_c.toString() == '0.00'
                                                                                ? 'ค่าธรรมเนียม ${item.fine_a} บาท'
                                                                                : 'ค่าธรรมเนียม ${item.fine_c} %',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            fontSize: 9,
                                                                            color: Colors.red,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ],
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
                                              // pamentpage = 0;
                                              paymentName2 = null;

                                              paymentSer1 =
                                                  rtnameSer.toString();
                                              // Form_payment2.clear();

                                              if (rtnameSer.toString() == '0') {
                                                paymentName1 = null;
                                              } else {
                                                paymentName1 =
                                                    rtnameName.toString();
                                              }
                                              if (rtnameSer.toString() == '0') {
                                                // Form_payment1.clear();
                                              } else {
                                                // Form_payment1.text = (sum_amt -
                                                //         sum_disamt -
                                                //         dis_sum_Pakan -
                                                //         sum_tran_dis -
                                                //         dis_sum_Matjum)
                                                //     .toStringAsFixed(2)
                                                //     .toString();
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
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 35,
                                                    color: AppbackgroundColor
                                                        .Sub_Abg_Colors,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Center(
                                                      child: Text(
                                                        'วันที่ทำรายการ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
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
                                                  child: Container(
                                                      height: 35,
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Colors.green,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            DateTime? newDate =
                                                                await showDatePicker(
                                                              locale:
                                                                  const Locale(
                                                                      'th',
                                                                      'TH'),
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate: DateTime
                                                                      .now()
                                                                  .add(const Duration(
                                                                      days:
                                                                          -50)),
                                                              lastDate: DateTime
                                                                      .now()
                                                                  .add(const Duration(
                                                                      days:
                                                                          365)),
                                                              builder: (context,
                                                                  child) {
                                                                return Theme(
                                                                  data: Theme.of(
                                                                          context)
                                                                      .copyWith(
                                                                    colorScheme:
                                                                        const ColorScheme
                                                                            .light(
                                                                      primary:
                                                                          AppBarColors
                                                                              .ABar_Colors, // header background color
                                                                      onPrimary:
                                                                          Colors
                                                                              .white, // header text color
                                                                      onSurface:
                                                                          Colors
                                                                              .black, // body text color
                                                                    ),
                                                                    textButtonTheme:
                                                                        TextButtonThemeData(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            Colors.black, // button text color
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: child!,
                                                                );
                                                              },
                                                            );

                                                            if (newDate ==
                                                                null) {
                                                              return;
                                                            } else {
                                                              String start =
                                                                  DateFormat(
                                                                          'yyyy-MM-dd')
                                                                      .format(
                                                                          newDate);
                                                              String end = DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(
                                                                      newDate);

                                                              print(
                                                                  '$start $end');
                                                              setState(() {
                                                                Value_newDateY1 =
                                                                    start;
                                                                Value_newDateD1 =
                                                                    end;
                                                              });
                                                            }
                                                          },
                                                          child: AutoSizeText(
                                                            Value_newDateD1 ==
                                                                    ''
                                                                ? 'เลือกวันที่'
                                                                : '$Value_newDateD1',
                                                            minFontSize: 8,
                                                            maxFontSize: 16,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                    height: 35,
                                                    color: AppbackgroundColor
                                                        .Sub_Abg_Colors,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Center(
                                                      child: Text(
                                                        'วันที่ชำระ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
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
                                                  child: Container(
                                                      height: 35,
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Colors.green,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            DateTime? newDate =
                                                                await showDatePicker(
                                                              locale:
                                                                  const Locale(
                                                                      'th',
                                                                      'TH'),
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate: DateTime
                                                                      .now()
                                                                  .add(const Duration(
                                                                      days:
                                                                          -50)),
                                                              lastDate: DateTime
                                                                      .now()
                                                                  .add(const Duration(
                                                                      days:
                                                                          365)),
                                                              builder: (context,
                                                                  child) {
                                                                return Theme(
                                                                  data: Theme.of(
                                                                          context)
                                                                      .copyWith(
                                                                    colorScheme:
                                                                        const ColorScheme
                                                                            .light(
                                                                      primary:
                                                                          AppBarColors
                                                                              .ABar_Colors, // header background color
                                                                      onPrimary:
                                                                          Colors
                                                                              .white, // header text color
                                                                      onSurface:
                                                                          Colors
                                                                              .black, // body text color
                                                                    ),
                                                                    textButtonTheme:
                                                                        TextButtonThemeData(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            Colors.black, // button text color
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: child!,
                                                                );
                                                              },
                                                            );

                                                            if (newDate ==
                                                                null) {
                                                              return;
                                                            } else {
                                                              String start =
                                                                  DateFormat(
                                                                          'yyyy-MM-dd')
                                                                      .format(
                                                                          newDate);
                                                              String end = DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(
                                                                      newDate);

                                                              print(
                                                                  '$start $end');
                                                              setState(() {
                                                                Value_newDateY =
                                                                    start;
                                                                Value_newDateD =
                                                                    end;
                                                              });
                                                            }
                                                          },
                                                          child: AutoSizeText(
                                                            Value_newDateD == ''
                                                                ? 'เลือกวันที่'
                                                                : '$Value_newDateD',
                                                            minFontSize: 8,
                                                            maxFontSize: 14,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: () async {
                                          in_Trans_invoice_refno()
                                              .then((value) {
                                            setState(() {
                                              for (int index = 0;
                                                  index < _TransModels.length;
                                                  index++) {
                                                de_Trans_item_inv(index);
                                              }
                                              red_Trans_select2();
                                              red_InvoiceMon_bill();
                                            });
                                          });
                                        },
                                        child: const Text(
                                          "ยืนยันการชำระ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: Font_.Fonts_T,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
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
        ));
  }

  // List<String> rowdetail = [];

  // _importFromExcel() async {
  //   var file = "${MyConstant().domain}/IMG/report.xlsx";
  //   var bytes = File(file).readAsBytesSync();
  //   var excel = Excel.decodeBytes(bytes);

  //   for (var table in excel.tables.keys) {
  //     for (var row in excel.tables[table]!.rows) {
  //       print(row.toString());
  //       // rowdetail.add(row.toString());
  //     }
  //   }

  //   // print(rowdetail.map((e) => e.toString()));
  // }

  Future<Null> de_Trans_item_inv(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    var tser = _TransModels[index].ser;

    print('tser >>.> $tser');

    String url =
        '${MyConstant().domain}/De_tran_ser_inv.php?isAdd=true&ren=$ren&tser=$tser&user=$user';
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

  Future<Null> in_Trans_invoice_refno() async {
    // for (int index = 0; index < _TransModels.length; index++) {
    String? fileName_Slip_ = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = cidSelect; //_TransModels[index].refno;
    var qutser = '1';
    var sumdis =
        sum_tran_dis; // double.parse(_TransModels[index].dis.toString()).toString();
    var sumdisp = '0.00';
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = DateFormat('HH:mm:ss').format(newDatetime).toString();
    //pamentpage == 0
    var dis_akan = '0.00';
    var dis_Matjum = '0.00';
    var payment1 = (sum_amt +
        sum_fine +
        (fine_total *
            _TransModels
                .length)); // (double.parse(_TransModels[index].total.toString()) + double.parse(_TransModels[index].fine.toString())).toString();
    var payment2 = 0.toString();
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var ref = ''; //_TransModels[index].docno;
    var sum_whta =
        sum_wht; // double.parse(_TransModels[index].wht.toString()).toString();
    var bill = 'P';
    var comment = '';
    // var sum_fine =
    //     double.parse(_TransModels[index].fine.toString()).toString();
    var fine_total_amt = fine_total;
    // print('in_Trans_invoice_refno()///$fileName_Slip_');
    // print('in_Trans_invoice_refno >>> $payment1  $payment2  $bill ');
//In_tran_financet1 //In_tran_finanref1
    String url =
        '${MyConstant().domain}/In_tran_INV_all.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_&comment=$comment&dis_Pakan=$dis_akan&dis_Matjum=$dis_Matjum&sum_fine=$sum_fine&fine_total_amt=$fine_total_amt';
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

            doctax = cFinnancetransModel.doctax;
          });
          print('zzzzasaaa123454>>>>  $cFinn');
          print(
              'in_Trans_invoice_refno bno123454>>>>  ${cFinnancetransModel.bno}//// ${cFinnancetransModel.doctax}');
        }

        // Insert_log.Insert_logs(
        //     'บัญชี',
        //     (Slip_status.toString() == '1')
        //         ? 'รับชำระ:$numinvoice '
        //         : 'รับชำระ:$cFinn ');
        // (Default_Receipt_type == 1)
        //     ? Show_Dialog()
        //     : Receipt_Tempage_Pay(tableData00, newValuePDFimg);

        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
    // }
  }
}
