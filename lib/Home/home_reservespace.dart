import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

import '../AdminScaffold/AdminScaffold.dart';
import '../Beam/Beam_apiPassw.dart';
import '../Beam/Beam_api_check_Pay.dart';
import '../Beam/Beam_api_disabled.dart';
import '../Beam/webviewPay_beamcheckout.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetC_rantaldata_Model.dart';
import '../Model/GetContract_Book_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/areak_model.dart';
import '../PeopleChao/webviewPay.dart';
import '../PeopleChao/webview_show.dart';
import '../Responsive/responsive.dart';
import '../Setting/Webview.dart';
import '../Style/colors.dart';
import 'dart:html' as html;

class HomeReserveSpace extends StatefulWidget {
  const HomeReserveSpace({super.key});

  @override
  State<HomeReserveSpace> createState() => _HomeReserveSpaceState();
}

class _HomeReserveSpaceState extends State<HomeReserveSpace> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime newDatetime = DateTime.now();
  List<GlobalKey> _btnKeys = [];
  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];
  List<AreaModel> _areaModels = <AreaModel>[];
  List<RenTalModel> renTalModels = [];
  List<ExpModel> expModels = [];
  List<ContractBookModel> contractBookModels = [];
  List<RenTaldataModel> renTaldataModels = [];
  List<AreakModel> selected_Area = [];
  List<dynamic> allowedWeekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  final _formKey = GlobalKey<FormState>();
  final TextForm_name = TextEditingController();
  final TextForm_tel = TextEditingController();
  final TextForm_tax = TextEditingController();
  final TextForm_email = TextEditingController();
  final TextForm_time = TextEditingController();
  final Form_payment1 = TextEditingController();

  final TextForm_time_hr = TextEditingController();
  final TextForm_time_min = TextEditingController();
  final TextForm_time_sec = TextEditingController();

  List<PayMentModel> _PayMentModels = [];
  int zone_ser = 0, open_set_date = 30;
  double sum_total_book = 0;
  int ser_data_Detail = 0, conbook = -1;
  DateTime now = DateTime.now();
  String? SDatex_total1_,
      zone_img,
      naem_book,
      docno_book,
      tax_book,
      tel_book,
      date_book,
      slip_book;
  String? base64_Imgmap, foder, cFinn;
  String? rtname, type, typex, renname, pkname, ser_Zonex, img_;
  String? paymentSer1, paymentName1, Pay_Ke, selectedValue, bname1;
  String? renTal_user,
      renTal_name,
      zone_name,
      Value_cid,
      fname_,
      pdate,
      number_custno,
      img_logo,
      img_zone,
      img_map;

  String? bill_name,
      bill_addr,
      bill_tax,
      bill_tel,
      bill_email,
      expbill,
      expbill_name,
      bill_default,
      bill_tser,
      bills_name_,
      numinvoice,
      newValuePDFimg_QR;
  String? base64_Slip, fileName_Slip, Slip_status;
  @override
  void initState() {
    super.initState();
    // SDatex_total1_ = DateFormat('yyyy-MM-dd').format(now);
    read_GC_rental();
    read_GC_zone();
    // read_GC_area();
    read_GC_rental_data_All();
    read_GC_Exp();
    red_payMent();
  }

  Future<Null> read_GC_rental() async {
    DateTime datex = DateTime.now();
    // read_GC_areak();

    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    setState(() {
      if (TextForm_time_hr.text != '') {
      } else {
        // var Time = DateTime.now();

        setState(() {
          TextForm_time_hr.text = (datex.hour.toString().length < 2)
              ? '0${datex.hour}'
              : '${datex.hour}';
          TextForm_time_min.text = (datex.minute.toString().length < 2)
              ? '0${datex.minute}'
              : '${datex.minute}';
          TextForm_time_sec.text = (datex.second.toString().length < 2)
              ? '0${datex.second}'
              : '${datex.second}';
        });
      }
    });

    setState(() {
      SDatex_total1_ = '${DateFormat('yyyy-MM-dd').format(datex)}';
      TextForm_time.text =
          '${TextForm_time_hr.text}:${TextForm_time_min.text}:${TextForm_time_sec.text}';
    });
    read_GC_area();
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
          var open_set_datex = int.parse(renTalModel.open_set_date!);
          setState(() {
            pkname = renTalModel.pk!.trim();
            img_ = renTalModel.img;

            open_set_date = open_set_datex == 0 ? 30 : open_set_datex;

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
            img_logo = renTalModel.imglogo;
            img_map = renTalModel.img;
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
    // print('name>>>>>  $renname');
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
        for (var map in result) {
          PayMentModel _PayMentModel = PayMentModel.fromJson(map);
          var autox = _PayMentModel.auto;
          var serx = _PayMentModel.ser;
          var ptnamex = _PayMentModel.ptname;
          var paykey = _PayMentModel.key_b;
          setState(() {
            if (_PayMentModel.ser_payweb! == '1') {
              _PayMentModels.add(_PayMentModel);
              // if (autox == '1') {
              Pay_Ke = paykey.toString();
              paymentSer1 = serx.toString();
              paymentName1 = ptnamex.toString();
              selectedValue = _PayMentModel.bno.toString();
              bname1 = _PayMentModel.bname.toString();
              // Form_payment1.text =
              //     (sum_amt - sum_disamt).toStringAsFixed(2).toString();
              // }
            }
          });
        }
        // if (paymentName1 == null) {
        //   paymentSer1 = 0.toString();
        //   paymentName1 = 'เลือก'.toString();
        //   setState(() {
        //     Form_payment1.text =
        //         (sum_amt - sum_disamt).toStringAsFixed(2).toString();
        //   });
        // }
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
      // print(result);
      if (result != null) {
        for (var map in result) {
          ExpModel expModel = ExpModel.fromJson(map);
          if (expModel.show_book.toString() == '1') {
            setState(() {
              expModels.add(expModel);
            });
          } else {}
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_rental_data_All() async {
    setState(() {
      renTaldataModels.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_rental_data_All.php?isAdd=true&serren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      for (var map in result) {
        RenTaldataModel renTaldataModel = RenTaldataModel.fromJson(map);

        setState(() {
          renTaldataModels.add(renTaldataModel);
        });
/////-------------------------->
        setState(() {
          if (renTaldataModel.d1.toString() == '0') {
            allowedWeekdays.remove('Sunday');
          }
          if (renTaldataModel.d2.toString() == '0') {
            allowedWeekdays.remove('Monday');
          }
          if (renTaldataModel.d3.toString() == '0') {
            allowedWeekdays.remove('Tuesday');
          }
          if (renTaldataModel.d4.toString() == '0') {
            allowedWeekdays.remove('Wednesday');
          }
          if (renTaldataModel.d5.toString() == '0') {
            allowedWeekdays.remove('Thursday');
          }
          if (renTaldataModel.d6.toString() == '0') {
            allowedWeekdays.remove('Friday');
          }
          if (renTaldataModel.d7.toString() == '0') {
            allowedWeekdays.remove('Saturday');
          }
        });
      }
    } catch (e) {}
  }

  double _scaleFactor = 1.0; // define the initial scale factor

  void _zoomIn() {
    setState(() {
      _scaleFactor *= 1.2; // increase the scale factor by 20%
    });
  }

  void _zoomOut() {
    setState(() {
      _scaleFactor /= 1.2; // decrease the scale factor by 20%
    });
  }

  // Future<Null> read_GC_rental() async {
  //   if (renTalModels.isNotEmpty) {
  //     setState(() {
  //       renTalModels.clear();
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   String url =
  //       '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result != null) {
  //       for (var map in result) {
  //         RenTalModel renTalModel = RenTalModel.fromJson(map);
  //         var rtnamex = renTalModel.rtname;
  //         var typexs = renTalModel.type;
  //         var typexx = renTalModel.typex;
  //         var name = renTalModel.pn!.trim();
  //         var pkqtyx = int.parse(renTalModel.pkqty!);
  //         var pkuserx = int.parse(renTalModel.pkuser!);
  //         var pkx = renTalModel.pk!.trim();
  //         var foderx = renTalModel.dbn;
  //         var img = renTalModel.img;
  //         var imglogo = renTalModel.imglogo;
  //         var open_setx = int.parse(renTalModel.open_set!);
  //         var open_set_datex = int.parse(renTalModel.open_set_date!);
  //         var mass_onx = int.parse(renTalModel.mass_on!);
  //         var imglineqrx = renTalModel.imglineqr;
  //         setState(() {
  //           // acc_2 = renTalModel.acc2!;
  //           foder = foderx;
  //           rtname = rtnamex;
  //           type = typexs;
  //           typex = typexx;
  //           renname = name;
  //           // pkqty = pkqtyx;
  //           // pkuser = pkuserx;
  //           pkname = pkx;
  //           img_ = img;
  //           // img_logo = imglogo;
  //           // open_set = open_setx;
  //           open_set_date = open_set_datex == 0 ? 30 : open_set_datex;
  //           // mass_on = mass_onx;
  //           // lineqr = imglineqrx;
  //           renTalModels.add(renTalModel);
  //         });
  //       }
  //     } else {}
  //   } catch (e) {}
  //   // print('name>>>>>  $renname');
  // }

  Future<Null> read_GC_area() async {
    if (areaModels.isNotEmpty) {
      setState(() {
        areaModels.clear();
        _areaModels.clear();
        selected_Area.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    //print('zone >>>>>> $zone');

    String url =
        '${MyConstant().domain}/GC_areaAll_booking.php?isAdd=true&ren=$ren&zone=$zone_ser&datelok=$SDatex_total1_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);

          setState(() {
            areaModels.add(areaModel);
          });
        }
      }
      setState(() {
        _areaModels = areaModels;
      });
    } catch (e) {}
  }

  Future<Null> read_GC_contractBook(doccid) async {
    if (contractBookModels.isNotEmpty) {
      setState(() {
        contractBookModels.clear();
        sum_total_book = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var cid = doccid;

    //print('zone >>>>>> $zone');

    String url =
        '${MyConstant().domain}/GC_area_bookcid.php?isAdd=true&ren=$ren&cid=$cid';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ContractBookModel contractBookModel = ContractBookModel.fromJson(map);
          var total = double.parse(contractBookModel.total!);
          setState(() {
            naem_book = contractBookModel.sname;
            sum_total_book = sum_total_book + total;
            docno_book = contractBookModel.cid;
            tax_book = contractBookModel.tax;
            tel_book = contractBookModel.tel;
            date_book = contractBookModel.daterec;
            slip_book = contractBookModel.slip;
            contractBookModels.add(contractBookModel);
          });
        }
      }
    } catch (e) {}
  }

  bool isAllowedDate(DateTime date) {
    String weekday = DateFormat('EEEE').format(date); // Get the weekday name
    return allowedWeekdays.contains(weekday);
  }

  Future<Null> _select_financial_StartDate(BuildContext context) async {
    DateTime initialDate;
    if (allowedWeekdays.contains(DateFormat('EEEE').format(DateTime.now()))) {
      initialDate = DateTime.now();
    } else {
      // Find the next valid weekday
      initialDate = DateTime.now().add(Duration(days: 1));
      while (
          !allowedWeekdays.contains(DateFormat('EEEE').format(initialDate))) {
        initialDate = initialDate.add(Duration(days: 1));
      }
    }

    final Future<DateTime?> picked = showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: initialDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
      // selectableDayPredicate: _decideWhichDayToEnable,
      selectableDayPredicate: (DateTime date) {
        return isAllowedDate(date);
      },
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
      setState(() {
        areaModels.clear();
        _areaModels.clear();
        selected_Area.clear();
      });
      if (picked != null) {
        var formatter = DateFormat('yyyy-MM-dd');
        print("${formatter.format(result!)}");
        setState(() {
          SDatex_total1_ = "${formatter.format(result)}";
        });
        read_GC_area();
      }
    });
  }

  Future<Null> read_GC_zone() async {
    if (zoneModels.length != 0) {
      zoneModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var zoneSubSer = preferences.getString('zoneSubSer');
    var zonesSubName = preferences.getString('zonesSubName');
    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      //print(result);
      // Map<String, dynamic> map = Map();
      // map['ser'] = '0';
      // map['rser'] = '0';
      // map['zn'] = 'ทั้งหมด';
      // map['qty'] = '0';
      // map['img'] = '0';
      // map['data_update'] = '0';

      // ZoneModel zoneModelx = ZoneModel.fromJson(map);

      // setState(() {
      //   zone_img = '${MyConstant().domain}/files/$foder/contract/$img_';
      //   zoneModels.add(zoneModelx);
      // });

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        var sub = zoneModel.sub_zone;
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue[700],
                            ),
                            child: IconButton(
                              onPressed: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();

                                String? _route = preferences.getString('route');

                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) =>
                                      AdminScafScreen(route: _route),
                                );
                                Navigator.pushAndRemoveUntil(
                                    context, route, (route) => false);
                              },
                              icon: Icon(
                                Icons.home_filled,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //     SharedPreferences preferences =
                          //         await SharedPreferences.getInstance();

                          //     String? _route = preferences.getString('route');

                          //     MaterialPageRoute route = MaterialPageRoute(
                          //       builder: (context) =>
                          //           AdminScafScreen(route: _route),
                          //     );
                          //     Navigator.pushAndRemoveUntil(
                          //         context, route, (route) => false);
                          //   },
                          //   child: Container(
                          //       width: 130,
                          //       padding: const EdgeInsets.all(8.0),
                          //       decoration: BoxDecoration(
                          //         color: Colors.green.shade900,
                          //         borderRadius: const BorderRadius.only(
                          //             topLeft: Radius.circular(8),
                          //             topRight: Radius.circular(8),
                          //             bottomLeft: Radius.circular(8),
                          //             bottomRight: Radius.circular(8)),
                          //         border: Border.all(
                          //             color: Colors.white, width: 1),
                          //       ),
                          //       child: const Center(
                          //         child: Text(
                          //           'Dashboard',
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold,
                          //             fontFamily: FontWeight_.Fonts_T,
                          //           ),
                          //         ),
                          //       )),
                          // ),
                        ],
                      ),
                    ),
                    Row(children: [
                      // const Padding(
                      //   padding: EdgeInsets.all(4.0),
                      //   child: Text(
                      //     'รายรับ :',
                      //     style: TextStyle(
                      //       color: ReportScreen_Color.Colors_Text2_,
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: FontWeight_.Fonts_T,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'วันที่ ',
                          style: TextStyle(
                            color: ReportScreen_Color.Colors_Text2_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: InkWell(
                          onTap: () {
                            _select_financial_StartDate(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              height: 25,
                              width: 120,
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                child: Text(
                                  (SDatex_total1_ == null)
                                      ? 'เลือก'
                                      : '$SDatex_total1_',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 0)),
                  builder: (context, snapshot) {
                    return ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.width * 0.43,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            // width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.width * 0.43,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // area_show2(context),
                                    area_show(context),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    area_showbook2(context),
                                    docno_book == null &&
                                            contractBookModels.length == 0
                                        ? SizedBox()
                                        : area_show2(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }

  Padding area_show(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 0.85,
            // height: MediaQuery.of(context).size.width *
            //     0.43,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              // color: Color(0xFFA8BFDB),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          for (int index = 0;
                              index < zoneModels.length;
                              index++)
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () {
                                    // read_GC_Pos();
                                    setState(() {
                                      zone_ser =
                                          int.parse(zoneModels[index].ser!);

                                      zone_img = int.parse(
                                                  zoneModels[index].ser!) ==
                                              0
                                          ? '${MyConstant().domain}/files/$foder/contract/$img_'
                                          : '${MyConstant().domain}/files/$foder/zone/${zoneModels[index].img}';
                                      read_GC_area();
                                      read_GC_contractBook(0);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: zone_ser ==
                                              int.parse(zoneModels[index].ser!)
                                          ? Colors.blue[700]
                                          : Colors.grey,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        zoneModels[index].zn.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
                                      ),
                                    ),
                                  ),
                                )),
                        ]),
                      ),
                    ),
                  )),
            ])));
  }

  Padding area_show2(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              // color: Color(0xFFA8BFDB),
            ),
            child: contractBookModels.length == 0
                ? area_showbook(context)
                : Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 40,
                                width: 40,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(7),
                                //   color: Colors.blue[700],
                                // ),
                                child: Text(
                                  'วันที่จอง : $SDatex_total1_',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.blue[700], //Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 40,
                                width: 40,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(7),
                                //   color: Colors.blue[700],
                                // ),
                                child: Text(
                                  'วันที่ทำรายการ : $date_book',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.grey[700], //Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            )
                          ]),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              // height: 40,
                              // width: 40,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(7),
                              //   color: Colors.blue[700],
                              // ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name : $naem_book',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors
                                                .blue[700], //Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tax : $tax_book',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors
                                                .grey[700], //Colors.white,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // height: 40,
                              // width: 40,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(7),
                              //   color: Colors.blue[700],
                              // ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '$docno_book',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors
                                                .blue[700], //Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Tel : $tel_book',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors
                                                .grey[700], //Colors.white,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'พื้นที่',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black, //Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'ราคา',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black, //Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      for (int index = 0;
                          index < contractBookModels.length;
                          index++)
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '${contractBookModels[index].ln}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black, //Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                '${contractBookModels[index].total}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black, //Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ],
                        ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'รวม',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black, //Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '$sum_total_book', //slip_book
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black, //Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.orange[700],
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  // _launchURL();
                                  showDialog<String>(
                                      // barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            content: _buildWebViewX(),
                                          ));
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       return _buildWebViewX();
                                  //     });
                                  print('$slip_book');
                                },
                                child: const Text(
                                  'Slip',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          conbook == 1
                              ? SizedBox()
                              : conbook == 0
                                  ? Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.blue[700],
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            print('$docno_book');
                                          },
                                          child: Text(
                                            'ยืนยันการจอง',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                        ],
                      ),
                    ],
                  )));
  }

  Widget _buildWebViewX() {
    return Container(
        height: 1000,
        width: 1000,
        child: StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 0)),
            builder: (context, snapshot) {
              return WebViewX2ShowPage(name_ser: slip_book);
            }));
  }

  void _launchURL() async {
    final String url = slip_book!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Padding area_showbook(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              // color: Color(0xFFA8BFDB),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // height: 65,
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.white.withOpacity(0.08),
                                      BlendMode.dstATop),
                                  image: const AssetImage(
                                    "images/box_cover_dark.png",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'กรุณากรอกข้อมูล ผู้ที่ต้องการเช่า',
                                overflow: TextOverflow.ellipsis,
                                // minFontSize: 1,
                                // maxFontSize: 12,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            // width: MediaQuery.of(context).size.width,
                            // height: 450,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'ชื่อผู้เช่า/บริษัท',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 40,
                                          padding: const EdgeInsets.all(4.0),
                                          child: TextFormField(
                                            //keyboardType: TextInputType.none,
                                            controller: TextForm_name,
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
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
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
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                labelText: 'ชื่อผู้เช่า/บริษัท',
                                                labelStyle: const TextStyle(
                                                  color: Colors.black,
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
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'เลขบัตรประชาชน 13 หลัก',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 60,
                                          padding: const EdgeInsets.all(4.0),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: TextForm_tax,
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
                                            maxLength: 13,
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
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
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
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                labelText: 'x-xxxx-xxxxx-xx-x',
                                                labelStyle: const TextStyle(
                                                  color: Colors.black,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                )),
                                            inputFormatters: <TextInputFormatter>[
                                              // for below version 2 use this
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                              // for version 2 and greater youcan also use this
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
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
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'เบอร์โทร',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold,
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
                                          height: 40,
                                          padding: const EdgeInsets.all(4.0),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: TextForm_tel,
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
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
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
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                labelText: 'ระบุเบอร์โทร',
                                                labelStyle: const TextStyle(
                                                  color: Colors.black,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                )),
                                            inputFormatters: <TextInputFormatter>[
                                              // for below version 2 use this
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                              // for version 2 and greater youcan also use this
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'วันที่จอง',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 40,
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
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: InkWell(
                                              onTap: () async {
                                                // read_GC_rental_data_All();
                                                _select_financial_StartDate(
                                                    context);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange,
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
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                  width: 120,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      // (allowedWeekdays.contains(DateFormat(
                                                      //                     'EEEE')
                                                      //                 .format(DateTime
                                                      //                     .now())) ==
                                                      //             false &&
                                                      //         allowedWeekdays.contains(DateFormat('EEEE').format(DateTime(
                                                      //                 DateTime.now()
                                                      //                     .year,
                                                      //                 DateTime.now()
                                                      //                     .month,
                                                      //                 DateTime.now()
                                                      //                         .day +
                                                      //                     1))) ==
                                                      //             false)
                                                      //     ? 'วันนี้และพรุ่งนี้ ไม่เปิดจอง'
                                                      //     :
                                                      (SDatex_total1_ == null)
                                                          ? 'เลือก'
                                                          : '$SDatex_total1_',
                                                      style: TextStyle(
                                                        color:
                                                            //  (allowedWeekdays.contains(DateFormat('EEEE').format(
                                                            //                 DateTime
                                                            //                     .now())) ==
                                                            //             false &&
                                                            //         allowedWeekdays.contains(DateFormat('EEEE').format(DateTime(
                                                            //                 DateTime.now()
                                                            //                     .year,
                                                            //                 DateTime.now()
                                                            //                     .month,
                                                            //                 DateTime.now().day +
                                                            //                     1))) ==
                                                            //             false)
                                                            //     ? Colors.red[300]
                                                            //     : (datex_selected ==
                                                            //             null)
                                                            //         ? Colors
                                                            //             .red[300]
                                                            //         :
                                                            Colors.black,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                        fontSize: (allowedWeekdays.contains(DateFormat(
                                                                            'EEEE')
                                                                        .format(DateTime
                                                                            .now())) ==
                                                                    false &&
                                                                allowedWeekdays.contains(DateFormat('EEEE').format(DateTime(
                                                                        DateTime.now()
                                                                            .year,
                                                                        DateTime.now()
                                                                            .month,
                                                                        DateTime.now().day +
                                                                            1))) ==
                                                                    false)
                                                            ? 12
                                                            : null,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'พื้นที่ที่เลือก',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.red[100]!.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text(
                                        (selected_Area.length == 0)
                                            ? 'ไม่พบพื้นที่ ที่ท่านเลือก'
                                            : '${selected_Area.map((data) => data.type.toString()).join(', ')}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: (selected_Area.length == 0)
                                              ? Colors.red[300]
                                              : PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                          fontSize: (selected_Area.length == 0)
                                              ? 12
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (selected_Area.length != 0)
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      // decoration: BoxDecoration(
                                      //   // color: Colors.red[100]!.withOpacity(0.5),
                                      //   borderRadius: BorderRadius.only(
                                      //     topLeft: Radius.circular(10),
                                      //     topRight: Radius.circular(10),
                                      //     bottomLeft: Radius.circular(10),
                                      //     bottomRight: Radius.circular(10),
                                      //   ),
                                      //   border: Border.all(color: Colors.grey, width: 1),
                                      // ),
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              ser_data_Detail =
                                                  (ser_data_Detail == 1)
                                                      ? 0
                                                      : 1;
                                            });
                                          },
                                          child: Text(
                                            (ser_data_Detail == 1)
                                                ? 'ปิด X '
                                                : 'แสดงเพิ่มเติม >> ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: (ser_data_Detail == 1)
                                                  ? Colors.red
                                                  : Colors.blue,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (ser_data_Detail == 1)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'รายการ',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: Font_.Fonts_T,
                                                  fontSize: 12),
                                            ),
                                            Divider(
                                              height: 2,
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'ราคา',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                  fontSize: 12),
                                            ),
                                            Divider(
                                              height: 2,
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'จำนวนพื้นที่',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                  fontSize: 12),
                                            ),
                                            Divider(
                                              height: 2,
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'ราคารวม',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                  fontSize: 12),
                                            ),
                                            Divider(
                                              height: 2,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                for (int index = 0;
                                    index < selected_Area.length;
                                    index++)
                                  Container(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${index + 1}. พื้นที่ : ${selected_Area[index].type.toString().trim()}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: Font_.Fonts_T,
                                                    fontSize: 12),
                                              ),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${nFormat.format(double.parse('${selected_Area[index].rent}'))} ',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                    fontSize: 12),
                                              ),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '1',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                    fontSize: 12),
                                              ),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${nFormat.format(double.parse('${selected_Area[index].rent}'))} ฿',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                    fontSize: 12),
                                              ),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                for (int indexexp = 0;
                                    indexexp < expModels.length;
                                    indexexp++)
                                  Container(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${(selected_Area.length) + (indexexp + 1)}. ${expModels[indexexp].expname}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: Font_.Fonts_T,
                                                    fontSize: 12),
                                              ),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${expModels[indexexp].pri_book}',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                    fontSize: 12),
                                              ),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${selected_Area.length}',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                    fontSize: 12),
                                              ),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${nFormat.format(double.parse('${expModels[indexexp].pri_book}') * selected_Area.length)} ฿',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                    fontSize: 12),
                                              ),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
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
                                  'จำนวนเงิน ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red[100]!.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      (selected_Area.length == 0)
                                          ? '0.00'
                                          : '${nFormat.format(double.parse((selected_Area.fold(0.0, (previousValue, element) => previousValue + ((element.rent != null) ? double.parse(element.rent!) : 0)).toString())) + double.parse((expModels.fold(0.0, (previousValue, element) => previousValue + ((element.pri_book != null) ? double.parse(element.pri_book!) : 0)).toString())))} บาท',
                                      // '${nFormat.format(double.parse((selected_Area.fold(0.0, (previousValue, element) => previousValue + ((element.rent != null) ? double.parse(element.rent!) : 0) * selected_Area.length).toString())) + double.parse((expModels.fold(0.0, (previousValue, element) => previousValue + ((element.pri_book != null) ? double.parse(element.pri_book!) : 0) * selected_Area.length).toString())))} บาท',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                        const SizedBox(height: 1),
                        if (TextForm_name.text.toString().trim() == '' ||
                            TextForm_tel.text.toString().trim() == '' ||
                            TextForm_tel.text.toString().trim().length < 9 ||
                            SDatex_total1_ == null ||
                            double.parse((selected_Area
                                    .fold(
                                        0.0,
                                        (previousValue, element) =>
                                            previousValue +
                                            (element.rent != null
                                                ? double.parse(element.rent!)
                                                : 0))
                                    .toString())) ==
                                0.00 ||
                            selected_Area.length == 0 ||
                            paymentName1 == null ||
                            paymentName1.toString().trim() == '')
                          const Center(
                            child: Text(
                              '*** กรุณาใส่ข้อมูลให้ครบถ้วน',
                              style: TextStyle(
                                color: Colors.red,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // (base64_Slip == null ||
                              //         TextForm_time.text.toString().trim() == '' ||
                              //         TextForm_name.text.toString().trim() == '' ||
                              //         TextForm_tel.text.toString().trim() == '' ||
                              //         datex_selected == null ||
                              //         double.parse((selected_Area
                              //                 .fold(
                              //                     0.0,
                              //                     (previousValue, element) =>
                              //                         previousValue +
                              //                         (element.rent != null
                              //                             ? double.parse(
                              //                                 element.rent!)
                              //                             : 0))
                              //                 .toString())) ==
                              //             0.00 ||
                              //         selected_Area.length == 0 ||
                              //         paymentName1 == null ||
                              //         paymentName1.toString().trim() == '' ||
                              //         TextForm_time.text == '00.00.00')

                              (TextForm_tax.text.toString().trim().length <
                                          13 ||
                                      TextForm_tax.text.toString().trim() ==
                                          '' ||
                                      TextForm_name.text.toString().trim() ==
                                          '' ||
                                      TextForm_tel.text.toString().trim() ==
                                          '' ||
                                      TextForm_tel.text
                                              .toString()
                                              .trim()
                                              .length <
                                          9 ||
                                      SDatex_total1_ == null ||
                                      double.parse((selected_Area
                                              .fold(
                                                  0.0,
                                                  (previousValue, element) =>
                                                      previousValue +
                                                      (element.rent != null
                                                          ? double.parse(
                                                              element.rent!)
                                                          : 0))
                                              .toString())) ==
                                          0.00 ||
                                      selected_Area.length == 0 ||
                                      paymentName1 == null ||
                                      paymentName1.toString().trim() == '')
                                  ? Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 204, 203, 203),
                                            width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Center(
                                        child: Text(
                                          'ยืนยัน การจองพื้นที่',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ))
                                  : OtpTimerButton(
                                      height: 50,
                                      text: Text(
                                        'ยืนยัน การจองพื้นที่',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                      duration: 3,
                                      radius: 8,
                                      backgroundColor: Colors.green[300],
                                      textColor: Colors.black,
                                      buttonType: ButtonType.elevated_button,
                                      loadingIndicator:
                                          CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.red,
                                      ),
                                      loadingIndicatorColor: Colors.red,
                                      onPressed: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        var ren =
                                            preferences.getString('renTalSer');
                                        String Area_Ser1 =
                                            (selected_Area.length > 0)
                                                ? selected_Area[0]
                                                    .ser
                                                    .toString()
                                                : '0';
                                        String Area_Ser2 =
                                            (selected_Area.length > 1)
                                                ? selected_Area[1]
                                                    .ser
                                                    .toString()
                                                : '0';
                                        String Area_Ser3 =
                                            (selected_Area.length > 2)
                                                ? selected_Area[2]
                                                    .ser
                                                    .toString()
                                                : '0';

                                        String url =
                                            '${MyConstant().domain}/GC_UsercheckLock_Market.php?isAdd=true&ren=$ren&pdatex=$SDatex_total1_&aser1=$Area_Ser1&aser2=$Area_Ser2&aser3=$Area_Ser3&Arealength=${selected_Area.length}';

                                        //--------------------> random_1
                                        int randomMilliseconds =
                                            Random().nextInt(401) + 200;
                                        Duration randomDuration = Duration(
                                            milliseconds: randomMilliseconds);

                                        int formattedMilliseconds =
                                            randomDuration.inMilliseconds %
                                                1000;
                                        //--------------------> random_2

                                        int randomMilliseconds2 =
                                            Random().nextInt(901) + 100;
                                        Duration randomDuration2 = Duration(
                                            milliseconds: randomMilliseconds2);

                                        int formattedMilliseconds2 =
                                            randomDuration2.inMilliseconds %
                                                1000;
                                        Dia_log(formattedMilliseconds);
                                        Future.delayed(
                                            Duration(
                                                milliseconds:
                                                    formattedMilliseconds),
                                            () async {
                                          print(
                                              ' random1 : ${formattedMilliseconds}');

                                          Future.delayed(
                                              Duration(
                                                  milliseconds:
                                                      formattedMilliseconds2),
                                              () async {
                                            try {
                                              http
                                                  .get(Uri.parse(url))
                                                  .then((response) {
                                                var result =
                                                    json.decode(response.body);
                                                // print(result);
                                                if (result == null) {
                                                  print(
                                                      ' Y random2 : ${formattedMilliseconds2}');
                                                  setState(() {
                                                    TextForm_time.text =
                                                        '${TextForm_time_hr.text}:${TextForm_time_min.text}:${TextForm_time_sec.text}';
                                                  });
                                                  in_Trans_select();
                                                } else {
                                                  Dialog_error();
                                                  print(
                                                      ' N random2 : ${formattedMilliseconds2}');
                                                }
                                              }).catchError((e) {
                                                Dialog_error();
                                                print(
                                                    ' N random2 : ${formattedMilliseconds2}');
                                              });
                                            } catch (e) {
                                              Dialog_error();
                                              print(
                                                  ' N random2 : ${formattedMilliseconds2}');
                                            }
                                          });
                                        });
                                      })
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ])));
  }

  Dialog_error() async {
    PanaraInfoDialog.showAnimatedGrow(
      context,
      title: "Oops",
      message:
          "เกิดข้อผิดพลาดไม่สามารถจองได้ หรือมีคนจองพื้นที่ไปก่อนหน้าท่านแล้ว..",
      buttonText: "รับทราบ",
      onTapDismiss: () async {
        read_GC_area();
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.error,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }

  Dia_log(milli_seconds) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(Duration(milliseconds: milli_seconds), () {
            Navigator.of(context).pop();
          });
          return Dialog(
            child: SizedBox(
                height: 40,
                width: 40,
                child: Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator()))
                // FittedBox(
                //   fit: BoxFit.cover,
                //   child: Image.asset(
                //     "images/gif-LOGOchao.gif",
                //     fit: BoxFit.cover,
                //     height: 20,
                //     width: 80,
                //   ),
                // ),
                ),
          );
        });
  }

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 22.0, color: Colors.grey[700]),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
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
          areaModels = _areaModels.where((areaModelss) {
            var notTitle = areaModelss.ln.toString().toLowerCase();
            var notTitle2 = areaModelss.lncode.toString().toLowerCase();
            // var notTitle3 = areaModelss.area.toString().toLowerCase();
            // var notTitle4 = areaModelss.rent.toString().toLowerCase();
            // var notTitle5 = areaModels.cname.toString().toLowerCase();
            return notTitle.contains(text) || notTitle2.contains(text);
          }).toList();
        });
      },
    );
  }

  Padding area_showbook2(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.54,
            height: MediaQuery.of(context).size.width * 0.38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              // color: Color(0xFFA8BFDB),
            ),
            child: areaModels.length == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          'เลือกวันที่',
                          minFontSize: 8,
                          maxFontSize: 20,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: Font_.Fonts_T,
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: InkWell(
                          onTap: () {
                            _select_financial_StartDate(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              height: 100,
                              width: 200,
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                child: Text(
                                  (SDatex_total1_ == null)
                                      ? 'เลือก'
                                      : '$SDatex_total1_',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue[700],
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    // read_GC_Pos();
                                    _showMyDialogImg();
                                  },
                                  icon: Icon(
                                    Icons.map_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 40,
                                width: 40,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(7),
                                //   color: Colors.blue[700],
                                // ),
                                child: _searchBar(),
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.32,
                              child: GridView.count(
                                crossAxisCount: 8,
                                children: [
                                  for (int i = 0; i < areaModels.length; i++)
                                    createCard(i, context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )));
  }

  Dialog_errorMax() async {
    PanaraInfoDialog.showAnimatedGrow(
      context,
      title: "Oops",
      message: "จองได้สูงสุด 3 พื้นที่/ต่อครั้ง",
      buttonText: "รับทราบ",
      onTapDismiss: () async {
        // read_GC_area();
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.warning,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }

  Widget createCard(int index, context) {
    return (areaModels.length == 0)
        ? SizedBox()
        : Card(
            color: areaModels[index].quantity == '' ||
                    areaModels[index].quantity == null
                ? Colors.green.shade200
                : areaModels[index].quantity == '4'
                    ? Colors.red.shade200
                    : Colors.grey.shade100,
            elevation:
                (selected_Area.any((area) => area.ser == areaModels[index].ser))
                    ? 30
                    : null,
            child: InkWell(
              onTap: () {
                setState(() {
                  zone_ser = int.parse(areaModels[index].zser!);
                });
                if (areaModels[index].quantity == '4') {
                  print('${areaModels[index].docno_book}');
                  setState(() {
                    var doccid = areaModels[index].docno_book;
                    conbook = int.parse(areaModels[index].con_book!);
                    read_GC_contractBook(doccid);
                    selected_Area.clear();
                    // contractBookModels.clear();
                    // sum_total_book = 0;
                  });
                } else if (areaModels[index].quantity == '' ||
                    areaModels[index].quantity == null) {
                  setState(() {
                    contractBookModels.clear();
                    sum_total_book = 0;
                    conbook = -1;
                    // read_GC_contractBook(0);
                  });
                  if (selected_Area.length >= 3) {
                    /////---------------->
                    setState(() {
                      selected_Area.removeWhere(
                          (area) => area.ser == areaModels[index].ser);
                    });
                    /////---------------->
                    if ((selected_Area.length >= 3)) {
                      Dialog_errorMax();
                    } else {}
                    /////---------------->
                  } else {
                    // print(areakModels[index].aserQout);
                    Map<String, dynamic> map = Map();
                    map['ser'] = '${areaModels[index].ser}';
                    map['datex'] = '${areaModels[index].datex}';
                    map['timex'] = '${areaModels[index].timex}';
                    map['cser'] = '${areaModels[index].cser}';
                    map['aser'] = '${areaModels[index].aser}';
                    map['aserQout'] = '${areaModels[index].aserQout}';
                    map['type'] = '${areaModels[index].lncode}';
                    map['sdate'] = '${areaModels[index].sdate}';
                    map['ldate'] = '${areaModels[index].ldate}';
                    map['dataUpdate'] = '${areaModels[index].dataUpdate}';
                    map['rent'] = '${areaModels[index].rent}';
                    map['area'] = '${areaModels[index].area}';
                    map['zn'] = '${areaModels[index].zn}';

                    AreakModel areakModel_add = AreakModel.fromJson(map);
                    // print(areakModel_add.type);

                    bool exists = selected_Area
                        .any((area) => area.ser == areakModel_add.ser);
                    if (!exists) {
                      setState(() {
                        selected_Area.add(areakModel_add);
                      });
                    } else {
                      setState(() {
                        selected_Area.removeWhere(
                            (area) => area.ser == areaModels[index].ser);
                      });
                    }
                  }
                } else {
                  setState(() {
                    selected_Area.clear();
                    contractBookModels.clear();
                    sum_total_book = 0;
                    conbook = -1;
                    // read_GC_contractBook(0);
                  });
                }
              },
              child: Container(
                  color: (selected_Area
                          .any((area) => area.ser == areaModels[index].ser))
                      ? Colors.yellow.shade600
                      : areaModels[index].quantity == '' ||
                              areaModels[index].quantity == null
                          ? Colors.green.shade200
                          : areaModels[index].quantity == '4'
                              ? areaModels[index].con_book == '0'
                                  ? Colors.blue.shade900
                                  : areaModels[index].con_book == '1'
                                      ? Colors.red.shade900
                                      : Colors.green.shade200
                              : Colors.grey.shade100,
                  width: MediaQuery.of(context).size.width * 0.1,
                  padding: EdgeInsets.all(8),
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: AutoSizeText(
                        '${areaModels[index].lncode}',
                        minFontSize: 8,
                        maxFontSize: (Responsive.isDesktop(context)) ? 18 : 12,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontSize: 20,
                          fontFamily: Font_.Fonts_T,
                          color: areaModels[index].quantity == '4'
                              ? areaModels[index].con_book == '0'
                                  ? Colors.white
                                  : areaModels[index].con_book == '1'
                                      ? Colors.white
                                      : PeopleChaoScreen_Color.Colors_Text2_
                              : PeopleChaoScreen_Color.Colors_Text2_,
                        ),
                        maxLines: (Responsive.isDesktop(context)) ? 4 : 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      AutoSizeText(
                        areaModels[index].quantity == '1'
                            ? (areaModels[index].ldate == null)
                                ? 'หมดสัญญา'
                                : now.isAfter(DateTime.parse(
                                                '${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(now) : areaModels[index].ldate} 00:00:00.000')
                                            .subtract(
                                                const Duration(days: 0))) ==
                                        true
                                    ? 'หมดสัญญา'
                                    : now.isAfter(DateTime.parse(
                                                    '${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(now) : areaModels[index].ldate} 00:00:00.000')
                                                .subtract(Duration(
                                                    days: open_set_date))) ==
                                            true
                                        ? 'ใกล้หมดสัญญา'
                                        : 'เช่าอยู่'
                            : areaModels[index].quantity == '2'
                                ? 'เสนอราคา'
                                : areaModels[index].quantity == '3'
                                    ? 'เสนอราคา(มัดจำ)'
                                    : areaModels[index].quantity == '4'
                                        ? areaModels[index].con_book == '0'
                                            ? 'จองแล้ว'
                                            : areaModels[index].con_book == '1'
                                                ? 'ยืนยันการจอง'
                                                : 'ว่าง'
                                        : 'ว่าง',
                        minFontSize: 8,
                        maxFontSize: 12,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontSize: 20,
                          fontFamily: Font_.Fonts_T,
                          color: areaModels[index].quantity == '4'
                              ? areaModels[index].con_book == '0'
                                  ? Colors.white
                                  : areaModels[index].con_book == '1'
                                      ? Colors.white
                                      : PeopleChaoScreen_Color.Colors_Text2_
                              : PeopleChaoScreen_Color.Colors_Text2_,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Center(
                          child: AutoSizeText(
                        '${areaModels[index].rent}',
                        minFontSize: 8,
                        maxFontSize: 12,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontSize: 20,
                          fontFamily: Font_.Fonts_T,
                          color: areaModels[index].quantity == '4'
                              ? areaModels[index].con_book == '0'
                                  ? Colors.white
                                  : areaModels[index].con_book == '1'
                                      ? Colors.white
                                      : PeopleChaoScreen_Color.Colors_Text2_
                              : PeopleChaoScreen_Color.Colors_Text2_,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  )),
            ));
  }

  Future<void> _showMyDialogImg() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
              child: Text(
            'รูปฝัง',
            style: const TextStyle(
              // fontSize: 15,
              color: Colors.black,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
            ),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InteractiveViewer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: (zone_img == null || zone_img.toString() == '')
                        ? const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.black,
                            ),
                          )
                        : Image.network(
                            '$zone_img',
                            fit: BoxFit.contain,
                          ),
                  ),
                  scaleEnabled: true,
                  minScale: 0.5,
                  maxScale: 5.0,
                  transformationController: TransformationController()
                    ..value =
                        Matrix4.diagonal3Values(_scaleFactor, _scaleFactor, 1),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(4.0),
                child: const Center(
                  child: Text(
                    'ปิด',
                    style: TextStyle(
                      // fontSize: 15,
                      color: Colors.white,
                      fontFamily: Font_.Fonts_T,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> read_GC_Pos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/print_pos.php?isAdd=true&ser=50&type=MS';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      // for (var map in result) {
      //   SubZoneModel subzoneModel = SubZoneModel.fromJson(map);
      //   setState(() {
      //     subzoneModels.add(subzoneModel);
      //   });
      // }
    } catch (e) {}
  }

  Future<Null> in_Trans_select() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ren = '${widget.Ser_}';
    var user = '${DateTime.now()}';
    var zoneser = '$zone_ser';
    var selecte = selected_Area.length;
    ////datex_selected
    DateTime newDatetimex = DateTime.now();
    var day = DateFormat('dd').format(newDatetimex);
    var timex = DateFormat('HHmmss').format(newDatetimex);
    var vts = day.toString() + timex.toString();
    String selecte_ln =
        '${selected_Area.map((data) => data.type.toString()).join(',')}';
    var ciddoc =
        'L$day$timex-${selected_Area.map((data) => data.type.toString()).join(',')}'; //In_c_paynew
    // var area_rent_sum = expModels[index].cal_auto == '1'
    //     ? expModels[index].pri_auto
    //     : _area_rent_sum; //ราคาพื้นที่

    for (int index = 0; index < selected_Area.length; index++) {
      var tser = selected_Area[index].aser;
      var area_rent_sum = selected_Area[index].rent;
      // print(tser);
      String url =
          '${MyConstant().domain}/In_c_paynewMarket.php?isAdd=true&ren=$ren&tser=$tser&selecte=$selecte&selecte_ln=$selecte_ln&_area_rent_sum=$area_rent_sum&user=$vts&ciddoc=$ciddoc&zone=$zoneser&serinsert=1&tax=${TextForm_tax.text.toString()}&date_lock=$SDatex_total1_';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(tser);
      } catch (e) {}
    }

    for (int index = 0; index < expModels.length; index++) {
      var tser = expModels[index].ser;
      var area_rent_sum = expModels[index].pri_book;
      String url =
          '${MyConstant().domain}/In_c_paynewMarket.php?isAdd=true&ren=$ren&tser=$tser&selecte=$selecte&selecte_ln=$selecte_ln&_area_rent_sum=$area_rent_sum&user=$vts&ciddoc=$ciddoc&zone=$zoneser&serinsert=2&tax=${TextForm_tax.text.toString()}&date_lock=$SDatex_total1_';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
      } catch (e) {}
    }

    // setState(() {
    //   selected_Area.clear();
    // });
    await in_Trans(vts, day, timex, ciddoc);
  }

  var file_;
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
        fileName_Slip = 'MarKetslip_${cFinn}_${date}_$Time_.png';
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
      // print(formData);

      // Handle the response
      await request.onLoad.first;

      if (request.status == 200) {
        // print('File uploaded successfully!');
      } else {
        // print('File upload failed with status code: ${request.status}');
      }
    } else {
      // print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

  /////---------------------------------------------------------->
  Future<Null> in_Trans(vts, day, timex, ciddoc) async {
    var datex_TransNow = DateFormat('yyyy-MM-dd').format(newDatetime);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ren = '${widget.Ser_}';
    var zoneser = zone_ser;
    if (base64_Slip != null) {
      // print('base64_Slip>>>  $ciddoc');
      OKuploadFile_Slip(vts);
    }

    ///------------------>
    String name_book = TextForm_name.text.toString().trim();
    String Tel_book = TextForm_tel.text.toString().trim();
    String datex_book = SDatex_total1_.toString().trim();
    String Area_selecte =
        '${selected_Area.map((data) => data.type.toString()).join(',')}';
    String Area_Ser =
        '${selected_Area.map((data) => data.ser.toString()).join(',')}';
    String PriArea_Book = (selected_Area.length == 0)
        ? '0.00'
        : '${double.parse((selected_Area.fold(0.0, (previousValue, element) => previousValue + (element.rent != null ? double.parse(element.rent!) : 0)).toString()))}';
    String PriExp_Book = (selected_Area.length == 0)
        ? '0.00'
        : '${double.parse((expModels.fold(0.0, (previousValue, element) => previousValue + ((element.pri_book != null) ? double.parse(element.pri_book!) : 0)).toString())) * selected_Area.length}';

    String TimePay_Book = TextForm_time.text;
    String? fileNameSlip_ =
        (fileName_Slip == null || fileName_Slip.toString() == 'null')
            ? ''
            : fileName_Slip.toString().trim();

    ////////----------------------------------------------->
    // print('--------->');
    // print('ชื่อผู้เช่า : ${name_book}');
    // print('เบอร์ : ${Tel_book}');
    // print('วันที่จอง : ${datex_book}');
    // print('พื้นที่จอง : ${Area_selecte}');
    // print('ราคาพื้นที่ : ${PriArea_Book}');
    // print('ราคาอื่นๆที่เก็บเพิ่ม : ${PriExp_Book}');
    // print('รูปแบบชำระ : ${paymentName1}');
    // print('Serแบบชำระ : ${paymentSer1}');
    // print('วันที่ทำรายการ : ${datex_selected}');
    // print('วันที่ชำระ : ${datex_selected}');
    // print('เวลาหลักฐาน : ${TimePay_Book}');
    // print('หลักฐานชำระ : ${fileNameSlip_}');
    // print('Ser พื้นที่จอง : ${Area_Ser}');
    // print('--------->');
    // print('ren : ${ren}');
    // print('user : ${vts}');
    // print('zoneser : ${zoneser}');
    // print('--------->');
    ////////-------------------------------------------------------->
    var qutser = selected_Area.length.toString();
    var bill = 'P';
    var payment1 = '0';
    var payment2 = '0';

    String url =
        // 'https://dzentric.com/chao_perty/chao_api/In_tran_financet_webmaket.php?isAdd=true&ren=$ren';
        '${MyConstant().domain}/In_tran_financet_webmaket.php?isAdd=true&ren=$ren';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'ciddoc': ciddoc.toString(),
        'qutser': qutser.toString(),
        'user': vts.toString(),
        'sumdis': '0.00',
        'sumdisp': '0.00',
        'dateY': SDatex_total1_,
        'dateY1': SDatex_total1_,
        'time': TimePay_Book,
        'payment1': '${double.parse(PriArea_Book) + double.parse(PriExp_Book)}',
        'payment2': '0.00',
        'pSer1': '$paymentSer1',
        'pSer2': '0',
        'sum_whta': '0.00',
        'bill': 'P',
        'fileNameSlip': fileNameSlip_.toString(),
        'areaSer': '$Area_Ser',
        'typeModels': '',
        'typeshop': name_book.toString(),
        'nameshop': name_book.toString(),
        'bussshop': name_book.toString(),
        'bussscontact': name_book.toString(),
        'address': '',
        'tel': Tel_book.toString(),
        'tax': TextForm_tax.text.toString(),
        'email': '',
        'Serbool': '',
        'area_rent_sum': '',
        'comment': '',
        'zser': zoneser.toString(),
        'namearea': Area_selecte,
      }).then((value) async {
        // print('*1111**********$value');
        var result = json.decode(value.body);
        // print('*222**********$result ');

        if (result.toString() != 'No') {
          for (var map in result) {
            CFinnancetransModel cFinnancetransModel =
                CFinnancetransModel.fromJson(map);
            setState(() {
              cFinn = cFinnancetransModel.docno;
            });
            // print('in_Trans_invoice///zzzzasaaa123454>>>>  $cFinn');
            // print(
            //     'in_Trans_invoice///bnobnobnobno123454>>>>  ${cFinnancetransModel.bno}');
          }
          Future.delayed(Duration(milliseconds: 100), () async {
            if (cFinn == null ||
                cFinn.toString() == '' ||
                cFinn.toString() == 'null') {
            } else {
              read_GC_beamcheckout(
                  cFinn,
                  selected_Area,
                  '${double.parse(PriArea_Book) + double.parse(PriExp_Book)}',
                  name_book);
            }

            // ManPay_Receipt_PDF.ManPayReceipt_PDF(context, widget.Ser_, '$cFinn',
            //     bill_addr, bill_email, bill_tel, bill_tax, bill_name);
          });
        }
      });
    } catch (e) {}
  }

///////--------------------------------------------------------->(Stap-1)
  Future<Null> read_GC_beamcheckout(
      cFinn, selected_Area, PriArea, name_book) async {
    /////////--------------->
    String decodedPassword = retrieveDecodedPassword(Pay_Ke.toString());
    String basicAuth = generateBasicAuth(decodedPassword);
    /////////--------->
    DateTime datexnow = DateTime.now();
    final moonLanding = DateTime.utc(datexnow.year, datexnow.month,
        datexnow.day, datexnow.hour, datexnow.minute + 10, 00);
    final isoDate2 = moonLanding.toIso8601String();

    String Area_selecte =
        '${selected_Area.map((data) => data.type.toString()).join(',')}';
    String datex_book = SDatex_total1_.toString().trim();
    /////////-------------->
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$basicAuth'
    };
    var request = https_Request();
    /////////------------->
    request.body = json.encode({
      "channel": "qrThb",
      "expiry": "$isoDate2",

      ///"2024-04-06T15:00:00Z",
      "order": {
        "currencyCode": "THB",
        "description":
            "คุณ :$name_book จองพื้นที่ ${Area_selecte} ,วันที่จอง : ${datex_book}",
        // "[${renTal_user}]:$renTal_name, คุณ :$name_book จองพื้นที่ ${Area_selecte} ,วันที่จอง : ${datex_book}",
        "merchantReference": "คุณ:$name_book,Market(LP)",
        "merchantReferenceId": "$cFinn",
        "netAmount": double.parse(PriArea.toString()),
        "orderItems": [
          for (int index = 0; index < selected_Area.length; index++)
            {
              "product": {
                "description": "พื้นที่ : ${selected_Area[index].type}",
                "imageUrl":
                    "https://www.shutterstock.com/image-vector/map-icon-red-marker-pin-260nw-1962656155.jpg",
                "name": "${selected_Area[index].type}",
                "price": double.parse(selected_Area[index].rent.toString()),
                "sku": "string"
              },
              "quantity": 1
            },
          // for (int index2 = 0; index2 < expModels.length; index2++)
          //   {
          //     "product": {
          //       "description": "string",
          //       "imageUrl": "",
          //       "name": "${selected_Area[index2]}",
          //       "price": double.parse(selected_Area[index2].rent.toString()),
          //       "sku": "string"
          //     },
          //     "quantity": 1
          //   },
        ],
        "totalAmount": double.parse(PriArea.toString()),
        "totalDiscount": 0
      },
      "redirectUrl": "",
      "requiredFieldsFormId": "",
      "supportedPaymentMethods": ["qrThb"]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      String jsonString = await response.stream.bytesToString();
      Map<String, dynamic> data = jsonDecode(jsonString);
      String purchaseId = data['purchaseId'];
      String paymentLink = data['paymentLink'];

      // print('Purchase ID: $purchaseId');
      // print('Payment Link: $paymentLink'); ////UP_PurchaseID_Beamcheck
      if (purchaseId == null ||
          paymentLink == null ||
          purchaseId.toString() == '' ||
          paymentLink.toString() == '' ||
          cFinn == null ||
          cFinn.toString() == '') {
      } else {
        Beamcheckout_Dialog(cFinn, purchaseId, paymentLink);
      }
    } else {
      // print(response.reasonPhrase);
    }
  }

  int cahek = 0;
  late Timer _timer;

  void startUpdates(cFinn, purchaseId) {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (cahek == 1) {
        _timer.cancel(); // Stop the timer if cahek is 1
        return;
      }

      await read_Recheck_beamcheckout(cFinn, purchaseId);
      // print('read_Recheck_beamcheckout ');
    });
  }

  Future<Null> read_Recheck_beamcheckout(cFinn, purchaseId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    /////////------------------------------------------------>
    String decodedPassword = retrieveDecodedPassword(Pay_Ke.toString());
    String basicAuth = generateBasicAuth(decodedPassword);
    /////////------------------------------------------------>
    var headers = {'Authorization': '$basicAuth'};
    var request = https_Request_check(purchaseId);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    /////////------------------------------------------------>
    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = json.decode(jsonString);
      var DateTimePay = jsonData['timePaid'].toString().trim();
      var urlIdpaycomplete = jsonData['paymentLink'].toString().trim();

      print('State: ${jsonData['state']}');
      if (jsonData['state'].toString().trim() == 'complete') {
        setState(() {
          cahek = 1;
        });
        Future.delayed(Duration(milliseconds: 200), () async {
          Beamcheckout_Complete(
              context,
              '$ren',
              bill_addr,
              bill_email,
              bill_tel,
              bill_tax,
              bill_name,
              cFinn,
              purchaseId,
              DateTimePay,
              urlIdpaycomplete);
        });
      } else {}
      // print(await response.stream.bytesToString());
    } else {
      // print(response.reasonPhrase);
    }
  }

///////----------------------------------------------------------->(Stap-2)
  Future<Null> Beamcheckout_Dialog(cFinn, purchaseId, paymentLink) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ren = '${widget.Ser_}';
    var cFinnc_s = cFinn;
    var purchaseId_s = purchaseId;
    var paymentLink_s = paymentLink;
    String url =
        await '${MyConstant().domain}/UP_PurchaseID_Beamcheck.php?isAdd=true&serren=$ren&iddocno=$cFinnc_s&beamid=$purchaseId_s&url_s=$paymentLink_s';
    if (purchaseId != null && cFinn != null) {
      Future.delayed(Duration(microseconds: 2), () {
        // read_Recheck_beamcheckout('$purchaseId');
        startUpdates(cFinn, '$purchaseId');
      });

      try {
        var response = await http.get(Uri.parse(url));

        var result = await json.decode(response.body);

        if (result.toString() == 'true') {
          await showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 0)),
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (cahek != 1)
                            InkWell(
                              onTap: () async {
                                Dia_log(200);
                                // Navigator.pop(context);
                                // Dialog_cancellock(purchaseId_s);

                                Beam_purchase_disabled(
                                        purchaseId, Pay_Ke, ren, cFinnc_s)
                                    .then((value) => {
                                          Navigator.pop(context),
                                          Future.delayed(
                                              Duration(milliseconds: 600),
                                              () async {
                                            Dialog_cancellock();
                                          }),
                                        });
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 30,
                              ),
                            )
                        ],
                      );
                    }),
                content: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 0)),
                    builder: (context, snapshot) {
                      return SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Container(
                              // height: 600,
                              width: MediaQuery.of(context).size.width,
                              child:
                                  WebViewX2Pagebeamcheck(id_ser: paymentLink_s),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            },
          );
        } else {}
      } catch (e) {
        print(e);
      }
    }
  }

  Dialog_cancellock() async {
    PanaraInfoDialog.showAnimatedGrow(
      context,
      title: "Oops",
      message: "ยกเลิกการจองพื้นที่ เสร็จสิ้น ...!!",
      buttonText: "รับทราบ",
      onTapDismiss: () async {
        read_GC_area();
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.warning,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }
}
