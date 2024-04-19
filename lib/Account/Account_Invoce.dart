import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:ftpconnect/ftpconnect.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetTrans_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import '../Model/GetPayMent_Model.dart';

class AccountInvoice extends StatefulWidget {
  const AccountInvoice({super.key});

  @override
  State<AccountInvoice> createState() => _AccountInvoiceState();
}

class _AccountInvoiceState extends State<AccountInvoice> {
  String tappedIndex_ = '';
  DateTime newDatetime = DateTime.now();
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var End_Bill_Paydate;
  List<TransModel> _TransModels = [];
  List<PayMentModel> _PayMentModels = [];
  DateTime? _selected;
  String? paymentSer1, paymentName1, paymentSer2, paymentName2, selectedValue;
  @override
  void initState() {
    super.initState();
    End_Bill_Paydate = DateFormat('yyyy-MM-dd').format(newDatetime);
    read_Trans_invoice_all();
    red_payMent();
  }

  Future<Null> red_payMent() async {
    if (_PayMentModels.length != 0) {
      setState(() {
        _PayMentModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren';
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
            }
          });
          if (_PayMentModel.btser.toString() == '1') {
          } else {}
        }

        if (paymentSer1 == null) {
          paymentSer1 = 0.toString();
          paymentName1 = 'เลือก'.toString();
        }
      }
    } catch (e) {}
  }

  Future<Null> read_Trans_invoice_all() async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    var serMONTH = _selected == null
        ? DateFormat('MM').format(newDatetime)
        : DateFormat('MM').format(_selected!);
    var serYEAR = _selected == null
        ? DateFormat('yyyy').format(newDatetime)
        : DateFormat('yyyy').format(_selected!);

    print('serYEAR >> $serMONTH $serYEAR');

    String url =
        '${MyConstant().domain}/GC_tran_invoice_all_account.php?isAdd=true&ren=$ren&user=$user&serMONTH=$serMONTH&serYEAR=$serYEAR';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'true') {
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);
          setState(() {
            _TransModels.add(_TransModel);
          });
          // print('zzzzasaaa123454>>>>  $cFinn');
          // print('docnodocnodocnodocnodocno123456>>>>  ${transBillModel.docno}');
        }
      }
    } catch (e) {}
    // Future.delayed(const Duration(milliseconds: 200), () async {
    //   setState(() {
    //     red_Trans_bill();
    //   });
    // });
  }

  Future<void> _onshowMonth({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
        context: context,
        initialDate: _selected ?? DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2050),
        locale: localeObj,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.green, // <-- SEE HERE
                // onPrimary: Colors.green, // <-- SEE HERE
                // onSurface: Colors.green, // <-- SEE HERE
              ),
              // textButtonTheme: TextButtonThemeData(
              //   style: TextButton.styleFrom(
              //     primary: Colors.red, // button text color
              //   ),
              // ),
            ),
            child: child!,
          );
        });
    // final selected = await showDatePicker(
    //   context: context,
    //   initialDate: _selected ?? DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime(2022),
    //   locale: localeObj,
    // );
    if (selected != null) {
      setState(() {
        _selected = selected;
        read_Trans_invoice_all();
      });
    }
  }

  ///////////--------------------------------------------->
  // ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///////////--------------------------------------------->
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
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppbackgroundColor
                                                            .Sub_Abg_Colors
                                                        .withOpacity(0.5),
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
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'เดือน/ปี : ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              AccountScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Container(
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
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
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: TextButton(
                                                            onPressed:
                                                                () async {
                                                              _onshowMonth(
                                                                  context:
                                                                      context,
                                                                  locale: 'th');
                                                            },
                                                            child: Text(
                                                              _selected == null
                                                                  ? DateFormat.yMMMM(
                                                                          'th_TH')
                                                                      .format(
                                                                          newDatetime)
                                                                      .toString()
                                                                  : DateFormat.yMMMM(
                                                                          'th_TH')
                                                                      .format(
                                                                          _selected!)
                                                                      .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: AccountScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      (_TransModels.isEmpty)
                                                          ? SizedBox()
                                                          : SizedBox(
                                                              height: 40,
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  select_Date(
                                                                      context);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'วันที่ครบกำหนดชำระ : ',
                                                                      style: TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          //fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          6,
                                                                          6,
                                                                          0,
                                                                          6),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius: const BorderRadius
                                                                              .only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(0),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(0)),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 1),
                                                                        ),
                                                                        // width: 120,
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${End_Bill_Paydate}'))}',
                                                                            // '${End_Bill_Paydate}',
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius: const BorderRadius
                                                                              .only(
                                                                              topLeft: Radius.circular(0),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(0),
                                                                              bottomRight: Radius.circular(10)),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 1),
                                                                        ),
                                                                        // width: 120,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_drop_down,
                                                                          color:
                                                                              Colors.black,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                      (_TransModels.isEmpty)
                                                          ? SizedBox()
                                                          : SizedBox(
                                                              width: 10,
                                                            ),
                                                      (_TransModels.isEmpty)
                                                          ? SizedBox()
                                                          : Text(
                                                              'รูปแบบชำระ',
                                                              style:
                                                                  const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                      (_TransModels.isEmpty)
                                                          ? SizedBox()
                                                          : Container(
                                                              height: 50,
                                                              width: 350,
                                                              // color:
                                                              //     AppbackgroundColor
                                                              //         .Sub_Abg_Colors,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppbackgroundColor
                                                                      .Sub_Abg_Colors,
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
                                                                          Radius.circular(
                                                                              10)),
                                                                  // border: Border.all(
                                                                  //     color: Colors.grey, width: 1),
                                                                ),
                                                                width: 120,
                                                                child:
                                                                    DropdownButtonFormField2(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //Add isDense true and zero Padding.
                                                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                    isDense:
                                                                        true,
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    //Add more decoration as you want here
                                                                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                  ),
                                                                  isExpanded:
                                                                      true,
                                                                  // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                  hint: Row(
                                                                    children: [
                                                                      Text(
                                                                        '$paymentName1',
                                                                        style: const TextStyle(
                                                                            fontSize: 14,
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .black45,
                                                                  ),
                                                                  iconSize: 25,
                                                                  buttonHeight:
                                                                      42,
                                                                  // buttonPadding:
                                                                  //     const EdgeInsets
                                                                  //         .only(
                                                                  //         left:
                                                                  //             10,
                                                                  //         right:
                                                                  //             10),
                                                                  dropdownDecoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  ),
                                                                  items: _PayMentModels.map((item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            selectedValue =
                                                                                item.bno!;
                                                                          });
                                                                          print(
                                                                              '**/*/*   --- ${selectedValue}');
                                                                        },
                                                                        value:
                                                                            '${item.ser}:${item.ptname}',
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                '${item.ptname!}',
                                                                                textAlign: TextAlign.start,
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
                                                                                textAlign: TextAlign.end,
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
                                                                  onChanged:
                                                                      (value) async {
                                                                    print(
                                                                        value);
                                                                    // Do something when changing the item if you want.

                                                                    var zones = value!
                                                                        .indexOf(
                                                                            ':');
                                                                    var rtnameSer =
                                                                        value.substring(
                                                                            0,
                                                                            zones);
                                                                    var rtnameName =
                                                                        value.substring(
                                                                            zones +
                                                                                1);
                                                                    // print(
                                                                    //     'mmmmm ${rtnameSer.toString()} $rtnameName');
                                                                    setState(
                                                                        () {
                                                                      paymentSer1 =
                                                                          rtnameSer
                                                                              .toString();

                                                                      if (rtnameSer
                                                                              .toString() ==
                                                                          '0') {
                                                                        paymentName1 =
                                                                            null;
                                                                      } else {
                                                                        paymentName1 =
                                                                            rtnameName.toString();
                                                                      }
                                                                      // paymentSer1 =
                                                                      //     rtnameSer;
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
                                                Expanded(
                                                    child: (_TransModels
                                                            .isEmpty)
                                                        ? SizedBox()
                                                        : SizedBox(
                                                            child: ButtonBill(),
                                                          ))
                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'ลำดับ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AccountScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'พื้นที่',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: AccountScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'ชื่อร้าน',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: AccountScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'ชื่อผู้เช่า',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: AccountScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'เลขที่สัญญา',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: AccountScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'เดือน',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: AccountScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'ปี',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: AccountScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'ยอดรวม',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      color: AccountScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
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
                                                  .height *
                                              0.63,
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
                                          child: _TransModels.isEmpty
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
                                                      _TransModels.length,
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
                                                            child: ListTile(
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    tappedIndex_ =
                                                                        '${index}';
                                                                  });
                                                                },
                                                                title:
                                                                    Container(
                                                                  decoration:
                                                                      const BoxDecoration(
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
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          '${index + 1}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AccountScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          '${_TransModels[index].refno}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AccountScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          '${_TransModels[index].ln}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AccountScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          '${_TransModels[index].sname}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AccountScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          '${_TransModels[index].cname}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AccountScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          DateFormat.MMMM('th_TH')
                                                                              .format(DateTime.parse('${_TransModels[index].date} 00:00:00'))
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AccountScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          DateFormat.y('th_TH')
                                                                              .format(DateTime.parse('${_TransModels[index].date} 00:00:00'))
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AccountScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          '${nFormat.format(double.parse(_TransModels[index].c_amt!))}',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AccountScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ),
                                                        )
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

  Future<Null> select_Date(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่ครบกำหนด', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month + 6, DateTime.now().day),
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
      // ignore: unnecessary_null_comparison
      if (picked != null) {
        var formatter = DateFormat('yyyy-MM-dd');
        print("${formatter.format(result!)}");
        setState(() {
          End_Bill_Paydate = "${formatter.format(result)}";
        });
      }
    });
  }

  Widget ButtonBill() {
    return Container(
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // width: 200,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextButton(
                  onPressed: () async {
                    print('docno$paymentSer1>>>>  $End_Bill_Paydate');
                    showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: const Center(
                            child: Text(
                          'ยืนยันการวางบิลทั้งหมด',
                          style: TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text1_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        content: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'ทั้งหมด ${_TransModels.length} รายการ',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(height: 1),
                                const Divider(),
                                const SizedBox(height: 1),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            print(
                                                'docno$paymentSer1>>>>  $End_Bill_Paydate');
                                            if (_TransModels.length != 0) {
                                              in_Trans_invoice_all();
                                            } else {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'กรุณาเลือก เดือน ปี ที่ต้องการวางบิล',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: Font_
                                                                .Fonts_T))),
                                              );
                                            }
                                          },
                                          child: Container(
                                              // height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade500,
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
                                                // border: Border.all(
                                                //     color: Colors.grey,
                                                //     width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ตกลง',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      // fontSize: 10.0,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              // height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
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
                                                // border: Border.all(
                                                //     color: Colors.grey,
                                                //     width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: Text(
                                                  'ยกเลิก',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      // fontSize: 10.0,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
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
                      ),
                    );
                  },
                  child: const Text(
                    "+ วางบิลทั้งหมด",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontWeight_.Fonts_T,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   width: 200,
            //   color: Colors.green,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: TextButton(
            //       onPressed: () async {
            //         if (_TransModels.length != 0) {
            //           in_Trans_invoice_all();
            //         } else {
            //           ScaffoldMessenger.of(context).showSnackBar(
            //             const SnackBar(
            //                 content: Text(
            //                     'กรุณาเลือก เดือน ปี ที่ต้องการวางบิล',
            //                     style: TextStyle(
            //                         color: Colors.white,
            //                         fontFamily: Font_.Fonts_T))),
            //           );
            //         }
            //       },
            //       child: const Text(
            //         "วางบิลทั้งหมด",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontFamily: Font_.Fonts_T,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<Null> in_Trans_invoice_all() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var serMONTH = _selected == null
        ? DateFormat('MM').format(newDatetime)
        : DateFormat('MM').format(_selected!);
    var serYEAR = _selected == null
        ? DateFormat('yyyy').format(newDatetime)
        : DateFormat('yyyy').format(_selected!);

    var c_payment_Ser = paymentSer1;
    var End_Bill_Paydate_ = End_Bill_Paydate;

    print('docno$paymentSer1>>>>  $End_Bill_Paydate');

    String url =
        '${MyConstant().domain}/In_tran_invoice_all_account.php?isAdd=true&ren=$ren&user=$user&serMONTH=$serMONTH&serYEAR=$serYEAR&pay_Ser1=$paymentSer1&pay_date=$End_Bill_Paydate';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        // for (var map in result) {
        //   // TransBillModel transBillModel = TransBillModel.fromJson(map);
        //   // setState(() {
        //   //   cFinn = transBillModel.docno;
        //   // });
        //   // print('zzzzasaaa123454>>>>  $cFinn');
        //   // print('docnodocnodocnodocnodocno123456>>>>  ${transBillModel.docno}');
        // }

        Insert_log.Insert_logs(
            'บัญชี', 'วางบิลทั้งหมด>>บันทึก(${user.toString()})');
        setState(() {
          read_Trans_invoice_all();
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('บันทึกรายการวางบิลสำเร็จ',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
    // Future.delayed(const Duration(milliseconds: 200), () async {
    //   setState(() {
    //     red_Trans_bill();
    //   });
    // });
  }
}
