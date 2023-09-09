import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/Style/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../Model/GetContractx_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/vat_SC_model.dart';
import '../Responsive/responsive.dart';

class SettringListMenu extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  const SettringListMenu({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
  });

  @override
  State<SettringListMenu> createState() => _SettringListMenuState();
}

class _SettringListMenuState extends State<SettringListMenu> {
  List<TransBillModel> _TransBillModels = [];
  List<ContractxModel> contractxModels = [];
  List<VatSeModel> vatSeModels = [];

  final edit_textall = TextEditingController();
  final edit_textvat = TextEditingController();
  final edit_textwht = TextEditingController();
  final Formposlok_ = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String ptype = 'ทั้งหมด';
  String? edit_data_ser,
      edit_data_date,
      edit_data_vtype,
      edit_data_nvat,
      edit_data_nwht,
      edit_data_docno,
      edit_data_total;
  int edit_data = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    red_Trans_billAll(ptype);
    read_GC_Exp();
    read_GC_vat();
  }

  Future<Null> read_GC_vat() async {
    if (vatSeModels.isNotEmpty) {
      setState(() {
        vatSeModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_vat_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          VatSeModel vatSeModel = VatSeModel.fromJson(map);
          setState(() {
            if (vatSeModel.st != '0') {
              vatSeModels.add(vatSeModel);
            }
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_Exp() async {
    if (contractxModels.isNotEmpty) {
      contractxModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;

    String url =
        '${MyConstant().domain}/GC_conx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);

      if (result != null) {
        Map<String, dynamic> map = Map();
        map['ser'] = '0';
        map['expname'] = 'ทั้งหมด';

        ContractxModel contractxModel = ContractxModel.fromJson(map);

        setState(() {
          contractxModels.add(contractxModel);
        });

        for (var map in result) {
          ContractxModel contractxModel = ContractxModel.fromJson(map);

          setState(() {
            contractxModels.add(contractxModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> red_Trans_billAll(ptype) async {
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
          var vv = _TransBillModel.expname;
          if (_TransBillModel.invoice == null) {
            setState(() {
              if (ptype == vv) {
                _TransBillModels.add(_TransBillModel);
              } else if (ptype == 'ทั้งหมด') {
                _TransBillModels.add(_TransBillModel);
              }
            });
          }
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.brown[200],
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              minFontSize: 10,
                              maxFontSize: 25,
                              maxLines: 1,
                              'รายการตั้งหนี้',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          // Expanded(
                          //   child: Container(
                          //     height: 50,
                          //     // color: Colors.brown[200],
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       color: Colors.grey[200],
                          //     ),
                          //     padding: EdgeInsets.all(8.0),
                          //     child: Center(
                          //       child: InkWell(
                          //         onTap: () async {},
                          //         child: Text(
                          //           'เพิ่มรายการ',
                          //           style: TextStyle(
                          //               color: PeopleChaoScreen_Color
                          //                   .Colors_Text2_,
                          //               fontWeight: FontWeight.bold,
                          //               fontFamily: Font_.Fonts_T),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.26,
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
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        // controller: _scrollController1,
                        // itemExtent: 50,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: contractxModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            color: ptype == contractxModels[index].expname
                                ? tappedIndex_Color.tappedIndex_Colors
                                : null,
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    ptype = contractxModels[index]
                                        .expname
                                        .toString();
                                    edit_data = 1;
                                    edit_data_ser = null;
                                    edit_data_date = null;
                                    edit_data_vtype = null;
                                    edit_data_nvat = null;
                                    edit_data_nwht = null;
                                    edit_data_docno = null;
                                    edit_data_total = null;
                                    edit_textall.clear();
                                    edit_textvat.clear();
                                    edit_textwht.clear();
                                    red_Trans_billAll(contractxModels[index]
                                        .expname
                                        .toString());
                                  });
                                },
                                title: Container(
                                  // _TransModelsdocno
                                  // color: ptype == contractxModels[index].expname
                                  //     ? tappedIndex_Color.tappedIndex_Colors
                                  //     : null,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 25,
                                            maxLines: 1,
                                            '${contractxModels[index].expname}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T)),
                                      ),
                                      ptype == contractxModels[index].expname
                                          ? Expanded(
                                              child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 25,
                                                  maxLines: 1,
                                                  '${_TransBillModels.length}',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      fontFamily:
                                                          Font_.Fonts_T)),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
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
                                  'เลขตั้งหนี้',
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
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 50,
                              color: Colors.brown[200],
                              padding: const EdgeInsets.all(8.0),
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
                                  ptype == 'ทั้งหมด' ? 'ประเภท' : ptype,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: TextHome_Color.TextHome_Colors,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                iconSize: 20,
                                buttonHeight: 50,
                                // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                items: contractxModels
                                    .map((item) => DropdownMenuItem<String>(
                                          value: '${item.expname}',
                                          child: Text(
                                            item.expname!,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        ))
                                    .toList(),

                                onChanged: (value) async {
                                  setState(() {
                                    ptype = value.toString();
                                    edit_data = 1;
                                    edit_data_ser = null;
                                    edit_data_date = null;
                                    edit_data_vtype = null;
                                    edit_data_nvat = null;
                                    edit_data_nwht = null;
                                    edit_data_docno = null;
                                    edit_data_total = null;
                                    edit_textall.clear();
                                    edit_textvat.clear();
                                    edit_textwht.clear();
                                    red_Trans_billAll(value);
                                  });
                                },
                              ),
                              //      Center(
                              //   child: AutoSizeText(
                              //     minFontSize: 10,
                              //     maxFontSize: 25,
                              //     maxLines: 2,
                              //     'ประเภท',
                              //     textAlign: TextAlign.center,
                              //     style: TextStyle(
                              //         color:
                              //             PeopleChaoScreen_Color.Colors_Text2_,
                              //         fontWeight: FontWeight.bold,
                              //         fontFamily: Font_.Fonts_T),
                              //   ),
                              // ),
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
                                  'VAT',
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
                                  'VAT %',
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
                                  'WHT %',
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
                              flex: 2,
                              child: Container(
                                height: 50,
                                color: Colors.brown[200],
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: InkWell(
                                    onTap: () async {
                                      // setState(() {
                                      //   edit_data = 1;
                                      // });
                                    },
                                    child: Text(
                                      'ยอดชำระ',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T),
                                    ),
                                  ),
                                  // AutoSizeText(
                                  //   minFontSize: 10,
                                  //   maxFontSize: 25,
                                  //   maxLines: 1,
                                  //   'ยอดชำระ',
                                  //   textAlign: TextAlign.end,
                                  //   style: TextStyle(
                                  //       color: PeopleChaoScreen_Color
                                  //           .Colors_Text2_,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontFamily: Font_.Fonts_T),
                                  // ),
                                ),
                              )),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.26,
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
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          // controller: _scrollController1,
                          // itemExtent: 50,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _TransBillModels.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Material(
                              color:
                                  edit_data_ser == _TransBillModels[index].ser
                                      ? tappedIndex_Color.tappedIndex_Colors
                                      : null,
                              child: InkWell(
                                onTap: () {},
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      edit_data = 2;
                                      edit_data_ser =
                                          _TransBillModels[index].ser!;
                                      edit_data_date =
                                          _TransBillModels[index].date!;
                                      edit_data_vtype =
                                          _TransBillModels[index].vtype!;
                                      edit_data_nvat =
                                          _TransBillModels[index].nvat!;
                                      edit_textvat.text =
                                          _TransBillModels[index].nvat!;
                                      edit_data_nwht =
                                          _TransBillModels[index].nwht!;
                                      edit_textwht.text =
                                          _TransBillModels[index].nwht!;
                                      edit_data_docno =
                                          _TransBillModels[index].docno!;
                                      edit_data_total =
                                          _TransBillModels[index].total!;
                                      edit_textall.text =
                                          _TransBillModels[index].total!;
                                    });

                                    print(
                                        '${_TransBillModels[index].ser} ${_TransBillModels[index].docno}');

                                    // in_Trans_select(index);
                                  },
                                  title: Container(
                                    //_TransModelsdocno
                                    // color: edit_data_ser ==
                                    //         _TransBillModels[index].ser
                                    //     ? tappedIndex_Color.tappedIndex_Colors
                                    //     : null,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text:
                                                  '${_TransBillModels[index].docno}',
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
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${_TransBillModels[index].docno}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text:
                                                  '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index].date} 00:00:00').year + 543}',
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
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index].date} 00:00:00').year + 543}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text: (Responsive.isDesktop(
                                                      context))
                                                  ? _TransBillModels[index]
                                                              .descr ==
                                                          null
                                                      ? '${_TransBillModels[index].expname}'
                                                      : '${_TransBillModels[index].descr}'
                                                  : _TransBillModels[index]
                                                              .descr ==
                                                          null
                                                      ? '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index].date} 00:00:00').year + 543} \n ${_TransBillModels[index].expname}'
                                                      : '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index].date} 00:00:00').year + 543} \n ${_TransBillModels[index].descr}',
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
                                            child:
                                                (Responsive.isDesktop(context))
                                                    ? AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 2,
                                                        _TransBillModels[index]
                                                                    .descr ==
                                                                null
                                                            ? '${_TransBillModels[index].expname}'
                                                            : '${_TransBillModels[index].descr}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      )
                                                    : Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              AutoSizeText(
                                                                minFontSize: 6,
                                                                maxFontSize: 12,
                                                                maxLines: 2,
                                                                '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index].date} 00:00:00').year + 543}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade500,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 2,
                                                                _TransBillModels[index]
                                                                            .descr ==
                                                                        null
                                                                    ? '${_TransBillModels[index].expname}'
                                                                    : '${_TransBillModels[index].descr}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text:
                                                  '${_TransBillModels[index].vtype}',
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
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${_TransBillModels[index].vtype}',
                                              textAlign: TextAlign.end,
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
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text:
                                                  '${_TransBillModels[index].nvat}',
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
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${_TransBillModels[index].nvat}',
                                              textAlign: TextAlign.end,
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
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text:
                                                  '${_TransBillModels[index].nwht}',
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
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${_TransBillModels[index].nwht}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Tooltip(
                                            richMessage: TextSpan(
                                              text:
                                                  '${_TransBillModels[index].total}',
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
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${_TransBillModels[index].total}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
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
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.width * 0.29,
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  color: Colors.brown[200],
                                  padding: const EdgeInsets.all(8.0),
                                  child: ptype == 'ทั้งหมด'
                                      ? edit_data == 1
                                          ? Text('')
                                          : Center(
                                              child: Text(
                                              'แก้ไขข้อมูล',
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ))
                                      : edit_data == 1
                                          ? Center(
                                              child: Text(
                                              'แก้ไขข้อมูลทั้งหมด',
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ))
                                          : Center(
                                              child: Text(
                                              'แก้ไขข้อมูล',
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            )),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: edit_data == 1
                                    ? ptype == 'ทั้งหมด'
                                        ? SizedBox()
                                        : _TransBillModels.length == 0
                                            ? SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            'แก้ไขราคาทั้งหมด'),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                edit_textall,
                                                            onFieldSubmitted:
                                                                (val) async {
                                                              print(edit_textall
                                                                  .text);
                                                              SharedPreferences
                                                                  preferences =
                                                                  await SharedPreferences
                                                                      .getInstance();

                                                              var ren = preferences
                                                                  .getString(
                                                                      'renTalSer');

                                                              showDialog<void>(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false, // user must tap button!
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      title:
                                                                          Container(
                                                                        height:
                                                                            150,
                                                                        child:
                                                                            const CircularProgressIndicator(),
                                                                      ),
                                                                    );
                                                                  });
                                                              for (var i = 0;
                                                                  i <
                                                                      _TransBillModels
                                                                          .length;
                                                                  i++) {
                                                                var serconx =
                                                                    _TransBillModels[
                                                                            i]
                                                                        .ser;
                                                                // print(serconx);
                                                                var edittext =
                                                                    edit_textall
                                                                        .text;
                                                                String url =
                                                                    '${MyConstant().domain}/UP_tran_Edit_all.php?isAdd=true&ren=$ren&serconx=$serconx&edittext=$edittext';
                                                                try {
                                                                  var response =
                                                                      await http.get(
                                                                          Uri.parse(
                                                                              url));

                                                                  var result =
                                                                      json.decode(
                                                                          response
                                                                              .body);
                                                                  // print(result);
                                                                  if (result
                                                                          .toString() ==
                                                                      'true') {}
                                                                } catch (e) {}
                                                              }
                                                              setState(() {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                edit_textall
                                                                    .clear();

                                                                red_Trans_billAll(
                                                                    ptype);
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon: const Icon(
                                                                    //     Icons.password,
                                                                    //     color: Colors.black),
                                                                    // // suffixIcon: Icon(Icons.clear, color: Colors.black),
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
                                                                    labelStyle: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            Font_.Fonts_T)),
                                                            inputFormatters: <TextInputFormatter>[
                                                              // for below version 2 use this
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      r'[0-9 .]')),
                                                              // for version 2 and greater youcan also use this
                                                              // FilteringTextInputFormatter.digitsOnly
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            'แก้ไข VAT % ทั้งหมด'),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                edit_textvat,
                                                            onFieldSubmitted:
                                                                (val) async {
                                                              print(edit_textvat
                                                                  .text);
                                                              SharedPreferences
                                                                  preferences =
                                                                  await SharedPreferences
                                                                      .getInstance();

                                                              var ren = preferences
                                                                  .getString(
                                                                      'renTalSer');

                                                              showDialog<void>(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false, // user must tap button!
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      title:
                                                                          Container(
                                                                        height:
                                                                            150,
                                                                        child:
                                                                            const CircularProgressIndicator(),
                                                                      ),
                                                                    );
                                                                  });
                                                              for (var i = 0;
                                                                  i <
                                                                      _TransBillModels
                                                                          .length;
                                                                  i++) {
                                                                var serconx =
                                                                    _TransBillModels[
                                                                            i]
                                                                        .ser;
                                                                // print(serconx);
                                                                var edittext =
                                                                    edit_textvat
                                                                        .text;
                                                                String url =
                                                                    '${MyConstant().domain}/UP_tran_Edit_all_vat.php?isAdd=true&ren=$ren&serconx=$serconx&edittext=$edittext';
                                                                try {
                                                                  var response =
                                                                      await http.get(
                                                                          Uri.parse(
                                                                              url));

                                                                  var result =
                                                                      json.decode(
                                                                          response
                                                                              .body);
                                                                  // print(result);
                                                                  if (result
                                                                          .toString() ==
                                                                      'true') {}
                                                                } catch (e) {}
                                                              }
                                                              setState(() {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                edit_textvat
                                                                    .clear();

                                                                red_Trans_billAll(
                                                                    ptype);
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon: const Icon(
                                                                    //     Icons.password,
                                                                    //     color: Colors.black),
                                                                    // // suffixIcon: Icon(Icons.clear, color: Colors.black),
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
                                                                    labelStyle: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            Font_.Fonts_T)),
                                                            inputFormatters: <TextInputFormatter>[
                                                              // for below version 2 use this
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      r'[0-9 .]')),
                                                              // for version 2 and greater youcan also use this
                                                              // FilteringTextInputFormatter.digitsOnly
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            'แก้ไข WHT % ทั้งหมด'),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                edit_textwht,
                                                            onFieldSubmitted:
                                                                (val) async {
                                                              print(edit_textwht
                                                                  .text);
                                                              SharedPreferences
                                                                  preferences =
                                                                  await SharedPreferences
                                                                      .getInstance();

                                                              var ren = preferences
                                                                  .getString(
                                                                      'renTalSer');

                                                              showDialog<void>(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false, // user must tap button!
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      title:
                                                                          Container(
                                                                        height:
                                                                            150,
                                                                        child:
                                                                            const CircularProgressIndicator(),
                                                                      ),
                                                                    );
                                                                  });
                                                              for (var i = 0;
                                                                  i <
                                                                      _TransBillModels
                                                                          .length;
                                                                  i++) {
                                                                var serconx =
                                                                    _TransBillModels[
                                                                            i]
                                                                        .ser;
                                                                // print(serconx);
                                                                var edittext =
                                                                    edit_textwht
                                                                        .text;
                                                                String url =
                                                                    '${MyConstant().domain}/UP_tran_Edit_all_wht.php?isAdd=true&ren=$ren&serconx=$serconx&edittext=$edittext';
                                                                try {
                                                                  var response =
                                                                      await http.get(
                                                                          Uri.parse(
                                                                              url));

                                                                  var result =
                                                                      json.decode(
                                                                          response
                                                                              .body);
                                                                  // print(result);
                                                                  if (result
                                                                          .toString() ==
                                                                      'true') {}
                                                                } catch (e) {}
                                                              }
                                                              setState(() {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                edit_textwht
                                                                    .clear();

                                                                red_Trans_billAll(
                                                                    ptype);
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon: const Icon(
                                                                    //     Icons.password,
                                                                    //     color: Colors.black),
                                                                    // // suffixIcon: Icon(Icons.clear, color: Colors.black),
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
                                                                    labelStyle: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            Font_.Fonts_T)),
                                                            inputFormatters: <TextInputFormatter>[
                                                              // for below version 2 use this
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      r'[0-9 .]')),
                                                              // for version 2 and greater youcan also use this
                                                              // FilteringTextInputFormatter.digitsOnly
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 8,
                                                                  bottom: 8),
                                                          child: Container(
                                                            width: 120,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                showDialog<
                                                                    String>(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      AlertDialog(
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(20.0))),
                                                                    title: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'ลบรายการ $ptype ทั้งหมด', // Navigator.pop(context, 'OK');
                                                                              style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              IconButton(
                                                                                  onPressed: () {
                                                                                    setState(() {
                                                                                      Formposlok_.clear();
                                                                                    });
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  icon: Icon(Icons.close, color: Colors.black)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: <Widget>[
                                                                      Form(
                                                                        key:
                                                                            _formKey,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: TextFormField(
                                                                                controller: Formposlok_,
                                                                                // obscureText:
                                                                                //     true,
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
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 150,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.black,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: TextButton(
                                                                                      onPressed: () async {
                                                                                        if (_formKey.currentState!.validate()) {
                                                                                          showDialog<void>(
                                                                                              context: context,
                                                                                              barrierDismissible: false, // user must tap button!
                                                                                              builder: (BuildContext context) {
                                                                                                return AlertDialog(
                                                                                                  backgroundColor: Colors.transparent,
                                                                                                  title: Container(
                                                                                                    height: 150,
                                                                                                    child: const CircularProgressIndicator(),
                                                                                                  ),
                                                                                                );
                                                                                              });

                                                                                          de_Trans_item_all().then((value) {
                                                                                            setState(() {
                                                                                              Formposlok_.clear();
                                                                                              edit_data = 1;
                                                                                              edit_data_ser = null;
                                                                                              edit_data_date = null;
                                                                                              edit_data_vtype = null;
                                                                                              edit_data_nvat = null;
                                                                                              edit_data_nwht = null;
                                                                                              edit_data_docno = null;
                                                                                              edit_data_total = null;
                                                                                              edit_textall.clear();
                                                                                              edit_textvat.clear();
                                                                                              edit_textwht.clear();
                                                                                              red_Trans_billAll(ptype);
                                                                                              Navigator.pop(context);
                                                                                              Navigator.pop(context);
                                                                                            });
                                                                                          });
                                                                                        }
                                                                                      },
                                                                                      child: const Text(
                                                                                        'Submit',
                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                                );
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  'ลบรายการทั้งหมด',
                                                                  minFontSize:
                                                                      9,
                                                                  maxFontSize:
                                                                      24,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: Colors.white,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                    : edit_data_ser == null
                                        ? Text('')
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                // edit_data_ser,
                                                // edit_data_date,
                                                // edit_data_vtype,
                                                // edit_data_nvat,
                                                // edit_data_nwht,
                                                // edit_data_docno;
                                                //edit_data_total
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      'เลขตั้งหนี้ $edit_data_docno',
                                                      textAlign: TextAlign.end,
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
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        'กำหนดชำระ',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '${DateFormat('dd-MM-yyy').format(DateTime.parse('$edit_data_date 00:00:00'))}',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '>',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8),
                                                        child: Container(
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: Colors.green,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              DateTime?
                                                                  newDate =
                                                                  await showDatePicker(
                                                                locale:
                                                                    const Locale(
                                                                        'th',
                                                                        'TH'),
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime.parse(
                                                                        '$edit_data_date 00:00:00'),
                                                                firstDate:
                                                                    DateTime(
                                                                        1000,
                                                                        1,
                                                                        01),
                                                                lastDate: DateTime
                                                                        .parse(
                                                                            '$edit_data_date 00:00:00')
                                                                    .add(const Duration(
                                                                        days:
                                                                            365)),
                                                                builder:
                                                                    (context,
                                                                        child) {
                                                                  return Theme(
                                                                    data: Theme.of(
                                                                            context)
                                                                        .copyWith(
                                                                      colorScheme:
                                                                          const ColorScheme
                                                                              .light(
                                                                        primary:
                                                                            AppBarColors.ABar_Colors, // header background color
                                                                        onPrimary:
                                                                            Colors.white, // header text color
                                                                        onSurface:
                                                                            Colors.black, // body text color
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
                                                                    child:
                                                                        child!,
                                                                  );
                                                                },
                                                              );

                                                              if (newDate ==
                                                                  null) {
                                                                return;
                                                              } else {
                                                                print(
                                                                    '$newDate');

                                                                String start =
                                                                    DateFormat(
                                                                            'yyyy-MM-dd')
                                                                        .format(
                                                                            newDate);

                                                                String
                                                                    end_StratTime =
                                                                    DateFormat(
                                                                            'dd-MM-yyy')
                                                                        .format(
                                                                            newDate);

                                                                print(
                                                                    '$start $end_StratTime ');

                                                                SharedPreferences
                                                                    preferences =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                String? ren =
                                                                    preferences
                                                                        .getString(
                                                                            'renTalSer');

                                                                showDialog<
                                                                        void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        false, // user must tap button!
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        title:
                                                                            Container(
                                                                          height:
                                                                              150,
                                                                          child:
                                                                              const CircularProgressIndicator(),
                                                                        ),
                                                                      );
                                                                    });

                                                                var serconx =
                                                                    edit_data_ser;
                                                                // print(serconx);

                                                                String url =
                                                                    '${MyConstant().domain}/UP_tran_Edit_all_date.php?isAdd=true&ren=$ren&serconx=$serconx&start=$start';
                                                                try {
                                                                  var response =
                                                                      await http.get(
                                                                          Uri.parse(
                                                                              url));

                                                                  var result =
                                                                      json.decode(
                                                                          response
                                                                              .body);
                                                                  // print(result);
                                                                  if (result
                                                                          .toString() ==
                                                                      'true') {}
                                                                } catch (e) {}

                                                                setState(() {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  edit_data_date =
                                                                      start;

                                                                  // edit_textvat.clear();

                                                                  red_Trans_billAll(
                                                                      ptype);
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15.0),
                                                              child:
                                                                  AutoSizeText(
                                                                '${DateFormat('dd-MM-yyy').format(DateTime.parse('$edit_data_date 00:00:00'))}',
                                                                minFontSize: 9,
                                                                maxFontSize: 16,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        'VAT',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '$edit_data_vtype',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '>',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          DropdownButtonFormField2(
                                                        decoration:
                                                            InputDecoration(
                                                          //Add isDense true and zero Padding.
                                                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          //Add more decoration as you want here
                                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                        ),
                                                        isExpanded: true,
                                                        // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                        hint: Row(
                                                          children: [
                                                            SizedBox(
                                                                child:
                                                                    AutoSizeText(
                                                              minFontSize: 5,
                                                              maxFontSize: 14,
                                                              maxLines: 1,
                                                              '$edit_data_vtype',
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
                                                            )),
                                                          ],
                                                        ),
                                                        icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                          color: Colors.black45,
                                                        ),
                                                        iconSize: 20,
                                                        buttonHeight: 50,
                                                        buttonPadding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        dropdownDecoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        items: vatSeModels
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value:
                                                                      '${item.ser}:${item.vtype}',
                                                                  child: SizedBox(
                                                                      child: AutoSizeText(
                                                                    minFontSize:
                                                                        5,
                                                                    maxFontSize:
                                                                        14,
                                                                    maxLines: 1,
                                                                    item.vtype!,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  )
                                                                      // Text(
                                                                      //   item.vtype!,
                                                                      //   maxLines: 1,
                                                                      //   style: const TextStyle(
                                                                      //       fontSize: 14,
                                                                      //       color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //       // fontWeight: FontWeight.bold,
                                                                      //       fontFamily: Font_.Fonts_T),
                                                                      // ),
                                                                      ),
                                                                ))
                                                            .toList(),
                                                        onChanged:
                                                            (value) async {
                                                          var zones = value!
                                                              .indexOf(':');
                                                          var vat_ser =
                                                              value.substring(
                                                                  0, zones);
                                                          var vat_name =
                                                              value.substring(
                                                                  zones + 1);
                                                          print(
                                                              'mmmmm ${vat_ser.toString()} $vat_name');

                                                          SharedPreferences
                                                              preferences =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          String? ren = preferences
                                                              .getString(
                                                                  'renTalSer');

                                                          showDialog<void>(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false, // user must tap button!
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  title:
                                                                      Container(
                                                                    height: 150,
                                                                    child:
                                                                        const CircularProgressIndicator(),
                                                                  ),
                                                                );
                                                              });

                                                          var serconx =
                                                              edit_data_ser;
                                                          // print(serconx);

                                                          String url =
                                                              '${MyConstant().domain}/UP_tran_Edit_all_vtype.php?isAdd=true&ren=$ren&serconx=$serconx&vat_ser=$vat_ser&vat_name=$vat_name';
                                                          try {
                                                            var response =
                                                                await http.get(
                                                                    Uri.parse(
                                                                        url));

                                                            var result = json
                                                                .decode(response
                                                                    .body);
                                                            // print(result);
                                                            if (result
                                                                    .toString() ==
                                                                'true') {}
                                                          } catch (e) {}

                                                          setState(() {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            edit_data_vtype =
                                                                vat_name;

                                                            // edit_textvat.clear();

                                                            red_Trans_billAll(
                                                                    ptype)
                                                                .then((value) {
                                                              setState(() {
                                                                edit_data_total = _TransBillModels.map((e) => e.ser ==
                                                                            edit_data_ser
                                                                        ? double.parse(e
                                                                            .total
                                                                            .toString())
                                                                        : 0.00)
                                                                    .reduce((a,
                                                                            b) =>
                                                                        a + b)
                                                                    .toStringAsFixed(
                                                                        2)
                                                                    .toString();
                                                                edit_textall
                                                                    .text = _TransBillModels.map((e) => e.ser ==
                                                                            edit_data_ser
                                                                        ? double.parse(e
                                                                            .total
                                                                            .toString())
                                                                        : 0.00)
                                                                    .reduce((a,
                                                                            b) =>
                                                                        a + b)
                                                                    .toStringAsFixed(
                                                                        2)
                                                                    .toString();
                                                              });
                                                            });
                                                          });
                                                        },
                                                        onSaved: (value) {
                                                          // selectedValue = value.toString();
                                                        },
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
                                                        'VAT %',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '$edit_data_nvat',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '>',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8),
                                                        child: TextFormField(
                                                          textAlign:
                                                              TextAlign.end,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              edit_textvat,
                                                          onFieldSubmitted:
                                                              (val) async {
                                                            print(edit_textvat
                                                                .text);
                                                            SharedPreferences
                                                                preferences =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            var ren = preferences
                                                                .getString(
                                                                    'renTalSer');

                                                            showDialog<void>(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false, // user must tap button!
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    title:
                                                                        Container(
                                                                      height:
                                                                          150,
                                                                      child:
                                                                          const CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                });

                                                            var serconx =
                                                                edit_data_ser;
                                                            // print(serconx);
                                                            var edittext =
                                                                edit_textvat
                                                                    .text;
                                                            String url =
                                                                '${MyConstant().domain}/UP_tran_Edit_all_vat.php?isAdd=true&ren=$ren&serconx=$serconx&edittext=$edittext';
                                                            try {
                                                              var response =
                                                                  await http.get(
                                                                      Uri.parse(
                                                                          url));

                                                              var result =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              // print(result);
                                                              if (result
                                                                      .toString() ==
                                                                  'true') {}
                                                            } catch (e) {}

                                                            setState(() {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              edit_data_nvat =
                                                                  edit_textvat
                                                                      .text;

                                                              // edit_textvat.clear();

                                                              red_Trans_billAll(
                                                                      ptype)
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  edit_data_total = _TransBillModels.map((e) => e.ser ==
                                                                              edit_data_ser
                                                                          ? double.parse(e
                                                                              .total
                                                                              .toString())
                                                                          : 0.00)
                                                                      .reduce((a,
                                                                              b) =>
                                                                          a + b)
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                  edit_textall
                                                                      .text = _TransBillModels.map((e) => e.ser ==
                                                                              edit_data_ser
                                                                          ? double.parse(e
                                                                              .total
                                                                              .toString())
                                                                          : 0.00)
                                                                      .reduce((a,
                                                                              b) =>
                                                                          a + b)
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                });
                                                              });
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.3),
                                                                  filled: true,
                                                                  // prefixIcon: const Icon(
                                                                  //     Icons.password,
                                                                  //     color: Colors.black),
                                                                  // // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
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
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
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
                                                                  labelStyle: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          Font_
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
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        'WHT %',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '$edit_data_nwht',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '>',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8),
                                                        child: TextFormField(
                                                          textAlign:
                                                              TextAlign.end,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              edit_textwht,
                                                          onFieldSubmitted:
                                                              (val) async {
                                                            print(edit_textwht
                                                                .text);
                                                            SharedPreferences
                                                                preferences =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            var ren = preferences
                                                                .getString(
                                                                    'renTalSer');

                                                            showDialog<void>(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false, // user must tap button!
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    title:
                                                                        Container(
                                                                      height:
                                                                          150,
                                                                      child:
                                                                          const CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                });

                                                            var serconx =
                                                                edit_data_ser;
                                                            // print(serconx);
                                                            var edittext =
                                                                edit_textwht
                                                                    .text;
                                                            String url =
                                                                '${MyConstant().domain}/UP_tran_Edit_all_wht.php?isAdd=true&ren=$ren&serconx=$serconx&edittext=$edittext';
                                                            try {
                                                              var response =
                                                                  await http.get(
                                                                      Uri.parse(
                                                                          url));

                                                              var result =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              // print(result);
                                                              if (result
                                                                      .toString() ==
                                                                  'true') {}
                                                            } catch (e) {}

                                                            setState(() {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              edit_data_nwht =
                                                                  edit_textwht
                                                                      .text;
                                                              // edit_textvat.clear();

                                                              red_Trans_billAll(
                                                                      ptype)
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  edit_data_total = _TransBillModels.map((e) => e.ser ==
                                                                              edit_data_ser
                                                                          ? double.parse(e
                                                                              .total
                                                                              .toString())
                                                                          : 0.00)
                                                                      .reduce((a,
                                                                              b) =>
                                                                          a + b)
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                  edit_textall
                                                                      .text = _TransBillModels.map((e) => e.ser ==
                                                                              edit_data_ser
                                                                          ? double.parse(e
                                                                              .total
                                                                              .toString())
                                                                          : 0.00)
                                                                      .reduce((a,
                                                                              b) =>
                                                                          a + b)
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                });
                                                              });
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.3),
                                                                  filled: true,
                                                                  // prefixIcon: const Icon(
                                                                  //     Icons.password,
                                                                  //     color: Colors.black),
                                                                  // // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
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
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
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
                                                                  labelStyle: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          Font_
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
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        'ยอดชำระ',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '$edit_data_total',
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
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '>',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8),
                                                        child: TextFormField(
                                                          textAlign:
                                                              TextAlign.end,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              edit_textall,
                                                          onFieldSubmitted:
                                                              (val) async {
                                                            print(edit_textall
                                                                .text);
                                                            SharedPreferences
                                                                preferences =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            var ren = preferences
                                                                .getString(
                                                                    'renTalSer');

                                                            showDialog<void>(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false, // user must tap button!
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    title:
                                                                        Container(
                                                                      height:
                                                                          150,
                                                                      child:
                                                                          const CircularProgressIndicator(),
                                                                    ),
                                                                  );
                                                                });

                                                            var serconx =
                                                                edit_data_ser;
                                                            // print(serconx);
                                                            var edittext =
                                                                edit_textall
                                                                    .text;
                                                            String url =
                                                                '${MyConstant().domain}/UP_tran_Edit_all.php?isAdd=true&ren=$ren&serconx=$serconx&edittext=$edittext';
                                                            try {
                                                              var response =
                                                                  await http.get(
                                                                      Uri.parse(
                                                                          url));

                                                              var result =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              // print(result);
                                                              if (result
                                                                      .toString() ==
                                                                  'true') {}
                                                            } catch (e) {}

                                                            setState(() {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              // edit_data_total =
                                                              //     edit_textall.text;
                                                              // edit_textvat.clear();

                                                              red_Trans_billAll(
                                                                      ptype)
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  edit_data_total = _TransBillModels.map((e) => e.ser ==
                                                                              edit_data_ser
                                                                          ? double.parse(e
                                                                              .total
                                                                              .toString())
                                                                          : 0.00)
                                                                      .reduce((a,
                                                                              b) =>
                                                                          a + b)
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                  edit_textall
                                                                      .text = _TransBillModels.map((e) => e.ser ==
                                                                              edit_data_ser
                                                                          ? double.parse(e
                                                                              .total
                                                                              .toString())
                                                                          : 0.00)
                                                                      .reduce((a,
                                                                              b) =>
                                                                          a + b)
                                                                      .toStringAsFixed(
                                                                          2)
                                                                      .toString();
                                                                });
                                                              });
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.3),
                                                                  filled: true,
                                                                  // prefixIcon: const Icon(
                                                                  //     Icons.password,
                                                                  //     color: Colors.black),
                                                                  // // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
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
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
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
                                                                  labelStyle: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          Font_
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 8),
                                                      child: Container(
                                                        width: 120,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
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
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20.0))),
                                                                title: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'ลบรายการ $edit_data_docno', // Navigator.pop(context, 'OK');
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  Formposlok_.clear();
                                                                                });
                                                                                Navigator.pop(context);
                                                                              },
                                                                              icon: Icon(Icons.close, color: Colors.black)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  Form(
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                Formposlok_,
                                                                            // obscureText:
                                                                            //     true,
                                                                            validator:
                                                                                (value) {
                                                                              if (value == null || value.isEmpty) {
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
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 150,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                ),
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: TextButton(
                                                                                  onPressed: () async {
                                                                                    if (_formKey.currentState!.validate()) {
                                                                                      de_Trans_item();
                                                                                    }
                                                                                  },
                                                                                  child: const Text(
                                                                                    'Submit',
                                                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: AutoSizeText(
                                                              'ลบรายการ',
                                                              minFontSize: 9,
                                                              maxFontSize: 24,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .white,
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
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    ]);
  }

  Future<Null> de_Trans_item() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    var tser = edit_data_ser;
    var tdocno = edit_data_docno;
    var poslok = Formposlok_.text;

    print('tser >>.> $tser');

    String url =
        '${MyConstant().domain}/De_tran_edit_item.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user&poslok=$poslok';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          Formposlok_.clear();
          edit_data = 1;
          edit_data_ser = null;
          edit_data_date = null;
          edit_data_vtype = null;
          edit_data_nvat = null;
          edit_data_nwht = null;
          edit_data_docno = null;
          edit_data_total = null;
          edit_textall.clear();
          edit_textvat.clear();
          edit_textwht.clear();
          red_Trans_billAll(ptype);
          Navigator.pop(context);
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<Null> de_Trans_item_all() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    for (var i = 0; i < _TransBillModels.length; i++) {
      var tser = _TransBillModels[i].ser;
      var tdocno = _TransBillModels[i].docno;
      var poslok = Formposlok_.text;

      print('tser >>.> $tser');

      String url =
          '${MyConstant().domain}/De_tran_edit_item.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user&poslok=$poslok';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
        if (result.toString() == 'true') {
          print('rrrrrrrrrrrrrr');
        }
      } catch (e) {}
    }
  }
}
