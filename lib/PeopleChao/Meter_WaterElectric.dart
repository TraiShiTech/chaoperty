import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../Model/GetContractx_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class MeterWaterElectric extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  const MeterWaterElectric({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
  });

  @override
  State<MeterWaterElectric> createState() => _MeterWaterElectricState();
}

class _MeterWaterElectricState extends State<MeterWaterElectric> {
  @override
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///----------------->
  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  List<String> mont = [
    'มกราคม',
    'กุมภาพันธ์	',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];

  String? _celvat, _cname, _cnamex, _cser, _cunitser, _cqty_vat, _cunit;

  List<TransModel> _TransModels = [];
  List<ContractxModel> _ContractxModels = [];
  int Ser__TapContractx = 0;
  String tappedIndex_1 = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    red_exp_wherser();
  }

  // var formatter = DateFormat.MMM();

  Future<Null> red_Trans(_cser) async {
    if (_TransModels.length != 0) {
      setState(() {
        _TransModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    if (qutser == '1') {
      String url = _cser == null
          ? '${MyConstant().domain}/GC_quotx_consx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&_cser=${_ContractxModels[0].ser}}'
          : '${MyConstant().domain}/GC_quotx_consx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&_cser=$_cser';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            TransModel _TransModel = TransModel.fromJson(map);
            setState(() {
              _TransModels.add(_TransModel);
            });
          }
        } else {
          setState(() {
            _TransModels.clear();
          });
        }
      } catch (e) {}
    }

    if (_cser == null) {
      setState(() {
        _celvat = _ContractxModels[0].nvat;
        _cname =
            '${_ContractxModels[0].expname}( ${_ContractxModels[0].unit} )\n${_ContractxModels[0].meter}';
        _cnamex = '${_ContractxModels[0].expname}';
        _cser = _ContractxModels[0].ser;
        _cunitser = _ContractxModels[0].unitser;
        _cunit = _ContractxModels[0].unit;
        _cqty_vat = _ContractxModels[0].qty;
      });
    }
  }

  Future<Null> red_exp_wherser() async {
    if (_ContractxModels.length != 0) {
      setState(() {
        _ContractxModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    if (qutser == '1') {
      String url =
          '${MyConstant().domain}/GC_exp_wherser.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            ContractxModel _ContractxModel = ContractxModel.fromJson(map);
            setState(() {
              _ContractxModels.add(_ContractxModel);
            });
          }
        } else {
          setState(() {
            _ContractxModels.clear();
          });
        }
      } catch (e) {}
    }

    if (_cser == null) {
      setState(() {
        _celvat = _ContractxModels[0].nvat;
        _cname =
            '${_ContractxModels[0].expname}( ${_ContractxModels[0].unit} )\n${_ContractxModels[0].meter}';
        _cnamex = '${_ContractxModels[0].expname}';
        _cser = _ContractxModels[0].ser;
        _cunitser = _ContractxModels[0].unitser;
        _cunit = _ContractxModels[0].unit;
        _cqty_vat = _ContractxModels[0].qty;
      });
    }

    setState(() {
      red_Trans(_cser);
    });
  }

  ///----------------->
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xfff3f3ee),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
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
                      for (int index = 0;
                          index < _ContractxModels.length;
                          index++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _celvat = _ContractxModels[index].nvat;
                                _cname =
                                    '${_ContractxModels[index].expname}( ${_ContractxModels[index].unit} )\n${_ContractxModels[index].meter}';
                                _cnamex = '${_ContractxModels[index].expname}';
                                _cser = _ContractxModels[index].ser;
                                _cunitser = _ContractxModels[index].unitser;
                                _cunit = _ContractxModels[index].unit;
                                _cqty_vat = _ContractxModels[index].qty;

                                red_Trans(_cser);
                                Ser__TapContractx = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: (Ser__TapContractx == index)
                                    ? Colors.blue[500]
                                    : Colors.blue[200],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.white, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 25,
                                        maxLines: 1,
                                        '${_ContractxModels[index].expname}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (Ser__TapContractx == index)
                                                ? Colors.white
                                                : PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 25,
                                        maxLines: 1,
                                        '( ${_ContractxModels[index].unit} )',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (Ser__TapContractx == index)
                                                ? Colors.white
                                                : PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 25,
                                        maxLines: 1,
                                        '${_ContractxModels[index].meter}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (Ser__TapContractx == index)
                                                ? Colors.white
                                                : PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Text(
                              //   '${_ContractxModels[index].expname}( ${_ContractxModels[index].unit} )\n${_ContractxModels[index].meter}',
                              //   textAlign: TextAlign.center,
                              //   style: const TextStyle(
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 15.0),
                              // ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            _ContractxModels.isEmpty
                ? const SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              Container(
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width * 0.84
                                      : 800,
                                  // height: MediaQuery.of(context).size.width * 0.5,
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.blue[200],
                                              borderRadius:
                                                  const BorderRadius.only(
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
                                                '$_cname',
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
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
                                    Container(
                                      height: 70,
                                      color: Colors.blue[200],
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                'เดือน',
                                                maxLines: 1,
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
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'ก่อน',
                                                      maxLines: 1,
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
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'เลขมิเตอร์(หน่วย)',
                                                      maxLines: 1,
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'หลัง',
                                                      maxLines: 1,
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
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'เลขมิเตอร์(หน่วย)',
                                                      maxLines: 1,
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'ราคาต่อหน่วย $_cqty_vat',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
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
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'ใช้ไป(หน่วย)',
                                                      maxLines: 1,
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      'ยอดเงิน',
                                                      maxLines: 1,
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
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      '(รวม vat $_celvat %)',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: (Responsive.isDesktop(context))
                                          ? MediaQuery.of(context).size.width *
                                              0.84
                                          : 800,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      // padding: EdgeInsets.only(bottom: 20),
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
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
                                        controller: _scrollController1,
                                        // itemExtent: 50,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _TransModels.length,
                                        itemBuilder: (BuildContext context,
                                            int indextran) {
                                          // ignore: curly_braces_in_flow_control_structures
                                          return Container(
                                            color: tappedIndex_1 ==
                                                    indextran.toString()
                                                ? tappedIndex_Color
                                                    .tappedIndex_Colors
                                                    .withOpacity(0.5)
                                                : null,
                                            child: ListTile(
                                              onTap: () {
                                                setState(() {
                                                  tappedIndex_1 =
                                                      indextran.toString();
                                                });
                                              },
                                              title: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      // ignore: unnecessary_string_interpolations
                                                      '${DateFormat.MMMM('th_TH').format((DateTime.parse('${_TransModels[indextran].duedate} 00:00:00')))}\n${DateTime.parse('${_TransModels[indextran].duedate} 00:00:00').year + 543}',
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
                                                    flex: 1,
                                                    child: _cunitser != '6'
                                                        ? Text(
                                                            '$_cunit',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          )
                                                        : Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              // color: Colors.green,
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
                                                                        6),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                              // border: Border.all(color: Colors.grey, width: 1),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: indextran ==
                                                                    0
                                                                ? _TransModels[indextran]
                                                                            .ovalue !=
                                                                        null
                                                                    ? Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade300,
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
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          indextran == 0
                                                                              ? '${_TransModels[indextran].ovalue}'
                                                                              : '${_TransModels[indextran - 1].nvalue}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              //fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      )
                                                                    : TextFormField(
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        showCursor: indextran ==
                                                                                0
                                                                            ? _TransModels[indextran].ovalue == null
                                                                                ? true
                                                                                : false
                                                                            : false,
                                                                        readOnly: indextran ==
                                                                                0
                                                                            ? _TransModels[indextran].ovalue == null
                                                                                ? false
                                                                                : true
                                                                            : true,
                                                                        initialValue: indextran ==
                                                                                0
                                                                            ? _TransModels[indextran].ovalue
                                                                            : _TransModels[indextran - 1].nvalue,
                                                                        onFieldSubmitted:
                                                                            (value) async {
                                                                          if (indextran ==
                                                                              0) {
                                                                            if (_TransModels[indextran].ovalue ==
                                                                                null) {
                                                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                              String? ren = preferences.getString('renTalSer');
                                                                              String? ser_user = preferences.getString('ser');
                                                                              var qser = _TransModels[indextran].ser;

                                                                              var oval = '$_cnamex ${DateFormat.MMM('th_TH').format((DateTime.parse('${_TransModels[indextran].date} 00:00:00')))} ${DateTime.parse('${_TransModels[indextran].date} 00:00:00').year + 543}';
                                                                              String url = '${MyConstant().domain}/InC_Invoice.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user&oval=$oval&con_ser=$_cser';

                                                                              try {
                                                                                var response = await http.get(Uri.parse(url));

                                                                                var result = json.decode(response.body);
                                                                                print(result);
                                                                                if (result.toString() != 'null') {
                                                                                  setState(() {
                                                                                    red_Trans(_cser);
                                                                                  });
                                                                                }
                                                                              } catch (e) {}
                                                                            }
                                                                          }
                                                                        },
                                                                        cursorColor:
                                                                            Colors.black,
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
                                                                            // labelText: 'ระบุชื่อร้านค้า',
                                                                            labelStyle: const TextStyle(color: Colors.black54, fontFamily: Font_.Fonts_T)),
                                                                        inputFormatters: <
                                                                            TextInputFormatter>[
                                                                          // for below version 2 use this
                                                                          FilteringTextInputFormatter.allow(
                                                                              RegExp(r'[0-9]')),
                                                                          // for version 2 and greater youcan also use this
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly
                                                                        ],
                                                                      )
                                                                : Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
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
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      indextran ==
                                                                              0
                                                                          ? '${_TransModels[indextran].ovalue}'
                                                                          : _TransModels[indextran - 1].nvalue == null
                                                                              ? ''
                                                                              : '${_TransModels[indextran - 1].nvalue}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
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
                                                    child: _cunitser != '6'
                                                        ? Text(
                                                            '$_cunit',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          )
                                                        : _TransModels[indextran]
                                                                        .docno_in ==
                                                                    null ||
                                                                _TransModels[
                                                                            indextran]
                                                                        .docno_in ==
                                                                    ''
                                                            ? Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  // color: Colors.green,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            6),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            6),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            6),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            6),
                                                                  ),
                                                                  // border: Border.all(color: Colors.grey, width: 1),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  showCursor: _TransModels[indextran].docno_in ==
                                                                              null ||
                                                                          _TransModels[indextran].docno_in ==
                                                                              ''
                                                                      ? true
                                                                      : false,
                                                                  //add this line
                                                                  readOnly: _TransModels[indextran].docno_in ==
                                                                              null ||
                                                                          _TransModels[indextran].docno_in ==
                                                                              ''
                                                                      ? false
                                                                      : true,

                                                                  initialValue:
                                                                      _TransModels[
                                                                              indextran]
                                                                          .nvalue,

                                                                  // controller: Form_nameshop,
                                                                  onFieldSubmitted:
                                                                      (value) async {
                                                                    if (indextran ==
                                                                        0) {
                                                                      SharedPreferences
                                                                          preferences =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String?
                                                                          ren =
                                                                          preferences
                                                                              .getString('renTalSer');
                                                                      String?
                                                                          ser_user =
                                                                          preferences
                                                                              .getString('ser');

                                                                      var qser_in =
                                                                          _TransModels[indextran]
                                                                              .ser_in;
                                                                      var tran_expser =
                                                                          _TransModels[indextran]
                                                                              .expser;
                                                                      var qser_inn =
                                                                          _TransModels[indextran + 1]
                                                                              .ser_in;

                                                                      var tran_ser =
                                                                          _TransModels[indextran]
                                                                              .ser;
                                                                      var tran_sern =
                                                                          _TransModels[indextran + 1]
                                                                              .ser;
                                                                      var ovalue =
                                                                          _TransModels[indextran]
                                                                              .ovalue; // ก่อน
                                                                      var nvalue =
                                                                          _TransModels[indextran]
                                                                              .nvalue; // หลัง
                                                                      _celvat; //vat
                                                                      _cqty_vat; // หน่วย

                                                                      print(
                                                                          'ovalue>>>. $ovalue  ---- nvalue>>>>>> $nvalue');

                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/UPC_Invoice.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser&tran_sern=$tran_sern&qser_inn=$qser_inn&tran_expser=$tran_expser';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() !=
                                                                            'null') {
                                                                          setState(
                                                                              () {
                                                                            red_Trans(_cser);
                                                                          });
                                                                        }
                                                                      } catch (e) {}
                                                                    } else {
                                                                      if (_TransModels[indextran]
                                                                              .ovalue ==
                                                                          null) {
                                                                        if (_TransModels[indextran].ovalue ==
                                                                            null) {
                                                                          SharedPreferences
                                                                              preferences =
                                                                              await SharedPreferences.getInstance();
                                                                          String?
                                                                              ren =
                                                                              preferences.getString('renTalSer');
                                                                          String?
                                                                              ser_user =
                                                                              preferences.getString('ser');

                                                                          var qser_in =
                                                                              _TransModels[indextran].ser_in; // ser in

                                                                          var tran_ser =
                                                                              _TransModels[indextran].ser; // ser tran
                                                                          var ovalue =
                                                                              _TransModels[indextran - 1].nvalue; // ก่อน
                                                                          var nvalue =
                                                                              _TransModels[indextran].nvalue; // หลัง
                                                                          _celvat; //vat
                                                                          _cqty_vat; // หน่วย

                                                                          var oval =
                                                                              '$_cnamex ${DateFormat.MMM('th_TH').format((DateTime.parse('${_TransModels[indextran].date} 00:00:00')))} ${DateTime.parse('${_TransModels[indextran].date} 00:00:00').year + 543}';
                                                                          String
                                                                              url =
                                                                              '${MyConstant().domain}/InC_InvoiceNew.php?isAdd=true&ren=$ren&tran_ser=$tran_ser&qty=$value&ser_user=$ser_user&oval=$oval&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser';

                                                                          try {
                                                                            var response =
                                                                                await http.get(Uri.parse(url));

                                                                            var result =
                                                                                json.decode(response.body);
                                                                            print(result);
                                                                            if (result.toString() !=
                                                                                'null') {
                                                                              setState(() {
                                                                                red_Trans(_cser);
                                                                              });
                                                                            }
                                                                          } catch (e) {}
                                                                        }
                                                                      } else {
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();
                                                                        String?
                                                                            ren =
                                                                            preferences.getString('renTalSer');
                                                                        String?
                                                                            ser_user =
                                                                            preferences.getString('ser');

                                                                        var qser_in =
                                                                            _TransModels[indextran].ser_in;
                                                                        var qser_inn =
                                                                            _TransModels[indextran + 1].ser_in;
                                                                        var tran_expser =
                                                                            _TransModels[indextran].expser;
                                                                        var tran_sern =
                                                                            _TransModels[indextran + 1].ser;
                                                                        var tran_ser =
                                                                            _TransModels[indextran].ser;
                                                                        var ovalue =
                                                                            _TransModels[indextran].ovalue; // ก่อน
                                                                        var nvalue =
                                                                            _TransModels[indextran].nvalue; // หลัง
                                                                        _celvat; //vat
                                                                        _cqty_vat; // หน่วย

                                                                        print(
                                                                            'ovalue>>>. $ovalue  ---- nvalue>>>>>> $nvalue');

                                                                        String
                                                                            url =
                                                                            '${MyConstant().domain}/UPC_Invoice.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser&tran_sern=$tran_sern&qser_inn=$qser_inn&tran_expser=$tran_expser';

                                                                        try {
                                                                          var response =
                                                                              await http.get(Uri.parse(url));

                                                                          var result =
                                                                              json.decode(response.body);
                                                                          print(
                                                                              result);
                                                                          if (result.toString() !=
                                                                              'null') {
                                                                            setState(() {
                                                                              red_Trans(_cser);
                                                                            });
                                                                          }
                                                                        } catch (e) {}
                                                                      }
                                                                    }
                                                                  },
                                                                  cursorColor:
                                                                      Colors
                                                                          .black,
                                                                  decoration: InputDecoration(
                                                                      fillColor: Colors.white.withOpacity(0.3),
                                                                      filled: true,
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder: const OutlineInputBorder(
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
                                                                        borderSide:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      enabledBorder: const OutlineInputBorder(
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
                                                                        borderSide:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                      // labelText: 'ระบุชื่อร้านค้า',
                                                                      labelStyle: const TextStyle(
                                                                          color: Colors.black54,

                                                                          //fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T)),
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    // for below version 2 use this
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            r'[0-9]')),
                                                                    // for version 2 and greater youcan also use this
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly
                                                                  ],
                                                                ),
                                                              )
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            15),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            15),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15),
                                                                  ),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width: 1),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  '${_TransModels[indextran].nvalue}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${_TransModels[indextran].qty5}',
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
                                                    flex: 1,
                                                    child: Text(
                                                      '${_TransModels[indextran].amt}',
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
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            AutoSizeText(
                                              maxLines: 1,
                                              minFontSize: 5,
                                              maxFontSize: 12,
                                              '* กด Enter ทุกครั้งที่มีการเปลี่ยนแปลงข้อมูลเพื่อบันทึกข้อมูล',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: Font_.Fonts_T
                                                  // fontWeight: FontWeight.bold,
                                                  //fontSize: 10.0
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

                      Container(
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.84
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
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(3.0),
                                            child: const Text(
                                              'Top',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
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
                                            'Down',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
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
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(3.0),
                                        child: const Text(
                                          'Scroll',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0,
                                              fontFamily: FontWeight_.Fonts_T),
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

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //       width: MediaQuery.of(context).size.width / 2.8,
                      //       child: Column(children: [
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 4,
                      //               child: Container(
                      //                 height: 50,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.red[200],
                      //                   borderRadius: const BorderRadius.only(
                      //                     topLeft: Radius.circular(10),
                      //                     topRight: Radius.circular(10),
                      //                     bottomLeft: Radius.circular(0),
                      //                     bottomRight: Radius.circular(0),
                      //                   ),
                      //                   // border: Border.all(
                      //                   //     color: Colors.grey, width: 1),
                      //                 ),
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ไฟฟ้า',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.red[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'เดือน',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.red[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'เลขมิเตอร์(หน่วย)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.red[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ใช้ไป(หน่วย)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.red[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ยอดเงิน(บาท)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ยอดเริ่มต้น',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '70',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '0',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '0',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Container(
                      //           height: 200,
                      //           decoration: const BoxDecoration(
                      //             color: AppbackgroundColor.Sub_Abg_Colors,
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(0),
                      //               topRight: Radius.circular(0),
                      //               bottomLeft: Radius.circular(0),
                      //               bottomRight: Radius.circular(0),
                      //             ),
                      //             // border: Border.all(
                      //             //     color: Colors.grey, width: 1),
                      //           ),
                      //           child: ListView.builder(
                      //             controller: _scrollController1,
                      //             // itemExtent: 50,
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             shrinkWrap: true,
                      //             itemCount: 12,
                      //             itemBuilder: (BuildContext context, int index) {
                      //               return ListTile(
                      //                 title: Row(
                      //                   children: [
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${mont[index]}',
                      //                         textAlign: TextAlign.center,
                      //                         style: const TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${750 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${230 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${1386 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         ),
                      //         Container(
                      //             width: MediaQuery.of(context).size.width,
                      //             decoration: const BoxDecoration(
                      //               color: AppbackgroundColor.Sub_Abg_Colors,
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(0),
                      //                   topRight: Radius.circular(0),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: Row(
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.all(8.0),
                      //                         child: InkWell(
                      //                           onTap: () {
                      //                             _scrollController1.animateTo(
                      //                               0,
                      //                               duration: const Duration(seconds: 1),
                      //                               curve: Curves.easeOut,
                      //                             );
                      //                           },
                      //                           child: Container(
                      //                               decoration: BoxDecoration(
                      //                                 // color: AppbackgroundColor
                      //                                 //     .TiTile_Colors,
                      //                                 borderRadius:
                      //                                     const BorderRadius.only(
                      //                                         topLeft: Radius.circular(6),
                      //                                         topRight:
                      //                                             Radius.circular(6),
                      //                                         bottomLeft:
                      //                                             Radius.circular(6),
                      //                                         bottomRight:
                      //                                             Radius.circular(8)),
                      //                                 border: Border.all(
                      //                                     color: Colors.grey, width: 1),
                      //                               ),
                      //                               padding: const EdgeInsets.all(3.0),
                      //                               child: const Text(
                      //                                 'Top',
                      //                                 style: TextStyle(
                      //                                     color: Colors.grey,
                      //                                     fontSize: 10.0),
                      //                               )),
                      //                         ),
                      //                       ),
                      //                       InkWell(
                      //                         onTap: () {
                      //                           if (_scrollController1.hasClients) {
                      //                             final position = _scrollController1
                      //                                 .position.maxScrollExtent;
                      //                             _scrollController1.animateTo(
                      //                               position,
                      //                               duration: const Duration(seconds: 1),
                      //                               curve: Curves.easeOut,
                      //                             );
                      //                           }
                      //                         },
                      //                         child: Container(
                      //                             decoration: BoxDecoration(
                      //                               // color: AppbackgroundColor
                      //                               //     .TiTile_Colors,
                      //                               borderRadius: const BorderRadius.only(
                      //                                   topLeft: Radius.circular(6),
                      //                                   topRight: Radius.circular(6),
                      //                                   bottomLeft: Radius.circular(6),
                      //                                   bottomRight: Radius.circular(6)),
                      //                               border: Border.all(
                      //                                   color: Colors.grey, width: 1),
                      //                             ),
                      //                             padding: const EdgeInsets.all(3.0),
                      //                             child: const Text(
                      //                               'Down',
                      //                               style: TextStyle(
                      //                                   color: Colors.grey,
                      //                                   fontSize: 10.0),
                      //                             )),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerRight,
                      //                   child: Row(
                      //                     children: [
                      //                       InkWell(
                      //                         onTap: _moveUp1,
                      //                         child: const Padding(
                      //                             padding: EdgeInsets.all(8.0),
                      //                             child: Align(
                      //                               alignment: Alignment.centerLeft,
                      //                               child: Icon(
                      //                                 Icons.arrow_upward,
                      //                                 color: Colors.grey,
                      //                               ),
                      //                             )),
                      //                       ),
                      //                       Container(
                      //                           decoration: BoxDecoration(
                      //                             // color: AppbackgroundColor
                      //                             //     .TiTile_Colors,
                      //                             borderRadius: const BorderRadius.only(
                      //                                 topLeft: Radius.circular(6),
                      //                                 topRight: Radius.circular(6),
                      //                                 bottomLeft: Radius.circular(6),
                      //                                 bottomRight: Radius.circular(6)),
                      //                             border: Border.all(
                      //                                 color: Colors.grey, width: 1),
                      //                           ),
                      //                           padding: const EdgeInsets.all(3.0),
                      //                           child: const Text(
                      //                             'Scroll',
                      //                             style: TextStyle(
                      //                                 color: Colors.grey, fontSize: 10.0),
                      //                           )),
                      //                       InkWell(
                      //                         onTap: _moveDown1,
                      //                         child: const Padding(
                      //                             padding: EdgeInsets.all(8.0),
                      //                             child: Align(
                      //                               alignment: Alignment.centerRight,
                      //                               child: Icon(
                      //                                 Icons.arrow_downward,
                      //                                 color: Colors.grey,
                      //                               ),
                      //                             )),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ))
                      //       ])),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //       width: MediaQuery.of(context).size.width / 2.5,
                      //       child: Column(children: [
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 4,
                      //               child: Container(
                      //                 height: 50,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.blue[200],
                      //                   borderRadius: const BorderRadius.only(
                      //                     topLeft: Radius.circular(10),
                      //                     topRight: Radius.circular(10),
                      //                     bottomLeft: Radius.circular(0),
                      //                     bottomRight: Radius.circular(0),
                      //                   ),
                      //                   // border: Border.all(
                      //                   //     color: Colors.grey, width: 1),
                      //                 ),
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'น้ำ',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.blue[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'เดือน',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.blue[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'เลขมิเตอร์(หน่วย)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.blue[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ใช้ไป(หน่วย)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.blue[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ยอดเงิน(บาท)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ยอดเริ่มต้น',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '70',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '0',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '0',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Container(
                      //           height: 200,
                      //           decoration: const BoxDecoration(
                      //             color: AppbackgroundColor.Sub_Abg_Colors,
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(0),
                      //               topRight: Radius.circular(0),
                      //               bottomLeft: Radius.circular(0),
                      //               bottomRight: Radius.circular(0),
                      //             ),
                      //             // border: Border.all(
                      //             //     color: Colors.grey, width: 1),
                      //           ),
                      //           child: ListView.builder(
                      //             controller: _scrollController2,
                      //             // itemExtent: 50,
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             shrinkWrap: true,
                      //             itemCount: 12,
                      //             itemBuilder: (BuildContext context, int index) {
                      //               return ListTile(
                      //                 title: Row(
                      //                   children: [
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${mont[index]}',
                      //                         textAlign: TextAlign.center,
                      //                         style: const TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${70 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${83 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${390 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         ),
                      //         Container(
                      //             width: MediaQuery.of(context).size.width,
                      //             decoration: const BoxDecoration(
                      //               color: AppbackgroundColor.Sub_Abg_Colors,
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(0),
                      //                   topRight: Radius.circular(0),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: Row(
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.all(8.0),
                      //                         child: InkWell(
                      //                           onTap: () {
                      //                             _scrollController2.animateTo(
                      //                               0,
                      //                               duration: const Duration(seconds: 1),
                      //                               curve: Curves.easeOut,
                      //                             );
                      //                           },
                      //                           child: Container(
                      //                               decoration: BoxDecoration(
                      //                                 // color: AppbackgroundColor
                      //                                 //     .TiTile_Colors,
                      //                                 borderRadius:
                      //                                     const BorderRadius.only(
                      //                                         topLeft: Radius.circular(6),
                      //                                         topRight:
                      //                                             Radius.circular(6),
                      //                                         bottomLeft:
                      //                                             Radius.circular(6),
                      //                                         bottomRight:
                      //                                             Radius.circular(8)),
                      //                                 border: Border.all(
                      //                                     color: Colors.grey, width: 1),
                      //                               ),
                      //                               padding: const EdgeInsets.all(3.0),
                      //                               child: const Text(
                      //                                 'Top',
                      //                                 style: TextStyle(
                      //                                     color: Colors.grey,
                      //                                     fontSize: 10.0),
                      //                               )),
                      //                         ),
                      //                       ),
                      //                       InkWell(
                      //                         onTap: () {
                      //                           if (_scrollController2.hasClients) {
                      //                             final position = _scrollController2
                      //                                 .position.maxScrollExtent;
                      //                             _scrollController2.animateTo(
                      //                               position,
                      //                               duration: const Duration(seconds: 1),
                      //                               curve: Curves.easeOut,
                      //                             );
                      //                           }
                      //                         },
                      //                         child: Container(
                      //                             decoration: BoxDecoration(
                      //                               // color: AppbackgroundColor
                      //                               //     .TiTile_Colors,
                      //                               borderRadius: const BorderRadius.only(
                      //                                   topLeft: Radius.circular(6),
                      //                                   topRight: Radius.circular(6),
                      //                                   bottomLeft: Radius.circular(6),
                      //                                   bottomRight: Radius.circular(6)),
                      //                               border: Border.all(
                      //                                   color: Colors.grey, width: 1),
                      //                             ),
                      //                             padding: const EdgeInsets.all(3.0),
                      //                             child: const Text(
                      //                               'Down',
                      //                               style: TextStyle(
                      //                                   color: Colors.grey,
                      //                                   fontSize: 10.0),
                      //                             )),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerRight,
                      //                   child: Row(
                      //                     children: [
                      //                       InkWell(
                      //                         onTap: _moveUp2,
                      //                         child: const Padding(
                      //                             padding: EdgeInsets.all(8.0),
                      //                             child: Align(
                      //                               alignment: Alignment.centerLeft,
                      //                               child: Icon(
                      //                                 Icons.arrow_upward,
                      //                                 color: Colors.grey,
                      //                               ),
                      //                             )),
                      //                       ),
                      //                       Container(
                      //                           decoration: BoxDecoration(
                      //                             // color: AppbackgroundColor
                      //                             //     .TiTile_Colors,
                      //                             borderRadius: const BorderRadius.only(
                      //                                 topLeft: Radius.circular(6),
                      //                                 topRight: Radius.circular(6),
                      //                                 bottomLeft: Radius.circular(6),
                      //                                 bottomRight: Radius.circular(6)),
                      //                             border: Border.all(
                      //                                 color: Colors.grey, width: 1),
                      //                           ),
                      //                           padding: const EdgeInsets.all(3.0),
                      //                           child: const Text(
                      //                             'Scroll',
                      //                             style: TextStyle(
                      //                                 color: Colors.grey, fontSize: 10.0),
                      //                           )),
                      //                       InkWell(
                      //                         onTap: _moveDown2,
                      //                         child: const Padding(
                      //                             padding: EdgeInsets.all(8.0),
                      //                             child: Align(
                      //                               alignment: Alignment.centerRight,
                      //                               child: Icon(
                      //                                 Icons.arrow_downward,
                      //                                 color: Colors.grey,
                      //                               ),
                      //                             )),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ))
                      //       ])),
                      // ),
                    ],
                  ),
            // SizedBox(
            //   height: 20,
            // ),
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     width: 200,
            //     decoration: BoxDecoration(
            //       color: Colors.green,
            //       borderRadius: const BorderRadius.only(
            //           topLeft: Radius.circular(10),
            //           topRight: Radius.circular(10),
            //           bottomLeft: Radius.circular(10),
            //           bottomRight: Radius.circular(10)),
            //       border: Border.all(color: Colors.grey, width: 1),
            //     ),
            //     padding: const EdgeInsets.all(8.0),
            //     child: Center(
            //       child: const AutoSizeText(
            //         minFontSize: 10,
            //         maxFontSize: 15,
            //         'บันทึกและตั้งหนี้',
            //         style: TextStyle(
            //             color: PeopleChaoScreen_Color.Colors_Text1_,
            //             fontWeight: FontWeight.bold,
            //             fontFamily: FontWeight_.Fonts_T
            //             //fontSize: 10.0
            //             //0953873075
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
