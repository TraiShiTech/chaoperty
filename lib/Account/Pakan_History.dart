import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Man_PDF/Man_Pay_Pakan.dart';
import '../Man_PDF/Man_Pay_Receipt_PDF.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetInvoiceRe_Model.dart';
import '../Model/GetPakan_Contractx_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTrans_Kon_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class PakanHistory extends StatefulWidget {
  const PakanHistory({super.key});

  @override
  State<PakanHistory> createState() => _PakanHistoryState();
}

class _PakanHistoryState extends State<PakanHistory> {
  //-------------------------------------->
  int limit = 50; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  //-------------------------------------->
  int limit_Pay = 50;
  int offset_Pay = 0;
  int endIndex_Pay = 0;

  //-------------------------------------->
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("###0.00", "en_US");
  TextEditingController Text_searchBar_main1 = TextEditingController();
  TextEditingController Text_searchBar_main2 = TextEditingController();
  //-------------------------------------->
  TextEditingController Text_searchBar1 = TextEditingController();
  TextEditingController Text_searchBar2 = TextEditingController();

  DateTime datex = DateTime.now();
  int? show_more;
  String tappedIndex_ = '';
  String? ser_payby, numdoctax;
  int Ser_Tap = 0;
  int Status_ = 1;
  int Date_ser = 0;
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0,
      dis_sum_Matjum = 0.00,
      sum_duesbill = 0.00;
  //-------------------------------------->
  List<RenTalModel> renTalModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<FinnancetransModel> finnancetransModels = [];
  //-------------------------------------->
  List<ContractxPakanModel> limitedList_contractxPakanModels = [];
  List<ContractxPakanModel> contractxPakanModels = [];
  List<ContractxPakanModel> _contractxPakanModels = <ContractxPakanModel>[];

  List<TransKonModel> limitedList_transKonModels = [];
  List<TransKonModel> transKonModels = [];
  List<TransKonModel> _transKonModels = <TransKonModel>[];
  //-------------------------------------->
  List<String> monthsInThai = [
    'มกราคม', // January
    'กุมภาพันธ์', // February
    'มีนาคม', // March
    'เมษายน', // April
    'พฤษภาคม', // May
    'มิถุนายน', // June
    'กรกฎาคม', // July
    'สิงหาคม', // August
    'กันยายน', // September
    'ตุลาคม', // October
    'พฤศจิกายน', // November
    'ธันวาคม', // December
  ];

  ///------------------------>
  List<String> YE_Th = [];
  String? base64_Slip, fileName_Slip, Slip_history, pdate;
  String? MONTH_Now, YEAR_Now;
  ///////////--------------------------------------------->
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
      newValuePDFimg_QR;
  ///////////--------------------------------------------->
  String? numinvoice;
  int TitleType_Default_Receipt = 0;
  String _ReportValue_type = "ไม่ระบุ";
  List TitleType_Default_Receipt_ = [
    'ไม่ระบุ',
    'ต้นฉบับ',
    'สำเนา',
  ];
  String? base64_Imgmap, tem_page_ser;

  ///----------------->
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();

  ///----------------->
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
    read_GC_rental();
  }

  ///////////--------------------------------------------->
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
    tenant_Pakan();
  }

  ///////////--------------------------------------------->
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
      // print('Error-Dis(read_GC_rental) : ${e}');
    }
    // print('name>>>>>  $renname');
  }

  ////////-------------------------------------------------------->(รับเงินประกัน)
  Future<Null> tenant_Pakan() async {
    if (limitedList_contractxPakanModels.isNotEmpty) {
      limitedList_contractxPakanModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');
    String url = (zone == null || zone == '0')
        ? '${MyConstant().domain}/GC_PakanAll.php?isAdd=true&ren=$ren&zser=0'
        : '${MyConstant().domain}/GC_PakanAll.php?isAdd=true&ren=$ren&zser=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ContractxPakanModel contractxPakanModelss =
              ContractxPakanModel.fromJson(map);

          setState(() {
            limitedList_contractxPakanModels.add(contractxPakanModelss);
          });
        }
        setState(() {
          _contractxPakanModels = limitedList_contractxPakanModels;
        });
        read_TransComePakan_limit();
      } else {}
    } catch (e) {}
  }

////////////------------------------------------------>(คืนเงินประกัน)
  Future<Null> red_Trans_Kon() async {
    if (limitedList_transKonModels.isNotEmpty) {
      setState(() {
        limitedList_transKonModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');
    String url = (zone == null || zone == '0')
        ? '${MyConstant().domain}/GC_tran_Kon_pakanAll.php?isAdd=true&ren=$ren&zser_zone=0'
        : '${MyConstant().domain}/GC_tran_Kon_pakanAll.php?isAdd=true&ren=$ren&zser_zone=$zone';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransKonModel transKonModel = TransKonModel.fromJson(map);
          var sum_amtx = double.parse(transKonModel.total!);
          setState(() {
            // sum_Kon = sum_Kon + sum_amtx;
            // bot = 1;
            limitedList_transKonModels.add(transKonModel);
          });
        }
        setState(() {
          _transKonModels = limitedList_transKonModels;
        });
        read_TransPayPakan_limit();
      }
    } catch (e) {}
  }

  ////////--------------------------------------------------------------->
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
    var ciddoc = transKonModels[index].ser;
    var qutser = transKonModels[index].ser_in;
    var docnoin = transKonModels[index].docno;
    String url =
        '${MyConstant().domain}/GC_bill_pay_PakanHistory.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel _TransReBillHistoryModel =
              TransReBillHistoryModel.fromJson(map);
          var dtypeinvoiceent = _TransReBillHistoryModel.dtype;
          var numinvoiceent = _TransReBillHistoryModel.docno;
          // var sumPvatx = double.parse(_TransReBillHistoryModel.pvat!);
          // var sumVatx = double.parse(_TransReBillHistoryModel.vat!);
          // var sumWhtx = double.parse(_TransReBillHistoryModel.wht!);
          // var sumAmtx = double.parse(_TransReBillHistoryModel.total!);

          var sum_pvatx = _TransReBillHistoryModel.pvat != null
              ? double.parse(_TransReBillHistoryModel.pvat!)
              : 0.0;
          var sum_vatx = _TransReBillHistoryModel.vat != null
              ? double.parse(_TransReBillHistoryModel.vat!)
              : 0.0;
          var sum_whtx = _TransReBillHistoryModel.wht != null
              ? double.parse(_TransReBillHistoryModel.wht!)
              : 0.0;
          var sum_amtx = _TransReBillHistoryModel.total != null
              ? double.parse(_TransReBillHistoryModel.total!)
              : 0.0;

          setState(() {
            numinvoice = _TransReBillHistoryModel.docno;
            numdoctax = _TransReBillHistoryModel.doctax;
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          });
        }
      }
      // setState(() {
      //   red_Invoice(index);
      // });
    } catch (e) {}
  }

  Future<Null> red_Finnan(index) async {
    if (finnancetransModels.length != 0) {
      setState(() {
        finnancetransModels.clear();
        sum_disamt = 0;
        sum_disp = 0;
        dis_sum_Matjum = 0.00;
        sum_duesbill = 0.00;
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = transKonModels[index].ser;
    var qutser = transKonModels[index].ser_in;
    var docnoin = transKonModels[index].docno; //.toString().trim()
    // print('>>>>>>>>>>>dd>>> in d  $docnoin');

    String url =
        '${MyConstant().domain}/GC_bill_pay_amtPakan.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      // print('BBBBBBBBBBBBBBBB>>>> $result');
      if (result.toString() != 'null') {
        for (var map in result) {
          FinnancetransModel finnancetransModel =
              FinnancetransModel.fromJson(map);

          var sidamt = double.parse(finnancetransModel.amt!);
          var siddisper = double.parse(finnancetransModel.disper!);
          var pdatex = finnancetransModel.pdate;

          setState(() {
            Slip_history = finnancetransModel.slip.toString();
            pdate = pdatex;
            if (int.parse(finnancetransModel.receiptSer!) != 0) {
              finnancetransModels.add(finnancetransModel);
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

          if (finnancetransModel.dtype! == 'FTA') {
            setState(() {
              sum_duesbill = double.parse(finnancetransModel.amt!);
            });
          }
          // print(
          //     '>>>>> ${finnancetransModel.slip}>>>>>>dd>>> in $sidamt $siddisper  ');
        }
      }
    } catch (e) {}
  }

  ////////--------------------------------------------------------------->
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

  ////////--------------------------------------------------------------->
  Future<Null> read_TransComePakan_limit() async {
    setState(() {
      endIndex = offset + limit;
      contractxPakanModels = limitedList_contractxPakanModels.sublist(
          offset, // Start index
          (endIndex <= limitedList_contractxPakanModels.length)
              ? endIndex
              : limitedList_contractxPakanModels.length // End index
          );
    });
  }

  Future<Null> read_TransPayPakan_limit() async {
    setState(() {
      endIndex_Pay = offset_Pay + limit_Pay;
      transKonModels = limitedList_transKonModels.sublist(
          offset_Pay, // Start index
          (endIndex_Pay <= limitedList_transKonModels.length)
              ? endIndex_Pay
              : limitedList_transKonModels.length // End index
          );
    });
  }

  ////////--------------------------------------------------------------->
  Widget Next_page_ComePakan() {
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
                    Icon(
                      Icons.menu_book,
                      color: Colors.grey,
                      size: 20,
                    ),
                    InkWell(
                        onTap: (offset == 0)
                            ? null
                            : () async {
                                if (offset == 0) {
                                } else {
                                  setState(() {
                                    offset = offset - limit;
                                    read_TransComePakan_limit();
                                  });
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
                        // '*//$endIndex /${limitedList_TransReBillModels_.length} ///${(endIndex / limit)}/${(limitedList_TransReBillModels_.length / limit).ceil()}',
                        '${(endIndex / limit)}/${(limitedList_contractxPakanModels.length / limit).ceil()}',

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
                        onTap: ((endIndex / limit) ==
                                (limitedList_contractxPakanModels.length /
                                        limit)
                                    .ceil())
                            ? null
                            : () async {
                                setState(() {
                                  offset = offset + limit;
                                  read_TransComePakan_limit();
                                });
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: ((endIndex / limit) ==
                                  (limitedList_contractxPakanModels.length /
                                          limit)
                                      .ceil())
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

  Widget Next_page_PayPakan() {
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
                    Icon(
                      Icons.menu_book,
                      color: Colors.grey,
                      size: 20,
                    ),
                    InkWell(
                        onTap: (offset_Pay == 0)
                            ? null
                            : () async {
                                if (offset_Pay == 0) {
                                } else {
                                  setState(() {
                                    offset_Pay = offset_Pay - limit_Pay;
                                    read_TransPayPakan_limit();
                                  });
                                }
                              },
                        child: Icon(
                          Icons.arrow_left,
                          color: (offset_Pay == 0)
                              ? Colors.grey[200]
                              : Colors.black,
                          size: 25,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        // '*//$endIndex /${limitedList_TransReBillModels_.length} ///${(endIndex / limit)}/${(limitedList_TransReBillModels_.length / limit).ceil()}',
                        '${(endIndex_Pay / limit_Pay)}/${(limitedList_transKonModels.length / limit_Pay).ceil()}',

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
                        onTap: ((endIndex_Pay / limit_Pay) ==
                                (limitedList_transKonModels.length / limit_Pay)
                                    .ceil())
                            ? null
                            : () async {
                                setState(() {
                                  offset_Pay = offset_Pay + limit_Pay;
                                  read_TransPayPakan_limit();
                                });
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: ((endIndex_Pay / limit_Pay) ==
                                  (limitedList_transKonModels.length /
                                          limit_Pay)
                                      .ceil())
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

  ////////--------------------------------------------------------------->
  _searchBarMain1() {
    return TextField(
      textAlign: TextAlign.start,
      controller: Text_searchBar_main1,
      autofocus: false,
      cursorHeight: 20,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: PeopleChaoScreen_Color.Colors_Text2_,
          fontFamily: Font_.Fonts_T),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100]!.withOpacity(0.5),
        hintText: ' Search...',
        hintStyle: const TextStyle(
            // fontSize: 12,
            color: PeopleChaoScreen_Color.Colors_Text2_,
            fontFamily: Font_.Fonts_T),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (text) {
        setState(() {
          contractxPakanModels =
              _contractxPakanModels.where((contractxPakanModel) {
                   var notTitle = contractxPakanModel.cid.toString();
            var notTitle2 = contractxPakanModel.cname.toString();
            var notTitle3 = contractxPakanModel.zn.toString();

            var notTitle4 = contractxPakanModel.sname.toString();
            var notTitle5 = contractxPakanModel.unit.toString();
            var notTitle6 =
                contractxPakanModel.expname.toString();
            // var notTitle = contractxPakanModel.cid.toString().toLowerCase();
            // var notTitle2 = contractxPakanModel.cname.toString().toLowerCase();
            // var notTitle3 = contractxPakanModel.zn.toString().toLowerCase();

            // var notTitle4 = contractxPakanModel.sname.toString().toLowerCase();
            // var notTitle5 = contractxPakanModel.unit.toString().toLowerCase();
            // var notTitle6 =
            //     contractxPakanModel.expname.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text) ||
                notTitle6.contains(text);
          }).toList();
        });
        if (text.isEmpty) {
          read_TransComePakan_limit();
        } else {}
      },
    );
  }

  _searchBarMain2() {
    return TextField(
      textAlign: TextAlign.start,
      controller: Text_searchBar_main2,
      autofocus: false,
      cursorHeight: 20,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: PeopleChaoScreen_Color.Colors_Text2_,
          fontFamily: Font_.Fonts_T),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100]!.withOpacity(0.5),
        hintText: ' Search...',
        hintStyle: const TextStyle(
            // fontSize: 12,
            color: PeopleChaoScreen_Color.Colors_Text2_,
            fontFamily: Font_.Fonts_T),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (text) {
        setState(() {
          transKonModels = _transKonModels.where((transKonModel) {
                        var notTitle = transKonModel.cid.toString();
            var notTitle2 = transKonModel.cname.toString();
            var notTitle3 = transKonModel.zn.toString();

            var notTitle4 = transKonModel.pdate.toString();
            var notTitle5 = transKonModel.type.toString();
            var notTitle6 = transKonModel.docno.toString();
            // var notTitle = transKonModel.cid.toString().toLowerCase();
            // var notTitle2 = transKonModel.cname.toString().toLowerCase();
            // var notTitle3 = transKonModel.zn.toString().toLowerCase();

            // var notTitle4 = transKonModel.pdate.toString().toLowerCase();
            // var notTitle5 = transKonModel.type.toString().toLowerCase();
            // var notTitle6 = transKonModel.docno.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text) ||
                notTitle6.contains(text);
          }).toList();
        });
        if (text.isEmpty) {
          read_TransPayPakan_limit();
        } else {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(23, 8, 8, 0),
          child: Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              //   child: InkWell(
              //     onTap: () {
              //       setState(() {
              //         Ser_Tap = 0;
              //         tappedIndex_ = '';
              //       });
              //     },
              //     child: Container(
              //       // width: 100, Verifi_Billing_Screen
              //       decoration: BoxDecoration(
              //         color:
              //             (Ser_Tap == 0) ? Colors.pink[600] : Colors.pink[200],
              //         borderRadius: const BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             topRight: Radius.circular(10),
              //             bottomLeft: Radius.circular(0),
              //             bottomRight: Radius.circular(0)),
              //         border: Border.all(color: Colors.white, width: 1),
              //       ),
              //       padding: const EdgeInsets.all(6.0),
              //       child: Text(
              //         "ประวัติยกเลิกชำระ",
              //         style: TextStyle(
              //           color: (Ser_Tap == 0) ? Colors.white : Colors.black,
              //           fontFamily: FontWeight_.Fonts_T,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Ser_Tap = 0;
                      tappedIndex_ = '';
                    });
                    tenant_Pakan();
                  },
                  child: Container(
                    // width: 130,
                    decoration: BoxDecoration(
                      color:
                          (Ser_Tap == 0) ? Colors.lime[600] : Colors.lime[200],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "ประวัติรับเงินประกันผู้เช่า",
                      style: TextStyle(
                        color: (Ser_Tap == 0) ? Colors.white : Colors.black,
                        fontFamily: FontWeight_.Fonts_T,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Ser_Tap = 1;
                      tappedIndex_ = '';
                    });
                    red_Trans_Kon();
                  },
                  child: Container(
                    // width: 130,
                    decoration: BoxDecoration(
                      color:
                          (Ser_Tap == 1) ? Colors.lime[600] : Colors.lime[200],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "ประวัติคืนเงินประกันผู้เช่า",
                      style: TextStyle(
                        color: (Ser_Tap == 1) ? Colors.white : Colors.black,
                        fontFamily: FontWeight_.Fonts_T,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        (Ser_Tap == 1) ? bill_Pay_Pakan() : bill_Come_Pakan()
      ],
    );
  }

  Widget bill_Come_Pakan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                        decoration:  BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: Text(
                                                      'ค้นหา :',
                                                      style: TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text2_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    // flex: 1,
                                                    child: Container(
                                                      height: 35, //Date_ser
                                                      // width: 150,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      child: _searchBarMain1(),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: 150,
                                                      child:
                                                          Next_page_ComePakan())
                                                  // Expanded(
                                                  //     child:
                                                  //         Next_page_billCancel())
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'เลขที่ใบเสร็จ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'เลขที่สัญญา',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'โซน',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'ชื่อผู้ติดต่อ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'ชื่อร้านค้า',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'เลขตั้งหนี้',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'รายการ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'ยอดสุทธิ',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.63,
                                          width:
                                              Responsive.isDesktop(context)
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
                                          child: contractxPakanModels.isEmpty
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
                                                      _scrollController1,
                                                  // itemExtent: 50,
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      contractxPakanModels
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Column(
                                                      children: [
                                                        Material(
                                                          color: tappedIndex_ ==
                                                                  index
                                                                      .toString()
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
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    tappedIndex_ =
                                                                        index
                                                                            .toString();
                                                                    // red_Trans_select(
                                                                    //     index);
                                                                    // red_Invoice(
                                                                    //     index);
                                                                  });

                                                                  // print(
                                                                  //     'objecnort ${_TransReBillModels[index].docno}');
                                                                  // // String Url =
                                                                  // //     await '${MyConstant().domain}/files/$foder/slip/${Slip_history}';
                                                                  // Future.delayed(
                                                                  //     const Duration(
                                                                  //         milliseconds:
                                                                  //             300),
                                                                  //     () async {
                                                                  //   checkshowDialog(
                                                                  //       index);
                                                                  // });
                                                                },
                                                                title:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    // color: Colors.green[100]!
                                                                    //     .withOpacity(0.5),
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${contractxPakanModels[index].docno}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[200],
                                                                            ),
                                                                            child:
                                                                                AutoSizeText(
                                                                              minFontSize: 10,
                                                                              maxFontSize: 25,
                                                                              maxLines: 1,
                                                                              '${contractxPakanModels[index].docno}',
                                                                              textAlign: TextAlign.start,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  //fontWeight: FontWeight.bold,
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
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: '${contractxPakanModels[index].cid}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[200],
                                                                            ),
                                                                            child:
                                                                                AutoSizeText(
                                                                              minFontSize: 10,
                                                                              maxFontSize: 25,
                                                                              maxLines: 1,
                                                                              '${contractxPakanModels[index].cid}',
                                                                              textAlign: TextAlign.start,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  //fontWeight: FontWeight.bold,
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
                                                                              TextSpan(
                                                                            text: (contractxPakanModels[index].zn != null)
                                                                                ? '${contractxPakanModels[index].zn}'
                                                                                : '${contractxPakanModels[index].zn1}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: HomeScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                              //fontSize: 10.0
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.grey[200],
                                                                          ),
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                2,
                                                                            (contractxPakanModels[index].zn != null)
                                                                                ? '${contractxPakanModels[index].zn}'
                                                                                : '${contractxPakanModels[index].zn1}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            (contractxPakanModels[index].cname == null)
                                                                                ? '${contractxPakanModels[index].remark}'
                                                                                : '${contractxPakanModels[index].cname}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Tooltip(
                                                                            richMessage:
                                                                                TextSpan(
                                                                              text: (contractxPakanModels[index].sname == null) ? '${contractxPakanModels[index].remark}' : '${contractxPakanModels[index].sname}',
                                                                              style: const TextStyle(
                                                                                color: HomeScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                //fontSize: 10.0
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey[200],
                                                                            ),
                                                                            child:
                                                                                AutoSizeText(
                                                                              minFontSize: 10,
                                                                              maxFontSize: 25,
                                                                              maxLines: 1,
                                                                              (contractxPakanModels[index].sname == null) ? '${contractxPakanModels[index].remark}' : '${contractxPakanModels[index].sname}',
                                                                              textAlign: TextAlign.start,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  //fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            AutoSizeText(
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              25,
                                                                          maxLines:
                                                                              1,
                                                                          '${contractxPakanModels[index].refno}',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              //fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                25,
                                                                            maxLines:
                                                                                1,
                                                                            '${contractxPakanModels[index].expname}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            AutoSizeText(
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              25,
                                                                          maxLines:
                                                                              1,
                                                                          nFormat
                                                                              .format(double.parse('${contractxPakanModels[index].total}'))
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              //fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ),
                                                        ),
                                                        if (index + 1 ==
                                                                contractxPakanModels
                                                                    .length &&
                                                            contractxPakanModels
                                                                    .length !=
                                                                0)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '<<- End ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: tappedIndex_Color
                                                                          .End_Colors,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // color: Colors
                                                                      //     .orange,
                                                                      border: Border.all(
                                                                          color: tappedIndex_Color
                                                                              .End_Colors,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    height: 1,
                                                                  ),
                                                                ),
                                                                AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  ' End ->>',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: tappedIndex_Color
                                                                          .End_Colors,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                      ],
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
                                            _scrollController1.animateTo(
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
                                          if (_scrollController1.hasClients) {
                                            final position = _scrollController1
                                                .position.maxScrollExtent;
                                            _scrollController1.animateTo(
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
                                        onTap: _moveUp1,
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
                                        onTap: _moveDown1,
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

//////////////--------------------------------------->
  Widget bill_Pay_Pakan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                        decoration:  BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: Text(
                                                      'ค้นหา :',
                                                      style: TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text2_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    // flex: 1,
                                                    child: Container(
                                                      height: 35, //Date_ser
                                                      // width: 150,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      child: _searchBarMain2(),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: 150,
                                                      child:
                                                          Next_page_PayPakan())
                                                  // Expanded(
                                                  //     child:
                                                  //         Next_page_billCancel())
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'เลขที่ใบเสร็จ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'วันที่',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'โซน',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'รหัสพื้นที่',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'เลขที่สัญญา',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'ชื่อผู้ติดต่อ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'ชื่อร้านค้า',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'รูปแบบชำระ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    'ยอดคืนสุทธิ',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 80,
                                                  child: const Text(
                                                    '...',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontSize: 14.0
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.63,
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
                                          child: transKonModels.isEmpty
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
                                                      transKonModels.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Column(
                                                      children: [
                                                        Material(
                                                          color: tappedIndex_ ==
                                                                  index
                                                                      .toString()
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
                                                                title:
                                                                    Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                // color: Colors.green[100]!
                                                                //     .withOpacity(0.5),
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text:
                                                                            '${transKonModels[index].docno}',
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
                                                                        '${transKonModels[index].docno}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      '${DateFormat('dd-MM').format(DateTime.parse('${transKonModels[index].pdate} 00:00:00'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${transKonModels[index].pdate} 00:00:00'))}') + 543}',
                                                                      // '${transKonModels[index].pdate}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          //fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text: (transKonModels[index].zn ==
                                                                                null)
                                                                            ? '${transKonModels[index].zn1}'
                                                                            : '${transKonModels[index].zn}',
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
                                                                            2,
                                                                        (transKonModels[index].zn !=
                                                                                null)
                                                                            ? '${transKonModels[index].zn}'
                                                                            : '${transKonModels[index].zn1}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text:
                                                                            '${transKonModels[index].ln}',
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
                                                                            2,
                                                                        '${transKonModels[index].ln}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text:
                                                                            '${transKonModels[index].cid}',
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
                                                                            2,
                                                                        '${transKonModels[index].cid}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text:
                                                                            '${transKonModels[index].cname}',
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
                                                                        '${transKonModels[index].cname}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text:
                                                                            '${transKonModels[index].sname}',
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
                                                                        '${transKonModels[index].sname}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text:
                                                                            '${transKonModels[index].type}',
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
                                                                        '${transKonModels[index].type}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      nFormat
                                                                          .format(
                                                                              double.parse('${transKonModels[index].total}'))
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          //fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            8,
                                                                            2,
                                                                            8,
                                                                            2),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          numinvoice =
                                                                              transKonModels[index].docno!;
                                                                          tappedIndex_ =
                                                                              index.toString();
                                                                          red_Trans_select(
                                                                              index);
                                                                          red_Finnan(
                                                                              index);
                                                                        });

                                                                        Future.delayed(
                                                                            const Duration(milliseconds: 300),
                                                                            () async {
                                                                          checkshowDialog(
                                                                              index);
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            80,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.lime,
                                                                          borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                        ),
                                                                        padding:
                                                                            const EdgeInsets.all(2.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              25,
                                                                          maxLines:
                                                                              1,
                                                                          'เรียกดู',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              //fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                          ),
                                                        ),
                                                        if (index + 1 ==
                                                                transKonModels
                                                                    .length &&
                                                            transKonModels
                                                                    .length !=
                                                                0)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '<<- End ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: tappedIndex_Color
                                                                          .End_Colors,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // color: Colors
                                                                      //     .orange,
                                                                      border: Border.all(
                                                                          color: tappedIndex_Color
                                                                              .End_Colors,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    height: 1,
                                                                  ),
                                                                ),
                                                                AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  ' End ->>',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: tappedIndex_Color
                                                                          .End_Colors,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                      ],
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
                backgroundColor: AppbackgroundColor.Sub_Abg_Colors,
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(10.0),
                actionsPadding: const EdgeInsets.all(6.0),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.highlight_off,
                            size: 30, color: Colors.red[700]),
                      ),
                    ),
                  ],
                ),
                content: Padding(
                  padding: const EdgeInsets.all(0.0),
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
                                        height: 30,
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
                                          child: AutoSizeText(
                                            minFontSize: 8,
                                            maxFontSize: 14,
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
                                        height: 30,
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
                                        padding: const EdgeInsets.all(4.0),
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
                                            child: AutoSizeText(
                                              minFontSize: 8,
                                              maxFontSize: 12,
                                              (transKonModels[index].docno ==
                                                          '' ||
                                                      transKonModels[index]
                                                              .docno ==
                                                          null)
                                                  ? 'บิลเลขที่ ${transKonModels[index].doctax}'
                                                  : 'บิลเลขที่ ${transKonModels[index].docno}',
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
                                Container(
                                  color: Colors.brown[200],
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'วันที่ชำระ',
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'กำหนดชำระ',
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
                                      Expanded(
                                        flex: 2,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'เลขตั้งหนี้',
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
                                      Expanded(
                                        flex: 2,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'รายการ',
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'VAT(฿)',
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'WHT(฿)',
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
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
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    // height:
                                    //     MediaQuery.of(context).size.height / 4.8,
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${index + 1}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransReBillHistoryModels[index].dateacc} 00:00:00'))}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        // '${_TransReBillHistoryModels[index].duedate}',
                                                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransReBillHistoryModels[index].date} 00:00:00'))}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].refno}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].expname}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].vat}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].wht}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
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
                                          width: 300,
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
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(4.0),
                                          child: StreamBuilder(
                                              stream: Stream.periodic(
                                                  const Duration(seconds: 0)),
                                              builder: (context, snapshot) {
                                                return Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        (pdate == null)
                                                            ? 'วันที่ชำระ : $pdate'
                                                            : 'วันที่ชำระ : ${DateFormat('dd-MM').format(DateTime.parse('$pdate 00:00:00'))}-${DateTime.parse('$pdate 00:00:00').year + 543}',
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
                                                      child: const AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 13,
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
                                                      if (finnancetransModels[i]
                                                              .dtype
                                                              .toString() !=
                                                          'FTA')
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AutoSizeText(
                                                                minFontSize: 8,
                                                                maxFontSize: 13,
                                                                '${i + 1}. จำนวน ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท (${finnancetransModels[i].ptname})',
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                              ),
                                                              if (finnancetransModels[
                                                                          i]
                                                                      .type
                                                                      .toString() !=
                                                                  'CASH')
                                                                AutoSizeText(
                                                                  minFontSize:
                                                                      8,
                                                                  maxFontSize:
                                                                      11,
                                                                  '  ** ${i + 1}.1. ธนาคาร : ${finnancetransModels[i].bank} , เลขบช. : ${finnancetransModels[i].bno}',
                                                                  style: TextStyle(
                                                                      color: Colors.grey[800],
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                    // (finnancetransModels[i]
                                                    //             .dtype
                                                    //             .toString() ==
                                                    //         'KP')
                                                    //     ? Align(
                                                    //         alignment:
                                                    //             Alignment
                                                    //                 .topLeft,
                                                    //         child:
                                                    //             AutoSizeText(
                                                    //           minFontSize:
                                                    //               8,
                                                    //           maxFontSize:
                                                    //               13,
                                                    //           (finnancetransModels[i]
                                                    //                       .type
                                                    //                       .toString() ==
                                                    //                   'CASH')
                                                    //               ? '${i + 1}.เงินสด : ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท'
                                                    //               : '${i + 1}.เงินโอน : ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท',
                                                    //           style: const TextStyle(
                                                    //               color: PeopleChaoScreen_Color.Colors_Text2_,
                                                    //               //fontWeight: FontWeight.bold,
                                                    //               fontFamily: Font_.Fonts_T),
                                                    //         ),
                                                    //       )
                                                    //     : Align(
                                                    //         alignment:
                                                    //             Alignment
                                                    //                 .topLeft,
                                                    //         child:
                                                    //             AutoSizeText(
                                                    //           minFontSize:
                                                    //               8,
                                                    //           maxFontSize:
                                                    //               13,
                                                    //           '${i + 1}.${finnancetransModels[i].remark} : ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท',
                                                    //           style: const TextStyle(
                                                    //               color: PeopleChaoScreen_Color.Colors_Text2_,
                                                    //               //fontWeight: FontWeight.bold,
                                                    //               fontFamily: Font_.Fonts_T),
                                                    //         ),
                                                    //       ),
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'รวมราคาสินค้า/Sub Total',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,

                                                          // '${sum_pvat} // $dis_sum_Matjum',

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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'ภาษีมูลค่าเพิ่ม/Vat',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'ค่าทำเนียม',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_duesbill)}',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,
                                                          // '${sum_amt} // $dis_sum_Matjum ',

                                                          '${nFormat.format(sum_amt + sum_duesbill)}',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'ส่วนลด/Discount $sum_disp %',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                  if (nFormat
                                                          .format(
                                                              dis_sum_Matjum)
                                                          .toString() !=
                                                      '0.00')
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 11,
                                                            'เงินมัดจำ(ตัดมัดจำ)',
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
                                                        Expanded(
                                                          // flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 11,
                                                            '${nFormat.format(dis_sum_Matjum)}',
                                                            textAlign:
                                                                TextAlign.end,
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
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,
                                                          //  '${sum_amt - sum_disamt} // $dis_sum_Matjum',

                                                          '${nFormat.format(((sum_amt - sum_disamt) - dis_sum_Matjum) + sum_duesbill)}',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'ยอดสุทธิ',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,
                                                          //  '${sum_amt - sum_disamt} // $dis_sum_Matjum',

                                                          '${nFormat.format((sum_amt - sum_disamt) + sum_duesbill)}',
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
                    children: [
                      const SizedBox(
                        height: 2.0,
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 2.0,
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 0)),
                          builder: (context, snapshot) {
                            return ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              }),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width * 0.85
                                      : 1200,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: 200,
                                        child: InkWell(
                                          onTap: () {
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

                                            String sname = transKonModels[index]
                                                        .sname ==
                                                    null
                                                ? '${transKonModels[index].remark}'
                                                : '${transKonModels[index].sname}';
                                            String cname =
                                                '${transKonModels[index].cname}';
                                            String addr =
                                                '${transKonModels[index].addr}';
                                            String tax =
                                                '${transKonModels[index].tax}';
                                            String room_number_BillHistory =
                                                '${transKonModels[index].room_number}';
                                            // print(
                                            //     'room_number ------> ${transKonModels[index].room_number}');

                                            _showMyDialog_SAVE(
                                                tableData00,
                                                newValuePDFimg,
                                                sname,
                                                cname,
                                                addr,
                                                tax,
                                                room_number_BillHistory);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
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
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(Icons.print,
                                                        color: Colors.white),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Text(
                                                      'พิมพ์',
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
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ));
  }

  ////////////------------------------------------------------------>(Export file)
  Future<void> _showMyDialog_SAVE(tableData00, newValuePDFimg, sname, cname,
      addr, tax, room_number_BillHistory) async {
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
                                sname,
                                cname,
                                addr,
                                tax,
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

  //////////////-------------------------------------------------------------> ( รายการ ประวัติบิล )
  Future<Null> Receipt_his_statusbill(
      tableData00,
      newValuePDFimg,
      sname,
      cname,
      addr,
      tax,
      room_number_BillHistory,
      TitleType_Default_Receipt_Name) async {
    // var date_Transaction = (finnancetransModels.length == 0)
    //     ? ''
    //     : '${finnancetransModels[0].daterec}';
    // var date_pay = (finnancetransModels.length == 0)
    //     ? ''
    //     : '${finnancetransModels[0].dateacc}';
    // ManPay_Receipt_PDF.ManPayReceipt_PDF(
    //     numinvoice,
    //     context,
    //     foder,
    //     renTal_name,
    //     // sname,
    //     // cname,
    //     // addr,
    //     // tax,
    //     bill_addr,
    //     bill_email,
    //     bill_tel,
    //     bill_tax,
    //     bill_name,
    //     newValuePDFimg,
    //     TitleType_Default_Receipt_Name,
    //     tem_page_ser,
    //     bills_name_);

    ManPay_Receipt_PakanPDF.ManPayReceipt_PakanPDF(
        numinvoice,
        context,
        foder,
        renTal_name,
        bill_addr,
        bill_email,
        bill_tel,
        bill_tax,
        bill_name,
        newValuePDFimg,
        TitleType_Default_Receipt_Name,
        tem_page_ser,
        bills_name_);
  }
}
