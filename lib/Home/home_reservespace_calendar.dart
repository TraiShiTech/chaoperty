import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../ChaoArea/ChaoAreaBid_Screen.dart';
import '../ChaoArea/ChaoAreaRenew_Screen.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetC_rantaldata_Model.dart';
import '../Model/GetContract_Book_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/areak_model.dart';
import '../PeopleChao/PeopleChao_Screen2.dart';
import '../Style/colors.dart';
import '../Style/view_pagenow.dart';

class Homereservespace_calendar extends StatefulWidget {
  const Homereservespace_calendar({super.key});

  @override
  State<Homereservespace_calendar> createState() =>
      _Homereservespace_calendarState();
}

class _Homereservespace_calendarState extends State<Homereservespace_calendar> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime newDatetime = DateTime.now();
  DateTime now = DateTime.now();

  int switcherIndex1 = 1;
  String Visit_ = 'calendar';
  int Ser_Body = 0;
  String? Value_stasus, ser_cidtan;
  ////////------------------------------------>
  late DataSource _dataSource;
  late List<CalendarResource> _resources = [];
  ////////------------------------------------>
  List<GlobalKey> _btnKeys = [];
  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];
  List<AreaModel> _areaModels = <AreaModel>[];
  List<AreaModel> tenants = [];
  List<AreaModel> _tenants = <AreaModel>[];
  List<RenTalModel> renTalModels = [];
  List<ExpModel> expModels = [];
  List<ContractBookModel> contractBookModels = [];
  List<RenTaldataModel> renTaldataModels = [];
  List<AreakModel> selected_Area = [];
  List<PayMentModel> _PayMentModels = [];
  List<dynamic> allowedWeekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  List<dynamic> allo_days = [];
  List<dynamic> Date_list_selected = [];
  ////////------------------------------------>
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
  ////////------------------------------------>
  int zone_ser = 0, open_set_date = 30;
  int ser_data_Detail = 0, conbook = -1;
  ////////------------------------------------>
  double sum_total_book = 0;
  ////////------------------------------------>
  String? SDatex_total1_ = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
  String? LDatex_total1_ = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}';

  String? day_ds1, day_ds2, day_ds3, day_ds4, day_ds5;
  String? base64_Imgmap, foder, cFinn;
  String? rtname, type, typex, renname, pkname, ser_Zonex, img_;
  String? base64_Slip, fileName_Slip, Slip_status;
  String? a_ser, a_area, a_rent, a_ln, a_page;
  String? zone_img,
      naem_book,
      docno_book,
      tax_book,
      tel_book,
      date_book,
      slip_book;

  String? paymentSer1,
      payment_Ptser,
      paymentName1,
      Pay_Ke,
      selectedValue,
      bname1;
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
  String? visibleStar, visibleEnd;
  int stuas = 0;

  ////////------------------------------------>

  ///////////---------------------------------------->

  @override
  void initState() {
    super.initState();
    Date_now();
    read_GC_rental();
    read_GC_zone();
    read_GC_Exp();
    red_payMent();

    Future.delayed(const Duration(seconds: 2), () {
      // Here you can write your code
      setState(() {
        stuas = 1;
      });
    });
  }

  Future<Null> Date_now() async {
    DateTime now = DateTime.now();

    // First day of the current month
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);

    // Last day of the current month
    DateTime firstDayOfNextMonth = (now.month < 12)
        ? DateTime(now.year, now.month + 1, 1)
        : DateTime(now.year + 1, 1, 1);
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));

    String currentMonth_Start =
        DateFormat('yyyy-MM-dd').format(firstDayOfMonth);

    String currentMonth_End = DateFormat('yyyy-MM-dd').format(lastDayOfMonth);

    print('First day of the month: $currentMonth_Start');
    print('Last day of the month: $currentMonth_End');

    setState(() {
      visibleStar = currentMonth_Start;
      visibleEnd = currentMonth_End;
    });
  }

  ////////------------------------------------>
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

  /////////////////////////////////-------------------------------------------->
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

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        var sub = zoneModel.sub_zone;
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
      if (zoneModels.length != 0) {
        zone_ser = int.parse(zoneModels[0].ser.toString());
        read_GC_area(zoneModels[0].ser);
        read_GC_Tenant(zoneModels[0].ser);
      }
    } catch (e) {}
  }

  /////////////////////////////////-------------------------------------------->
  Future<Null> read_GC_area(ser) async {
    if (areaModels.isNotEmpty) {
      setState(() {
        areaModels.clear();
        _areaModels.clear();
        selected_Area.clear();
        _resources.clear();
        _resources.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    //print('zone >>>>>> $zone');

    String url =
        '${MyConstant().domain}/GC_area_calendar.php?isAdd=true&ren=$ren&zone=$ser&datelok=$SDatex_total1_&Ldate_x=$LDatex_total1_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        int index1 = 0;
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);

          setState(() {
            areaModels.add(areaModel);
          });
          setState(() {
            _resources.add(
              CalendarResource(
                id: '${index1}',
                displayName: '${areaModel.ln}',
                color: Colors.grey,
                image: const NetworkImage(
                    'https://banner2.cleanpng.com/20180328/she/kisspng-google-maps-computer-icons-maps-5abc3a7a261239.322842121522285178156.jpg'),
              ),
            );
          });
          setState(() {
            index1++;
          });
        }
      }
      setState(() {
        _areaModels = areaModels;
      });
    } catch (e) {}
  }

  /////////////////////////////////-------------------------------------------->
  Future<Null> read_GC_Tenant(ser) async {
    var visibleStartDate_ = visibleStar;
    var visibleEndDate_ = visibleEnd;
    if (tenants.isNotEmpty) {
      setState(() {
        tenants.clear();
        _tenants.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    //print('zone >>>>>> $zone');

    String url =
        '${MyConstant().domain}/GC_areaAll_booking_calendar.php?isAdd=true&ren=$ren&zone=$ser&date_s=$visibleStartDate_&date_l=$visibleEndDate_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);

          setState(() {
            tenants.add(areaModel);
          });
        }
      }
      setState(() {
        _tenants = tenants;
      });
    } catch (e) {}
    print('read_GC_Tenant');
    print(tenants.length);
    red_getCalen();
  }

///////----------------------------------------------->DataSource(appointments, _resources)
  Future<Null> _getResources() async {
    setState(() {
      _resources.clear();
      _resources.clear();
    });
    for (int index1 = 0; index1 < areaModels.length; index1++) {
      setState(() {
        _resources.add(
          CalendarResource(
            id: '${index1}',
            displayName: '${areaModels[index1].ln}',
            color: Colors.grey,
            image: const NetworkImage(
                'https://banner2.cleanpng.com/20180328/she/kisspng-google-maps-computer-icons-maps-5abc3a7a261239.322842121522285178156.jpg'),
          ),
        );
      });
    }
  }

  List<Appointment> appointments = [];
  ///////////////////////------------------------------------------------>
  void red_getCalen() {
    // setState(() {
    //   selected_Area.clear();
    // });
    // _getResources();
    _dataSource = _getCalendarDataSource();
  }

  ///////////////////////------------------------------------------------>
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
              payment_Ptser = _PayMentModel.ptser.toString();
              bname1 = _PayMentModel.bname.toString();
            }
          });
        }
      }
    } catch (e) {}
  }

  ///////////////////////------------------------------------------------>
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

  DataSource _getCalendarDataSource() {
    setState(() {
      appointments.clear();

      // _resources.clear();
    });

    // final ass = assetmodels
    //                                           .where((value) =>
    //                                               value.typeSer ==
    //                                               assetTypemodels[index1].ser)
    //                                           .toList();
    DateTime datex = DateTime.now();
    for (int index = 0; index < areaModels.length; index++) {
      for (int index1 = 0; index1 < tenants.length; index1++) {
        if (tenants[index1].ser.toString() ==
            areaModels[index].ser.toString()) {
          if (tenants[index1].quantity != null) {
            if (tenants[index1].sdate != null &&
                tenants[index1].ldate != null) {
              // print(
              //     '${index}  // ${index1}  ( ${areaModels.length}  ---  ${tenants.length} )');
              // print(
              //     '${tenants[index1].cid} // ${index1 + 1} //${tenants[index1].ser} ** ${areaModels[index].ser}');
              setState(() {
                appointments.add(Appointment(
                  startTimeZone: 'Asia/Bangkok',
                  endTimeZone: 'Asia/Bangkok',
                  startTime: DateTime(
                      DateTime.parse('${tenants[index1].sdate}').year,
                      DateTime.parse('${tenants[index1].sdate}').month,
                      DateTime.parse('${tenants[index1].sdate}').day,
                      0),
                  endTime: DateTime(
                      DateTime.parse('${tenants[index1].ldate}').year,
                      DateTime.parse('${tenants[index1].ldate}').month,
                      DateTime.parse('${tenants[index1].ldate}').day,
                      0),
                  //  (datex.isAfter(DateTime.parse(
                  //                 '${tenants[index1].ldate} 00:00:00.000')
                  //             .subtract(Duration(days: 0))) ==
                  //         false)
                  //     ? DateTime(
                  //         DateTime.parse('${tenants[index1].ldate}').year,
                  //         DateTime.parse('${tenants[index1].ldate}').month,
                  //         DateTime.parse('${tenants[index1].ldate}').day,
                  //         0)
                  //     : DateTime(
                  //         DateTime.parse('${datex}').year,
                  //         DateTime.parse('${datex}').month + 1,
                  //         DateTime.parse('${datex}').day,
                  //         0),
                  subject: (tenants[index1].docno_book == null)
                      ? (datex.isAfter(DateTime.parse(
                                      '${tenants[index1].ldate} 00:00:00.000')
                                  .subtract(Duration(days: 0))) ==
                              false)
                          ? '🟢 : ${tenants[index1].cid}'
                          : '🟢 : ${tenants[index1].cid}'
                      : '🟢 : ${tenants[index1].docno_book}',
                  id: tenants[index1].cid,
                  //  (tenants[index1].docno_book == null)
                  //     ? (datex.isAfter(DateTime.parse(
                  //                     '${tenants[index1].ldate} 00:00:00.000')
                  //                 .subtract(Duration(days: 0))) ==
                  //             false)
                  //         ? 'เช่าอยู่ : ${tenants[index1].cid}'
                  //         : 'หมดสัญญา : ${tenants[index1].cid}'
                  //     : 'ล็อคเสียบ : ${tenants[index1].docno_book}',

                  color: tenants[index1].quantity == '1' ||
                          tenants[index1].quantity == '4'
                      ? (tenants[index1].ldate == null)
                          ? Colors.red.shade300
                          : datex.isAfter(DateTime.parse(
                                          '${tenants[index1].ldate} 00:00:00.000')
                                      .subtract(
                                          Duration(days: open_set_date))) ==
                                  true //datex
                              ? datex.isAfter(DateTime.parse(
                                              '${tenants[index1].ldate} 00:00:00.000')
                                          .subtract(Duration(days: 0))) ==
                                      false
                                  ? Colors.orange.shade300
                                  : Colors.grey.shade300
                              : Colors.red.shade300
                      : tenants[index1].quantity == '2'
                          ? Colors.blue.shade300
                          : areaModels[index1].quantity == '3'
                              ? Colors.purple.shade300
                              : Colors.green.shade300,
                  resourceIds: ['${index}'],
                ));
              });
            }
          }
        }
      }
    }

    return DataSource(appointments, _resources);
  }

  CalendarController _controller = CalendarController();
  String? _message;
  void updateMessage(String newMessage) {
    setState(() {
      _message = newMessage;
      Ser_Body = 0;
    });
    // checkPreferance();
    // read_GC_zone();
    // read_GC_rental();
    // read_GC_area();
  }

  int sumAppointmentsForDay(
      DateTime dateToCheck, List<Appointment> appointments) {
    int sum = 0;

    for (var appointment in appointments) {
      if (isDateInRange(
          dateToCheck, appointment.startTime, appointment.endTime)) {
        sum++;
      }
    }

    return sum;
  }

  bool isDateInRange(
      DateTime dateToCheck, DateTime startTime, DateTime endTime) {
    return dateToCheck.isAfter(startTime.subtract(Duration(days: 1))) &&
        dateToCheck.isBefore(endTime.add(Duration(days: 1)));
  }

///////////////-------------------------------->
  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(Duration(milliseconds: 2400), () {
            Navigator.of(context).pop();
          });
          return Dialog(
            child: SizedBox(
              height: 20,
              width: 80,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  "images/gif-LOGOchao.gif",
                  fit: BoxFit.cover,
                  height: 20,
                  width: 80,
                ),
              ),
            ),
          );
        });
  }

  ///////////////////////------------------------------------------------>
  @override
  Widget build(BuildContext context) {
    return (stuas == 0)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(3),
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height,
              //     0.43,
              decoration: const BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 2, 0),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Box,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      'พื้นที่เช่า ',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 8,
                                      maxFontSize: 20,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                    AutoSizeText(
                                      ' > > ',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 8,
                                      maxFontSize: 20,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: viewpage(context, '1'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.TiTile_Box,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // border: Border.all(color: Colors.white, width: 1),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          // Container(
                          //   height: 40,
                          //   width: 40,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(7),
                          //     color: Colors.blue[700],
                          //   ),
                          //   child: IconButton(
                          //     onPressed: () async {
                          //       SharedPreferences preferences =
                          //           await SharedPreferences.getInstance();

                          //       String? _route = preferences.getString('route');

                          //       MaterialPageRoute route = MaterialPageRoute(
                          //         builder: (context) => AdminScafScreen(route: _route),
                          //       );
                          //       Navigator.pushAndRemoveUntil(
                          //           context, route, (route) => false);
                          //     },
                          //     icon: Icon(
                          //       Icons.home_filled,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'มุมมอง :',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: SlideSwitcher(
                                      initialIndex: 1,
                                      containerBorderRadius: 10,
                                      onSelect: (index) async {
                                        setState(() {
                                          switcherIndex1 = index;
                                        });
                                        if (index + 1 == 2) {
                                          setState(() {
                                            Visit_ = 'calendar';
                                          });
                                        } else {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          String? _route =
                                              preferences.getString('route');

                                          MaterialPageRoute route =
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                AdminScafScreen(route: _route),
                                          );
                                          Navigator.pushAndRemoveUntil(
                                              context, route, (route) => false);
                                        }
                                      },
                                      containerHeight: 40,
                                      containerWight: 130,
                                      containerColor: Colors.grey,
                                      children: [
                                        Icon(
                                          Icons.grid_view_rounded,
                                          color: (Visit_ == 'grid')
                                              ? Colors.blue[900]
                                              : Colors.black,
                                        ),
                                        Icon(
                                          Icons.calendar_month_rounded,
                                          color: (Visit_ == 'calendar')
                                              ? Colors.blue[900]
                                              : Colors.black,
                                        ),
                                        Icon(
                                          Icons.list,
                                          color: (Visit_ == 'list')
                                              ? Colors.blue[900]
                                              : Colors.black,
                                        ),
                                        Icon(
                                          Icons.map_outlined,
                                          color: (Visit_ == 'map')
                                              ? Colors.blue[900]
                                              : Colors.black,
                                        )
                                      ],
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
                  Expanded(
                    child: Center(
                        child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          StreamBuilder(
                            stream: Stream.periodic(
                                const Duration(milliseconds: 25), (i) => i),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const Text('');
                              double elapsed =
                                  double.parse(snapshot.data.toString()) * 0.05;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (elapsed > 8.00)
                                    ? const Text(
                                        'ไม่พบข้อมูล',
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      )
                                    : Text(
                                        'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                        // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
                  ),
                ],
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(children: [
            if ((Ser_Body != 0 && Ser_Body != 5))
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        minFontSize: 10,
                        maxFontSize: 25,
                        maxLines: 1,
                        Ser_Body == 1
                            ? 'เสนอราคา'
                            : Ser_Body == 2
                                ? 'ทำ/ต่อสัญญา'
                                : '',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20,
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          if (Ser_Body == 1 || Ser_Body == 2) {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();

                            String? _route = preferences.getString('route');

                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) =>
                                  AdminScafScreen(route: _route),
                            );
                            Navigator.pushAndRemoveUntil(
                                context, route, (route) => false);
                          } else {
                            setState(() {
                              Ser_Body = 0;
                            });
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'ปิด',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            (Ser_Body == 1)
                ? ChaoAreaBidScreen(
                    Get_Value_area_index: a_ser,
                    Get_Value_area_ln: a_ln,
                    Get_Value_area_sum: a_area,
                    Get_Value_rent_sum: a_rent,
                    Get_Value_page: a_page,
                  )
                : (Ser_Body == 2)
                    ? ChaoAreaRenewScreen(
                        Get_Value_area_index: a_ser,
                        Get_Value_area_ln: a_ln,
                        Get_Value_area_sum: a_area,
                        Get_Value_rent_sum: a_rent,
                        Get_Value_page: a_page,
                      )
                    : (Ser_Body == 3)
                        ? PeopleChaoScreen2(
                            Get_Value_cid: Value_cid,
                            Get_Value_NameShop_index: ser_cidtan,
                            Get_Value_status: Value_stasus,
                            Get_Value_indexpage: '0',
                            updateMessage: updateMessage,
                          )
                        : (Ser_Body == 4)
                            ? PeopleChaoScreen2(
                                Get_Value_cid: Value_cid,
                                Get_Value_NameShop_index: ser_cidtan,
                                Get_Value_status: Value_stasus,
                                Get_Value_indexpage: '4',
                                updateMessage: updateMessage,
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    //  (MediaQuery.of(context).size.height <
                                    //         1800)
                                    //     ? (MediaQuery.of(context).size.height *
                                    //             0.98) +
                                    //         200
                                    //     :
                                    MediaQuery.of(context).size.height * 0.98,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 8, 0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 8, 2, 0),
                                                child: Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: AppbackgroundColor
                                                        .TiTile_Box,
                                                    borderRadius:
                                                        const BorderRadius.only(
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
                                                        color: Colors.white,
                                                        width: 2),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AutoSizeText(
                                                        'พื้นที่เช่า ',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        minFontSize: 8,
                                                        maxFontSize: 20,
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                      AutoSizeText(
                                                        ' > > ',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        minFontSize: 8,
                                                        maxFontSize: 20,
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: viewpage(context, '1'),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppbackgroundColor.TiTile_Box,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          // border: Border.all(color: Colors.white, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            // Container(
                                            //   height: 40,
                                            //   width: 40,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(7),
                                            //     color: Colors.blue[700],
                                            //   ),
                                            //   child: IconButton(
                                            //     onPressed: () async {
                                            //       SharedPreferences preferences =
                                            //           await SharedPreferences.getInstance();

                                            //       String? _route = preferences.getString('route');

                                            //       MaterialPageRoute route = MaterialPageRoute(
                                            //         builder: (context) => AdminScafScreen(route: _route),
                                            //       );
                                            //       Navigator.pushAndRemoveUntil(
                                            //           context, route, (route) => false);
                                            //     },
                                            //     icon: Icon(
                                            //       Icons.home_filled,
                                            //       color: Colors.white,
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'มุมมอง :',
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: SlideSwitcher(
                                                        initialIndex: 1,
                                                        containerBorderRadius:
                                                            10,
                                                        onSelect:
                                                            (index) async {
                                                          setState(() {
                                                            switcherIndex1 =
                                                                index;
                                                          });
                                                          if (index + 1 == 2) {
                                                            setState(() {
                                                              Visit_ =
                                                                  'calendar';
                                                            });
                                                          } else {
                                                            SharedPreferences
                                                                preferences =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            String? _route =
                                                                preferences
                                                                    .getString(
                                                                        'route');

                                                            MaterialPageRoute
                                                                route =
                                                                MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AdminScafScreen(
                                                                      route:
                                                                          _route),
                                                            );
                                                            Navigator
                                                                .pushAndRemoveUntil(
                                                                    context,
                                                                    route,
                                                                    (route) =>
                                                                        false);
                                                          }
                                                        },
                                                        containerHeight: 40,
                                                        containerWight: 130,
                                                        containerColor:
                                                            Colors.grey,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .grid_view_rounded,
                                                            color: (Visit_ ==
                                                                    'grid')
                                                                ? Colors
                                                                    .blue[900]
                                                                : Colors.black,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .calendar_month_rounded,
                                                            color: (Visit_ ==
                                                                    'calendar')
                                                                ? Colors
                                                                    .blue[900]
                                                                : Colors.black,
                                                          ),
                                                          Icon(
                                                            Icons.list,
                                                            color: (Visit_ ==
                                                                    'list')
                                                                ? Colors
                                                                    .blue[900]
                                                                : Colors.black,
                                                          ),
                                                          Icon(
                                                            Icons.map_outlined,
                                                            color: (Visit_ ==
                                                                    'map')
                                                                ? Colors
                                                                    .blue[900]
                                                                : Colors.black,
                                                          )
                                                        ],
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
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 5, 8, 0),
                                        child: Container(
                                            padding: const EdgeInsets.all(3),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            // height: MediaQuery.of(context).size.width *
                                            //     0.43,
                                            decoration: const BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          flex: 8,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child:
                                                                ScrollConfiguration(
                                                              behavior: ScrollConfiguration
                                                                      .of(
                                                                          context)
                                                                  .copyWith(
                                                                      dragDevices: {
                                                                    PointerDeviceKind
                                                                        .touch,
                                                                    PointerDeviceKind
                                                                        .mouse,
                                                                  }),
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                    children: [
                                                                      // Text(
                                                                      //     '${areaModels.length} //${_resources.length}'),
                                                                      for (int index =
                                                                              0;
                                                                          index <
                                                                              zoneModels.length;
                                                                          index++)
                                                                        Padding(
                                                                            padding: const EdgeInsets.all(4.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                // read_GC_Pos();
                                                                                setState(() {
                                                                                  zone_ser = int.parse(zoneModels[index].ser!);

                                                                                  zone_name = zoneModels[index].zn!;

                                                                                  // read_GC_contractBook(0);
                                                                                });
                                                                                Dia_log();
                                                                                read_GC_area(zone_ser);
                                                                                read_GC_Tenant(zone_ser);
                                                                              },
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: zone_ser == int.parse(zoneModels[index].ser!) ? Colors.blue[700] : Colors.grey,
                                                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                  border: Border.all(color: Colors.white, width: 1),
                                                                                ),
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    zoneModels[index].zn.toString(),
                                                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                    ]),
                                                              ),
                                                            ),
                                                          )),
                                                    ]),
                                              ],
                                            ))),

                                    //                           tenants[index1].quantity == '1' ||
                                    //     tenants[index1].quantity == '4'
                                    // ? (tenants[index1].ldate == null)
                                    //     ? Colors.red.shade300
                                    //     : datex.isAfter(DateTime.parse(
                                    //                     '${tenants[index1].ldate} 00:00:00.000')
                                    //                 .subtract(
                                    //                     Duration(days: open_set_date))) ==
                                    //             true //datex
                                    //         ? datex.isAfter(DateTime.parse(
                                    //                         '${tenants[index1].ldate} 00:00:00.000')
                                    //                     .subtract(Duration(days: 0))) ==
                                    //                 false
                                    //             ? Colors.orange.shade300
                                    //             : Colors.grey.shade300
                                    //         : Colors.red.shade300
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(0.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.white60,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                          // border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'หมายเหตุ : ',
                                                style: TextStyle(
                                                    color: AdminScafScreen_Color
                                                        .Colors_Text1_,
                                                    fontSize: 10,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: ' เช่าอยู่ ,',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.red.shade300,
                                                        fontSize: 10,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                  TextSpan(
                                                    text: ' ใกล้หมดสัญญา ,',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .orange.shade300,
                                                        fontSize: 10,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                  TextSpan(
                                                    text: ' หมดสัญญา ',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 10,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                            color: Colors.white60,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          child: SfCalendar(
                                            minDate: DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day - 5),
                                            maxDate: DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month + 12,
                                                DateTime.now().day),
                                            controller: _controller,
                                            backgroundColor: Color.fromARGB(
                                                    255, 232, 243, 235)!
                                                .withOpacity(0.2),
                                            // headerHeight: 100,
                                            timeZone: 'Asia/Bangkok',
                                            view: CalendarView.timelineMonth,
                                            headerDateFormat: 'MMM,yyy',
                                            showDatePickerButton: true,
                                            showNavigationArrow: true,
                                            allowViewNavigation: false,
                                            allowedViews: [
                                              // CalendarView.timelineDay,
                                              // CalendarView.timelineWeek,
                                              // CalendarView.timelineWorkWeek,
                                              // CalendarView.month,
                                              CalendarView.timelineMonth,
                                              // CalendarView.schedule,
                                            ],
                                            cellEndPadding: 8,
                                            viewHeaderHeight: 35,
                                            allowDragAndDrop: false,
                                            // showWeekNumber: true,
                                            showCurrentTimeIndicator: false,
                                            allowAppointmentResize: false,
                                            // cellBorderColor: Colors.black,
                                            dataSource: _dataSource,
                                            resourceViewHeaderBuilder:
                                                resourceBuilder,
                                            cellBorderColor: Colors.grey,
                                            blackoutDatesTextStyle: TextStyle(
                                                backgroundColor: Colors.blue),
                                            headerStyle: CalendarHeaderStyle(
                                                textStyle: TextStyle(
                                                  // fontSize: 20,
                                                  fontFamily: Font_.Fonts_T,
                                                  fontWeight: FontWeight.bold,
                                                  color: TextHome_Color
                                                      .TextHome_Colors_w,
                                                ),
                                                backgroundColor:
                                                    AppbackgroundColor
                                                        .TiTile_Colors),
                                            todayHighlightColor:
                                                Colors.green[700],
                                            todayTextStyle: TextStyle(
                                              fontFamily: Font_.Fonts_T,
                                              fontWeight: FontWeight.bold,
                                              color: TextHome_Color
                                                  .TextHome_Colors_w,
                                            ),
                                            scheduleViewMonthHeaderBuilder:
                                                (context, details) {
                                              return Container(
                                                color: Colors.blue,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      details.date.month
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    Text(
                                                      details.date.year
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },

                                            viewHeaderStyle: ViewHeaderStyle(
                                                dayTextStyle: TextStyle(
                                                  fontFamily: Font_.Fonts_T,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                dateTextStyle: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                  color: Colors.black,
                                                ),
                                                backgroundColor:
                                                    AppbackgroundColor
                                                            .TiTile_Colors
                                                        .withOpacity(0.5)),
                                            appointmentTextStyle: TextStyle(
                                              // letterSpacing: 5,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: Font_.Fonts_T,
                                              color: Colors.black,
                                            ),
                                            selectionDecoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 54, 138, 58),
                                                  width: 2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4)),
                                              shape: BoxShape.rectangle,
                                            ),
                                            scheduleViewSettings:
                                                const ScheduleViewSettings(
                                              appointmentItemHeight: 70,
                                              hideEmptyScheduleWeek: true,
                                              appointmentTextStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: Font_.Fonts_T,
                                                  color: Colors.black),
                                            ),
                                            resourceViewSettings:
                                                ResourceViewSettings(
                                                    showAvatar: false,
                                                    visibleResourceCount: 10,
                                                    size: 150,
                                                    displayNameTextStyle:
                                                        TextStyle(
                                                            wordSpacing: 10,
                                                            // decorationColor: Colors.amber,
                                                            backgroundColor:
                                                                AppbackgroundColor
                                                                        .TiTile_Colors
                                                                    .withOpacity(
                                                                        0.5),
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                            timeSlotViewSettings:
                                                TimeSlotViewSettings(
                                              timeIntervalWidth: 45,
                                              startHour: 0,
                                              endHour: 0,

                                              // nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]
                                            ),

                                            // loadMoreWidgetBuilder: (context, loadMoreAppointments) {
                                            //   return FutureBuilder<void>(
                                            //     initialData: 'loading',
                                            //     future: Future.delayed(
                                            //         Duration(seconds: 1), loadMoreAppointments),
                                            //     builder: (context, snapShot) {
                                            //       return Container(
                                            //           height: _controller.view == CalendarView.schedule
                                            //               ? 50
                                            //               : double.infinity,
                                            //           width: double.infinity,
                                            //           color: Colors.white38,
                                            //           alignment: Alignment.center,
                                            //           child: CircularProgressIndicator(
                                            //               valueColor:
                                            //                   AlwaysStoppedAnimation(Colors.deepPurple)));
                                            //     },
                                            //   );
                                            // },

                                            // onTap: (CalendarTapDetails calendarTapDetails) {
                                            //   print('onTap');
                                            //   // var displayId = calendarTapDetails.resource!.id;
                                            //   // var displayName = calendarTapDetails.resource!.displayName;
                                            //   // var displayImg = calendarTapDetails.resource!.image;
                                            //   // if (calendarTapDetails.resource!.id == null ||
                                            //   //     calendarTapDetails.resource!.id.toString() == '') {
                                            //   // } else {
                                            //   //   _showMyDialog(
                                            //   //     displayId,
                                            //   //     displayName,
                                            //   //     displayImg,
                                            //   //   );
                                            //   // }
                                            // },
                                            // onSelectionChanged: (CalendarSelectionDetails details) {
                                            //   var displayName = details.resource!.displayName;

                                            //   int selectedIndex = tenants.indexWhere(
                                            //       (item) => item.cid.toString() == displayName.toString());

                                            //   var displayId = details.resource!.id;

                                            //   var displayImg = details.resource!.image;
                                            //   print(selectedIndex);
                                            //   print(displayName);
                                            // },
                                            onSelectionChanged:
                                                selectionChanged,
                                            onTap: calendarTapped,
                                            onViewChanged: _printCurrentMonth,

                                            // onSelectionChanged: (calendarSelectionDetails) {
                                            //   print(calendarSelectionDetails.resource!.displayName);
                                            //   print(calendarSelectionDetails.date);
                                            // },
                                            // onViewChanged: (viewChangedDetails) {
                                            //   // List<DateTime> dates = viewChangedDetails.visibleDates;
                                            //   print('onViewChanged');
                                            // },

                                            // onAppointmentResizeEnd: (appointmentResizeEndDetails) {
                                            //   print(appointmentResizeEndDetails.endTime);
                                            // },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          // border: Border.all(color: Colors.white, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    color: AppbackgroundColor
                                                            .TiTile_Colors
                                                        .withOpacity(0.5),
                                                    width: 150,
                                                    height: 25,
                                                    child: Text(
                                                      "# ${DateFormat('MMM,yyyy').format(DateTime.parse(visibleStar.toString()))}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: AppbackgroundColor
                                                            .TiTile_Colors
                                                        .withOpacity(0.5),
                                                    width: 150,
                                                    height: 25,
                                                    child: Text(
                                                      "# เช่าอยู่",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                          color:
                                                              Colors.red[800]),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: AppbackgroundColor
                                                            .TiTile_Colors
                                                        .withOpacity(0.5),
                                                    width: 150,
                                                    height: 25,
                                                    child: Text(
                                                      "# ว่าง(พื้นที่ทั้งหมด: ${areaModels.length})",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                          color: Colors
                                                              .green[800]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ScrollConfiguration(
                                                behavior:
                                                    ScrollConfiguration.of(
                                                            context)
                                                        .copyWith(dragDevices: {
                                                  PointerDeviceKind.touch,
                                                  PointerDeviceKind.mouse,
                                                }),
                                                child: SingleChildScrollView(
                                                  // controller: _controller.displayDate,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          for (DateTime date =
                                                                  DateTime.parse(
                                                                      visibleStar
                                                                          .toString());
                                                              date.isBefore(DateTime.parse(
                                                                      visibleEnd
                                                                          .toString())) ||
                                                                  date ==
                                                                      DateTime.parse(
                                                                          visibleEnd
                                                                              .toString());
                                                              date = date.add(
                                                                  Duration(
                                                                      days: 1)))
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                                border: Border.all(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        214,
                                                                        211,
                                                                        211),
                                                                    width: 0.5),
                                                              ),
                                                              width: 45,
                                                              height: 25,
                                                              child: Center(
                                                                child: Text(
                                                                  '${date.day}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: TextHome_Color
                                                                        .TextHome_Colors_w,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          for (DateTime date =
                                                                  DateTime.parse(
                                                                      visibleStar
                                                                          .toString());
                                                              date.isBefore(DateTime.parse(
                                                                      visibleEnd
                                                                          .toString())) ||
                                                                  date ==
                                                                      DateTime.parse(
                                                                          visibleEnd
                                                                              .toString());
                                                              date = date.add(
                                                                  Duration(
                                                                      days: 1)))
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                        .TiTile_Colors
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 0.5),
                                                              ),
                                                              width: 45,
                                                              height: 25,
                                                              child: Center(
                                                                child: Text(
                                                                  '${sumAppointmentsForDay(DateTime(date.year, date.month, date.day), appointments)}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black45,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          for (DateTime date =
                                                                  DateTime.parse(
                                                                      visibleStar
                                                                          .toString());
                                                              date.isBefore(DateTime.parse(
                                                                      visibleEnd
                                                                          .toString())) ||
                                                                  date ==
                                                                      DateTime.parse(
                                                                          visibleEnd
                                                                              .toString());
                                                              date = date.add(
                                                                  Duration(
                                                                      days: 1)))
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                        .TiTile_Colors
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 0.5),
                                                              ),
                                                              width: 45,
                                                              height: 25,
                                                              child: Center(
                                                                child: Text(
                                                                  '${areaModels.length - sumAppointmentsForDay(DateTime(date.year, date.month, date.day), appointments)}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black45,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
          ]));
  }

  Future<Null> _printCurrentMonth(ViewChangedDetails details) async {
    Future.delayed(const Duration(milliseconds: 100), () {
      Dia_log();
    });
    DateTime visibleStartDate = details.visibleDates.first;
    DateTime visibleEndDate = details.visibleDates.last;

    // Calculate the current month
    String currentMonth_Start =
        DateFormat('yyyy-MM-dd').format(visibleStartDate);
    String currentMonth_End = DateFormat('yyyy-MM-dd').format(visibleEndDate);

    // Print the current month
    // print('Current Month: $currentMonth');
    print('S-L Month: $currentMonth_Start - $currentMonth_End ');
    setState(() {
      visibleStar = currentMonth_Start;
      visibleEnd = currentMonth_End;
    });
    read_GC_Tenant(zone_ser);
  }

  String? _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '',
      _displayId = '',
      _displayName = '';
  Color? _headerColor, _viewHeaderColor, _calendarColor;
  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      if (appointmentDetails.isAllDay) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      _displayName = appointmentDetails.id.toString();

      int selectedIndex = tenants
          .indexWhere((item) => item.cid.toString() == _displayName.toString());

      _displayId = details.resource!.id.toString();

      var displayImg = details.resource!.image;

      print(_subjectText);
      print(_displayName);
      print(selectedIndex);

      _showMyDialog2(_subjectText, displayImg, selectedIndex);
    } else {
      // _startTimeText =
      //     DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      // _endTimeText =
      //     DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      // _Date = DateFormat('dd, MMMM yyyy').format(details.date!).toString();
    }
  }

  String _text = '';
  void selectionChanged(CalendarSelectionDetails details) {
    DateTime datex = DateTime.now();

    if (_controller.view == CalendarView.month ||
        _controller.view == CalendarView.timelineMonth) {
      _text = DateFormat('dd-MM-yyyy').format(details.date!).toString();
    } else {
      _text = DateFormat('dd-MM-yyyy hh:mm a').format(details.date!).toString();
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppbackgroundColor.Sub_Abg_Colors,
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(10.0),
            actionsPadding: const EdgeInsets.all(6.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
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
                Text(
                  ' ${details.resource!.displayName}',
                  style: const TextStyle(
                      color: AdminScafScreen_Color.Colors_Text1_,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: FontWeight_.Fonts_T),
                ),
                Text(
                  '(${_text})',
                  style: const TextStyle(
                      color: AdminScafScreen_Color.Colors_Text1_,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: Font_.Fonts_T),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 3.0,
                ),
                const SizedBox(
                  height: 2.0,
                ),
              ],
            )),
            content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
              // Container(child: new Text("You have selected " + '$_text')),
              // if (areaModels[index].quantity != '1')
              ListTile(
                  onTap: () async {
                    int index_ = int.parse(details.resource!.id.toString());

                    // print(areaModels[index_].ser);
                    // if (renTal_lavel <= 2) {
                    //     infomation();
                    //   } else {
                    // SharedPreferences preferences =
                    //     await SharedPreferences.getInstance();
                    // preferences.setString('zoneSer', zone_ser.toString());
                    // preferences.setString('zonesName', zone_name.toString());
                    setState(() {
                      Ser_Body = 1;
                      a_ln = areaModels[index_].lncode;
                      a_ser = areaModels[index_].ser;
                      a_area = areaModels[index_].area;
                      a_rent = areaModels[index_].rent;
                      a_page = '1';
                    });
                    Navigator.pop(context, 'OK');
                    //   }
                  },
                  title: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        width: 0.5,
                      ),
                    )),
                    padding: const EdgeInsets.all(4.0),
                    width: 270,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เสนอราคา: ${details.resource!.displayName} ',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(
                          Iconsax.arrow_circle_right,
                          // color: getRandomColor(index)
                        ),
                      ],
                    ),
                  )),
////////////-------------------------->
              // if (areaModels[index].quantity != '1')
              ListTile(
                  onTap: () async {
                    int index_ = int.parse(details.resource!.id.toString());
                    //  if (renTal_lavel <= 2) {
                    //       infomation();
                    //     } else {
                    // SharedPreferences preferences =
                    //     await SharedPreferences.getInstance();
                    // preferences.setString('zoneSer', zone_ser.toString());
                    // preferences.setString('zonesName', zone_name.toString());

                    setState(() {
                      Ser_Body = 2;
                      a_ln = areaModels[index_].lncode;
                      a_ser = areaModels[index_].ser;
                      a_area = areaModels[index_].area;
                      a_rent = areaModels[index_].rent;
                      a_page = '1';
                    });
                    Navigator.pop(context, 'OK');
                    //     }
                  },
                  title: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    )),
                    padding: const EdgeInsets.all(4.0),
                    width: 270,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ทำสัญญา: ${details.resource!.displayName}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(
                          Iconsax.arrow_circle_right,
                          // color: getRandomColor(index)
                        ),
                      ],
                    ),
                  )),
            ])),
            // actions: <Widget>[
            //   Center(
            //     child: Container(
            //       width: 100,
            //       decoration: const BoxDecoration(
            //         color: Colors.black,
            //         borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(10),
            //             topRight: Radius.circular(10),
            //             bottomLeft: Radius.circular(10),
            //             bottomRight: Radius.circular(10)),
            //       ),
            //       padding: const EdgeInsets.all(8.0),
            //       child: TextButton(
            //         onPressed: () => Navigator.pop(context, 'OK'),
            //         child: const Text(
            //           'ปิด',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //               fontFamily: FontWeight_.Fonts_T),
            //         ),
            //       ),
            //     ),
            //   ),
            //   // TextButton(
            //   //   child: const Text('Approve'),
            //   //   onPressed: () {
            //   //     Navigator.of(context).pop();
            //   //   },
            //   // ),
            // ],
          );
        });
  }

  Widget resourceBuilder(
      BuildContext context, ResourceViewHeaderDetails details) {
    if (details.resource.image != null) {
      return Container(
        color: int.parse(details.resource.id.toString()) % 2 == 0
            ? AppbackgroundColor.TiTile_Colors.withOpacity(0.5)
            : AppbackgroundColor.TiTile_Colors.withOpacity(0.2),
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // CircleAvatar(
            //   radius: 15,
            //   backgroundImage: details.resource.image,
            //   backgroundColor: details.resource.color,
            // ),
            Text(
              details.resource.displayName,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 11,
                fontFamily: FontWeight_.Fonts_T,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: AppbackgroundColor.TiTile_Colors,
        child: Text(details.resource.displayName),
      );
    }
  }

  _showMyDialog1(displayName, displayImg, tenants_ser) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!areaModels
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.91),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ' ',
                style: const TextStyle(
                    color: AdminScafScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: FontWeight_.Fonts_T),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Divider(
                color: Colors.grey[300],
                height: 3.0,
              ),
              const SizedBox(
                height: 2.0,
              ),
            ],
          )),
          content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'ว่าง',
                  style: const TextStyle(
                      color: Colors.green,
                      // fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
            ),
          ])),
          actions: <Widget>[
            Center(
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
            ),
          ],
        );
      },
    );
  }

  _showMyDialog2(displayName, displayImg, tenants_ser) {
    DateTime datex = DateTime.now();
    int index = int.parse(tenants_ser.toString());
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!areaModels
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppbackgroundColor.Sub_Abg_Colors,
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(10.0),
          actionsPadding: const EdgeInsets.all(6.0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
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
              Text(
                ' ${tenants[index].lncode}',
                style: const TextStyle(
                    color: AdminScafScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: FontWeight_.Fonts_T),
              ),
              Text(
                '(${tenants[index].ln})',
                style: const TextStyle(
                    color: AdminScafScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: Font_.Fonts_T),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Divider(
                color: Colors.grey[300],
                height: 3.0,
              ),
              const SizedBox(
                height: 2.0,
              ),
            ],
          )),
          content: (tenants[index].quantity == null ||
                  tenants[index].quantity.toString() == '')
              ? SingleChildScrollView(
                  child: ListBody(children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'ว่าง',
                        style: const TextStyle(
                            color: Colors.green,
                            // fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T),
                      ),
                    ),
                  ),
                ]))
              : SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              (tenants[index].docno_book == null)
                                  ? 'สัญญา'
                                  : 'ล็อกเสียบ',
                              style: const TextStyle(
                                  color: Colors.green,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(4.0),
                      //   child: Text(
                      //     (tenants[index].docno_book == null)
                      //         ? 'เลขที่ : ${tenants[index].cid}'
                      //         : 'เลขที่ : ${tenants[index].docno_book}',
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          (tenants[index].sdate == null ||
                                  tenants[index].ldate == null)
                              ? ''
                              : 'วันที่ : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${tenants[index].sdate}'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${tenants[index].ldate}'))}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text((tenants[index].sdate == null ||
                                tenants[index].ldate == null)
                            ? ''
                            : tenants[index].quantity == '1' ||
                                    tenants[index].quantity == '4'
                                ? (tenants[index].ldate == null)
                                    ? 'สถานะ : หมดสัญญา'
                                    : datex.isAfter(DateTime.parse(
                                                    '${tenants[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : tenants[index].ldate} 00:00:00.000')
                                                .subtract(
                                                    const Duration(days: 0))) ==
                                            true
                                        ? 'สถานะ : หมดสัญญา'
                                        : datex.isAfter(DateTime.parse(
                                                        '${tenants[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : tenants[index].ldate} 00:00:00.000')
                                                    .subtract(
                                                        Duration(days: open_set_date))) ==
                                                true
                                            ? 'สถานะ : ใกล้หมดสัญญา'
                                            : 'สถานะ : เช่าอยู่'
                                : tenants[index].quantity == '2'
                                    ? 'สถานะ : เสนอราคา'
                                    : tenants[index].quantity == '3'
                                        ? 'สถานะ : เสนอราคา(มัดจำ)'
                                        : 'สถานะ : ว่าง'),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ListTile(
                          onTap: () async {
                            // if (renTal_lavel <= 2) {
                            //   infomation();
                            // } else {
                            setState(() {
                              Ser_Body = 3;
                              Value_stasus = tenants[index].quantity == '1'
                                  ? datex.isAfter(DateTime.parse(
                                                  '${tenants[index].ldate} 00:00:00.000')
                                              .subtract(
                                                  const Duration(days: 0))) ==
                                          true
                                      ? 'หมดสัญญา'
                                      : datex.isAfter(DateTime.parse(
                                                      '${tenants[index].ldate} 00:00:00.000')
                                                  .subtract(Duration(
                                                      days: open_set_date))) ==
                                              true
                                          ? 'ใกล้หมดสัญญา'
                                          : 'เช่าอยู่'
                                  : tenants[index].quantity == '2'
                                      ? 'เสนอราคา'
                                      : tenants[index].quantity == '3'
                                          ? 'เสนอราคา(มัดจำ)'
                                          : 'ว่าง';
                              Value_cid = tenants[index].cid;
                              ser_cidtan = '1';
                            });
                            Navigator.pop(context, 'OK');
                            // }
                          },
                          title: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                //                    <--- top side
                                width: 0.5,
                              ),
                            )),
                            padding: const EdgeInsets.all(4.0),
                            width: 270,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'เช่าอยู่: ${tenants[index].cid} (${tenants[index].cname})',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Icon(
                                  Iconsax.arrow_circle_right,
                                  // color: getRandomColor(index)
                                ),
                              ],
                            ),
                          )),
                      ListTile(
                          onTap: () async {
                            //             if (renTal_lavel <= 2) {
                            //   infomation();
                            // } else {
                            setState(() {
                              Value_stasus = tenants[index].quantity == '1'
                                  ? datex.isAfter(DateTime.parse(
                                                  '${tenants[index].ldate} 00:00:00.000')
                                              .subtract(
                                                  const Duration(days: 0))) ==
                                          true
                                      ? 'หมดสัญญา'
                                      : datex.isAfter(DateTime.parse(
                                                      '${tenants[index].ldate} 00:00:00.000')
                                                  .subtract(Duration(
                                                      days: open_set_date))) ==
                                              true
                                          ? 'ใกล้หมดสัญญา'
                                          : 'เช่าอยู่'
                                  : tenants[index].quantity == '2'
                                      ? 'เสนอราคา'
                                      : tenants[index].quantity == '3'
                                          ? 'เสนอราคา(มัดจำ)'
                                          : 'ว่าง';
                              Ser_Body = 4;
                              Value_cid = tenants[index].cid;
                              ser_cidtan = '1';
                            });
                            Navigator.pop(context, 'OK');
                            // }
                          },
                          title: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                //                    <--- top side
                                width: 0.5,
                              ),
                            )),
                            padding: const EdgeInsets.all(4.0),
                            width: 270,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'รับชำระ: ${tenants[index].cid} (${tenants[index].cname})',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Icon(
                                  Iconsax.arrow_circle_right,
                                  // color: getRandomColor(index)
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
          // actions: <Widget>[
          //   Center(
          //     child: Container(
          //       width: 100,
          //       decoration: const BoxDecoration(
          //         color: Colors.black,
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(10),
          //             topRight: Radius.circular(10),
          //             bottomLeft: Radius.circular(10),
          //             bottomRight: Radius.circular(10)),
          //       ),
          //       padding: const EdgeInsets.all(8.0),
          //       child: TextButton(
          //         onPressed: () => Navigator.pop(context, 'OK'),
          //         child: const Text(
          //           'ปิด',
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold,
          //               fontFamily: FontWeight_.Fonts_T),
          //         ),
          //       ),
          //     ),
          //   ),
          //   // TextButton(
          //   //   child: const Text('Approve'),
          //   //   onPressed: () {
          //   //     Navigator.of(context).pop();
          //   //   },
          //   // ),
          // ],
        );
      },
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> appointments, List<CalendarResource> resources) {
    this.appointments = appointments;
    this.resources = resources;
  }
}

// class User {
//   final String name;
//   final String avatarUrl;
//   final Color color;

//   User({required this.name, required this.avatarUrl, required this.color});
// }
